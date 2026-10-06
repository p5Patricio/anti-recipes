import 'package:anti_recipes/core/database/app_database.dart';
import 'package:anti_recipes/features/inventory/data/inventory_dao.dart';
import 'package:anti_recipes/features/meal_log/data/meal_log_dao.dart';
import 'package:anti_recipes/features/nutrition_targets/domain/day_type.dart';
import 'package:anti_recipes/features/recipes/data/recipes_dao.dart';
import 'package:anti_recipes/features/recipes/domain/recipe_kind.dart';
import 'package:drift/drift.dart' show OrderingTerm;

/// Monday, so the default schedule makes it a training day.
final monday = DateTime(2026, 10, 5);

Future<int> ingredientIdByName(AppDatabase db, String name) async =>
    (await (db.select(
      db.ingredients,
    )..where((i) => i.name.equals(name))).getSingle()).id;

/// One-ingredient recipe: [rawG] of chicken breast (22.5 g protein per 100 g).
Future<int> seedRecipe(
  AppDatabase db,
  String name, {
  RecipeKind kind = RecipeKind.proteinBase,
  double yieldFactor = 0.75,
  double rawG = 400,
}) async => db.recipesDao.saveRecipe(
  RecipeDraft(
    name: name,
    kind: kind,
    expectedYieldFactor: yieldFactor,
    ingredients: [
      RecipeIngredientDraft(
        ingredientId: await ingredientIdByName(db, 'Chicken breast'),
        rawG: rawG,
      ),
    ],
  ),
);

/// Cooks one batch item and returns its batch item id.
///
/// With the defaults (400 g raw, 300 g cooked chicken) one cooked gram holds
/// 0.3 g protein and 1.6 kcal.
Future<int> seedBatchItem(
  AppDatabase db,
  int recipeId, {
  double rawG = 400,
  double cookedG = 300,
  DateTime? cookedOn,
}) async {
  final day = cookedOn ?? DateTime(2026, 10, 1);
  await db.inventoryDao.createBatch(
    cookedOn: day,
    coversFrom: day,
    coversTo: day.add(const Duration(days: 3)),
    items: [
      BatchItemDraft(
        recipeId: recipeId,
        rawTotalG: rawG,
        cookedTotalG: cookedG,
      ),
    ],
  );
  return (await (db.select(
    db.batchItems,
  )..orderBy([(i) => OrderingTerm.desc(i.id)])).get()).first.id;
}

/// Logs [grams] of a batch item as the meal in [slot] of [date].
Future<void> logBatchMeal(
  AppDatabase db,
  int batchItemId,
  double grams, {
  DateTime? date,
  int slot = 1,
}) => db.mealLogDao.upsertMeal(
  date: date ?? monday,
  slot: slot,
  dayType: DayType.training,
  components: [MealComponentDraft(batchItemId: batchItemId, grams: grams)],
);
