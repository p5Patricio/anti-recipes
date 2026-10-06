import 'package:anti_recipes/core/nutrition/nutrients.dart';
import 'package:anti_recipes/core/nutrition/range.dart';
import 'package:anti_recipes/features/nutrition_targets/domain/day_type.dart';
import 'package:anti_recipes/features/nutrition_targets/domain/nutrition_engine.dart';
import 'package:anti_recipes/features/nutrition_targets/domain/nutrition_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final engine = NutritionEngine(
    NutritionPlan.exampleDefaults(),
    WeekSchedule.exampleDefaults(),
  );
  // 2026-10-05 is a Monday (training); 2026-10-07 is a Wednesday (rest).
  final monday = DateTime(2026, 10, 5);
  final wednesday = DateTime(2026, 10, 7);

  group('schedule', () {
    test('default weekday mapping', () {
      final s = WeekSchedule.exampleDefaults();
      expect(s.dayTypeFor(monday), DayType.training);
      expect(s.dayTypeFor(DateTime(2026, 10, 8)), DayType.training); // Thu
      expect(s.dayTypeFor(wednesday), DayType.rest);
      expect(s.dayTypeFor(DateTime(2026, 10, 11)), DayType.rest); // Sun
    });
  });

  group('validation', () {
    final base = NutritionPlan.exampleDefaults();
    NutritionPlan build({
      double protein = 160,
      double fat = 70,
      int meals = 3,
      Map<DayType, DayTypeTargets>? types,
    }) => NutritionPlan(
      proteinGPerDay: protein,
      fatGPerDay: fat,
      mealsPerDay: meals,
      proteinPerMeal: Range(50, 55),
      dayTypes: types ?? base.dayTypes,
    );

    test('plan rejects invalid meals, protein, fat and missing day types', () {
      expect(() => build(meals: 0), throwsArgumentError);
      expect(() => build(protein: 0), throwsArgumentError);
      expect(() => build(fat: -1), throwsArgumentError);
      expect(
        () => build(types: {DayType.rest: base.targetsFor(DayType.rest)}),
        throwsArgumentError,
      );
      expect(build, returnsNormally);
    });

    test('schedule requires all weekdays 1..7', () {
      expect(
        () => WeekSchedule({1: DayType.rest, 2: DayType.rest}),
        throwsArgumentError,
      );
      expect(
        () => WeekSchedule({
          for (var i = 1; i <= 6; i++) i: DayType.rest,
          8: DayType.rest,
        }),
        throwsArgumentError,
      );
    });

    test('dayTypeFor uses the local calendar weekday', () {
      final s = WeekSchedule.exampleDefaults();
      final utcMonday = DateTime.utc(2026, 10, 5, 12);
      expect(s.dayTypeFor(utcMonday), s.days[utcMonday.toLocal().weekday]);
    });
  });

  group('targetsFor', () {
    test('training day derives 295 g carbs at 2450 kcal, no warnings', () {
      final t = engine.targetsFor(monday);
      expect(t.dayType, DayType.training);
      expect(t.kcal, 2450);
      expect(t.proteinG, 160);
      expect(t.fatG, 70);
      expect(t.carbsG, closeTo(295, 1e-9));
      expect(t.warnings, isEmpty);
    });

    test('rest day derives ~251 g carbs and flags the configured range', () {
      final t = engine.targetsFor(wednesday);
      expect(t.dayType, DayType.rest);
      expect(t.kcal, 2275);
      expect(t.carbsG, closeTo(251.25, 1e-9));
      expect(t.warnings, contains(TargetWarning.carbsOutsideConfiguredRange));
    });

    test('protein per meal target is protein / meals', () {
      expect(engine.targetsFor(monday).proteinPerMealG, closeTo(53.33, 0.01));
    });

    test('derived carbs reconcile with kcal', () {
      final t = engine.targetsFor(wednesday);
      expect(
        kcalFromMacros(proteinG: t.proteinG, fatG: t.fatG, carbsG: t.carbsG),
        closeTo(t.kcal, 1e-9),
      );
    });
  });

  test('weeklyAverageKcal follows the schedule', () {
    expect(
      engine.weeklyAverageKcal(),
      closeTo((4 * 2450 + 3 * 2275) / 7, 1e-9),
    );
  });

  group('checkMeal', () {
    test('below / within / above', () {
      Nutrients meal(double p) => Nutrients(proteinG: p);
      expect(engine.checkMeal(meal(45)).protein, RangeStatus.below);
      expect(engine.checkMeal(meal(53)).protein, RangeStatus.within);
      expect(engine.checkMeal(meal(60)).protein, RangeStatus.above);
    });
  });

  group('progress', () {
    test('training day remaining values and statuses', () {
      final p = engine.progress(
        monday,
        consumed: const Nutrients(
          kcal: 1500,
          proteinG: 100,
          fatG: 40,
          carbsG: 200,
          fiberG: 20,
        ),
        waterMl: 3600,
        fruitPortions: 0,
        vegPortions: 2,
      );
      expect(p.remainingKcal, 950);
      expect(p.remainingProteinG, 60);
      expect(p.remainingFatG, 30);
      expect(p.remainingCarbsG, closeTo(95, 1e-9));
      expect(p.kcal, RangeStatus.below);
      expect(p.fiber, RangeStatus.below);
      expect(p.water, RangeStatus.within); // 3600 within 3500-4250
      expect(p.fruit, RangeStatus.below);
      expect(p.veg, RangeStatus.within);
    });

    test('water 3400 ml is below on training day but within on rest day', () {
      const none = Nutrients.zero;
      final train = engine.progress(
        monday,
        consumed: none,
        waterMl: 3400,
        fruitPortions: 1,
        vegPortions: 2,
      );
      final rest = engine.progress(
        wednesday,
        consumed: none,
        waterMl: 3400,
        fruitPortions: 1,
        vegPortions: 2,
      );
      expect(train.water, RangeStatus.below);
      expect(rest.water, RangeStatus.within);
    });

    test('exceeding targets gives negative remaining and above status', () {
      final p = engine.progress(
        monday,
        consumed: const Nutrients(kcal: 2600, proteinG: 170, fiberG: 40),
        waterMl: 5000,
        fruitPortions: 4,
        vegPortions: 4,
      );
      expect(p.remainingKcal, -150);
      expect(p.remainingProteinG, -10);
      expect(p.kcal, RangeStatus.above);
      expect(p.fiber, RangeStatus.above);
      expect(p.water, RangeStatus.above);
      expect(p.fruit, RangeStatus.above);
      expect(p.veg, RangeStatus.above);
    });
  });
}
