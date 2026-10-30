import 'dart:math' as math;

import '../../../core/nutrition/nutrients.dart';
import '../../nutrition_targets/domain/nutrition_engine.dart';
import 'batch_plan.dart';
import 'plan_inputs.dart';

/// Raw weights are rounded up to this many grams so they are easy to weigh.
const double rawRoundingStepG = 5;

/// Rounds [grams] up to the next [step]; tolerant of floating-point noise so
/// 400.0000000001 stays 400.
double roundUpToStep(double grams, [double step = rawRoundingStepG]) =>
    grams <= 0 ? 0 : (grams / step - 1e-9).ceil() * step;

/// Reverse batch calculator: how much of each recipe to cook so a block of
/// days reaches its protein and carb targets.
///
/// Approach:
/// 1. Targets are summed per day from the engine, so training days (more
///    carbs) weigh more than rest days.
/// 2. Fresh additions, pantry leftovers and the fixed vegetable/sauce recipes
///    are deducted; what remains (never negative) is the need of the bases.
/// 3. With one base, it is sized for its own nutrient. With a protein base
///    and a carb base, the 2x2 system
///    `pp*xp + cp*xc = P` / `pc*xp + cc*xc = C` is solved for the cooked
///    grams (`p?` = protein base per cooked gram, `c?` = carb base), so the
///    carbs of the protein base and the protein of the carb base are not
///    counted twice. If the exact solution needs a negative amount (one base
///    already over-supplies the other nutrient), that base is dropped to 0 and
///    the other is sized for its own nutrient; the residual then shows the
///    miss. Degenerate systems fall back to sizing the protein base first and
///    letting the carb base fill the carbs left over.
/// 4. Cooked grams become raw grams through the yield factor, every recipe
///    line is scaled proportionally and rounded up to [rawRoundingStepG], and
///    the reported totals use those rounded weights.
class BatchPlanner {
  const BatchPlanner(this.engine);

  final NutritionEngine engine;

  BatchPlan plan(BatchPlanInput input) {
    final days = [for (final date in input.dates) _dayNeed(date)];
    final target = Nutrients(
      kcal: days.fold(0, (s, d) => s + d.kcal),
      proteinG: days.fold(0, (s, d) => s + d.proteinG),
      fatG: days.fold(0, (s, d) => s + d.fatG),
      carbsG: days.fold(0, (s, d) => s + d.carbsG),
    );
    final meals = input.mealCount;

    final fresh = [
      for (final f in input.fresh)
        PlannedFresh(
          addition: f,
          totalG: f.gramsPerMeal * meals,
          nutrients: Nutrients.fromPer100g(f.per100, f.gramsPerMeal * meals),
        ),
    ];

    final sides = <PlannedRecipe>[
      for (final role in [PlanRole.vegetable, PlanRole.sauce])
        if (input.componentFor(role) case final c?)
          _scaleRecipe(c, c.cookedGPerMeal * meals, meals),
    ];

    final fixed = Nutrients.sum([
      ...fresh.map((f) => f.nutrients),
      ...input.leftovers.map((l) => l.nutrients),
      ...sides.map((s) => s.nutrients),
    ]);
    final proteinNeed = math.max(0.0, target.proteinG - fixed.proteinG);
    final carbsNeed = math.max(0.0, target.carbsG - fixed.carbsG);

    final proteinBase = input.componentFor(PlanRole.proteinBase);
    final carbBase = input.componentFor(PlanRole.carbBase);
    final cooked = _solveBases(
      proteinBase?.recipe.perCookedGram,
      carbBase?.recipe.perCookedGram,
      proteinNeed,
      carbsNeed,
    );

    final bases = <PlannedRecipe>[
      if (proteinBase != null) _scaleRecipe(proteinBase, cooked.protein, meals),
      if (carbBase != null) _scaleRecipe(carbBase, cooked.carb, meals),
    ];
    final recipes = [...bases, ...sides];

    return BatchPlan(
      days: days,
      mealsPerDay: input.mealsPerDay,
      target: target,
      proteinToCookG: proteinNeed,
      carbsToCookG: carbsNeed,
      recipes: recipes,
      fresh: fresh,
      leftovers: input.leftovers,
      covered: fixed + Nutrients.sum(bases.map((b) => b.nutrients)),
    );
  }

  DayNeed _dayNeed(DateTime date) {
    final t = engine.targetsFor(date);
    return DayNeed(
      date: date,
      dayType: t.dayType,
      kcal: t.kcal,
      proteinG: t.proteinG,
      fatG: t.fatG,
      carbsG: t.carbsG,
    );
  }

  /// Cooked grams of the protein base and the carb base (see class docs).
  ({double protein, double carb}) _solveBases(
    Nutrients? proteinBase,
    Nutrients? carbBase,
    double proteinNeed,
    double carbsNeed,
  ) {
    if (proteinBase == null && carbBase == null) return (protein: 0, carb: 0);
    if (carbBase == null) {
      return (protein: _share(proteinNeed, proteinBase!.proteinG), carb: 0);
    }
    if (proteinBase == null) {
      return (protein: 0, carb: _share(carbsNeed, carbBase.carbsG));
    }

    final det =
        proteinBase.proteinG * carbBase.carbsG -
        carbBase.proteinG * proteinBase.carbsG;
    if (det > 1e-12) {
      final protein =
          (proteinNeed * carbBase.carbsG - carbBase.proteinG * carbsNeed) / det;
      final carb =
          (proteinBase.proteinG * carbsNeed -
              proteinBase.carbsG * proteinNeed) /
          det;
      if (protein >= 0 && carb >= 0) return (protein: protein, carb: carb);
      // det > 0 guarantees at most one of them is negative.
      if (carb < 0) {
        return (protein: _share(proteinNeed, proteinBase.proteinG), carb: 0);
      }
      return (protein: 0, carb: _share(carbsNeed, carbBase.carbsG));
    }

    final protein = _share(proteinNeed, proteinBase.proteinG);
    final carbsLeft = carbsNeed - proteinBase.carbsG * protein;
    return (protein: protein, carb: _share(carbsLeft, carbBase.carbsG));
  }

  /// [need] divided by [perGram]; zero when there is nothing to cover or the
  /// recipe carries none of the nutrient.
  static double _share(double need, double perGram) =>
      need > 0 && perGram > 0 ? need / perGram : 0;

  /// Scales [component]'s recipe to [cookedG] cooked grams.
  PlannedRecipe _scaleRecipe(
    PlanComponent component,
    double cookedG,
    int meals,
  ) {
    final recipe = component.recipe;
    final rawTotal = recipe.rawTotalG;
    final factor = rawTotal > 0 ? (cookedG / recipe.yieldFactor) / rawTotal : 0;
    final lines = [
      for (final l in recipe.lines)
        if (roundUpToStep(l.rawG * factor) > 0)
          PlannedLine(
            ingredientId: l.ingredientId,
            name: l.name,
            category: l.category,
            rawG: roundUpToStep(l.rawG * factor),
            servingG: l.servingG,
          ),
    ];
    final rawG = lines.fold<double>(0, (s, l) => s + l.rawG);
    final byId = {for (final l in recipe.lines) l.ingredientId: l};
    return PlannedRecipe(
      role: component.role,
      recipe: recipe,
      lines: lines,
      rawG: rawG,
      cookedG: rawG * recipe.yieldFactor,
      nutrients: Nutrients.sum([
        for (final l in lines)
          Nutrients.fromPer100g(byId[l.ingredientId]!.per100, l.rawG),
      ]),
      portions: meals,
    );
  }
}
