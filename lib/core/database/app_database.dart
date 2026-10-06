import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../features/inventory/data/inventory_dao.dart';
import '../../features/meal_log/data/meal_log_dao.dart';
import '../../features/nutrition_targets/data/targets_dao.dart';
import '../../features/nutrition_targets/domain/day_type.dart';
import '../../features/nutrition_targets/domain/nutrition_plan.dart';
import '../../features/recipes/data/recipes_dao.dart';
import '../../features/recipes/domain/recipe_kind.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    UserProfiles,
    DayTypeTargetRows,
    WeekScheduleEntries,
    Ingredients,
    Tools,
    Recipes,
    RecipeIngredients,
    RecipeSteps,
    RecipeTools,
    BatchSessions,
    BatchItems,
    MealLogs,
    MealComponents,
    HydrationLogs,
    DayLogs,
  ],
  daos: [TargetsDao, RecipesDao, InventoryDao, MealLogDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  /// Opens the on-device database.
  AppDatabase.open() : super(driftDatabase(name: 'anti_recipes'));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await _seed();
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) await m.createTable(dayLogs);
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  /// Example defaults only; the numbers come from the domain objects.
  Future<void> _seed() async {
    await targetsDao.savePlan(NutritionPlan.exampleDefaults());
    await targetsDao.saveSchedule(WeekSchedule.exampleDefaults());

    await batch((b) {
      b.insertAll(tools, [
        for (final name in _starterTools) ToolsCompanion.insert(name: name),
      ]);
      b.insertAll(ingredients, _starterIngredients);
    });
  }
}

const _starterTools = [
  'Oven',
  'Air fryer',
  'Cast iron skillet',
  'Kitchen scale',
  'Rice cooker',
  'Sheet pan',
];

IngredientsCompanion _food(
  String name,
  String category, {
  required double kcal,
  required double protein,
  required double fat,
  required double carbs,
  required double fiber,
  bool fruit = false,
  bool vegetable = false,
  double? servingG,
}) => IngredientsCompanion.insert(
  name: name,
  category: category,
  isFruit: Value(fruit),
  isVegetable: Value(vegetable),
  servingG: Value(servingG),
  kcal100: kcal,
  protein100: protein,
  fat100: fat,
  carbs100: carbs,
  fiber100: fiber,
);

/// Raw values per 100 g, USDA-like.
final _starterIngredients = [
  _food(
    'Chicken breast',
    'protein',
    kcal: 120,
    protein: 22.5,
    fat: 2.6,
    carbs: 0,
    fiber: 0,
  ),
  _food(
    'Lean ground beef 90/10',
    'protein',
    kcal: 176,
    protein: 20,
    fat: 10,
    carbs: 0,
    fiber: 0,
  ),
  _food(
    'Egg',
    'protein',
    kcal: 143,
    protein: 12.6,
    fat: 9.5,
    carbs: 0.7,
    fiber: 0,
    servingG: 50,
  ),
  _food(
    'White rice',
    'carb',
    kcal: 365,
    protein: 7.1,
    fat: 0.7,
    carbs: 80,
    fiber: 1.3,
  ),
  _food(
    'Rolled oats',
    'carb',
    kcal: 379,
    protein: 13.2,
    fat: 6.5,
    carbs: 67.7,
    fiber: 10.1,
  ),
  _food(
    'Potato',
    'carb',
    kcal: 77,
    protein: 2,
    fat: 0.1,
    carbs: 17.5,
    fiber: 2.2,
  ),
  _food(
    'Broccoli',
    'vegetable',
    kcal: 34,
    protein: 2.8,
    fat: 0.4,
    carbs: 6.6,
    fiber: 2.6,
    vegetable: true,
  ),
  _food(
    'Banana',
    'fruit',
    kcal: 89,
    protein: 1.1,
    fat: 0.3,
    carbs: 22.8,
    fiber: 2.6,
    fruit: true,
    servingG: 118,
  ),
  _food(
    'Apple',
    'fruit',
    kcal: 52,
    protein: 0.3,
    fat: 0.2,
    carbs: 13.8,
    fiber: 2.4,
    fruit: true,
    servingG: 182,
  ),
  _food(
    'Olive oil',
    'fat',
    kcal: 884,
    protein: 0,
    fat: 100,
    carbs: 0,
    fiber: 0,
  ),
];
