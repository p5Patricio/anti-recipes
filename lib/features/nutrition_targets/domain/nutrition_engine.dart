import '../../../core/nutrition/nutrients.dart';
import '../../../core/nutrition/range.dart';
import 'day_type.dart';
import 'nutrition_plan.dart';

enum TargetWarning {
  /// Carbs derived from the kcal residual fall outside the configured range.
  carbsOutsideConfiguredRange,
}

class DailyTargets {
  const DailyTargets({
    required this.dayType,
    required this.kcal,
    required this.proteinG,
    required this.fatG,
    required this.carbsG,
    required this.proteinPerMealG,
    required this.ranges,
    required this.warnings,
  });

  final DayType dayType;
  final double kcal;
  final double proteinG;
  final double fatG;

  /// Derived from the kcal residual (source of truth), not from the carbs range.
  final double carbsG;
  final double proteinPerMealG;
  final DayTypeTargets ranges;
  final List<TargetWarning> warnings;
}

class MealCheck {
  const MealCheck({required this.protein});
  final RangeStatus protein;
}

class DayProgress {
  const DayProgress({
    required this.remainingKcal,
    required this.remainingProteinG,
    required this.remainingFatG,
    required this.remainingCarbsG,
    required this.kcal,
    required this.fiber,
    required this.water,
    required this.fruit,
    required this.veg,
  });

  /// Remaining amounts may be negative when the target is exceeded.
  final double remainingKcal;
  final double remainingProteinG;
  final double remainingFatG;
  final double remainingCarbsG;
  final RangeStatus kcal;
  final RangeStatus fiber;
  final RangeStatus water;
  final RangeStatus fruit;
  final RangeStatus veg;
}

class NutritionEngine {
  const NutritionEngine(this.plan, this.schedule);

  final NutritionPlan plan;
  final WeekSchedule schedule;

  DailyTargets targetsFor(DateTime date) {
    final dayType = schedule.dayTypeFor(date);
    final ranges = plan.targetsFor(dayType);
    final kcal = ranges.kcal.midpoint;
    final carbs = plan.derivedCarbsG(dayType);
    return DailyTargets(
      dayType: dayType,
      kcal: kcal,
      proteinG: plan.proteinGPerDay,
      fatG: plan.fatGPerDay,
      carbsG: carbs,
      proteinPerMealG: plan.proteinGPerDay / plan.mealsPerDay,
      ranges: ranges,
      warnings: [
        if (!ranges.carbs.contains(carbs))
          TargetWarning.carbsOutsideConfiguredRange,
      ],
    );
  }

  /// Mean of the kcal targets across the seven weekdays.
  double weeklyAverageKcal() {
    final total = schedule.days.values.fold<double>(
      0,
      (sum, t) => sum + plan.targetsFor(t).kcal.midpoint,
    );
    return total / schedule.days.length;
  }

  MealCheck checkMeal(Nutrients meal) =>
      MealCheck(protein: plan.proteinPerMeal.status(meal.proteinG));

  DayProgress progress(
    DateTime date, {
    required Nutrients consumed,
    required int waterMl,
    required int fruitPortions,
    required int vegPortions,
  }) {
    final t = targetsFor(date);
    return DayProgress(
      remainingKcal: t.kcal - consumed.kcal,
      remainingProteinG: t.proteinG - consumed.proteinG,
      remainingFatG: t.fatG - consumed.fatG,
      remainingCarbsG: t.carbsG - consumed.carbsG,
      kcal: t.ranges.kcal.status(consumed.kcal),
      fiber: t.ranges.fiber.status(consumed.fiberG),
      water: t.ranges.waterMl.status(waterMl.toDouble()),
      fruit: t.ranges.fruitPortions.status(fruitPortions.toDouble()),
      veg: t.ranges.vegPortions.status(vegPortions.toDouble()),
    );
  }
}
