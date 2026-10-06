import '../../../core/nutrition/nutrients.dart';
import '../../../core/nutrition/range.dart';

/// One component of a meal being composed: a food described per 100 g and the
/// grams eaten. Batch items use their per-cooked-gram nutrients scaled to 100 g.
class MealLineInput {
  const MealLineInput({required this.per100g, required this.grams});

  final Nutrients per100g;
  final double grams;

  Nutrients get nutrients => Nutrients.fromPer100g(per100g, grams);
}

/// Total nutrients of the meal; empty meals are [Nutrients.zero].
Nutrients mealTotals(Iterable<MealLineInput> lines) =>
    Nutrients.sum(lines.map((l) => l.nutrients));

/// Sum of the logged meals of a day except the one in [slot] (which is being
/// replaced by the meal under composition).
Nutrients dayTotalsExcludingSlot(
  Iterable<({int slot, Nutrients nutrients})> meals,
  int slot,
) => Nutrients.sum(meals.where((m) => m.slot != slot).map((m) => m.nutrients));

/// Distance of [proteinG] from the per-meal [range]: negative when below the
/// minimum, positive when above the maximum and zero when within.
double proteinOutsideRangeG(Range range, double proteinG) {
  if (proteinG < range.min) return proteinG - range.min;
  if (proteinG > range.max) return proteinG - range.max;
  return 0;
}
