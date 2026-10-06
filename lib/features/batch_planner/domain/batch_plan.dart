import '../../../core/nutrition/nutrients.dart';
import '../../../core/nutrition/range.dart';
import '../../meal_log/domain/day_summary.dart';
import '../../nutrition_targets/domain/day_type.dart';
import 'plan_inputs.dart';

/// What one covered day asks for.
class DayNeed {
  const DayNeed({
    required this.date,
    required this.dayType,
    required this.kcal,
    required this.proteinG,
    required this.fatG,
    required this.carbsG,
  });

  final DateTime date;
  final DayType dayType;
  final double kcal;
  final double proteinG;
  final double fatG;
  final double carbsG;
}

/// One ingredient line of a recipe after scaling to the planned quantity.
class PlannedLine {
  const PlannedLine({
    required this.ingredientId,
    required this.name,
    required this.category,
    required this.rawG,
    this.servingG,
  });

  final int ingredientId;
  final String name;
  final String category;

  /// Raw grams, already rounded up to the practical increment.
  final double rawG;
  final double? servingG;
}

/// A recipe scaled to what the block needs.
class PlannedRecipe {
  const PlannedRecipe({
    required this.role,
    required this.recipe,
    required this.lines,
    required this.rawG,
    required this.cookedG,
    required this.nutrients,
    required this.portions,
  });

  final PlanRole role;
  final PlanRecipe recipe;
  final List<PlannedLine> lines;

  /// Sum of the rounded [lines].
  final double rawG;

  /// Expected cooked weight of [rawG] at the recipe's yield factor.
  final double cookedG;

  /// Nutrients of the whole planned quantity.
  final Nutrients nutrients;

  /// One portion per meal of the block.
  final int portions;

  bool get isNeeded => rawG > 0;

  double get gramsPerPortion => portions > 0 ? cookedG / portions : 0;

  Nutrients get perPortion =>
      portions > 0 ? nutrients.scale(1 / portions) : Nutrients.zero;
}

/// A fresh ingredient with the total quantity the block needs.
class PlannedFresh {
  const PlannedFresh({
    required this.addition,
    required this.totalG,
    required this.nutrients,
  });

  final FreshAddition addition;
  final double totalG;
  final Nutrients nutrients;
}

/// Result of [BatchPlanner.plan]: quantities to cook and how well they match
/// the block's targets.
class BatchPlan {
  const BatchPlan({
    required this.days,
    required this.mealsPerDay,
    required this.target,
    required this.proteinToCookG,
    required this.carbsToCookG,
    required this.recipes,
    required this.fresh,
    required this.leftovers,
    required this.covered,
  });

  final List<DayNeed> days;
  final int mealsPerDay;

  /// Sum of the per-day targets (kcal, protein, fat, carbs).
  final Nutrients target;

  /// Protein and carbs left for the sized bases after fresh additions,
  /// leftovers and the fixed side recipes; never negative.
  final double proteinToCookG;
  final double carbsToCookG;

  final List<PlannedRecipe> recipes;
  final List<PlannedFresh> fresh;
  final List<PantryLeftover> leftovers;

  /// Everything the block provides: recipes, fresh additions and leftovers.
  final Nutrients covered;

  int get mealCount => days.length * mealsPerDay;

  /// Covered minus target; positive means a surplus.
  double get proteinResidualG => covered.proteinG - target.proteinG;
  double get carbsResidualG => covered.carbsG - target.carbsG;

  RangeStatus get proteinStatus =>
      singleTargetStatus(covered.proteinG, target.proteinG);
  RangeStatus get carbsStatus =>
      singleTargetStatus(covered.carbsG, target.carbsG);

  /// Average nutrients of one meal.
  Nutrients get perMeal => covered.scale(1 / mealCount);

  /// What each day receives; portions are equal, so every day gets the same.
  Nutrients get coveredPerDay => covered.scale(1 / days.length);

  Nutrients get freshNutrients => Nutrients.sum(fresh.map((f) => f.nutrients));

  Nutrients get leftoverNutrients =>
      Nutrients.sum(leftovers.map((l) => l.nutrients));

  PlannedRecipe? recipeFor(PlanRole role) =>
      recipes.where((r) => r.role == role).firstOrNull;
}
