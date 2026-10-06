import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import 'ingredient_form_screen.dart';
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
      appBar: AppBar(title: const Text('Ingredients')),
      floatingActionButton: FloatingActionButton(
        key: const Key('add-ingredient'),
        tooltip: 'New ingredient',
        onPressed: () => _open(context),
        child: const Icon(Icons.add),
      ),
      body: ingredients.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Could not load ingredients: $e')),
        data: (list) => list.isEmpty
            ? const Center(child: Text('No ingredients yet. Tap + to add one.'))
            : ListView.builder(
                padding: const EdgeInsets.only(bottom: 88),
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final ing = list[i];
                  return ListTile(
                    key: Key('ingredient-${ing.id}'),
                    title: Text(ing.name),
                    subtitle: Text(
                      '${ing.category} · ${ing.kcal100.round()} kcal · '
                      'P ${ing.protein100.round()} · F ${ing.fat100.round()} · '
                      'C ${ing.carbs100.round()} per 100 g raw',
                    ),
                    onTap: () => _open(context, ing),
                  );
                },
              ),
      ),
    );
  }
}
