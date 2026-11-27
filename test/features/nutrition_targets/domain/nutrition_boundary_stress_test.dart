import 'package:anti_recipes/core/nutrition/nutrients.dart';
import 'package:anti_recipes/core/nutrition/range.dart';
import 'package:anti_recipes/features/nutrition_targets/domain/day_type.dart';
import 'package:anti_recipes/features/nutrition_targets/domain/nutrition_engine.dart';
import 'package:anti_recipes/features/nutrition_targets/domain/nutrition_plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final schedule = WeekSchedule.exampleDefaults();
  final wednesday = DateTime(2026, 10, 7); // Wednesday is DayType.rest
  final monday = DateTime(2026, 10, 5); // Monday is DayType.training

  NutritionPlan createPlan({
    double protein = 160,
    double fat = 70,
    Range? restKcal,
    Range? restCarbs,
    Range? trainingKcal,
    Range? trainingCarbs,
  }) {
    return NutritionPlan(
      proteinGPerDay: protein,
      fatGPerDay: fat,
      mealsPerDay: 3,
      proteinPerMeal: Range(50, 55),
      dayTypes: {
        DayType.training: DayTypeTargets(
          kcal: trainingKcal ?? Range(2400, 2500),
          carbs: trainingCarbs ?? Range(270, 305),
          fiber: Range(30, 35),
          waterMl: Range(3500, 4250),
          fruitPortions: Range(1, 3),
          vegPortions: Range(2, 3),
        ),
        DayType.rest: DayTypeTargets(
          kcal: restKcal ?? Range(2230, 2320),
          carbs: restCarbs ?? Range(245, 305),
          fiber: Range(30, 35),
          waterMl: Range(3000, 3500),
          fruitPortions: Range(1, 3),
          vegPortions: Range(2, 3),
        ),
      },
    );
  }

  group('Stress Test 1: Rest-day Midpoint (Default Targets)', () {
    test(
      'Default rest-day targets derive 251.25g carbs and yield 0 warnings',
      () {
        final plan = NutritionPlan.exampleDefaults();
        final engine = NutritionEngine(plan, schedule);
        final targets = engine.targetsFor(wednesday);

        expect(targets.dayType, DayType.rest);
        expect(targets.kcal, 2275.0);
        expect(targets.proteinG, 160.0);
        expect(targets.fatG, 70.0);
        expect(targets.carbsG, 251.25);
        expect(targets.ranges.carbs.min, 245.0);
        expect(targets.ranges.carbs.max, 305.0);
        expect(targets.warnings, isEmpty);

        // Reconcile with energy math
        final totalKcal = kcalFromMacros(
          proteinG: targets.proteinG,
          fatG: targets.fatG,
          carbsG: targets.carbsG,
        );
        expect(totalKcal, 2275.0);
      },
    );
  });

  group('Stress Test 2: Boundary Kcal Midpoints for Rest Days', () {
    test('Lower bound kcal (2230): derived carbs = 240.0g triggers carbsOutsideConfiguredRange', () {
      final plan = createPlan(
        restKcal: Range(2230, 2230), // Midpoint = 2230
      );
      final engine = NutritionEngine(plan, schedule);
      final targets = engine.targetsFor(wednesday);

      expect(targets.kcal, 2230.0);
      // (2230 - 160*4 - 70*9) / 4 = (2230 - 640 - 630) / 4 = 960 / 4 = 240.0
      expect(targets.carbsG, 240.0);
      // 240.0 is below 245.0 -> MUST trigger warning
      expect(
        targets.warnings,
        contains(TargetWarning.carbsOutsideConfiguredRange),
      );
    });

    test('Upper bound kcal (2320): derived carbs = 262.5g stays within [245, 305] (0 warnings)', () {
      final plan = createPlan(
        restKcal: Range(2320, 2320), // Midpoint = 2320
      );
      final engine = NutritionEngine(plan, schedule);
      final targets = engine.targetsFor(wednesday);

      expect(targets.kcal, 2320.0);
      // (2320 - 160*4 - 70*9) / 4 = (2320 - 1270) / 4 = 1050 / 4 = 262.5
      expect(targets.carbsG, 262.5);
      // 262.5 is within [245, 305] -> 0 warnings
      expect(targets.warnings, isEmpty);
    });

    test('Exact lower threshold kcal (2250.0): derived carbs = 245.0g is exactly at floor (0 warnings)', () {
      final plan = createPlan(
        restKcal: Range(2250, 2250), // Midpoint = 2250
      );
      final engine = NutritionEngine(plan, schedule);
      final targets = engine.targetsFor(wednesday);

      expect(targets.kcal, 2250.0);
      // (2250 - 1270) / 4 = 980 / 4 = 245.0
      expect(targets.carbsG, 245.0);
      // Range.contains(245.0) is inclusive -> 0 warnings
      expect(targets.warnings, isEmpty);
    });

    test('Slightly below lower threshold (2249.96 kcal): derived carbs = 244.99g triggers warning', () {
      final plan = createPlan(restKcal: Range(2249.96, 2249.96));
      final engine = NutritionEngine(plan, schedule);
      final targets = engine.targetsFor(wednesday);

      expect(targets.carbsG, closeTo(244.99, 1e-4));
      expect(
        targets.warnings,
        contains(TargetWarning.carbsOutsideConfiguredRange),
      );
    });

    test('Exact upper threshold kcal (2490.0): derived carbs = 305.0g is exactly at ceiling (0 warnings)', () {
      final plan = createPlan(restKcal: Range(2490, 2490));
      final engine = NutritionEngine(plan, schedule);
      final targets = engine.targetsFor(wednesday);

      expect(targets.kcal, 2490.0);
      // (2490 - 1270) / 4 = 1220 / 4 = 305.0
      expect(targets.carbsG, 305.0);
      expect(targets.warnings, isEmpty);
    });

    test('Slightly above upper threshold (2490.04 kcal): derived carbs = 305.01g triggers warning', () {
      final plan = createPlan(restKcal: Range(2490.04, 2490.04));
      final engine = NutritionEngine(plan, schedule);
      final targets = engine.targetsFor(wednesday);

      expect(targets.carbsG, closeTo(305.01, 1e-4));
      expect(
        targets.warnings,
        contains(TargetWarning.carbsOutsideConfiguredRange),
      );
    });
  });

  group('Stress Test 3: User Target Mutations', () {
    test('Higher protein (180g) lowers derived carbs to 231.25g -> triggers warning', () {
      final plan = createPlan(protein: 180);
      final engine = NutritionEngine(plan, schedule);
      final targets = engine.targetsFor(wednesday);

      // (2275 - 180*4 - 70*9) / 4 = (2275 - 720 - 630) / 4 = 925 / 4 = 231.25
      expect(targets.carbsG, 231.25);
      expect(
        targets.warnings,
        contains(TargetWarning.carbsOutsideConfiguredRange),
      );
    });

    test('Lower protein (140g) raises derived carbs to 271.25g -> within [245, 305], 0 warnings', () {
      final plan = createPlan(protein: 140);
      final engine = NutritionEngine(plan, schedule);
      final targets = engine.targetsFor(wednesday);

      // (2275 - 140*4 - 70*9) / 4 = (2275 - 560 - 630) / 4 = 1085 / 4 = 271.25
      expect(targets.carbsG, 271.25);
      expect(targets.warnings, isEmpty);
    });

    test(
      'Higher fat (85g) lowers derived carbs to 217.5g -> triggers warning',
      () {
        final plan = createPlan(fat: 85);
        final engine = NutritionEngine(plan, schedule);
        final targets = engine.targetsFor(wednesday);

        // (2275 - 160*4 - 85*9) / 4 = (2275 - 640 - 765) / 4 = 870 / 4 = 217.5
        expect(targets.carbsG, 217.5);
        expect(
          targets.warnings,
          contains(TargetWarning.carbsOutsideConfiguredRange),
        );
      },
    );

    test('Lower fat (50g) raises derived carbs to 296.25g -> within [245, 305], 0 warnings', () {
      final plan = createPlan(fat: 50);
      final engine = NutritionEngine(plan, schedule);
      final targets = engine.targetsFor(wednesday);

      // (2275 - 160*4 - 50*9) / 4 = (2275 - 640 - 450) / 4 = 1185 / 4 = 296.25
      expect(targets.carbsG, 296.25);
      expect(targets.warnings, isEmpty);
    });

    test(
      'Extremely high fat (180g) leaves 3.75g carbs -> triggers warning',
      () {
        final plan = createPlan(fat: 180);
        final engine = NutritionEngine(plan, schedule);
        final targets = engine.targetsFor(wednesday);

        // (2275 - 160*4 - 180*9) / 4 = (2275 - 640 - 1620) / 4 = 15 / 4 = 3.75
        expect(targets.carbsG, 3.75);
        expect(
          targets.warnings,
          contains(TargetWarning.carbsOutsideConfiguredRange),
        );
      },
    );

    test('Impossible macros exceeding kcal (protein 200g, fat 170g) yields negative carbs -> triggers warning', () {
      final plan = createPlan(protein: 200, fat: 170);
      final engine = NutritionEngine(plan, schedule);
      final targets = engine.targetsFor(wednesday);

      // (2275 - 200*4 - 170*9) / 4 = (2275 - 800 - 1530) / 4 = -55 / 4 = -13.75
      expect(targets.carbsG, -13.75);
      expect(
        targets.warnings,
        contains(TargetWarning.carbsOutsideConfiguredRange),
      );
    });

    test('Custom carb range: floor raised to 260g -> derived 251.25g triggers warning', () {
      final plan = createPlan(restCarbs: Range(260, 305));
      final engine = NutritionEngine(plan, schedule);
      final targets = engine.targetsFor(wednesday);

      expect(targets.carbsG, 251.25);
      expect(
        targets.warnings,
        contains(TargetWarning.carbsOutsideConfiguredRange),
      );
    });

    test('Custom carb range: ceiling lowered to 250g -> derived 251.25g triggers warning', () {
      final plan = createPlan(restCarbs: Range(240, 250));
      final engine = NutritionEngine(plan, schedule);
      final targets = engine.targetsFor(wednesday);

      expect(targets.carbsG, 251.25);
      expect(
        targets.warnings,
        contains(TargetWarning.carbsOutsideConfiguredRange),
      );
    });

    test('Custom carb range: widened to [200, 320] -> derived 251.25g yields 0 warnings', () {
      final plan = createPlan(restCarbs: Range(200, 320));
      final engine = NutritionEngine(plan, schedule);
      final targets = engine.targetsFor(wednesday);

      expect(targets.carbsG, 251.25);
      expect(targets.warnings, isEmpty);
    });
  });

  group('Stress Test 4: Training Day Boundaries', () {
    test('Default training day (midpoint 2450 kcal) derives 295.0g carbs within [270, 305]', () {
      final plan = NutritionPlan.exampleDefaults();
      final engine = NutritionEngine(plan, schedule);
      final targets = engine.targetsFor(monday);

      expect(targets.dayType, DayType.training);
      expect(targets.kcal, 2450.0);
      expect(targets.carbsG, 295.0);
      expect(targets.warnings, isEmpty);
    });

    test('Training lower bound kcal (2400): derived carbs = 282.5g stays within [270, 305] (0 warnings)', () {
      final plan = createPlan(trainingKcal: Range(2400, 2400));
      final engine = NutritionEngine(plan, schedule);
      final targets = engine.targetsFor(monday);

      // (2400 - 1270) / 4 = 1130 / 4 = 282.5
      expect(targets.carbsG, 282.5);
      expect(targets.warnings, isEmpty);
    });

    test('Training upper bound kcal (2500): derived carbs = 307.5g exceeds 305g -> triggers warning', () {
      final plan = createPlan(trainingKcal: Range(2500, 2500));
      final engine = NutritionEngine(plan, schedule);
      final targets = engine.targetsFor(monday);

      // (2500 - 1270) / 4 = 1230 / 4 = 307.5
      expect(targets.carbsG, 307.5);
      expect(
        targets.warnings,
        contains(TargetWarning.carbsOutsideConfiguredRange),
      );
    });
  });
}
