import 'dart:convert';

import 'package:anti_recipes/core/database/app_database.dart';
import 'package:anti_recipes/features/backup/domain/backup_exception.dart';
import 'package:anti_recipes/features/backup/domain/backup_file_gateway.dart';
import 'package:anti_recipes/features/inventory/data/inventory_dao.dart';
import 'package:anti_recipes/features/meal_log/data/meal_log_dao.dart';
import 'package:anti_recipes/features/nutrition_targets/domain/day_type.dart';
import 'package:anti_recipes/features/nutrition_targets/domain/nutrition_plan.dart';
import 'package:anti_recipes/features/recipes/data/recipes_dao.dart';
import 'package:anti_recipes/features/recipes/domain/recipe_kind.dart';
import 'package:drift/drift.dart' show Value;

import 'db_seed.dart';

/// Fills [db] (a freshly created, seeded database) with at least one row in
/// every table and values that differ from the defaults.
Future<void> populateRichDb(AppDatabase db) async {
  final defaults = NutritionPlan.exampleDefaults();
  await db.targetsDao.savePlan(
    NutritionPlan(
      proteinGPerDay: 172.5,
      fatGPerDay: defaults.fatGPerDay,
      mealsPerDay: defaults.mealsPerDay,
      proteinPerMeal: defaults.proteinPerMeal,
      dayTypes: defaults.dayTypes,
    ),
  );
  await db.targetsDao.saveSchedule(
    WeekSchedule({
      for (var d = 1; d <= 7; d++) d: d == 3 ? DayType.training : DayType.rest,
    }),
  );
  await db.targetsDao.saveBodyWeightKg(81.4);

  final blender = await db
      .into(db.tools)
      .insert(ToolsCompanion.insert(name: 'Blender'));
  final oven = (await (db.select(
    db.tools,
  )..where((t) => t.name.equals('Oven'))).getSingle()).id;
  final lentils = await db
      .into(db.ingredients)
      .insert(
        IngredientsCompanion.insert(
          name: 'Lentils',
          category: 'carb',
          kcal100: 353,
          protein100: 25.8,
          fat100: 1.1,
          carbs100: 60,
          fiber100: 10.7,
          servingG: const Value(45),
        ),
      );
  final chicken = await ingredientIdByName(db, 'Chicken breast');
  final rice = await ingredientIdByName(db, 'White rice');

  final chickenRecipe = await db.recipesDao.saveRecipe(
    RecipeDraft(
      name: 'Roast chicken',
      kind: RecipeKind.proteinBase,
      expectedYieldFactor: 0.72,
      notes: 'Rest 5 minutes before slicing.',
      ingredients: [RecipeIngredientDraft(ingredientId: chicken, rawG: 800)],
      steps: [
        RecipeStepDraft(
          technique: 'Roast',
          tempC: 200,
          minutes: 35,
          toolId: oven,
        ),
        const RecipeStepDraft(technique: 'Rest'),
      ],
      toolIds: [oven, blender],
    ),
  );
  final riceRecipe = await db.recipesDao.saveRecipe(
    RecipeDraft(
      name: 'Lentil rice',
      kind: RecipeKind.carbBase,
      expectedYieldFactor: 2.4,
      ingredients: [
        RecipeIngredientDraft(ingredientId: rice, rawG: 300),
        RecipeIngredientDraft(ingredientId: lentils, rawG: 100),
      ],
    ),
  );

  final day = DateTime(2026, 10, 1);
  await db.inventoryDao.createBatch(
    cookedOn: day,
    coversFrom: day,
    coversTo: day.add(const Duration(days: 3)),
    items: [
      BatchItemDraft(
        recipeId: chickenRecipe,
        rawTotalG: 1600,
        cookedTotalG: 1150,
      ),
      BatchItemDraft(recipeId: riceRecipe, rawTotalG: 800, cookedTotalG: 1900),
    ],
  );
  final items = await db.select(db.batchItems).get();

  await db.mealLogDao.upsertMeal(
    date: monday,
    slot: 1,
    dayType: DayType.training,
    components: [
      MealComponentDraft(batchItemId: items.first.id, grams: 180),
      MealComponentDraft(batchItemId: items.last.id, grams: 220),
    ],
  );
  await db.mealLogDao.upsertMeal(
    date: monday,
    slot: 2,
    dayType: DayType.training,
    components: [MealComponentDraft(ingredientId: chicken, grams: 150.5)],
  );
  await db.mealLogDao.addHydration(
    monday,
    500,
    loggedAt: DateTime(2026, 10, 5, 8, 15),
  );
  await db.mealLogDao.addHydration(
    monday,
    750,
    loggedAt: DateTime(2026, 10, 5, 13, 40),
  );
  await db.mealLogDao.adjustServings(monday, fruitDelta: 2, vegDelta: 3);
}

/// Parsed export with the volatile `exportedAt` removed, for comparisons.
Map<String, Object?> withoutTimestamp(String json) =>
    (jsonDecode(json) as Map<String, dynamic>)..remove('exportedAt');

/// In-memory [BackupFileGateway] that records what the app saved.
class FakeBackupFileGateway implements BackupFileGateway {
  FakeBackupFileGateway({this.pickResult, this.saveLocation = 'backup.json'});

  /// Returned by [pickBackup]; null simulates the user cancelling.
  String? pickResult;

  /// Returned by [saveBackup]; null simulates the user cancelling.
  String? saveLocation;

  /// Makes [pickBackup] throw, like an unreadable file.
  BackupException? pickError;

  final saved = <({String fileName, String contents})>[];

  @override
  Future<String?> saveBackup({
    required String fileName,
    required String contents,
  }) async {
    if (saveLocation != null) {
      saved.add((fileName: fileName, contents: contents));
    }
    return saveLocation;
  }

  @override
  Future<String?> pickBackup() async {
    if (pickError != null) throw pickError!;
    return pickResult;
  }
}
