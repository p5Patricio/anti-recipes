import 'package:drift/drift.dart';

import '../../features/nutrition_targets/domain/day_type.dart';
import '../../features/recipes/domain/recipe_kind.dart';

/// Single-row profile (id = 1) holding the daily macro targets.
class UserProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get bodyWeightKg => real().nullable()();
  RealColumn get proteinGPerDay => real()();
  RealColumn get fatGPerDay => real()();
  IntColumn get mealsPerDay => integer()();
  RealColumn get proteinPerMealMin => real()();
  RealColumn get proteinPerMealMax => real()();
}

class DayTypeTargetRows extends Table {
  TextColumn get dayType => textEnum<DayType>()();
  RealColumn get kcalMin => real()();
  RealColumn get kcalMax => real()();
  RealColumn get carbsMin => real()();
  RealColumn get carbsMax => real()();
  RealColumn get fiberMin => real()();
  RealColumn get fiberMax => real()();
  RealColumn get waterMlMin => real()();
  RealColumn get waterMlMax => real()();
  RealColumn get fruitMin => real()();
  RealColumn get fruitMax => real()();
  RealColumn get vegMin => real()();
  RealColumn get vegMax => real()();

  @override
  Set<Column> get primaryKey => {dayType};
}

class WeekScheduleEntries extends Table {
  /// 1 = Monday .. 7 = Sunday.
  // ignore: recursive_getters
  IntColumn get weekday => integer().check(weekday.isBetweenValues(1, 7))();
  TextColumn get dayType => textEnum<DayType>()();

  @override
  Set<Column> get primaryKey => {weekday};
}

/// Raw nutrient values per 100 g.
class Ingredients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  TextColumn get category => text()();
  BoolColumn get isFruit => boolean().withDefault(const Constant(false))();
  BoolColumn get isVegetable => boolean().withDefault(const Constant(false))();
  RealColumn get servingG => real().nullable()();
  RealColumn get kcal100 => real()();
  RealColumn get protein100 => real()();
  RealColumn get fat100 => real()();
  RealColumn get carbs100 => real()();
  RealColumn get fiber100 => real()();
}

class Tools extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
}

class Recipes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get kind => textEnum<RecipeKind>()();
  RealColumn get expectedYieldFactor =>
      real().withDefault(const Constant(1.0))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class RecipeIngredients extends Table {
  IntColumn get recipeId =>
      integer().references(Recipes, #id, onDelete: KeyAction.cascade)();
  IntColumn get ingredientId =>
      integer().references(Ingredients, #id, onDelete: KeyAction.restrict)();
  RealColumn get rawG => real()();

  @override
  Set<Column> get primaryKey => {recipeId, ingredientId};
}

class RecipeSteps extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get recipeId =>
      integer().references(Recipes, #id, onDelete: KeyAction.cascade)();
  IntColumn get position => integer()();
  TextColumn get technique => text()();
  IntColumn get tempC => integer().nullable()();
  IntColumn get minutes => integer().nullable()();
  IntColumn get toolId => integer().nullable().references(
    Tools,
    #id,
    onDelete: KeyAction.setNull,
  )();
}

class RecipeTools extends Table {
  IntColumn get recipeId =>
      integer().references(Recipes, #id, onDelete: KeyAction.cascade)();
  IntColumn get toolId =>
      integer().references(Tools, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {recipeId, toolId};
}

class BatchSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get cookedOn => dateTime()();
  DateTimeColumn get coversFrom => dateTime()();
  DateTimeColumn get coversTo => dateTime()();
}

class BatchItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get batchSessionId =>
      integer().references(BatchSessions, #id, onDelete: KeyAction.cascade)();
  IntColumn get recipeId =>
      integer().references(Recipes, #id, onDelete: KeyAction.restrict)();
  RealColumn get rawTotalG => real()();
  RealColumn get cookedTotalG => real()();
}

class MealLogs extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Local midnight of the calendar day (see `dateOnly`).
  DateTimeColumn get date => dateTime()();
  // ignore: recursive_getters
  IntColumn get slot => integer().check(slot.isBetweenValues(1, 3))();

  /// Day type snapshot taken when the meal was logged.
  TextColumn get dayType => textEnum<DayType>()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {date, slot},
  ];
}

class MealComponents extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get mealLogId =>
      integer().references(MealLogs, #id, onDelete: KeyAction.cascade)();
  IntColumn get batchItemId => integer().nullable().references(
    BatchItems,
    #id,
    onDelete: KeyAction.restrict,
  )();
  IntColumn get ingredientId => integer().nullable().references(
    Ingredients,
    #id,
    onDelete: KeyAction.restrict,
  )();
  RealColumn get grams => real()();

  @override
  List<String> get customConstraints => [
    'CHECK ((batch_item_id IS NULL) <> (ingredient_id IS NULL))',
  ];
}

class HydrationLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  IntColumn get ml => integer()();
  DateTimeColumn get loggedAt => dateTime().withDefault(currentDateAndTime)();
}

/// Per-day counters that are not tied to a logged meal (fruit and vegetable
/// portions). A row exists only once the day was touched.
class DayLogs extends Table {
  /// Local midnight of the calendar day (see `dateOnly`).
  DateTimeColumn get date => dateTime()();
  IntColumn get fruitPortions => integer().withDefault(const Constant(0))();
  IntColumn get vegPortions => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {date};
}
