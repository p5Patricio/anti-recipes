import 'package:anti_recipes/core/nutrition/nutrients.dart';
import 'package:anti_recipes/core/nutrition/range.dart';
import 'package:anti_recipes/features/meal_log/domain/day_summary.dart';
import 'package:anti_recipes/features/nutrition_targets/domain/day_type.dart';
import 'package:anti_recipes/features/nutrition_targets/domain/nutrition_engine.dart';
import 'package:anti_recipes/features/nutrition_targets/domain/nutrition_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final engine = NutritionEngine(
    NutritionPlan.exampleDefaults(),
    WeekSchedule.exampleDefaults(),
  );
  final monday = DateTime(2026, 10, 5);
  final wednesday = DateTime(2026, 10, 7);

  DaySummary summarize(
    DateTime date, {
    List<({int slot, Nutrients nutrients})> meals = const [],
    int waterMl = 0,
    int fruit = 0,
    int veg = 0,
  }) => summarizeDay(
    engine,
    date,
    meals: meals,
    waterMl: waterMl,
    fruitPortions: fruit,
    vegPortions: veg,
  );

  test('an empty training day is below every target', () {
    final s = summarize(monday);

    expect(s.dayType, DayType.training);
    expect(s.consumed, Nutrients.zero);
    expect(s.kcal.target, 2450);
    expect(s.kcal.range, Range(2400, 2500));
    expect(s.kcal.status, RangeStatus.below);
    expect(s.kcal.remaining, 2450);
    expect(s.kcal.fraction, 0);
    expect(s.protein.remaining, 160);
    expect(s.carbs.target, closeTo(295, 1e-9));
    expect(s.carbs.remaining, closeTo(295, 1e-9));
    expect(s.fiber.status, RangeStatus.below);
    expect(s.water.range, Range(3500, 4250));
    expect(s.water.status, RangeStatus.below);
    expect(s.fruit.status, RangeStatus.below);
    expect(s.veg.status, RangeStatus.below);
    expect(s.carbsOutsideConfiguredRange, isFalse);
    expect(s.slots.map((m) => m.slot), mealSlots);
    expect(s.slots.every((m) => m.isEmpty), isTrue);
    expect(s.slots.every((m) => m.proteinStatus == null), isTrue);
    expect(s.proteinPerMeal, Range(50, 55));
  });

  test('a rest day uses the smaller water range and flags derived carbs', () {
    final s = summarize(wednesday);

    expect(s.dayType, DayType.rest);
    expect(s.water.range, Range(3000, 3500));
    expect(s.water.target, 3250);
    expect(s.kcal.target, 2275);
    expect(s.carbsOutsideConfiguredRange, isTrue);
  });

  test('sums meals, derives remaining amounts and per-slot protein status', () {
    final s = summarize(
      monday,
      meals: [
        (
          slot: 1,
          nutrients: const Nutrients(
            kcal: 800,
            proteinG: 52,
            fatG: 20,
            carbsG: 90,
            fiberG: 8,
          ),
        ),
        (
          slot: 3,
          nutrients: const Nutrients(
            kcal: 700,
            proteinG: 40,
            fatG: 25,
            carbsG: 80,
            fiberG: 7,
          ),
        ),
      ],
    );

    expect(s.consumed.kcal, 1500);
    expect(s.kcal.remaining, 950);
    expect(s.kcal.fraction, closeTo(1500 / 2450, 1e-9));
    expect(s.protein.consumed, 92);
    expect(s.protein.remaining, 68);
    expect(s.fat.remaining, 25);
    expect(s.carbs.remaining, closeTo(295 - 170, 1e-9));
    expect(s.fiber.consumed, 15);
    expect(s.slots[0].proteinStatus, RangeStatus.within);
    expect(s.slots[1].isEmpty, isTrue);
    expect(s.slots[2].proteinStatus, RangeStatus.below);
    expect(s.slots[2].proteinG, 40);
  });

  test('going over the calories reports above and a negative remainder', () {
    final s = summarize(
      monday,
      meals: [(slot: 1, nutrients: const Nutrients(kcal: 2600))],
    );

    expect(s.kcal.status, RangeStatus.above);
    expect(s.kcal.remaining, -150);
    expect(s.kcal.fraction, 1);
  });

  test('single-value targets allow a 5% band', () {
    expect(singleTargetStatus(153, 160), RangeStatus.within);
    expect(singleTargetStatus(167, 160), RangeStatus.within);
    expect(singleTargetStatus(150, 160), RangeStatus.below);
    expect(singleTargetStatus(170, 160), RangeStatus.above);
  });

  test('hydration and servings are judged against the day-type ranges', () {
    final s = summarize(monday, waterMl: 3600, fruit: 4, veg: 2);

    expect(s.water.status, RangeStatus.within);
    expect(s.fruit.status, RangeStatus.above);
    expect(s.veg.status, RangeStatus.within);
    expect(s.veg.range, Range(2, 3));
  });
}
