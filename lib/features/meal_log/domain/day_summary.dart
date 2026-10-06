import '../../../core/nutrition/nutrients.dart';
import '../../../core/nutrition/range.dart';
import '../../nutrition_targets/domain/day_type.dart';
import '../../nutrition_targets/domain/nutrition_engine.dart';

/// Meal slots offered per day (matches the `MealLogs.slot` check constraint).
const mealSlots = [1, 2, 3];

/// Relative band around single-value targets (protein, fat, carbs) that still
/// counts as "within" the target.
const singleTargetTolerance = 0.05;

/// Consumed amount of one metric against its target.
class MetricProgress {
  const MetricProgress({
    required this.consumed,
    required this.target,
    required this.status,
    this.range,
  });

  final double consumed;

  /// Single value the bar fills against (midpoint for range-based metrics).
  final double target;

  /// Configured range, when the metric has one.
  final Range? range;
  final RangeStatus status;

  /// Negative when the target is exceeded.
  double get remaining => target - consumed;

  /// Bar fill in 0..1.
  double get fraction =>
      target <= 0 ? 0 : (consumed / target).clamp(0.0, 1.0).toDouble();
}

/// One of the day's meal slots; [nutrients] is null while the slot is empty.
class MealSlotSummary {
  const MealSlotSummary({
    required this.slot,
    required this.nutrients,
    required this.proteinStatus,
  });

  final int slot;
  final Nutrients? nutrients;
  final RangeStatus? proteinStatus;

  bool get isEmpty => nutrients == null;
  double get proteinG => nutrients?.proteinG ?? 0;
}

/// Everything the Today dashboard shows, ready to render.
class DaySummary {
  const DaySummary({
    required this.date,
    required this.dayType,
    required this.consumed,
    required this.kcal,
    required this.protein,
    required this.fat,
    required this.carbs,
    required this.fiber,
    required this.water,
    required this.fruit,
    required this.veg,
    required this.slots,
    required this.proteinPerMeal,
    required this.carbsOutsideConfiguredRange,
  });

  final DateTime date;
  final DayType dayType;
  final Nutrients consumed;
  final MetricProgress kcal;
  final MetricProgress protein;
  final MetricProgress fat;
  final MetricProgress carbs;
  final MetricProgress fiber;

  /// In ml.
  final MetricProgress water;

  /// Portions.
  final MetricProgress fruit;
  final MetricProgress veg;
  final List<MealSlotSummary> slots;
  final Range proteinPerMeal;

  /// The derived carbs target lies outside the configured carbs range.
  final bool carbsOutsideConfiguredRange;
}

/// Statuses for a single-value target: within [singleTargetTolerance] of it.
RangeStatus singleTargetStatus(double consumed, double target) => Range(
  target * (1 - singleTargetTolerance),
  target * (1 + singleTargetTolerance),
).status(consumed);

/// Combines the logged meals ([slot] plus nutrients), hydration and servings
/// of [date] with the engine's targets.
DaySummary summarizeDay(
  NutritionEngine engine,
  DateTime date, {
  required Iterable<({int slot, Nutrients nutrients})> meals,
  required int waterMl,
  required int fruitPortions,
  required int vegPortions,
}) {
  final targets = engine.targetsFor(date);
  final consumed = Nutrients.sum(meals.map((m) => m.nutrients));
  final progress = engine.progress(
    date,
    consumed: consumed,
    waterMl: waterMl,
    fruitPortions: fruitPortions,
    vegPortions: vegPortions,
  );
  final ranges = targets.ranges;

  MetricProgress single(double value, double target) => MetricProgress(
    consumed: value,
    target: target,
    status: singleTargetStatus(value, target),
  );

  MetricProgress ranged(double value, Range range, RangeStatus status) =>
      MetricProgress(
        consumed: value,
        target: range.midpoint,
        range: range,
        status: status,
      );

  final bySlot = {for (final m in meals) m.slot: m.nutrients};
  return DaySummary(
    date: date,
    dayType: targets.dayType,
    consumed: consumed,
    kcal: ranged(consumed.kcal, ranges.kcal, progress.kcal),
    protein: single(consumed.proteinG, targets.proteinG),
    fat: single(consumed.fatG, targets.fatG),
    carbs: MetricProgress(
      consumed: consumed.carbsG,
      target: targets.carbsG,
      range: ranges.carbs,
      status: singleTargetStatus(consumed.carbsG, targets.carbsG),
    ),
    fiber: ranged(consumed.fiberG, ranges.fiber, progress.fiber),
    water: ranged(waterMl.toDouble(), ranges.waterMl, progress.water),
    fruit: ranged(
      fruitPortions.toDouble(),
      ranges.fruitPortions,
      progress.fruit,
    ),
    veg: ranged(vegPortions.toDouble(), ranges.vegPortions, progress.veg),
    slots: [
      for (final slot in mealSlots)
        MealSlotSummary(
          slot: slot,
          nutrients: bySlot[slot],
          proteinStatus: bySlot[slot] == null
              ? null
              : engine.checkMeal(bySlot[slot]!).protein,
        ),
    ],
    proteinPerMeal: engine.plan.proteinPerMeal,
    carbsOutsideConfiguredRange: targets.warnings.contains(
      TargetWarning.carbsOutsideConfiguredRange,
    ),
  );
}
