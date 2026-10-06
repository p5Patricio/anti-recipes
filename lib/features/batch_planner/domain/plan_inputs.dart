import '../../../core/nutrition/nutrients.dart';
import '../../recipes/domain/recipe_nutrition.dart';
import '../../recipes/domain/yield_calculator.dart';

/// Part a recipe plays in a planned block of days.
///
/// The declaration order is the display order of the planned recipes.
enum PlanRole {
  /// Sized so the block reaches its protein target.
  proteinBase,

  /// Sized so the block reaches its carb target.
  carbBase,

  /// Fixed grams per meal; its nutrients are deducted from the needs.
  vegetable,

  /// Fixed grams per meal; its nutrients are deducted from the needs.
  sauce;

  /// Roles that are sized to cover a nutrient need.
  bool get isBase => this == proteinBase || this == carbBase;
}

/// One raw ingredient line of a recipe, with the identity needed to build a
/// shopping list.
class PlanIngredientLine {
  const PlanIngredientLine({
    required this.ingredientId,
    required this.name,
    required this.category,
    required this.per100,
    required this.rawG,
    this.servingG,
  });

  final int ingredientId;
  final String name;
  final String category;

  /// Raw nutrients per 100 g.
  final Nutrients per100;
  final double rawG;

  /// Typical weight of one unit (an egg, a banana), when known.
  final double? servingG;
}

/// A recipe as written (raw weights) plus its expected cooked/raw yield.
class PlanRecipe {
  /// Throws [ArgumentError] when [yieldFactor] is not above zero.
  PlanRecipe({
    required this.id,
    required this.name,
    required this.yieldFactor,
    required Iterable<PlanIngredientLine> lines,
  }) : lines = List.unmodifiable(lines) {
    if (!(yieldFactor > 0)) {
      throw ArgumentError.value(yieldFactor, 'yieldFactor', 'must be > 0');
    }
  }

  final int id;
  final String name;
  final double yieldFactor;
  final List<PlanIngredientLine> lines;

  RecipeNutrition get nutrition => RecipeNutrition([
    for (final l in lines) RawIngredient(l.per100, l.rawG),
  ], yieldFactor);

  double get rawTotalG => nutrition.rawTotalG;

  /// Nutrients in one cooked gram; zero while the recipe has no weight.
  Nutrients get perCookedGram {
    final cooked = nutrition.cookedTotalG;
    return cooked > 0 ? nutrition.total.scale(1 / cooked) : Nutrients.zero;
  }
}

/// A recipe chosen for a [PlanRole].
class PlanComponent {
  /// Throws [ArgumentError] for a negative [cookedGPerMeal].
  PlanComponent({
    required this.role,
    required this.recipe,
    this.cookedGPerMeal = 0,
  }) {
    if (cookedGPerMeal < 0) {
      throw ArgumentError.value(
        cookedGPerMeal,
        'cookedGPerMeal',
        'must be >= 0',
      );
    }
  }

  final PlanRole role;
  final PlanRecipe recipe;

  /// Cooked grams eaten per meal. Only used by the vegetable and sauce roles;
  /// the quantity of a base is derived from the nutrient it must cover.
  final double cookedGPerMeal;
}

/// An ingredient eaten as is (fresh fruit, raw vegetables) next to the batch.
class FreshAddition {
  /// Throws [ArgumentError] for a negative [gramsPerMeal].
  FreshAddition({
    required this.ingredientId,
    required this.name,
    required this.category,
    required this.per100,
    required this.gramsPerMeal,
    this.servingG,
  }) {
    if (gramsPerMeal < 0) {
      throw ArgumentError.value(gramsPerMeal, 'gramsPerMeal', 'must be >= 0');
    }
  }

  final int ingredientId;
  final String name;
  final String category;
  final Nutrients per100;
  final double gramsPerMeal;
  final double? servingG;
}

/// Cooked food still in the pantry that covers part of the block.
class PantryLeftover {
  const PantryLeftover({
    required this.batchItemId,
    required this.name,
    required this.remainingG,
    required this.perCookedGram,
  });

  final int batchItemId;
  final String name;
  final double remainingG;
  final Nutrients perCookedGram;

  Nutrients get nutrients =>
      remainingG > 0 ? perCookedGram.scale(remainingG) : Nutrients.zero;
}

/// Everything the planner needs for one block of consecutive days.
class BatchPlanInput {
  /// Throws [ArgumentError] unless 1..7 dates, at least one meal per day, and
  /// at most one component per [PlanRole].
  BatchPlanInput({
    required Iterable<DateTime> dates,
    required this.mealsPerDay,
    Iterable<PlanComponent> components = const [],
    Iterable<FreshAddition> fresh = const [],
    Iterable<PantryLeftover> leftovers = const [],
  }) : dates = List.unmodifiable(dates),
       components = List.unmodifiable(components),
       fresh = List.unmodifiable(fresh),
       leftovers = List.unmodifiable(leftovers) {
    if (this.dates.isEmpty || this.dates.length > maxPlanDays) {
      throw ArgumentError('A plan covers 1..$maxPlanDays days');
    }
    if (mealsPerDay < 1) {
      throw ArgumentError.value(mealsPerDay, 'mealsPerDay', 'must be >= 1');
    }
    final roles = this.components.map((c) => c.role).toSet();
    if (roles.length != this.components.length) {
      throw ArgumentError('Each role can hold only one recipe');
    }
  }

  /// [count] consecutive local calendar days starting at [from].
  factory BatchPlanInput.fromDay(
    DateTime from,
    int count, {
    required int mealsPerDay,
    Iterable<PlanComponent> components = const [],
    Iterable<FreshAddition> fresh = const [],
    Iterable<PantryLeftover> leftovers = const [],
  }) => BatchPlanInput(
    dates: consecutiveDays(from, count),
    mealsPerDay: mealsPerDay,
    components: components,
    fresh: fresh,
    leftovers: leftovers,
  );

  static const int maxPlanDays = 7;

  final List<DateTime> dates;
  final int mealsPerDay;
  final List<PlanComponent> components;
  final List<FreshAddition> fresh;
  final List<PantryLeftover> leftovers;

  int get mealCount => dates.length * mealsPerDay;

  PlanComponent? componentFor(PlanRole role) =>
      components.where((c) => c.role == role).firstOrNull;
}

/// [count] consecutive local calendar days starting at [from] (DST-safe).
List<DateTime> consecutiveDays(DateTime from, int count) => [
  for (var i = 0; i < count; i++) DateTime(from.year, from.month, from.day + i),
];
