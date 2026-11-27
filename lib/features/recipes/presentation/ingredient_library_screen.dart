import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/l10n/l10n.dart';
import 'ingredient_form_screen.dart';
import 'category_label.dart';
import 'recipes_providers.dart';

/// Lists every ingredient; tapping one edits it.
class IngredientLibraryScreen extends ConsumerWidget {
  const IngredientLibraryScreen({super.key});

  void _open(BuildContext context, [Ingredient? ingredient]) =>
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => IngredientFormScreen(ingredient: ingredient),
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ingredients = ref.watch(ingredientsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.recipesIngredientsTitle)),
      floatingActionButton: FloatingActionButton(
        key: const Key('add-ingredient'),
        heroTag: 'ingredients-fab',
        tooltip: context.l10n.recipesNewIngredientTooltip,
        onPressed: () => _open(context),
        child: const Icon(Icons.add),
      ),
      body: ingredients.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) =>
            Center(child: Text(context.l10n.recipesIngredientsLoadError('$e'))),
        data: (list) => list.isEmpty
            ? Center(child: Text(context.l10n.recipesIngredientsEmpty))
            : ListView.builder(
                padding: const EdgeInsets.only(bottom: 88),
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final ing = list[i];
                  return ListTile(
                    key: Key('ingredient-${ing.id}'),
                    title: Text(ing.name),
                    subtitle: Text(
                      context.l10n.recipesIngredientSubtitle(
                        categoryLabel(context.l10n, ing.category),
                        ing.kcal100.round(),
                        ing.protein100.round(),
                        ing.fat100.round(),
                        ing.carbs100.round(),
                      ),
                    ),
                    onTap: () => _open(context, ing),
                  );
                },
              ),
      ),
    );
  }
}
