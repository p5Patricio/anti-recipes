import '../../../core/nutrition/nutrients.dart';

/// A raw ingredient line: nutrients per 100 g raw and the raw weight used.
class RawIngredient {
  const RawIngredient(this.per100, this.rawGrams);

  final Nutrients per100;
  final double rawGrams;
}

/// Cooked-yield math for a batch: raw inputs, measured cooked total weight.
class YieldCalculator {
  YieldCalculator(Iterable<RawIngredient> ingredients, this.cookedTotalG)
      : ingredients = List.unmodifiable(ingredients) {
    if (this.ingredients.isEmpty) {
      throw ArgumentError('At least one ingredient is required');
    }
    for (final i in this.ingredients) {
      if (!(i.rawGrams > 0)) {
        throw ArgumentError.value(i.rawGrams, 'rawGrams', 'must be > 0');
      }
    }
    if (!(cookedTotalG > 0)) {
      throw ArgumentError.value(cookedTotalG, 'cookedTotalG', 'must be > 0');
    }
  }

  final List<RawIngredient> ingredients;
  final double cookedTotalG;

  double get rawTotalG =>
      ingredients.fold<double>(0, (sum, i) => sum + i.rawGrams);

  /// Nutrients of the whole batch (cooking does not change totals).
  Nutrients get totalNutrients => Nutrients.sum(
      ingredients.map((i) => Nutrients.fromPer100g(i.per100, i.rawGrams)));

  /// cooked / raw total weight (e.g. 0.75 when meat loses 25% water).
  double get yieldFactor => cookedTotalG / rawTotalG;

  Nutrients get nutrientsPerCookedGram =>
      totalNutrients.scale(1 / cookedTotalG);

  Nutrients nutrientsForCookedPortion(double grams) {
    if (!(grams > 0)) {
      throw ArgumentError.value(grams, 'grams', 'must be > 0');
    }
    return nutrientsPerCookedGram.scale(grams);
  }
}
