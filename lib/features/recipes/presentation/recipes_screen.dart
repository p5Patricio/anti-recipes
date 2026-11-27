import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/theme/app_colors.dart';
import '../domain/recipe_kind.dart';
import 'ingredient_library_screen.dart';
import 'recipe_detail_screen.dart';
import 'recipe_editor_screen.dart';
import 'recipe_kind_label.dart';
import 'recipes_providers.dart';
import 'widgets/recipe_card.dart';

/// Container: owns the kind filter and navigation; cards are presentational.
class RecipesScreen extends ConsumerStatefulWidget {
  const RecipesScreen({super.key});

  @override
  ConsumerState<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends ConsumerState<RecipesScreen> {
  /// null means "All".
  RecipeKind? _filter;

  void _push(Widget screen) =>
      Navigator.of(context)
          .push(MaterialPageRoute<void>(builder: (_) => screen));

  @override
  Widget build(BuildContext context) {
    final summaries = ref.watch(recipeSummariesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.recipesTitle),
        actions: [
          IconButton(
            key: const Key('open-ingredients'),
            tooltip: context.l10n.recipesIngredientsTooltip,
            icon: const Icon(Icons.egg_alt_outlined),
            onPressed: () => _push(const IngredientLibraryScreen()),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('add-recipe'),
        heroTag: 'recipes-fab',
        tooltip: context.l10n.recipesNewRecipeTooltip,
        onPressed: () => _push(const RecipeEditorScreen()),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                _chip(context.l10n.recipesFilterAll, null),
                for (final kind in RecipeKind.values)
                  _chip(kind.localizedLabel(context.l10n), kind),
              ],
            ),
          ),
          Expanded(
            child: summaries.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) =>
                  Center(child: Text(context.l10n.recipesLoadError('$e'))),
              data: (all) {
                final shown = _filter == null
                    ? all
                    : all.where((s) => s.recipe.kind == _filter).toList();
                if (shown.isEmpty) {
                  return _EmptyState(filtered: all.isNotEmpty);
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
                  itemCount: shown.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    final s = shown[i];
                    return RecipeCard(
                      key: Key('recipe-card-${s.recipe.id}'),
                      name: s.recipe.name,
                      kind: s.recipe.kind,
                      yieldFactor: s.recipe.expectedYieldFactor,
                      per100Cooked: s.per100Cooked,
                      onTap: () => _push(RecipeDetailScreen(s.recipe.id)),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, RecipeKind? kind) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: ChoiceChip(
      key: Key('filter-${kind?.name ?? 'all'}'),
      label: Text(label),
      selected: _filter == kind,
      onSelected: (_) => setState(() => _filter = kind),
    ),
  );
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.filtered});

  /// True when recipes exist but none match the selected kind.
  final bool filtered;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final l10n = context.l10n;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.menu_book_outlined,
              size: 48,
              color: AppColors.blossom,
            ),
            const SizedBox(height: 12),
            Text(
              filtered
                  ? l10n.recipesEmptyFilteredTitle
                  : l10n.recipesEmptyTitle,
              style: text.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              filtered ? l10n.recipesEmptyFilteredBody : l10n.recipesEmptyBody,
              textAlign: TextAlign.center,
              style: text.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
