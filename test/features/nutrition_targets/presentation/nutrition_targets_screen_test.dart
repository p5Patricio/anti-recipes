import 'package:anti_recipes/core/database/app_database.dart';
import 'package:anti_recipes/core/database/database_provider.dart';
import 'package:anti_recipes/core/theme/app_theme.dart';
import 'package:anti_recipes/features/nutrition_targets/presentation/nutrition_targets_screen.dart';
import 'package:anti_recipes/features/nutrition_targets/presentation/targets_providers.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  Future<void> pumpScreen(WidgetTester tester) async {
    tester.view.physicalSize = const Size(900, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: MaterialApp(
          theme: AppTheme.light(),
          home: const NutritionTargetsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> enter(WidgetTester tester, String key, String text) async {
    final finder = find.byKey(Key(key));
    await tester.ensureVisible(finder);
    await tester.enterText(finder, text);
    await tester.pump();
  }

  Future<void> tapKey(WidgetTester tester, String key) async {
    final finder = find.byKey(Key(key));
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  String fieldText(WidgetTester tester, String key) => tester
      .widget<TextFormField>(
        find.descendant(
          of: find.byKey(Key(key)),
          matching: find.byType(TextFormField),
        ),
      )
      .controller!
      .text;

  testWidgets('loads defaults and warns on rest-day carbs only', (
    tester,
  ) async {
    await pumpScreen(tester);

    expect(fieldText(tester, 'field-protein'), '160');
    expect(fieldText(tester, 'field-fat'), '70');
    expect(find.byKey(const Key('rest-carbs-warning')), findsOneWidget);
    expect(find.byKey(const Key('training-carbs-warning')), findsNothing);
    expect(
      find.text('Carbs are derived from calories left after protein and fat.'),
      findsOneWidget,
    );
    expect(find.text('Protein per meal target: 53.3 g'), findsOneWidget);
  });

  testWidgets('shows g/kg hints and weekly average when weight is set', (
    tester,
  ) async {
    await pumpScreen(tester);
    await enter(tester, 'field-weight', '80');
    expect(find.text('Protein: 2.00 g/kg'), findsOneWidget);
    expect(find.textContaining('Weekly average: 2'), findsOneWidget);
  });

  testWidgets('rejects min > max and does not save', (tester) async {
    await pumpScreen(tester);
    await enter(tester, 'training-kcal-min', '3000');
    await tapKey(tester, 'save-targets');

    expect(find.text('Must be at least min'), findsWidgets);
    final plan = await db.targetsDao.loadPlan();
    expect(plan!.proteinGPerDay, 160);
    expect(find.text('Nutrition targets saved'), findsNothing);
  });

  testWidgets('saves an edited protein value through the DAO', (tester) async {
    await pumpScreen(tester);
    await enter(tester, 'field-protein', '170');
    await enter(tester, 'field-weight', '82.5');
    await tapKey(tester, 'schedule-3'); // Wednesday rest -> training
    await tapKey(tester, 'save-targets');

    expect(find.text('Nutrition targets saved'), findsOneWidget);
    expect((await db.targetsDao.loadPlan())!.proteinGPerDay, 170);
    expect(await db.targetsDao.loadBodyWeightKg(), 82.5);
    expect(
      (await db.targetsDao.loadSchedule())!.days[3].toString(),
      contains('training'),
    );
  });

  testWidgets('reset restores example defaults after confirmation', (
    tester,
  ) async {
    await pumpScreen(tester);
    await enter(tester, 'field-protein', '999');
    await tapKey(tester, 'reset-targets');
    expect(find.text('Reset to example defaults?'), findsOneWidget);
    await tester.tap(find.text('Reset'));
    await tester.pumpAndSettle();
    expect(fieldText(tester, 'field-protein'), '160');
  });

  test('providers expose engine and today targets', () async {
    final container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
    addTearDown(container.dispose);
    container.listen(nutritionEngineProvider, (_, _) {});
    await pumpEventQueue();
    final engine = container.read(nutritionEngineProvider);
    expect(engine.requireValue, isNotNull);
    final today = container.read(todayTargetsProvider).requireValue!;
    expect(today.proteinG, 160);
  });
}
