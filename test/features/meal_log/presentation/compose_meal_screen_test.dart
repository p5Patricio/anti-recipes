import 'package:anti_recipes/core/database/app_database.dart';
import 'package:anti_recipes/core/database/date_utils.dart';
import 'package:anti_recipes/core/theme/app_colors.dart';
import 'package:anti_recipes/features/inventory/presentation/pantry_screen.dart';
import 'package:anti_recipes/features/meal_log/data/meal_log_dao.dart';
import 'package:anti_recipes/features/meal_log/presentation/compose_meal_screen.dart';
import 'package:anti_recipes/features/nutrition_targets/domain/day_type.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/db_seed.dart';
import '../../../helpers/ui_helpers.dart';

void main() {
  late AppDatabase db;
  late int chickenItem;

  /// 400 g raw chicken cooked down to 300 g: 0.3 g protein per cooked gram.
  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    chickenItem = await seedBatchItem(
      db,
      await seedRecipe(db, 'Grilled chicken'),
    );
  });
  tearDown(() => db.close());

  Future<void> pumpComposer(WidgetTester tester, {int slot = 1}) =>
      pumpWithDb(tester, db, ComposeMealScreen(date: monday, slot: slot));

  Future<void> addChicken(WidgetTester tester) async {
    await tapKey(tester, 'add-from-pantry');
    await tapKey(tester, 'pick-stock-$chickenItem');
  }

  Color statusColor(WidgetTester tester) {
    final box = tester.widget<Container>(
      find.byKey(const Key('protein-status')),
    );
    return ((box.decoration! as BoxDecoration).border! as Border).top.color;
  }

  uiTest('composes a meal from stock and a fresh ingredient', (tester) async {
    await pumpComposer(tester);
    expect(find.text('Mon, Oct 5'), findsOneWidget);
    expect(find.text('Protein 50 g below 50-55 g'), findsOneWidget);

    await addChicken(tester);
    await tapKey(tester, 'chip-b$chickenItem-100');
    await tapKey(tester, 'chip-b$chickenItem-50');
    expect(fieldText(tester, 'grams-b$chickenItem'), '150');
    // 150 g cooked chicken = 45 g protein, 240 kcal.
    expect(find.text('Protein 5 g below 50-55 g'), findsOneWidget);
    expect(statusColor(tester), AppColors.terracotta);

    final egg = await ingredientIdByName(db, 'Egg');
    await tapKey(tester, 'add-fresh');
    await tapKey(tester, 'pick-ingredient-$egg');
    await enterKey(tester, 'grams-i$egg', '50');
    // 45 + 6.3 g protein.
    expect(find.text('Protein on target (50-55 g)'), findsOneWidget);
    expect(statusColor(tester), AppColors.sage);

    await tapKey(tester, 'save-meal');

    expect(find.byKey(const Key('save-meal')), findsNothing);
    final meal = (await db.mealLogDao.loadDay(monday)).single;
    expect(meal.slot, 1);
    expect(meal.dayType, DayType.training);
    expect(
      meal.components.map((c) => (c.batchItemId, c.ingredientId, c.grams)),
      [(chickenItem, null, 150.0), (null, egg, 50.0)],
    );
    final stock = (await db.inventoryDao.loadStock()).single;
    expect(stock.remainingG, 150);
  });

  uiTest('protein turns terracotta again when the meal goes over the range', (
    tester,
  ) async {
    await pumpComposer(tester);
    await addChicken(tester);
    await enterKey(tester, 'grams-b$chickenItem', '200');

    // 60 g protein.
    expect(find.text('Protein 5 g above 50-55 g'), findsOneWidget);
    expect(statusColor(tester), AppColors.terracotta);
  });

  uiTest('shows what is left of the day after this meal', (tester) async {
    final oil = await ingredientIdByName(db, 'Olive oil');
    await db.mealLogDao.upsertMeal(
      date: monday,
      slot: 2,
      dayType: DayType.training,
      components: [MealComponentDraft(ingredientId: oil, grams: 10)],
    );
    await pumpComposer(tester);
    await addChicken(tester);
    await enterKey(tester, 'grams-b$chickenItem', '100');

    // Training day: 2450 kcal and 295 g carbs; oil 88.4 kcal, chicken 160 kcal.
    expect(
      find.text(
        'Left today after this meal (training day): 2202 kcal · 295 g carbs',
      ),
      findsOneWidget,
    );
  });

  uiTest('the suggestion button sets grams to hit the protein target', (
    tester,
  ) async {
    await pumpComposer(tester);
    expect(
      tester
          .widget<FilledButton>(find.byKey(const Key('suggest-protein')))
          .onPressed,
      isNull,
    );
    expect(find.byKey(const Key('suggest-hint')), findsOneWidget);

    await addChicken(tester);
    await tapKey(tester, 'suggest-protein');

    // Midpoint 52.5 g protein at 0.3 g per cooked gram.
    expect(fieldText(tester, 'grams-b$chickenItem'), '175');
    expect(find.text('Protein on target (50-55 g)'), findsOneWidget);
    expect(find.byKey(const Key('suggest-hint')), findsNothing);
  });

  uiTest('the suggestion accounts for the other components', (tester) async {
    await pumpComposer(tester);
    final egg = await ingredientIdByName(db, 'Egg');
    await tapKey(tester, 'add-fresh');
    await tapKey(tester, 'pick-ingredient-$egg');
    await enterKey(tester, 'grams-i$egg', '100');
    await addChicken(tester);
    await tapKey(tester, 'suggest-protein');

    // (52.5 - 12.6) / 0.3 = 133 g.
    expect(fieldText(tester, 'grams-b$chickenItem'), '133');
    expect(find.text('Protein on target (50-55 g)'), findsOneWidget);
  });

  uiTest('the suggestion is limited to what is left in the pantry', (
    tester,
  ) async {
    await logBatchMeal(db, chickenItem, 220, slot: 3);
    await pumpComposer(tester);
    await addChicken(tester);
    await tapKey(tester, 'suggest-protein');

    expect(fieldText(tester, 'grams-b$chickenItem'), '80');
    expect(
      find.textContaining('protein stays below the target'),
      findsOneWidget,
    );
    expect(find.text('Protein 26 g below 50-55 g'), findsOneWidget);
  });

  uiTest('quick chips never go past the remaining stock', (tester) async {
    await pumpComposer(tester);
    await addChicken(tester);
    for (var i = 0; i < 4; i++) {
      await tapKey(tester, 'chip-b$chickenItem-100');
    }

    expect(fieldText(tester, 'grams-b$chickenItem'), '300');
    expect(find.byKey(Key('warning-b$chickenItem')), findsNothing);

    await enterKey(tester, 'grams-b$chickenItem', '50');
    await tapKey(tester, 'chip-b$chickenItem-all');
    expect(fieldText(tester, 'grams-b$chickenItem'), '300');
  });

  uiTest('typing more than the remaining stock needs confirmation', (
    tester,
  ) async {
    await pumpComposer(tester);
    await addChicken(tester);
    await enterKey(tester, 'grams-b$chickenItem', '350');
    expect(find.text('Only 300 g left in the pantry.'), findsOneWidget);

    await tapKey(tester, 'save-meal');
    expect(find.text('Not enough in the pantry'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(await db.mealLogDao.loadDay(monday), isEmpty);

    await tapKey(tester, 'save-meal');
    await tapKey(tester, 'confirm-override');
    final meal = (await db.mealLogDao.loadDay(monday)).single;
    expect(meal.components.single.grams, 350);
    expect((await db.inventoryDao.loadStock()).single.remainingG, -50);
  });

  uiTest('requires at least one component with grams', (tester) async {
    await pumpComposer(tester);
    await tapKey(tester, 'save-meal');
    expect(find.byKey(const Key('lines-error')), findsOneWidget);

    await addChicken(tester);
    await tapKey(tester, 'save-meal');
    expect(find.text('Enter a number'), findsOneWidget);
    expect(await db.mealLogDao.loadDay(monday), isEmpty);
  });

  uiTest('only pantry items with stock left can be added', (tester) async {
    final recipe = await seedRecipe(db, 'Pulled pork');
    final emptied = await seedBatchItem(db, recipe);
    await logBatchMeal(db, emptied, 300, slot: 3);
    await pumpComposer(tester);
    await tapKey(tester, 'add-from-pantry');

    expect(find.byKey(Key('pick-stock-$chickenItem')), findsOneWidget);
    expect(find.byKey(Key('pick-stock-$emptied')), findsNothing);
    expect(find.text('300 g left · cooked Oct 1'), findsOneWidget);
  });

  uiTest('editing a meal gives its grams back to the available stock', (
    tester,
  ) async {
    await logBatchMeal(db, chickenItem, 100);
    await pumpComposer(tester);

    // 200 g left in the pantry plus the 100 g this meal already holds.
    expect(find.text('From pantry · 300 g available'), findsOneWidget);
    expect(fieldText(tester, 'grams-b$chickenItem'), '100');
    await enterKey(tester, 'grams-b$chickenItem', '250');
    expect(find.byKey(Key('warning-b$chickenItem')), findsNothing);
    await tapKey(tester, 'save-meal');

    final meal = (await db.mealLogDao.loadDay(monday)).single;
    expect(meal.components.single.grams, 250);
    expect((await db.inventoryDao.loadStock()).single.remainingG, 50);
  });

  uiTest('switching the slot loads that slot and saves into it', (
    tester,
  ) async {
    final oil = await ingredientIdByName(db, 'Olive oil');
    await db.mealLogDao.upsertMeal(
      date: monday,
      slot: 2,
      dayType: DayType.training,
      components: [MealComponentDraft(ingredientId: oil, grams: 10)],
    );
    await pumpComposer(tester);
    expect(find.byKey(Key('grams-i$oil')), findsNothing);

    await tapKey(tester, 'slot-2');
    expect(fieldText(tester, 'grams-i$oil'), '10');

    await tapKey(tester, 'slot-3');
    expect(find.byKey(Key('grams-i$oil')), findsNothing);
    await addChicken(tester);
    await enterKey(tester, 'grams-b$chickenItem', '100');
    await tapKey(tester, 'save-meal');

    final meals = await db.mealLogDao.loadDay(monday);
    expect(meals.map((m) => m.slot), [2, 3]);
  });

  uiTest('the pantry app bar opens the composer on the first free slot', (
    tester,
  ) async {
    await db.mealLogDao.upsertMeal(
      date: dateOnly(DateTime.now()),
      slot: 1,
      dayType: DayType.training,
      components: [MealComponentDraft(batchItemId: chickenItem, grams: 50)],
    );
    await pumpWithDb(tester, db, const PantryScreen());

    await tapKey(tester, 'compose-meal');

    expect(find.text('Compose meal'), findsOneWidget);
    final slot2 = tester.widget<ChoiceChip>(find.byKey(const Key('slot-2')));
    expect(slot2.selected, isTrue);
  });
}
