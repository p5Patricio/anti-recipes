import 'package:anti_recipes/core/nutrition/nutrients.dart';
import 'package:anti_recipes/features/recipes/domain/yield_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const chicken = Nutrients(kcal: 120, proteinG: 23, fatG: 2, carbsG: 0);

  YieldCalculator build({double rawG = 1000, double cookedG = 750}) =>
      YieldCalculator([RawIngredient(chicken, rawG)], cookedG);

  test('totals and yield factor', () {
    final y = build();
    expect(y.totalNutrients.kcal, closeTo(1200, 1e-9));
    expect(y.totalNutrients.proteinG, closeTo(230, 1e-9));
    expect(y.yieldFactor, 0.75);
  });

  test('nutrients per cooked gram and portion', () {
    final y = build();
    expect(y.nutrientsPerCookedGram.proteinG, closeTo(0.3067, 1e-4));
    expect(y.nutrientsForCookedPortion(150).proteinG, closeTo(46, 1e-9));
    expect(y.nutrientsForCookedPortion(150).kcal, closeTo(240, 1e-9));
  });

  test('multiple ingredients are summed', () {
    const rice = Nutrients(kcal: 360, proteinG: 7, carbsG: 78);
    final y = YieldCalculator([
      RawIngredient(chicken, 500),
      const RawIngredient(rice, 200),
    ], 1100);
    expect(y.rawTotalG, 700);
    expect(y.totalNutrients.kcal, closeTo(600 + 720, 1e-9));
    expect(y.yieldFactor, closeTo(1100 / 700, 1e-9));
  });

  group('argument errors', () {
    test('empty ingredients', () {
      expect(() => YieldCalculator(const [], 100), throwsArgumentError);
    });
    test('zero or negative raw weight', () {
      expect(() => build(rawG: 0), throwsArgumentError);
      expect(() => build(rawG: -5), throwsArgumentError);
    });
    test('zero or negative cooked weight', () {
      expect(() => build(cookedG: 0), throwsArgumentError);
      expect(() => build(cookedG: -1), throwsArgumentError);
    });
    test('zero or negative portion', () {
      expect(() => build().nutrientsForCookedPortion(0), throwsArgumentError);
      expect(() => build().nutrientsForCookedPortion(-10), throwsArgumentError);
    });
  });
}
