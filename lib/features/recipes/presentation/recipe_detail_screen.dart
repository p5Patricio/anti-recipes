import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/ingredient_nutrients.dart';
import '../data/recipes_dao.dart';
import '../domain/recipe_nutrition.dart';
import '../domain/yield_calculator.dart';
import 'recipe_editor_screen.dart';
import 'recipe_kind_label.dart';
import 'recipes_providers.dart';
import 'widgets/confirm_delete.dart';
import 'widgets/recipe_summary_card.dart';

/// Read-only view of one recipe with edit and delete actions.
class RecipeDetailScreen extends ConsumerWidget {
  const RecipeDetailScreen(this.recipeId, {super.key});

  final int recipeId;

  Future<void> _edit(BuildContext context) async {
    final deleted = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (_) => RecipeEditorScreen(recipeId: recipeId)),
    );
    if (deleted == true && context.mounted) Navigator.of(context).pop();
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    RecipeDetail detail,
  ) async {
    final navigator = Navigator.of(context);
    final dao = ref.read(recipesDaoProvider);
    final done = await confirmAndDelete(
      context,
      title: 'Delete "${detail.recipe.name}"?',
      message:
          'The recipe and its steps will be removed. This cannot be undone.',
      blockedMessage:
          'This recipe is used by a cooked batch, so it cannot be deleted.',
      inUse: () => dao.isRecipeInUse(recipeId),
      delete: () => dao.deleteRecipe(recipeId),
    );
    if (done) navigator.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(recipeDetailProvider(recipeId));
    final data = detail.value;
    return Scaffold(
      appBar: AppBar(
        title: Text(data?.recipe.name ?? 'Recipe'),
        actions: [
          if (data != null) ...[
            IconButton(
              key: const Key('edit-recipe'),
              tooltip: 'Edit',
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => _edit(context),
            ),
            IconButton(
              key: const Key('delete-recipe'),
              tooltip: 'Delete',
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _delete(context, ref, data),
            ),
          ],
        ],
      ),
      body: detail.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Could not load recipe: $e')),
        data: (d) => d == null
            ? const Center(child: Text('This recipe no longer exists.'))
            : _DetailBody(d),
      ),
    );
  }
}

class _DetailBody extends ConsumerWidget {
  const _DetailBody(this.detail);

  final RecipeDetail detail;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = Theme.of(context).textTheme;
    final recipe = detail.recipe;
    // A step may use a tool that is not in the recipe's tool list.
    final toolNames = {
      for (final t in ref.watch(toolsProvider).value ?? <Tool>[]) t.id: t.name,
    };
    final nutrition = RecipeNutrition([
      for (final l in detail.ingredients)
        RawIngredient(l.ingredient.per100g, l.rawG),
    ], recipe.expectedYieldFactor);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          '${recipe.kind.label} · yield ${recipe.expectedYieldFactor.toStringAsFixed(2)}',
          style: text.titleSmall,
        ),
        const SizedBox(height: 12),
        RecipeSummaryCard(nutrition),
        const SizedBox(height: 16),
        Text('Ingredients', style: text.titleMedium),
        for (final l in detail.ingredients)
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text(l.ingredient.name),
            trailing: Text('${l.rawG.round()} g raw'),
          ),
        const SizedBox(height: 16),
        Text('Tools', style: text.titleMedium),
        if (detail.tools.isEmpty)
          const Text('No tools selected.')
        else
          Wrap(
            spacing: 8,
            children: [for (final t in detail.tools) Chip(label: Text(t.name))],
          ),
        const SizedBox(height: 16),
        Text('Steps', style: text.titleMedium),
        if (detail.steps.isEmpty) const Text('No steps yet.'),
        for (final (i, s) in detail.steps.indexed)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(radius: 14, child: Text('${i + 1}')),
            title: Text(s.technique),
            subtitle: Text(
              [
                if (s.tempC != null) '${s.tempC} °C',
                if (s.minutes != null) '${s.minutes} min',
                if (s.toolId != null && toolNames[s.toolId] != null)
                  toolNames[s.toolId]!,
              ].join(' · '),
            ),
          ),
        if (recipe.notes != null && recipe.notes!.isNotEmpty) ...[
          const SizedBox(height: 16),
          Text('Notes', style: text.titleMedium),
          Text(recipe.notes!),
        ],
      ],
    );
  }
}
