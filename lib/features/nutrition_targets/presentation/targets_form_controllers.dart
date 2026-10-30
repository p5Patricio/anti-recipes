import 'package:flutter/widgets.dart';

import '../../../core/nutrition/range.dart';
import '../../../core/widgets/number_fields.dart';
import '../domain/day_type.dart';
import '../domain/nutrition_plan.dart';

/// Range-valued targets edited per day type.
enum TargetField {
  kcal('Calories', 'kcal'),
  carbs('Carbs', 'g'),
  fiber('Fiber', 'g'),
  water('Water', 'ml'),
  fruit('Fruit', 'portions'),
  veg('Vegetables', 'portions');

  const TargetField(this.label, this.unit);
  final String label;
  final String unit;

  Range pick(DayTypeTargets t) => switch (this) {
    kcal => t.kcal,
    carbs => t.carbs,
    fiber => t.fiber,
    water => t.waterMl,
    fruit => t.fruitPortions,
    veg => t.vegPortions,
  };
}

class RangeControllers {
  final min = TextEditingController();
  final max = TextEditingController();

  void dispose() {
    min.dispose();
    max.dispose();
  }
}

/// Owns every text controller of the targets form and maps them to the domain.
class TargetsFormControllers {
  TargetsFormControllers(NutritionPlan plan, double? weightKg) {
    fill(plan, weightKg);
  }

  final weight = TextEditingController();
  final protein = TextEditingController();
  final fat = TextEditingController();
  final meals = TextEditingController();
  final proteinPerMeal = RangeControllers();
  final Map<DayType, Map<TargetField, RangeControllers>> dayTypes = {
    for (final type in DayType.values)
      type: {for (final f in TargetField.values) f: RangeControllers()},
  };

  void fill(NutritionPlan plan, double? weightKg) {
    weight.text = weightKg == null ? '' : formatNumber(weightKg);
    protein.text = formatNumber(plan.proteinGPerDay);
    fat.text = formatNumber(plan.fatGPerDay);
    meals.text = plan.mealsPerDay.toString();
    proteinPerMeal.min.text = formatNumber(plan.proteinPerMeal.min);
    proteinPerMeal.max.text = formatNumber(plan.proteinPerMeal.max);
    for (final type in DayType.values) {
      for (final f in TargetField.values) {
        final r = f.pick(plan.targetsFor(type));
        dayTypes[type]![f]!.min.text = formatNumber(r.min);
        dayTypes[type]![f]!.max.text = formatNumber(r.max);
      }
    }
  }

  double? get weightKg => parseNumber(weight.text);

  /// Builds the plan from the current text. Throws [ArgumentError] when a
  /// field is missing or the domain rejects the values.
  NutritionPlan read() {
    double need(TextEditingController c) =>
        parseNumber(c.text) ?? (throw ArgumentError('Fill in all fields'));
    Range range(RangeControllers c) => Range(need(c.min), need(c.max));
    final mealCount = int.tryParse(meals.text.trim());
    if (mealCount == null) {
      throw ArgumentError('Meals per day must be a whole number');
    }
    return NutritionPlan(
      proteinGPerDay: need(protein),
      fatGPerDay: need(fat),
      mealsPerDay: mealCount,
      proteinPerMeal: range(proteinPerMeal),
      dayTypes: {
        for (final type in DayType.values)
          type: DayTypeTargets(
            kcal: range(dayTypes[type]![TargetField.kcal]!),
            carbs: range(dayTypes[type]![TargetField.carbs]!),
            fiber: range(dayTypes[type]![TargetField.fiber]!),
            waterMl: range(dayTypes[type]![TargetField.water]!),
            fruitPortions: range(dayTypes[type]![TargetField.fruit]!),
            vegPortions: range(dayTypes[type]![TargetField.veg]!),
          ),
      },
    );
  }

  /// Like [read] but returns null while the form is incomplete or invalid.
  NutritionPlan? tryRead() {
    try {
      return read();
    } on ArgumentError {
      return null;
    }
  }

  void dispose() {
    weight.dispose();
    protein.dispose();
    fat.dispose();
    meals.dispose();
    proteinPerMeal.dispose();
    for (final fields in dayTypes.values) {
      for (final c in fields.values) {
        c.dispose();
      }
    }
  }
}
