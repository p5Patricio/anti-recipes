import 'package:anti_recipes/core/database/app_database.dart';
import 'package:anti_recipes/core/database/date_utils.dart';
import 'package:anti_recipes/features/inventory/presentation/pantry_screen.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/db_seed.dart';
import '../../../helpers/ui_helpers.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  Future<void> pumpPantry(WidgetTester tester) =>
      pumpWithDb(tester, db, const PantryScreen());

  /// Opens the log-batch screen and adds [recipeName] as the first item.
  Future<void> startBatchWith(
    WidgetTester tester,
    int recipeId, {
    String cooked = '300',
  }) async {
    await tapKey(tester, 'log-batch');
    await tapKey(tester, 'add-batch-item');
    await tapKey(tester, 'pick-recipe-$recipeId');
    await enterKey(tester, 'batch-cooked-0', cooked);
  }

  uiTest('empty pantry invites logging the first batch', (tester) async {
    await pumpPantry(tester);

    expect(find.text('Your pantry is empty'), findsOneWidget);
    expect(find.byKey(const Key('log-batch')), findsOneWidget);
    expect(find.text('Log batch cooked'), findsOneWidget);
  });

  uiTest('logging a batch adds it to the pantry with full stock', (
    tester,
  ) async {
    final recipeId = await seedRecipe(db, 'Grilled chicken');
    await pumpPantry(tester);

    await startBatchWith(tester, recipeId);
    // Raw total defaults to the recipe's own raw total.
    expect(fieldText(tester, 'batch-raw-0'), '400');
    expect(find.text('Yield 0.75 (recipe expects 0.75)'), findsOneWidget);
    expect(find.byKey(const Key('yield-note-0')), findsNothing);
    await tapKey(tester, 'save-batch');

    expect(find.byKey(const Key('save-batch')), findsNothing);
    expect(find.text('Grilled chicken'), findsOneWidget);
    expect(find.text('300 g left of 300 g'), findsOneWidget);
    expect(find.text('Low'), findsNothing);
    // 480 kcal, 90 g protein over 300 g cooked, per 100 g.
    expect(find.text('160 kcal · P 30 · F 3 · C 0 · Fiber 0'), findsOneWidget);

    final session = (await db.select(db.batchSessions).get()).single;
    final today = dateOnly(DateTime.now());
    expect(session.cookedOn, today);
    expect(session.coversFrom, today);
    expect(session.coversTo, today.add(const Duration(days: 3)));
    final item = (await db.select(db.batchItems).get()).single;
    expect(
      (item.recipeId, item.rawTotalG, item.cookedTotalG),
      (recipeId, 400.0, 300.0),
    );
  });

  uiTest('a batch can hold several items with their own weights', (
    tester,
  ) async {
    final chicken = await seedRecipe(db, 'Grilled chicken');
    final rice = await seedRecipe(db, 'Rice', yieldFactor: 2.5, rawG: 200);
    await pumpPantry(tester);

    await startBatchWith(tester, chicken);
    await tapKey(tester, 'add-batch-item');
    await tapKey(tester, 'pick-recipe-$rice');
    await enterKey(tester, 'batch-raw-1', '250');
    await enterKey(tester, 'batch-cooked-1', '625');
    await tapKey(tester, 'save-batch');

    final items = await db.select(db.batchItems).get();
    expect(items.map((i) => (i.recipeId, i.rawTotalG, i.cookedTotalG)), [
      (chicken, 400.0, 300.0),
      (rice, 250.0, 625.0),
    ]);
    expect(await db.select(db.batchSessions).get(), hasLength(1));
  });

  uiTest('rejects an empty batch and a missing cooked weight', (tester) async {
    final recipeId = await seedRecipe(db, 'Grilled chicken');
    await pumpPantry(tester);

    await tapKey(tester, 'log-batch');
    await tapKey(tester, 'save-batch');
    expect(find.byKey(const Key('items-error')), findsOneWidget);

    await tapKey(tester, 'add-batch-item');
    await tapKey(tester, 'pick-recipe-$recipeId');
    await tapKey(tester, 'save-batch');
    expect(find.text('Enter a number'), findsOneWidget);
    expect(await db.select(db.batchItems).get(), isEmpty);
  });

  uiTest('a yield far from the recipe offers to update it', (tester) async {
    final recipeId = await seedRecipe(db, 'Grilled chicken', yieldFactor: 0.75);
    await pumpPantry(tester);

    await startBatchWith(tester, recipeId, cooked: '310');
    // 0.775 is within 10% of 0.75.
    expect(find.byKey(const Key('yield-note-0')), findsNothing);
    expect(find.byKey(const Key('update-yield-0')), findsNothing);

    await enterKey(tester, 'batch-cooked-0', '360');
    expect(find.text('Yield 0.90 (recipe expects 0.75)'), findsOneWidget);
    expect(find.byKey(const Key('yield-note-0')), findsOneWidget);
    expect(find.text('Update recipe yield to this value'), findsOneWidget);

    await tapKey(tester, 'update-yield-0');
    await tapKey(tester, 'save-batch');

    final recipe = (await db.recipesDao.getRecipeDetail(recipeId))!.recipe;
    expect(recipe.expectedYieldFactor, closeTo(0.9, 1e-9));
    expect((await db.select(db.batchItems).get()).single.cookedTotalG, 360);
  });

  uiTest('the recipe yield stays unchanged unless the switch is on', (
    tester,
  ) async {
    final recipeId = await seedRecipe(db, 'Grilled chicken', yieldFactor: 0.75);
    await pumpPantry(tester);

    await startBatchWith(tester, recipeId, cooked: '360');
    expect(find.byKey(const Key('yield-note-0')), findsOneWidget);
    await tapKey(tester, 'save-batch');

    final recipe = (await db.recipesDao.getRecipeDetail(recipeId))!.recipe;
    expect(recipe.expectedYieldFactor, 0.75);
    expect(await db.select(db.batchItems).get(), hasLength(1));
  });

  uiTest('flags low and empty stock', (tester) async {
    final recipeId = await seedRecipe(db, 'Grilled chicken');
    final full = await seedBatchItem(db, recipeId);
    final low = await seedBatchItem(db, recipeId);
    final empty = await seedBatchItem(db, recipeId);
    await logBatchMeal(db, low, 270, slot: 1);
    await logBatchMeal(db, empty, 300, slot: 2);
    await pumpPantry(tester);

    expect(find.byKey(Key('stock-card-$full')), findsOneWidget);
    expect(
      find.descendant(
        of: find.byKey(Key('stock-card-$low')),
        matching: find.text('Low'),
      ),
      findsOneWidget,
    );
    expect(find.text('30 g left of 300 g'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byKey(Key('stock-card-$empty')),
        matching: find.text('Empty'),
      ),
      findsOneWidget,
    );
    expect(find.text('0 g left of 300 g'), findsOneWidget);
    expect(find.text('Low'), findsOneWidget);
    expect(find.text('Empty'), findsOneWidget);
  });

  uiTest('detail shows macros, portion and consumption history', (
    tester,
  ) async {
    final recipeId = await seedRecipe(db, 'Grilled chicken');
    final itemId = await seedBatchItem(db, recipeId);
    await logBatchMeal(db, itemId, 120, date: DateTime(2026, 10, 3), slot: 2);
    await pumpPantry(tester);

    await tapKey(tester, 'stock-card-$itemId');

    expect(find.byKey(const Key('detail-remaining')), findsOneWidget);
    expect(find.text('180 g left of 300 g'), findsOneWidget);
    expect(find.text('160 kcal · P 30 · F 3 · C 0 · Fiber 0'), findsOneWidget);
    expect(find.text('Per typical 150 g portion'), findsOneWidget);
    expect(find.text('240 kcal · P 45 · F 5 · C 0 · Fiber 0'), findsOneWidget);
    expect(find.text('Sat, Oct 3 · Meal 2'), findsOneWidget);
    expect(find.text('120 g'), findsOneWidget);
  });

  uiTest('an unused item can be deleted from its detail', (tester) async {
    final recipeId = await seedRecipe(db, 'Grilled chicken');
    final itemId = await seedBatchItem(db, recipeId);
    await pumpPantry(tester);

    await tapKey(tester, 'stock-card-$itemId');
    expect(find.text('Not used in any meal yet.'), findsOneWidget);
    await tapKey(tester, 'delete-batch-item');
    expect(find.text('Delete "Grilled chicken"?'), findsOneWidget);
    await tapKey(tester, 'confirm-delete');

    expect(find.text('Your pantry is empty'), findsOneWidget);
    expect(await db.select(db.batchItems).get(), isEmpty);
  });

  uiTest('a consumed item cannot be deleted and says why', (tester) async {
    final recipeId = await seedRecipe(db, 'Grilled chicken');
    final itemId = await seedBatchItem(db, recipeId);
    await logBatchMeal(db, itemId, 100);
    await pumpPantry(tester);

    await tapKey(tester, 'stock-card-$itemId');
    await tapKey(tester, 'delete-batch-item');
    await tapKey(tester, 'confirm-delete');

    expect(
      find.text('This batch item was used in a meal, so it cannot be deleted.'),
      findsOneWidget,
    );
    expect(find.byKey(const Key('detail-remaining')), findsOneWidget);
    expect(await db.select(db.batchItems).get(), hasLength(1));
  });
}
