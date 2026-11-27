import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/ingredient_nutrients.dart';
import '../../../core/l10n/l10n.dart';
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
      title: context.l10n.recipesDeleteRecipeTitle(detail.recipe.name),
      message: context.l10n.recipesDeleteRecipeMessage,
      blockedMessage: context.l10n.recipesRecipeInUse,
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
        title: Text(
          data?.recipe.name ?? context.l10n.recipesDetailTitleFallback,
        ),
        actions: [
          if (data != null) ...[
            IconButton(
              key: const Key('edit-recipe'),
              tooltip: context.l10n.recipesEditTooltip,
              icon: const Icon(Icons.edit_outlined),
              onPressed: () => _edit(context),
            ),
            IconButton(
              key: const Key('delete-recipe'),
              tooltip: context.l10n.recipesDeleteTooltip,
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _delete(context, ref, data),
            ),
          ],
        ],
      ),
      body: detail.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) =>
            Center(child: Text(context.l10n.recipesLoadRecipeError('$e'))),
        data: (d) => d == null
            ? Center(child: Text(context.l10n.recipesRecipeMissing))
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
    final l10n = context.l10n;
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
          l10n.recipesCardKindYield(
            recipe.kind.localizedLabel(l10n),
            recipe.expectedYieldFactor.toStringAsFixed(2),
          ),
          style: text.titleSmall,
        ),
        const SizedBox(height: 12),
        RecipeSummaryCard(nutrition),
        const SizedBox(height: 16),
        Text(l10n.recipesIngredientsTitle, style: text.titleMedium),
        for (final l in detail.ingredients)
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text(l.ingredient.name),
            trailing: Text(l10n.recipesRawGramsLine(l.rawG.round())),
          ),
        const SizedBox(height: 16),
        Text(l10n.recipesSectionTools, style: text.titleMedium),
        if (detail.tools.isEmpty)
          Text(l10n.recipesNoToolsSelected)
        else
          Wrap(
            spacing: 8,
            children: [for (final t in detail.tools) Chip(label: Text(t.name))],
          ),
        const SizedBox(height: 16),
        Text(l10n.recipesSectionSteps, style: text.titleMedium),
        if (detail.steps.isEmpty) Text(l10n.recipesNoSteps),
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
          Text(l10n.recipesSectionNotes, style: text.titleMedium),
          Text(recipe.notes!),
        ],
      ],
    );
  }
}
