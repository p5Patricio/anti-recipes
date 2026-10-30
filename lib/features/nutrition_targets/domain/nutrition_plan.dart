import '../../../core/nutrition/nutrients.dart';
import '../../../core/nutrition/range.dart';
import 'day_type.dart';

/// Per-day-type targets that are ranges.
class DayTypeTargets {
  const DayTypeTargets({
    required this.kcal,
    required this.carbs,
    required this.fiber,
    required this.waterMl,
    required this.fruitPortions,
    required this.vegPortions,
  });

  final Range kcal;
  final Range carbs;
  final Range fiber;
  final Range waterMl;
  final Range fruitPortions;
  final Range vegPortions;
}

/// Maps weekday (1 = Monday .. 7 = Sunday) to a [DayType].
class WeekSchedule {
  /// Throws [ArgumentError] unless weekdays 1..7 are all present.
  factory WeekSchedule(Map<int, DayType> days) {
    final complete =
        days.length == 7 &&
        List.generate(7, (i) => i + 1).every(days.containsKey);
    if (!complete) {
      throw ArgumentError('Schedule must define weekdays 1..7');
    }
    return WeekSchedule._(Map.unmodifiable(days));
  }

  const WeekSchedule._(this.days);

  /// Mon, Tue, Thu, Fri training; Wed, Sat, Sun rest.
  factory WeekSchedule.exampleDefaults() => WeekSchedule({
    DateTime.monday: DayType.training,
    DateTime.tuesday: DayType.training,
    DateTime.wednesday: DayType.rest,
    DateTime.thursday: DayType.training,
    DateTime.friday: DayType.training,
    DateTime.saturday: DayType.rest,
    DateTime.sunday: DayType.rest,
  });

  final Map<int, DayType> days;

  /// Uses the local calendar weekday (UTC inputs are converted to local first).
  DayType dayTypeFor(DateTime date) => days[date.toLocal().weekday]!;
}

class NutritionPlan {
  /// Throws [ArgumentError] for non-positive meals, protein or fat, or when a
  /// [DayType] has no targets.
  NutritionPlan({
    required this.proteinGPerDay,
    required this.fatGPerDay,
    required this.mealsPerDay,
    required this.proteinPerMeal,
    required Map<DayType, DayTypeTargets> dayTypes,
  }) : dayTypes = Map.unmodifiable(dayTypes) {
    if (mealsPerDay < 1) {
      throw ArgumentError('mealsPerDay must be >= 1');
    }
    if (!(proteinGPerDay > 0)) {
      throw ArgumentError('proteinGPerDay must be > 0');
    }
    if (!(fatGPerDay > 0)) {
      throw ArgumentError('fatGPerDay must be > 0');
    }
    for (final type in DayType.values) {
      if (!dayTypes.containsKey(type)) {
        throw ArgumentError('Missing targets for day type ${type.name}');
      }
    }
  }

  /// Example values only; real user data is never committed.
  factory NutritionPlan.exampleDefaults() => NutritionPlan(
    proteinGPerDay: 160,
    fatGPerDay: 70,
    mealsPerDay: 3,
    proteinPerMeal: Range(50, 55),
    dayTypes: {
      DayType.training: DayTypeTargets(
        kcal: Range(2400, 2500),
        carbs: Range(270, 305),
        fiber: Range(30, 35),
        waterMl: Range(3500, 4250),
        fruitPortions: Range(1, 3),
        vegPortions: Range(2, 3),
      ),
      DayType.rest: DayTypeTargets(
        kcal: Range(2230, 2320),
        carbs: Range(270, 305),
        fiber: Range(30, 35),
        waterMl: Range(3000, 3500),
        fruitPortions: Range(1, 3),
        vegPortions: Range(2, 3),
      ),
    },
  );

  final double proteinGPerDay;
  final double fatGPerDay;
  final int mealsPerDay;
  final Range proteinPerMeal;
  final Map<DayType, DayTypeTargets> dayTypes;

  DayTypeTargets targetsFor(DayType type) => dayTypes[type]!;

  /// Carbs (g) left after protein and fat at the kcal midpoint of [type].
  double derivedCarbsG(DayType type) =>
      (targetsFor(type).kcal.midpoint -
          proteinGPerDay * kcalPerGramProtein -
          fatGPerDay * kcalPerGramFat) /
      kcalPerGramCarbs;
}
