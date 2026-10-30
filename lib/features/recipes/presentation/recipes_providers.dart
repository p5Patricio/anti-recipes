import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/nutrition/nutrients.dart';
import '../data/recipes_dao.dart';
import '../domain/recipe_nutrition.dart';
import '../domain/yield_calculator.dart';

final recipesProvider = StreamProvider<List<Recipe>>(
  (ref) => ref.watch(recipesDaoProvider).watchRecipes(),
);

final ingredientsProvider = StreamProvider<List<Ingredient>>(
  (ref) => ref.watch(recipesDaoProvider).watchIngredients(),
);

final toolsProvider = StreamProvider<List<Tool>>(
  (ref) => ref.watch(recipesDaoProvider).watchTools(),
);

final recipeLinesProvider = StreamProvider<List<RecipeLine>>(
  (ref) => ref.watch(recipesDaoProvider).watchRecipeLines(),
);

/// A recipe row plus its computed nutrition, for list cards.
class RecipeSummary {
  const RecipeSummary(this.recipe, this.nutrition);
  final Recipe recipe;
  final RecipeNutrition nutrition;

  Nutrients get per100Cooked => nutrition.per100Cooked;
}

final recipeSummariesProvider = Provider<AsyncValue<List<RecipeSummary>>>((
  ref,
) {
  final recipes = ref.watch(recipesProvider);
  final lines = ref.watch(recipeLinesProvider);
  if (recipes.hasError) return AsyncError(recipes.error!, recipes.stackTrace!);
  if (lines.hasError) return AsyncError(lines.error!, lines.stackTrace!);
  if (!recipes.hasValue || !lines.hasValue) return const AsyncLoading();
  final byRecipe = <int, List<RawIngredient>>{};
  for (final l in lines.requireValue) {
    byRecipe
        .putIfAbsent(l.recipeId, () => [])
        .add(RawIngredient(l.per100, l.rawG));
  }
  return AsyncData([
    for (final r in recipes.requireValue)
      RecipeSummary(
        r,
        RecipeNutrition(byRecipe[r.id] ?? const [], r.expectedYieldFactor),
      ),
  ]);
});

/// Detail reloads whenever the recipe table or any recipe line changes.
final recipeDetailProvider = FutureProvider.autoDispose
    .family<RecipeDetail?, int>((ref, id) {
      ref.watch(recipesProvider);
      ref.watch(recipeLinesProvider);
      return ref.watch(recipesDaoProvider).getRecipeDetail(id);
    });
