import '../../../core/nutrition/nutrients.dart';
import 'yield_calculator.dart';

/// Nutrition of a recipe as written: raw ingredient lines plus the expected
/// cooked/raw weight ratio ([yieldFactor], e.g. 0.75 when meat loses water).
class RecipeNutrition {
  RecipeNutrition(Iterable<RawIngredient> lines, this.yieldFactor)
    : lines = List.unmodifiable(lines);

  final List<RawIngredient> lines;
  final double yieldFactor;

  double get rawTotalG => lines.fold<double>(0, (sum, l) => sum + l.rawGrams);

  /// Expected weight after cooking.
  double get cookedTotalG => rawTotalG * yieldFactor;

  /// Whole-recipe nutrients (cooking does not change totals).
  Nutrients get total => Nutrients.sum(
    lines.map((l) => Nutrients.fromPer100g(l.per100, l.rawGrams)),
  );

  /// Nutrients per 100 g of cooked food; zero while the recipe is empty.
  Nutrients get per100Cooked =>
      cookedTotalG > 0 ? total.scale(100 / cookedTotalG) : Nutrients.zero;
}
