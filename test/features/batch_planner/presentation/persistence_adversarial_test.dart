import 'package:anti_recipes/core/database/app_database.dart';
import 'package:anti_recipes/core/database/database_provider.dart';
import 'package:anti_recipes/features/backup/data/backup_service.dart';
import 'package:anti_recipes/features/batch_planner/domain/plan_inputs.dart';
import 'package:anti_recipes/features/batch_planner/presentation/plan_providers.dart';
import 'package:anti_recipes/features/batch_planner/presentation/plan_screen.dart';
import 'package:anti_recipes/features/batch_planner/presentation/shopping_list_screen.dart';
import 'package:anti_recipes/features/meal_log/presentation/today_providers.dart';
import 'package:anti_recipes/features/recipes/data/recipes_dao.dart';
import 'package:anti_recipes/features/recipes/domain/recipe_kind.dart';
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart';

import '../../../helpers/db_seed.dart';
import '../../../helpers/ui_helpers.dart';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  final monday = DateTime(2026, 10, 5);

  group('Adversarial JSON corruption resilience', () {
    test('PlanSelection.fromJson handles malformed or wild types safely', () {
      final fallback = DateTime(2026, 10, 5);

      // Empty map
      final empty = PlanSelection.fromJson({}, fallbackFrom: fallback);
      expect(empty.from, fallback);
      expect(empty.dayCount, 3);
      expect(empty.recipeIds, isEmpty);
      expect(empty.fresh, isEmpty);
      expect(empty.leftoverIds, isEmpty);

      // Completely wrong types for every field
      final corrupted = PlanSelection.fromJson({
        'from': 12345,
        'dayCount': 'invalid',
        'recipeIds': ['not', 'a', 'map'],
        'sideGramsPerMeal': 99.9,
        'fresh': 'not a list',
        'leftoverIds': {'not': 'a list'},
      }, fallbackFrom: fallback);

      expect(corrupted.from, fallback);
      expect(corrupted.dayCount, 3);
      expect(corrupted.recipeIds, isEmpty);
      expect(corrupted.fresh, isEmpty);
      expect(corrupted.leftoverIds, isEmpty);

      // Extreme dayCount clamping
      final lowDays = PlanSelection.fromJson({'dayCount': -50});
      expect(lowDays.dayCount, 1);

      final highDays = PlanSelection.fromJson({'dayCount': 999});
      expect(highDays.dayCount, BatchPlanInput.maxPlanDays);

      // Partially corrupted recipeIds & sideGramsPerMeal
      final partialRecipes = PlanSelection.fromJson({
        'recipeIds': {
          'proteinBase': 10,
          'carbBase': 'invalid_string',
          'nonExistentRole': 99,
          'vegetable': null,
        },
        'sideGramsPerMeal': {
          'vegetable': 200,
          'sauce': 'thirty',
          'unknownRole': 50,
        },
      });
      expect(partialRecipes.recipeIds, {PlanRole.proteinBase: 10});
      expect(partialRecipes.sideGramsPerMeal[PlanRole.vegetable], 200.0);
      // sauce falls back to defaultSideGramsPerMeal
      expect(partialRecipes.sideGramsPerMeal[PlanRole.sauce], 30.0);

      // Corrupted fresh additions
      final corruptedFresh = PlanSelection.fromJson({
        'fresh': [
          {'ingredientId': 1, 'gramsPerMeal': 50.0},
          {'ingredientId': 'bad', 'gramsPerMeal': 50.0}, // caught & skipped
          {'ingredientId': 2}, // caught & skipped
          'not a map',
          null,
          42,
          {'ingredientId': 3, 'gramsPerMeal': 75},
        ],
      });
      expect(corruptedFresh.fresh.length, 2);
      expect(corruptedFresh.fresh[0].ingredientId, 1);
      expect(corruptedFresh.fresh[0].gramsPerMeal, 50.0);
      expect(corruptedFresh.fresh[1].ingredientId, 3);
      expect(corruptedFresh.fresh[1].gramsPerMeal, 75.0);

      // Corrupted leftoverIds
      final corruptedLeftovers = PlanSelection.fromJson({
        'leftoverIds': [1, 'two', null, 3.0, 4, <String, dynamic>{}],
      });
      expect(corruptedLeftovers.leftoverIds, {1, 3, 4});
    });

    test('deserializeShoppingChecked handles corrupted payloads safely', () {
      expect(deserializeShoppingChecked(null), isEmpty);
      expect(deserializeShoppingChecked(''), isEmpty);
      expect(deserializeShoppingChecked('{not json'), isEmpty);
      expect(deserializeShoppingChecked('{"key": "value"}'), isEmpty);
      expect(deserializeShoppingChecked('123'), isEmpty);
      expect(deserializeShoppingChecked('"just a string"'), isEmpty);
      expect(deserializeShoppingChecked('true'), isEmpty);
      expect(deserializeShoppingChecked('null'), isEmpty);

      // Heterogeneous list
      final mixed = deserializeShoppingChecked(
        '[1, 2, "three", null, 4.0, [5], {"a": 1}, 6]',
      );
      expect(mixed, {1, 2, 4, 6});
    });

    test('PlanSelectionNotifier recovers from malformed JSON in DB', () async {
      final db = AppDatabase(NativeDatabase.memory());
      addTearDown(db.close);

      // Inject malformed JSON into SettingsDao
      await db.settingsDao.setSetting(
        PlanSelectionNotifier.settingKey,
        '{corrupted json :::: broken',
      );

      final container = ProviderContainer(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          todayProvider.overrideWithValue(monday),
        ],
      );
      addTearDown(container.dispose);

      // Read notifier
      final initial = container.read(planSelectionProvider);
      expect(initial.from, monday);
      expect(initial.dayCount, 3);

      // Allow async hydration to complete
      await pumpEventQueue();

      final hydrated = container.read(planSelectionProvider);
      expect(hydrated.from, monday);
      expect(hydrated.dayCount, 3);
      expect(hydrated.recipeIds, isEmpty);
    });

    test(
      'ShoppingCheckedNotifier recovers from malformed JSON in DB',
      () async {
        final db = AppDatabase(NativeDatabase.memory());
        addTearDown(db.close);

        await db.settingsDao.setSetting(
          ShoppingCheckedNotifier.settingKey,
          '{"invalid": "format not list"}',
        );

        final container = ProviderContainer(
          overrides: [appDatabaseProvider.overrideWithValue(db)],
        );
        addTearDown(container.dispose);

        final initial = container.read(shoppingCheckedProvider);
        expect(initial, isEmpty);

        await pumpEventQueue();

        final hydrated = container.read(shoppingCheckedProvider);
        expect(hydrated, isEmpty);
      },
    );
  });

  group('Missing / deleted entity resilience in batchPlanProvider', () {
    uiTest(
      'deleted or phantom recipe referenced in plan is gracefully omitted without throwing',
      (tester) async {
        final db = AppDatabase(NativeDatabase.memory());
        addTearDown(db.close);

        final chicken = await seedRecipe(db, 'Grilled chicken');

        // Preload plan_selection with phantom recipe 99999, phantom fresh 88888, phantom leftover 77777
        await db.settingsDao.setSetting(
          PlanSelectionNotifier.settingKey,
          '{"from":"2026-10-05T00:00:00.000","dayCount":3,"recipeIds":{"proteinBase":$chicken,"carbBase":99999},"sideGramsPerMeal":{"vegetable":150.0,"sauce":30.0},"fresh":[{"ingredientId":88888,"gramsPerMeal":100.0}],"leftoverIds":[77777]}',
        );

        // Mount PlanScreen
        await pumpWithDb(
          tester,
          db,
          const PlanScreen(),
          overrides: [todayProvider.overrideWithValue(monday)],
        );

        // The screen should render cleanly without error
        expect(find.text('Grilled chicken'), findsWidgets);
        expect(
          find.descendant(
            of: find.byKey(const Key('pick-role-carbBase')),
            matching: find.text('Choose'),
          ),
          findsOneWidget,
        );
        expect(
          find.descendant(
            of: find.byKey(const Key('pick-role-proteinBase')),
            matching: find.text('Change'),
          ),
          findsOneWidget,
        );
        expect(
          find.byKey(const Key('plan-recipe-proteinBase')),
          findsOneWidget,
        );
        expect(find.byKey(const Key('plan-recipe-carbBase')), findsNothing);
        expect(
          find.text('Raw 2,135 g · cooked 1,601 g (yield 0.75)'),
          findsOneWidget,
        );
        expect(find.text('Protein 480 / 480 g'), findsOneWidget);
        expect(find.text('Carbs 0 / 841 g'), findsOneWidget);

        // Now delete the existing chicken recipe from DB
        await db.recipesDao.deleteRecipe(chicken);
        await tester.pumpAndSettle();

        // Screen re-renders gracefully: protein base is now also omitted, showing 0/480 g
        expect(find.text('Grilled chicken'), findsNothing);
        expect(
          find.descendant(
            of: find.byKey(const Key('pick-role-proteinBase')),
            matching: find.text('Choose'),
          ),
          findsOneWidget,
        );
      },
    );
  });

  group('Drift schema v3 migration and SettingsDao stress testing', () {
    test(
      'SettingsDao distinct watch triggers do not freeze or collide',
      () async {
        final db = AppDatabase(NativeDatabase.memory());
        addTearDown(db.close);

        final eventsKey1 = <String?>[];
        final eventsKey2 = <String?>[];

        final sub1 = db.settingsDao
            .watchSetting('key_1')
            .listen(eventsKey1.add);
        final sub2 = db.settingsDao
            .watchSetting('key_2')
            .listen(eventsKey2.add);
        addTearDown(sub1.cancel);
        addTearDown(sub2.cancel);

        // Wait for initial null emissions
        await Future<void>.delayed(const Duration(milliseconds: 50));
        expect(eventsKey1, [null]);
        expect(eventsKey2, [null]);

        await db.settingsDao.setSetting('key_1', 'value_1');
        await Future<void>.delayed(const Duration(milliseconds: 50));

        expect(eventsKey1.last, 'value_1');
        expect(eventsKey2.last, null);

        await db.settingsDao.setSetting('key_2', 'value_2');
        await Future<void>.delayed(const Duration(milliseconds: 50));

        expect(eventsKey1.last, 'value_1');
        expect(eventsKey2.last, 'value_2');

        await db.settingsDao.deleteSetting('key_1');
        await Future<void>.delayed(const Duration(milliseconds: 50));

        expect(eventsKey1.last, null);
        expect(eventsKey2.last, 'value_2');
      },
    );

    test(
      'v1 -> v3 migration retains complex user data and creates app_settings',
      () async {
        final raw = sqlite3.openInMemory();
        addTearDown(raw.close);
        AppDatabase open() => AppDatabase(
          NativeDatabase.opened(raw, closeUnderlyingOnClose: false),
        );

        final initDb = open();
        // Insert a custom recipe
        final rId = await initDb.recipesDao.saveRecipe(
          const RecipeDraft(name: 'Legacy Chili', kind: RecipeKind.complete),
        );
        await initDb.close();

        // Drop day_logs and app_settings, set user_version to 1
        raw.execute('DROP TABLE day_logs');
        raw.execute('DROP TABLE app_settings');
        raw.execute('PRAGMA user_version = 1');

        // Verify v1 state
        final tablesV1 = raw
            .select("SELECT name FROM sqlite_master WHERE type='table'")
            .map((row) => row['name'] as String)
            .toList();
        expect(tablesV1, isNot(contains('day_logs')));
        expect(tablesV1, isNot(contains('app_settings')));

        // Migrate to v3
        final upgradedDb = open();
        addTearDown(upgradedDb.close);

        // Verify legacy recipe exists
        final recipes = await upgradedDb.select(upgradedDb.recipes).get();
        expect(
          recipes.any((r) => r.id == rId && r.name == 'Legacy Chili'),
          isTrue,
        );

        // Verify app_settings works for reads and writes
        await upgradedDb.settingsDao.setSetting('migrated', 'yes');
        expect(await upgradedDb.settingsDao.getSetting('migrated'), 'yes');
        expect(await upgradedDb.settingsDao.loadAll(), {'migrated': 'yes'});

        // Verify user_version is 3
        expect(raw.select('PRAGMA user_version').single.values.single, 3);
      },
    );

    test(
      'Backup export and import round-trip preserves app_settings',
      () async {
        final source = AppDatabase(NativeDatabase.memory());
        final target = AppDatabase(NativeDatabase.memory());
        addTearDown(source.close);
        addTearDown(target.close);

        await source.settingsDao.setSetting(
          'active_plan_selection',
          '{"dayCount":2}',
        );
        await source.settingsDao.setSetting(
          'shopping_checked_ids',
          '[1, 2, 3]',
        );

        final serviceSource = BackupService(source);
        final json = await serviceSource.exportJson();

        final serviceTarget = BackupService(target);
        final importResult = await serviceTarget.importJson(json);

        expect(importResult.rowCounts['app_settings'], 2);
        expect(
          await target.settingsDao.getSetting('active_plan_selection'),
          '{"dayCount":2}',
        );
        expect(
          await target.settingsDao.getSetting('shopping_checked_ids'),
          '[1, 2, 3]',
        );
      },
    );
  });
}
