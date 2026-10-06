import 'package:anti_recipes/core/database/app_database.dart';
import 'package:anti_recipes/core/theme/app_colors.dart';
import 'package:anti_recipes/features/meal_log/presentation/today_providers.dart';
import 'package:anti_recipes/features/meal_log/presentation/today_screen.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/db_seed.dart';
import '../../../helpers/ui_helpers.dart';

void main() {
  late AppDatabase db;
  late int chickenItem;

  /// One big chicken batch: 0.3 g protein and 1.6 kcal per cooked gram.
  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    chickenItem = await seedBatchItem(
      db,
      await seedRecipe(db, 'Grilled chicken'),
      rawG: 1600,
      cookedG: 1200,
    );
  });
  tearDown(() => db.close());

  /// Pumps the dashboard with "today" pinned to Monday (a training day).
  Future<void> pumpToday(WidgetTester tester) => pumpWithDb(
    tester,
    db,
    const TodayScreen(),
    overrides: [todayProvider.overrideWithValue(monday)],
  );

  Color chipColor(WidgetTester tester, String key) {
    final box = tester.widget<Container>(
      find.descendant(
        of: find.byKey(Key(key)),
        matching: find.byType(Container),
      ),
    );
    return ((box.decoration! as BoxDecoration).border! as Border).top.color;
  }

  Color barColor(WidgetTester tester, String key) => tester
      .widget<LinearProgressIndicator>(
        find.descendant(
          of: find.byKey(Key(key)),
          matching: find.byType(LinearProgressIndicator),
        ),
      )
      .color!;

  String badge(WidgetTester tester) => tester
      .widget<Text>(
        find.descendant(
          of: find.byKey(const Key('day-type-badge')),
          matching: find.byType(Text),
        ),
      )
      .data!;

  uiTest('shows the training day defaults', (tester) async {
    await pumpToday(tester);

    expect(find.text('Mon, Oct 5'), findsOneWidget);
    expect(badge(tester), 'Training day');
    expect(find.byKey(const Key('jump-today')), findsNothing);
    expect(find.text('0 / 2450 kcal'), findsOneWidget);
    expect(find.text('Range 2400-2500 kcal · 2450 kcal left'), findsOneWidget);
    expect(find.text('0 / 160 g'), findsNWidgets(1));
    expect(find.text('Goal 3500-4250 ml'), findsOneWidget);
    expect(find.text('0 / 3875 ml'), findsOneWidget);
    expect(find.byKey(const Key('carbs-info')), findsNothing);
    for (final slot in [1, 2, 3]) {
      expect(find.byKey(Key('compose-slot-$slot')), findsOneWidget);
    }
    expect(find.text('Goal 1-3 portions'), findsOneWidget);
    expect(find.text('Goal 2-3 portions'), findsOneWidget);
    expect(find.byKey(const Key('protein-distribution')), findsOneWidget);
  });

  uiTest('day navigation changes the date and the day type', (tester) async {
    await pumpToday(tester);

    await tapKey(tester, 'prev-day');
    expect(find.text('Sun, Oct 4'), findsOneWidget);
    expect(badge(tester), 'Rest day');
    expect(find.text('Goal 3000-3500 ml'), findsOneWidget);
    expect(find.text('0 / 3250 ml'), findsOneWidget);
    expect(find.byKey(const Key('jump-today')), findsOneWidget);
    // Rest-day derived carbs fall below the configured range.
    expect(find.byKey(const Key('carbs-info')), findsOneWidget);

    await tapKey(tester, 'jump-today');
    expect(find.text('Mon, Oct 5'), findsOneWidget);
    expect(badge(tester), 'Training day');
    expect(find.byKey(const Key('jump-today')), findsNothing);

    await tapKey(tester, 'next-day');
    expect(find.text('Tue, Oct 6'), findsOneWidget);
    expect(badge(tester), 'Training day');
  });

  uiTest('data is per day', (tester) async {
    await logBatchMeal(db, chickenItem, 100);
    await pumpToday(tester);
    expect(find.byKey(const Key('slot-totals-1')), findsOneWidget);

    await tapKey(tester, 'next-day');
    expect(find.byKey(const Key('slot-totals-1')), findsNothing);
    expect(find.byKey(const Key('compose-slot-1')), findsOneWidget);
  });

  uiTest('an empty slot opens the composer on that slot', (tester) async {
    await pumpToday(tester);

    await tapKey(tester, 'compose-slot-2');

    expect(find.byKey(const Key('compose-date')), findsOneWidget);
    expect(find.text('Mon, Oct 5'), findsOneWidget);
    expect(
      tester.widget<ChoiceChip>(find.byKey(const Key('slot-2'))).selected,
      isTrue,
    );
  });

  uiTest('a meal saved in the composer shows up after returning', (
    tester,
  ) async {
    await pumpToday(tester);

    await tapKey(tester, 'compose-slot-1');
    await tapKey(tester, 'add-from-pantry');
    await tapKey(tester, 'pick-stock-$chickenItem');
    await enterKey(tester, 'grams-b$chickenItem', '175');
    await tapKey(tester, 'save-meal');

    expect(find.byKey(const Key('save-meal')), findsNothing);
    expect(find.text('280 kcal · P 53 · F 6 · C 0'), findsOneWidget);
    expect(find.text('Protein 53 g · on target'), findsOneWidget);
    expect(find.byKey(const Key('compose-slot-1')), findsNothing);
    expect(find.text('280 / 2450 kcal'), findsOneWidget);
  });

  uiTest('filled slots show totals and the protein chip status', (
    tester,
  ) async {
    await logBatchMeal(db, chickenItem, 175, slot: 1);
    await logBatchMeal(db, chickenItem, 100, slot: 2);
    await logBatchMeal(db, chickenItem, 200, slot: 3);
    await pumpToday(tester);

    expect(find.text('Protein 53 g · on target'), findsOneWidget);
    expect(find.text('Protein 30 g · below 50-55 g'), findsOneWidget);
    expect(find.text('Protein 60 g · above 50-55 g'), findsOneWidget);
    expect(chipColor(tester, 'slot-protein-1'), AppColors.sage);
    expect(chipColor(tester, 'slot-protein-2'), AppColors.terracotta);
    expect(chipColor(tester, 'slot-protein-3'), AppColors.terracotta);
    expect(find.text('Grilled chicken 175 g'), findsOneWidget);
    expect(find.byKey(const Key('compose-slot-1')), findsNothing);

    // 475 g * 1.6 kcal = 760 kcal, still below the calorie range.
    expect(find.text('760 / 2450 kcal'), findsOneWidget);
    expect(find.text('Range 2400-2500 kcal · 1690 kcal left'), findsOneWidget);
    expect(barColor(tester, 'bar-kcal'), AppColors.kraft);
    expect(find.text('Calories · Below'), findsOneWidget);
  });

  uiTest('the edit action reopens the composer for that meal', (tester) async {
    await logBatchMeal(db, chickenItem, 100, slot: 2);
    await pumpToday(tester);

    await tapKey(tester, 'edit-meal-2');

    expect(find.byKey(const Key('compose-date')), findsOneWidget);
    expect(fieldText(tester, 'grams-b$chickenItem'), '100');
  });

  uiTest('deleting a meal asks for confirmation', (tester) async {
    await logBatchMeal(db, chickenItem, 100);
    await pumpToday(tester);

    await tapKey(tester, 'delete-meal-1');
    expect(find.text('Delete meal 1?'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(await db.mealLogDao.loadDay(monday), hasLength(1));
    expect(find.byKey(const Key('slot-totals-1')), findsOneWidget);

    await tapKey(tester, 'delete-meal-1');
    await tapKey(tester, 'confirm-delete');

    expect(await db.mealLogDao.loadDay(monday), isEmpty);
    expect(find.byKey(const Key('slot-totals-1')), findsNothing);
    expect(find.byKey(const Key('compose-slot-1')), findsOneWidget);
    // The pantry gets the grams back.
    expect((await db.inventoryDao.loadStock()).single.remainingG, 1200);
  });

  uiTest('hydration quick add, custom amount and undo update the progress', (
    tester,
  ) async {
    await pumpToday(tester);
    expect(
      tester
          .widget<TextButton>(find.byKey(const Key('hydration-undo')))
          .onPressed,
      isNull,
    );

    await tapKey(tester, 'hydration-add-500');
    expect(find.text('500 / 3875 ml'), findsOneWidget);
    await tapKey(tester, 'hydration-add-250');
    await tapKey(tester, 'hydration-add-750');
    expect(find.text('1500 / 3875 ml'), findsOneWidget);

    await tapKey(tester, 'hydration-custom');
    await enterKey(tester, 'custom-ml-field', '0');
    await tapKey(tester, 'custom-ml-confirm');
    expect(find.text('Must be above 0'), findsOneWidget);
    await enterKey(tester, 'custom-ml-field', '2000');
    await tapKey(tester, 'custom-ml-confirm');
    expect(find.text('3500 / 3875 ml'), findsOneWidget);
    expect(find.text('On target'), findsOneWidget);
    expect(barColor(tester, 'bar-water'), AppColors.sage);

    await tapKey(tester, 'hydration-undo');
    expect(find.text('1500 / 3875 ml'), findsOneWidget);
    expect(barColor(tester, 'bar-water'), AppColors.kraft);
    await tapKey(tester, 'hydration-undo');
    expect(find.text('750 / 3875 ml'), findsOneWidget);
  });

  uiTest('fruit and vegetable steppers track portions against the ranges', (
    tester,
  ) async {
    await pumpToday(tester);
    String count(String id) =>
        tester.widget<Text>(find.byKey(Key('$id-count'))).data!;
    String status(String id) => tester
        .widget<Text>(
          find.descendant(
            of: find.byKey(Key('$id-status')),
            matching: find.byType(Text),
          ),
        )
        .data!;

    expect(count('fruit'), '0');
    expect(status('fruit'), 'Below');
    expect(
      tester.widget<IconButton>(find.byKey(const Key('fruit-minus'))).onPressed,
      isNull,
    );

    await tapKey(tester, 'fruit-plus');
    expect(count('fruit'), '1');
    expect(status('fruit'), 'On target');

    await tapKey(tester, 'veg-plus');
    expect(status('veg'), 'Below');
    await tapKey(tester, 'veg-plus');
    expect(count('veg'), '2');
    expect(status('veg'), 'On target');

    for (var i = 0; i < 3; i++) {
      await tapKey(tester, 'fruit-plus');
    }
    expect(count('fruit'), '4');
    expect(status('fruit'), 'Above');
    await tapKey(tester, 'fruit-minus');
    expect(count('fruit'), '3');
    expect(status('fruit'), 'On target');

    final row = (await db.select(db.dayLogs).get()).single;
    expect((row.fruitPortions, row.vegPortions), (3, 2));
  });

  uiTest('asks to set up targets when no plan exists', (tester) async {
    await db.delete(db.userProfiles).go();
    await pumpToday(tester);

    expect(find.byKey(const Key('setup-targets-hint')), findsOneWidget);
    expect(find.byKey(const Key('macro-summary')), findsNothing);
    expect(find.byKey(const Key('prev-day')), findsOneWidget);
  });
}
