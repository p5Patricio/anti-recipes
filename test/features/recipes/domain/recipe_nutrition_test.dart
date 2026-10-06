import 'package:anti_recipes/core/nutrition/nutrients.dart';
import 'package:anti_recipes/features/recipes/domain/energy_check.dart';
import 'package:anti_recipes/features/recipes/domain/recipe_nutrition.dart';
import 'package:anti_recipes/features/recipes/domain/yield_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const chicken = Nutrients(kcal: 120, proteinG: 22.5, fatG: 2.6);
  const rice = Nutrients(kcal: 365, proteinG: 7, fatG: 1, carbsG: 80);

  group('RecipeNutrition', () {
    test('weights and totals', () {
      final n = RecipeNutrition(const [
        RawIngredient(chicken, 400),
        RawIngredient(rice, 100),
      ], 0.8);
      expect(n.rawTotalG, 500);
      expect(n.cookedTotalG, closeTo(400, 1e-9));
      expect(n.total.kcal, closeTo(480 + 365, 1e-9));
      expect(n.total.carbsG, closeTo(80, 1e-9));
    });

    test('per 100 g cooked divides by cooked weight', () {
      final n = RecipeNutrition(const [RawIngredient(chicken, 1000)], 0.75);
      // 1200 kcal over 750 g cooked.
      expect(n.per100Cooked.kcal, closeTo(160, 1e-9));
      expect(n.per100Cooked.proteinG, closeTo(30, 1e-9));
    });

    test('yield factor 1 keeps raw density', () {
      final n = RecipeNutrition(const [RawIngredient(chicken, 250)], 1);
      expect(n.per100Cooked.kcal, closeTo(120, 1e-9));
    });

    test('empty recipe is zero without dividing by zero', () {
      final n = RecipeNutrition(const [], 0.75);
      expect(n.rawTotalG, 0);
      expect(n.total, Nutrients.zero);
      expect(n.per100Cooked, Nutrients.zero);
    });
  });

  group('kcalDeviatesFromMacros', () {
    test('consistent values pass', () {
      expect(
        kcalDeviatesFromMacros(kcal: 120, proteinG: 22.5, fatG: 2.6, carbsG: 0),
        isFalse,
      );
    });

    test('more than 15% off is flagged', () {
      expect(
        kcalDeviatesFromMacros(kcal: 300, proteinG: 10, fatG: 5, carbsG: 20),
        isTrue,
      );
    });

    test('exactly at the tolerance edge is accepted', () {
      // Implied 100 kcal, declared 115.
      expect(
        kcalDeviatesFromMacros(kcal: 115, proteinG: 25, fatG: 0, carbsG: 0),
        isFalse,
      );
    });

    test('kcal with no macros is flagged, all zero is not', () {
      expect(
        kcalDeviatesFromMacros(kcal: 50, proteinG: 0, fatG: 0, carbsG: 0),
        isTrue,
      );
      expect(
        kcalDeviatesFromMacros(kcal: 0, proteinG: 0, fatG: 0, carbsG: 0),
        isFalse,
      );
    });
  });
}
