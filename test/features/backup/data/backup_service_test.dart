import 'dart:convert';

import 'package:anti_recipes/core/database/app_database.dart';
import 'package:anti_recipes/features/backup/data/backup_codec.dart';
import 'package:anti_recipes/features/backup/data/backup_schema.dart';
import 'package:anti_recipes/features/backup/data/backup_service.dart';
import 'package:anti_recipes/features/backup/domain/backup_document.dart';
import 'package:anti_recipes/features/backup/domain/backup_exception.dart';
import 'package:anti_recipes/features/recipes/data/recipes_dao.dart';
import 'package:anti_recipes/features/recipes/domain/recipe_kind.dart';
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/backup_fixtures.dart';
import '../../../helpers/db_seed.dart' show monday;

void main() {
  // Two in-memory databases are used on purpose.
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  late AppDatabase source;
  late AppDatabase target;
  late BackupService sourceService;
  late BackupService targetService;

  setUp(() async {
    source = AppDatabase(NativeDatabase.memory());
    target = AppDatabase(NativeDatabase.memory());
    sourceService = BackupService(source);
    targetService = BackupService(target);
    await populateRichDb(source);
  });
  tearDown(() async {
    await source.close();
    await target.close();
  });

  /// Decoded export of [source], ready to be tampered with.
  Future<Map<String, dynamic>> exported() async =>
      jsonDecode(await sourceService.exportJson()) as Map<String, dynamic>;

  List<dynamic> rows(Map<String, dynamic> doc, String table) =>
      (doc['data'] as Map<String, dynamic>)[table] as List<dynamic>;

  /// Imports [doc] into the populated [source] and expects a rejection that
  /// leaves every row untouched.
  Future<void> expectRejected(Map<String, dynamic> doc, Matcher message) async {
    final before = withoutTimestamp(await sourceService.exportJson());
    await expectLater(
      sourceService.importJson(jsonEncode(doc)),
      throwsA(
        isA<BackupException>().having((e) => e.message, 'message', message),
      ),
    );
    expect(withoutTimestamp(await sourceService.exportJson()), before);
  }

  group('table coverage', () {
    test('every table of the database is a backup table', () {
      final actual = source.allTables.map((t) => t.actualTableName).toSet();
      expect(backupTables.map((s) => s.name).toSet(), actual);
      expect(backupTables.map((s) => s.name).toSet(), hasLength(actual.length));
    });

    test('the export has every table and every column', () async {
      final doc = await exported();
      final data = doc['data'] as Map<String, dynamic>;
      for (final table in source.allTables) {
        final exportedRows = data[table.actualTableName] as List<dynamic>?;
        expect(
          exportedRows,
          isNotNull,
          reason: '${table.actualTableName} is missing from the export',
        );
        expect(
          exportedRows,
          isNotEmpty,
          reason: 'populateRichDb must fill ${table.actualTableName}',
        );
        for (final row in exportedRows!) {
          expect(
            (row as Map<String, dynamic>).keys.toSet(),
            table.$columns.map((c) => c.$name).toSet(),
            reason: table.actualTableName,
          );
        }
      }
    });

    test('a table missing from the backup schema is detected', () {
      expect(
        () => BackupCodec(source, specs: backupTables.skip(1).toList()),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            contains('user_profiles'),
          ),
        ),
      );
      expect(
        () => BackupCodec(
          source,
          specs: [...backupTables, const BackupTableSpec('ghost', 'Ghosts')],
        ),
        throwsStateError,
      );
    });
  });

  group('export format', () {
    test('wraps the data in a versioned envelope', () async {
      final doc = await exported();
      expect(doc['format'], 'anti-recipes-backup');
      expect(doc['version'], 1);
      expect(doc['schemaVersion'], source.schemaVersion);
      expect(DateTime.parse(doc['exportedAt'] as String).isUtc, isTrue);
      expect(doc.keys, containsAll(['data']));
    });

    test(
      'stores enums by name, dates as UTC ISO 8601 and raw numbers',
      () async {
        final doc = await exported();
        final schedule = rows(doc, 'week_schedule_entries').cast<Map>();
        expect(
          schedule.firstWhere((r) => r['weekday'] == 3)['day_type'],
          'training',
        );
        expect(
          schedule.firstWhere((r) => r['weekday'] == 1)['day_type'],
          'rest',
        );

        final recipe = rows(doc, 'recipes').cast<Map>().first;
        expect(recipe['kind'], 'proteinBase');
        expect(recipe['expected_yield_factor'], 0.72);
        expect((recipe['created_at'] as String).endsWith('Z'), isTrue);

        expect(rows(doc, 'user_profiles').single['body_weight_kg'], 81.4);
        expect(
          rows(doc, 'ingredients').cast<Map>().first['is_fruit'],
          isA<bool>(),
        );
        final hydration = rows(doc, 'hydration_logs').cast<Map>().first;
        expect(
          DateTime.parse(hydration['logged_at'] as String),
          DateTime(2026, 10, 5, 8, 15).toUtc(),
        );
      },
    );

    test('describes counts and builds the file name', () {
      expect(
        describeRowCounts({'recipes': 2, 'meal_logs': 1, 'tools': 0}),
        'Recipes: 2, Meals: 1',
      );
      expect(describeRowCounts({}), 'no data');
      expect(
        backupFileName(DateTime(2026, 3, 7, 9, 5)),
        'anti-recipes-backup-20260307-0905.json',
      );
    });
  });

  group('round trip', () {
    test(
      'export, import into a fresh database, export again is identical',
      () async {
        final first = await sourceService.exportJson();

        final result = await targetService.importJson(first);
        final second = await targetService.exportJson();

        expect(withoutTimestamp(second), withoutTimestamp(first));
        expect(
          result.rowCounts,
          (await sourceService.exportDocument()).rowCounts,
        );
        expect(result.totalRows, greaterThan(40));
        expect(await target.targetsDao.loadBodyWeightKg(), 81.4);
        expect((await target.targetsDao.loadPlan())!.proteinGPerDay, 172.5);
      },
    );

    test('keeps the data usable: stock, meals and new ids', () async {
      await targetService.importJson(await sourceService.exportJson());

      final stock = await target.inventoryDao.loadStock();
      expect(stock.map((s) => s.recipeName), contains('Roast chicken'));
      expect(await target.mealLogDao.loadDay(monday), hasLength(2));
      // Autoincrement continues after the imported maximum.
      final id = await target.recipesDao.saveRecipe(
        const RecipeDraft(name: 'Garlic sauce', kind: RecipeKind.sauce),
      );
      expect(id, greaterThan(2));
    });

    test('replaces seeded rows instead of merging with them', () async {
      final doc = await exported();
      final ingredients = rows(doc, 'ingredients');
      ingredients.removeWhere((r) => (r as Map)['name'] == 'Banana');
      expect(await target.select(target.ingredients).get(), hasLength(10));

      await targetService.importJson(jsonEncode(doc));

      final names = (await target.select(target.ingredients).get()).map(
        (i) => i.name,
      );
      expect(names, hasLength(10)); // 10 seeded - Banana + Lentils
      expect(names, isNot(contains('Banana')));
      expect(names, contains('Lentils'));
    });

    test('an empty database exports and imports as empty', () async {
      await target.close();
      target = AppDatabase(NativeDatabase.memory());
      targetService = BackupService(target);
      final emptyExport = await targetService.exportJson();

      final result = await sourceService.importJson(emptyExport);

      expect(
        withoutTimestamp(await sourceService.exportJson()),
        withoutTimestamp(emptyExport),
      );
      expect(result.rowCounts['recipes'], 0);
      expect(result.rowCounts['ingredients'], 10);
    });
  });

  group('rejections never leave partial data', () {
    test('a foreign key violation rolls the whole import back', () async {
      final doc = await exported();
      (rows(doc, 'recipe_ingredients').first as Map)['recipe_id'] = 9999;
      await expectRejected(doc, contains('refers to data that is not'));
    });

    test('a duplicate primary key rolls back', () async {
      final doc = await exported();
      final recipes = rows(doc, 'recipes');
      recipes.add(
        Map<String, dynamic>.of(recipes.first as Map<String, dynamic>),
      );
      await expectRejected(doc, contains('duplicate'));
    });

    test('a value breaking a check constraint rolls back', () async {
      final doc = await exported();
      (rows(doc, 'week_schedule_entries').first as Map)['weekday'] = 9;
      await expectRejected(doc, contains('allowed range'));
    });

    test('malformed JSON', () async {
      await expectLater(
        sourceService.importJson('{ not json'),
        throwsA(
          isA<BackupException>().having(
            (e) => e.message,
            'message',
            'This file is not valid JSON.',
          ),
        ),
      );
      expect(await source.select(source.recipes).get(), isNotEmpty);
    });

    test('files that are not backups', () async {
      for (final json in [
        '[]',
        '"x"',
        '{}',
        '{"format":"other","version":1}',
      ]) {
        await expectLater(
          sourceService.importJson(json),
          throwsA(
            isA<BackupException>().having(
              (e) => e.message,
              'message',
              contains('not an Anti-recipes backup'),
            ),
          ),
          reason: json,
        );
      }
    });

    test('a newer file format version', () async {
      final doc = await exported();
      doc['version'] = 2;
      await expectRejected(doc, contains('file format 2'));
    });

    test('a newer database schema version', () async {
      final doc = await exported();
      doc['schemaVersion'] = source.schemaVersion + 1;
      await expectRejected(doc, contains('newer version of the app'));
    });

    test('missing envelope fields', () async {
      for (final key in ['version', 'schemaVersion', 'exportedAt', 'data']) {
        final doc = await exported()
          ..remove(key);
        await expectRejected(doc, isNotEmpty);
      }
    });

    test('a missing table', () async {
      final doc = await exported();
      (doc['data'] as Map).remove('recipes');
      await expectRejected(doc, contains('missing the "recipes" table'));
    });

    test('an unknown table', () async {
      final doc = await exported();
      (doc['data'] as Map)['mystery'] = [];
      await expectRejected(doc, contains('unknown table "mystery"'));
    });

    test('an unknown column', () async {
      final doc = await exported();
      (rows(doc, 'recipes').first as Map)['flavor'] = 'sweet';
      await expectRejected(doc, contains('unknown column "flavor"'));
    });

    test('a missing required column', () async {
      final doc = await exported();
      (rows(doc, 'recipes').first as Map).remove('name');
      await expectRejected(doc, contains('missing "name"'));
    });

    test('values of the wrong type or an unknown enum name', () async {
      var doc = await exported();
      (rows(doc, 'recipes').first as Map)['kind'] = 'dessert';
      await expectRejected(doc, contains('unknown value "dessert"'));

      doc = await exported();
      (rows(doc, 'recipes').first as Map)['expected_yield_factor'] = 'lots';
      await expectRejected(doc, contains('must be a number'));

      doc = await exported();
      (rows(doc, 'recipes').first as Map)['created_at'] = 'yesterday';
      await expectRejected(doc, contains('ISO 8601'));

      doc = await exported();
      (rows(doc, 'ingredients').first as Map)['is_fruit'] = 'yes';
      await expectRejected(doc, contains('true or false'));

      doc = await exported();
      (rows(doc, 'tools').first as Map)['id'] = 1.5;
      await expectRejected(doc, contains('whole number'));

      doc = await exported();
      (doc['data'] as Map)['recipes'] = {'a': 1};
      await expectRejected(doc, contains('list of rows'));

      doc = await exported();
      rows(doc, 'recipes')[0] = 'nope';
      await expectRejected(doc, contains('not an object'));
    });
  });

  group('older schema versions', () {
    test('a v1 backup without day_logs loads with the table empty', () async {
      final doc = await exported();
      doc['schemaVersion'] = 1;
      (doc['data'] as Map).remove('day_logs');

      final result = await sourceService.importJson(jsonEncode(doc));

      expect(result.rowCounts['day_logs'], 0);
      expect(await source.select(source.dayLogs).get(), isEmpty);
      expect(await source.select(source.recipes).get(), isNotEmpty);
    });

    test('a current-version backup must include every table', () async {
      final doc = await exported();
      (doc['data'] as Map).remove('day_logs');
      await expectRejected(doc, contains('missing the "day_logs" table'));
    });
  });

  test('inspect validates without writing', () async {
    final doc = sourceService.inspect(await sourceService.exportJson());
    expect(doc.version, BackupDocument.formatVersion);
    expect(doc.rowCounts['recipes'], 2);
    expect(await target.select(target.recipes).get(), isEmpty);
  });
}
