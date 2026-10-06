import 'package:anti_recipes/core/nutrition/nutrients.dart';
import 'package:anti_recipes/core/nutrition/range.dart';
import 'package:anti_recipes/features/meal_log/domain/meal_totals.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const chicken = Nutrients(kcal: 120, proteinG: 22.5, fatG: 2.6);
  const rice = Nutrients(kcal: 365, proteinG: 7.1, carbsG: 80, fiberG: 1.3);

  group('mealTotals', () {
    test('sums the nutrients of every line by grams', () {
      final total = mealTotals(const [
        MealLineInput(per100g: chicken, grams: 200),
        MealLineInput(per100g: rice, grams: 50),
      ]);
      expect(total.kcal, closeTo(240 + 182.5, 1e-9));
      expect(total.proteinG, closeTo(45 + 3.55, 1e-9));
      expect(total.carbsG, closeTo(40, 1e-9));
      expect(total.fiberG, closeTo(0.65, 1e-9));
    });

    test('an empty meal is zero', () {
      expect(mealTotals(const []), Nutrients.zero);
    });

    test('a zero-gram line contributes nothing', () {
      expect(
        mealTotals(const [MealLineInput(per100g: chicken, grams: 0)]),
        Nutrients.zero,
      );
    });
  });

  group('dayTotalsExcludingSlot', () {
    const lunch = Nutrients(kcal: 700, proteinG: 50);
    const dinner = Nutrients(kcal: 600, proteinG: 40);

    test('skips the slot being replaced', () {
      final total = dayTotalsExcludingSlot([
        (slot: 1, nutrients: lunch),
        (slot: 2, nutrients: dinner),
      ], 1);
      expect(total, dinner);
    });

    test('keeps every meal when the slot is empty', () {
      final total = dayTotalsExcludingSlot([
        (slot: 1, nutrients: lunch),
        (slot: 2, nutrients: dinner),
      ], 3);
      expect(total.kcal, 1300);
    });
  });

  group('proteinOutsideRangeG', () {
    final range = Range(50, 55);

    test('is negative below the minimum', () {
      expect(proteinOutsideRangeG(range, 42), -8);
    });

    test('is positive above the maximum', () {
      expect(proteinOutsideRangeG(range, 61), 6);
    });

    test('is zero within the range, bounds included', () {
      expect(proteinOutsideRangeG(range, 50), 0);
      expect(proteinOutsideRangeG(range, 52.5), 0);
      expect(proteinOutsideRangeG(range, 55), 0);
    });
  });
}
