import 'package:anti_recipes/core/nutrition/nutrients.dart';
import 'package:anti_recipes/features/batch_planner/domain/plan_inputs.dart';
import 'package:anti_recipes/features/nutrition_targets/domain/nutrition_engine.dart';
import 'package:anti_recipes/features/nutrition_targets/domain/nutrition_plan.dart';

/// Example plan: Mon/Tue/Thu/Fri training, 3 meals, 160 g protein per day.
/// Derived carbs: 295 g on training days, 251.25 g on rest days.
NutritionEngine exampleEngine() => NutritionEngine(
  NutritionPlan.exampleDefaults(),
  WeekSchedule.exampleDefaults(),
);

const chickenPer100 = Nutrients(kcal: 120, proteinG: 22.5, fatG: 2.6);
const ricePer100 = Nutrients(
  kcal: 365,
  proteinG: 7.1,
  fatG: 0.7,
  carbsG: 80,
  fiberG: 1.3,
);
const potatoPer100 = Nutrients(
  kcal: 77,
  proteinG: 2,
  fatG: 0.1,
  carbsG: 17.5,
  fiberG: 2.2,
);
const oilPer100 = Nutrients(kcal: 884, fatG: 100);
const bananaPer100 = Nutrients(
  kcal: 89,
  proteinG: 1.1,
  fatG: 0.3,
  carbsG: 22.8,
  fiberG: 2.6,
);
const broccoliPer100 = Nutrients(
  kcal: 34,
  proteinG: 2.8,
  fatG: 0.4,
  carbsG: 6.6,
  fiberG: 2.6,
);

PlanIngredientLine line(
  int id,
  String name,
  String category,
  Nutrients per100,
  double rawG, {
  double? servingG,
}) => PlanIngredientLine(
  ingredientId: id,
  name: name,
  category: category,
  per100: per100,
  rawG: rawG,
  servingG: servingG,
);

PlanIngredientLine chickenLine([double rawG = 400]) =>
    line(1, 'Chicken breast', 'protein', chickenPer100, rawG);
PlanIngredientLine riceLine([double rawG = 200]) =>
    line(2, 'White rice', 'carb', ricePer100, rawG);
PlanIngredientLine oilLine(double rawG) =>
    line(3, 'Olive oil', 'fat', oilPer100, rawG);

/// 400 g raw chicken -> 300 g cooked: 0.3 g protein per cooked gram.
PlanRecipe chickenRecipe({double yieldFactor = 0.75, int id = 1}) => PlanRecipe(
  id: id,
  name: 'Grilled chicken',
  yieldFactor: yieldFactor,
  lines: [chickenLine()],
);

/// 200 g raw rice -> 500 g cooked: 0.32 g carbs and 0.0284 g protein per gram.
PlanRecipe riceRecipe({double yieldFactor = 2.5, int id = 2}) => PlanRecipe(
  id: id,
  name: 'Rice',
  yieldFactor: yieldFactor,
  lines: [riceLine()],
);

PlanComponent protein(PlanRecipe r) =>
    PlanComponent(role: PlanRole.proteinBase, recipe: r);
PlanComponent carb(PlanRecipe r) =>
    PlanComponent(role: PlanRole.carbBase, recipe: r);

/// Monday 2026-10-05, the first day of the fixed test block.
final mon = DateTime(2026, 10, 5);
