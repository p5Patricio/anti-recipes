import 'package:anti_recipes/core/database/app_database.dart';
import 'package:anti_recipes/core/database/date_utils.dart';
import 'package:anti_recipes/core/database/ingredient_nutrients.dart';
import 'package:anti_recipes/core/nutrition/nutrients.dart';
import 'package:anti_recipes/features/inventory/data/inventory_dao.dart';
import 'package:anti_recipes/features/meal_log/data/meal_log_dao.dart';
import 'package:anti_recipes/features/nutrition_targets/domain/day_type.dart';
import 'package:anti_recipes/features/nutrition_targets/domain/nutrition_plan.dart';
import 'package:anti_recipes/features/recipes/data/recipes_dao.dart';
import 'package:anti_recipes/features/recipes/domain/recipe_kind.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  Future<int> ingredientId(String name) async => (await (db.select(
    db.ingredients,
  )..where((i) => i.name.equals(name))).getSingle()).id;

  /// 300 g chicken + 100 g rice.
  Future<int> saveChickenRice() async => db.recipesDao.saveRecipe(
    RecipeDraft(
      name: 'Chicken and rice',
      kind: RecipeKind.complete,
      ingredients: [
        RecipeIngredientDraft(
          ingredientId: await ingredientId('Chicken breast'),
          rawG: 300,
        ),
        RecipeIngredientDraft(
          ingredientId: await ingredientId('White rice'),
          rawG: 100,
        ),
      ],
    ),
  );

  group('seed and targets', () {
    test('loads the example plan back unchanged', () async {
      final plan = await db.targetsDao.loadPlan();
      final expected = NutritionPlan.exampleDefaults();
      expect(plan, isNotNull);
      expect(plan!.proteinGPerDay, expected.proteinGPerDay);
      expect(plan.fatGPerDay, expected.fatGPerDay);
      expect(plan.mealsPerDay, expected.mealsPerDay);
      expect(plan.proteinPerMeal, expected.proteinPerMeal);
      for (final type in DayType.values) {
        final a = plan.targetsFor(type);
        final b = expected.targetsFor(type);
        expect(a.kcal, b.kcal);
        expect(a.carbs, b.carbs);
        expect(a.fiber, b.fiber);
        expect(a.waterMl, b.waterMl);
        expect(a.fruitPortions, b.fruitPortions);
        expect(a.vegPortions, b.vegPortions);
      }
    });

    test('schedule round-trips and can be changed', () async {
      expect(
        (await db.targetsDao.loadSchedule())!.days,
        WeekSchedule.exampleDefaults().days,
      );

      final changed = WeekSchedule({
        for (var d = 1; d <= 7; d++) d: DayType.rest,
      });
      await db.targetsDao.saveSchedule(changed);
      expect((await db.targetsDao.loadSchedule())!.days, changed.days);
    });

    test('watchPlan re-emits after a save', () async {
      final updated = NutritionPlan.exampleDefaults();
      final emitted = <NutritionPlan?>[];
      final sub = db.targetsDao.watchPlan().listen(emitted.add);
      addTearDown(sub.cancel);
      await pumpEventQueue();
      expect(emitted.last!.proteinGPerDay, 160);
      await db.targetsDao.savePlan(
        NutritionPlan(
          proteinGPerDay: 170,
          fatGPerDay: updated.fatGPerDay,
          mealsPerDay: updated.mealsPerDay,
          proteinPerMeal: updated.proteinPerMeal,
          dayTypes: updated.dayTypes,
        ),
      );
      await pumpEventQueue();
      expect(emitted.last!.proteinGPerDay, 170);
    });

    test('starter tools and ingredients are seeded', () async {
      expect(await db.select(db.tools).get(), hasLength(6));
      expect(await db.select(db.ingredients).get(), hasLength(10));
    });
  });

  group('recipes', () {
    test('saves children, replaces them and cascades on delete', () async {
      final oven = (await db.select(db.tools).get()).first;
      final id = await db.recipesDao.saveRecipe(
        RecipeDraft(
          name: 'Chicken',
          kind: RecipeKind.proteinBase,
          ingredients: [
            RecipeIngredientDraft(
              ingredientId: await ingredientId('Chicken breast'),
              rawG: 500,
            ),
          ],
          steps: [
            RecipeStepDraft(
              technique: 'Roast',
              tempC: 200,
              minutes: 25,
              toolId: oven.id,
            ),
            const RecipeStepDraft(technique: 'Rest'),
          ],
          toolIds: [oven.id],
        ),
      );

      var detail = (await db.recipesDao.getRecipeDetail(id))!;
      expect(detail.ingredients, hasLength(1));
      expect(detail.steps.map((s) => s.position), [1, 2]);
      expect(detail.tools.single.id, oven.id);

      await db.recipesDao.saveRecipe(
        RecipeDraft(
          id: id,
          name: 'Chicken v2',
          kind: RecipeKind.proteinBase,
          ingredients: [
            RecipeIngredientDraft(
              ingredientId: await ingredientId('Egg'),
              rawG: 100,
            ),
          ],
        ),
      );
      detail = (await db.recipesDao.getRecipeDetail(id))!;
      expect(detail.recipe.name, 'Chicken v2');
      expect(detail.ingredients.single.ingredient.name, 'Egg');
      expect(detail.steps, isEmpty);
      expect(detail.tools, isEmpty);

      await db.recipesDao.deleteRecipe(id);
      expect(await db.select(db.recipeIngredients).get(), isEmpty);
      expect(await db.select(db.recipeSteps).get(), isEmpty);
    });

    test('recipeNutrients sums raw nutrients', () async {
      final id = await saveChickenRice();
      final n = await db.recipesDao.recipeNutrients(id);
      expect(n.kcal, closeTo(3 * 120 + 365, 1e-9));
      expect(n.proteinG, closeTo(3 * 22.5 + 7.1, 1e-9));
      expect(n.carbsG, closeTo(80, 1e-9));
    });

    test('an ingredient used by a recipe cannot be deleted', () async {
      await saveChickenRice();
      final id = await ingredientId('Chicken breast');
      await expectLater(db.recipesDao.deleteIngredient(id), throwsException);
    });
  });

  group('inventory and meals', () {
    final day = DateTime(2026, 10, 5);

    Future<int> batchItemFor(int recipeId) async {
      await db.inventoryDao.createBatch(
        cookedOn: day,
        coversFrom: day,
        coversTo: day.add(const Duration(days: 3)),
        // 400 g raw cooks down to 300 g.
        items: [
          BatchItemDraft(recipeId: recipeId, rawTotalG: 400, cookedTotalG: 300),
        ],
      );
      return (await db.select(db.batchItems).getSingle()).id;
    }

    test('remaining stock decreases after logging a batch component', () async {
      final recipeId = await saveChickenRice();
      final itemId = await batchItemFor(recipeId);

      var stock = (await db.inventoryDao.loadStock()).single;
      expect(stock.recipeName, 'Chicken and rice');
      expect(stock.remainingG, 300);
      // 460 g raw-recipe kcal spread over 300 g cooked.
      expect(stock.nutrientsPerCookedGram.kcal, closeTo(725 / 300, 1e-9));

      await db.mealLogDao.upsertMeal(
        date: day,
        slot: 1,
        dayType: DayType.training,
        components: [MealComponentDraft(batchItemId: itemId, grams: 120)],
      );
      stock = (await db.inventoryDao.watchStock().first).single;
      expect(stock.consumedG, 120);
      expect(stock.remainingG, 180);
    });

    test('scales recipe nutrients to the batch raw total', () async {
      final recipeId = await saveChickenRice();
      await db.inventoryDao.createBatch(
        cookedOn: day,
        coversFrom: day,
        coversTo: day,
        items: [
          // Double the recipe: 800 g raw, 600 g cooked.
          BatchItemDraft(recipeId: recipeId, rawTotalG: 800, cookedTotalG: 600),
        ],
      );
      final stock = (await db.inventoryDao.loadStock()).single;
      expect(stock.nutrientsPerCookedGram.kcal, closeTo(2 * 725 / 600, 1e-9));
    });

    test('meal components must reference exactly one source', () async {
      final mealId = await db.mealLogDao.upsertMeal(
        date: day,
        slot: 1,
        dayType: DayType.rest,
        components: const [],
      );
      await expectLater(
        db
            .into(db.mealComponents)
            .insert(
              MealComponentsCompanion.insert(mealLogId: mealId, grams: 10),
            ),
        throwsException,
      );
      final chicken = await ingredientId('Chicken breast');
      final item = await batchItemFor(await saveChickenRice());
      await expectLater(
        db
            .into(db.mealComponents)
            .insert(
              MealComponentsCompanion.insert(
                mealLogId: mealId,
                grams: 10,
                ingredientId: Value(chicken),
                batchItemId: Value(item),
              ),
            ),
        throwsException,
      );
    });

    test(
      'upsert on (date, slot) replaces components and normalizes date',
      () async {
        final chicken = await ingredientId('Chicken breast');
        final rice = await ingredientId('White rice');
        final first = await db.mealLogDao.upsertMeal(
          date: DateTime(2026, 10, 5, 13, 45),
          slot: 2,
          dayType: DayType.training,
          components: [MealComponentDraft(ingredientId: chicken, grams: 200)],
        );
        final second = await db.mealLogDao.upsertMeal(
          date: day,
          slot: 2,
          dayType: DayType.rest,
          components: [MealComponentDraft(ingredientId: rice, grams: 100)],
        );
        expect(second, first);

        final meals = await db.mealLogDao.loadDay(day);
        expect(meals, hasLength(1));
        expect(meals.single.dayType, DayType.rest);
        expect(meals.single.date, dateOnly(day));
        expect(meals.single.components.single.label, 'White rice');
        expect(
          meals.single.nutrients,
          Nutrients.fromPer100g(
            (await (db.select(
              db.ingredients,
            )..where((i) => i.id.equals(rice))).getSingle()).per100g,
            100,
          ),
        );
        expect(await db.select(db.mealComponents).get(), hasLength(1));
      },
    );

    test('hydration sums per day', () async {
      await db.mealLogDao.addHydration(DateTime(2026, 10, 5, 8), 500);
      await db.mealLogDao.addHydration(DateTime(2026, 10, 5, 20), 750);
      await db.mealLogDao.addHydration(DateTime(2026, 10, 6, 9), 300);
      expect(await db.mealLogDao.watchHydrationMl(day).first, 1250);
      expect(
        await db.mealLogDao.watchHydrationMl(DateTime(2026, 10, 7)).first,
        0,
      );
    });
  });
}
