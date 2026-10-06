import 'dart:convert';

import 'package:anti_recipes/core/database/app_database.dart';
import 'package:anti_recipes/app_shell.dart';
import 'package:anti_recipes/features/backup/data/backup_service.dart';
import 'package:anti_recipes/features/backup/domain/backup_exception.dart';
import 'package:anti_recipes/features/backup/presentation/backup_providers.dart';
import 'package:anti_recipes/features/backup/presentation/backup_screen.dart';
import 'package:anti_recipes/features/meal_log/presentation/today_providers.dart';
import 'package:anti_recipes/features/settings/presentation/settings_screen.dart';
import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/backup_fixtures.dart';
import '../../../helpers/db_seed.dart';
import '../../../helpers/ui_helpers.dart';

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  late AppDatabase db;
  late AppDatabase source;
  late FakeBackupFileGateway gateway;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    source = AppDatabase(NativeDatabase.memory());
    await populateRichDb(source);
    gateway = FakeBackupFileGateway();
  });
  tearDown(() async {
    await db.close();
    await source.close();
  });

  Future<void> pumpBackup(WidgetTester tester) => pumpWithDb(
    tester,
    db,
    const BackupScreen(),
    overrides: [backupFileGatewayProvider.overrideWithValue(gateway)],
  );

  Future<String> sourceJson() => BackupService(source).exportJson();

  Future<int> recipeCount() async => (await db.select(db.recipes).get()).length;

  uiTest('shows the privacy note before sharing anything', (tester) async {
    await pumpBackup(tester);

    expect(find.byKey(const Key('backup-privacy-note')), findsOneWidget);
    expect(find.textContaining('unencrypted'), findsOneWidget);
    expect(find.textContaining('body weight'), findsOneWidget);
  });

  uiTest('export saves a named JSON file and reports the row counts', (
    tester,
  ) async {
    await populateRichDb(db);
    await pumpBackup(tester);

    await tapKey(tester, 'export-backup');

    final file = gateway.saved.single;
    expect(
      file.fileName,
      matches(RegExp(r'^anti-recipes-backup-\d{8}-\d{4}\.json$')),
    );
    final document = BackupService(db).inspect(file.contents);
    expect(document.rowCounts['recipes'], 2);
    expect(jsonDecode(file.contents)['format'], 'anti-recipes-backup');
    expect(find.textContaining('Backup saved'), findsOneWidget);
    expect(find.textContaining('Recipes: 2'), findsOneWidget);
    expect(find.textContaining('Meals: 2'), findsOneWidget);
  });

  uiTest('cancelling the save dialog says nothing was saved', (tester) async {
    gateway.saveLocation = null;
    await pumpBackup(tester);

    await tapKey(tester, 'export-backup');

    expect(gateway.saved, isEmpty);
    expect(find.textContaining('Export cancelled'), findsOneWidget);
  });

  uiTest('import asks for confirmation with counts, then replaces the data', (
    tester,
  ) async {
    gateway.pickResult = await sourceJson();
    await pumpBackup(tester);

    await tapKey(tester, 'import-backup');

    expect(find.text('Replace all data?'), findsOneWidget);
    expect(find.textContaining('erased'), findsOneWidget);
    expect(find.textContaining('cannot be undone'), findsOneWidget);
    expect(find.text('Recipes: 2'), findsOneWidget);
    expect(find.text('Meals: 2'), findsOneWidget);
    expect(find.text('Profile: 1'), findsOneWidget);
    // Nothing is touched until the user confirms.
    expect(await recipeCount(), 0);

    await tapKey(tester, 'confirm-import');

    expect(find.text('Backup restored'), findsOneWidget);
    expect(await recipeCount(), 2);
    expect(await db.targetsDao.loadBodyWeightKg(), 81.4);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('import-success')), findsNothing);
  });

  uiTest('cancelling the confirmation keeps the current data', (tester) async {
    gateway.pickResult = await sourceJson();
    await pumpBackup(tester);

    await tapKey(tester, 'import-backup');
    await tapKey(tester, 'cancel-import');

    expect(find.text('Replace all data?'), findsNothing);
    expect(find.text('Backup restored'), findsNothing);
    expect(await recipeCount(), 0);
    expect(await db.select(db.ingredients).get(), hasLength(10));
  });

  uiTest('cancelling the file picker does nothing', (tester) async {
    await pumpBackup(tester);

    await tapKey(tester, 'import-backup');

    expect(find.text('Replace all data?'), findsNothing);
    expect(find.byKey(const Key('import-error')), findsNothing);
  });

  uiTest('an invalid file shows the reason and leaves the data alone', (
    tester,
  ) async {
    gateway.pickResult = '{ definitely not json';
    await pumpBackup(tester);

    await tapKey(tester, 'import-backup');

    expect(find.text('Import failed'), findsOneWidget);
    expect(find.textContaining('not valid JSON'), findsOneWidget);
    expect(find.textContaining('current data was not changed'), findsOneWidget);
    expect(find.text('Replace all data?'), findsNothing);
    expect(await db.select(db.ingredients).get(), hasLength(10));
  });

  uiTest('a backup that fails midway reports it and rolls back', (
    tester,
  ) async {
    final doc = jsonDecode(await sourceJson()) as Map<String, dynamic>;
    ((doc['data'] as Map)['recipe_ingredients'] as List).first['recipe_id'] =
        9999;
    gateway.pickResult = jsonEncode(doc);
    await pumpBackup(tester);

    await tapKey(tester, 'import-backup');
    await tapKey(tester, 'confirm-import');

    expect(find.text('Import failed'), findsOneWidget);
    expect(find.textContaining('refers to data that is not'), findsOneWidget);
    expect(await recipeCount(), 0);
    expect(await db.select(db.ingredients).get(), hasLength(10));
    expect(await db.select(db.userProfiles).get(), hasLength(1));
  });

  uiTest('an unreadable file is reported from the gateway', (tester) async {
    gateway.pickError = const BackupException('The file could not be read.');
    await pumpBackup(tester);

    await tapKey(tester, 'import-backup');

    expect(find.text('Import failed'), findsOneWidget);
    expect(find.textContaining('The file could not be read.'), findsOneWidget);
  });

  uiTest('Settings links to the backup screen', (tester) async {
    await pumpWithDb(tester, db, const SettingsScreen());

    await tapKey(tester, 'backup-tile');

    expect(find.byKey(const Key('export-backup')), findsOneWidget);
    expect(find.byKey(const Key('import-backup')), findsOneWidget);
  });

  uiTest('imported data shows up in Recipes and Today without a restart', (
    tester,
  ) async {
    gateway.pickResult = await sourceJson();
    await pumpWithDb(
      tester,
      db,
      const AppShell(),
      overrides: [
        backupFileGatewayProvider.overrideWithValue(gateway),
        todayProvider.overrideWithValue(monday),
      ],
    );
    Future<void> openTab(String label) async {
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text(label),
        ),
      );
      await tester.pumpAndSettle();
    }

    // Everything starts empty, with the screens already built and listening.
    await openTab('Recipes');
    expect(find.text('No recipes yet'), findsOneWidget);
    await openTab('Today');
    expect(find.byKey(const Key('slot-totals-1')), findsNothing);

    await openTab('Settings');
    await tapKey(tester, 'backup-tile');
    await tapKey(tester, 'import-backup');
    await tapKey(tester, 'confirm-import');
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();

    await openTab('Recipes');
    expect(find.text('No recipes yet'), findsNothing);
    expect(find.text('Roast chicken'), findsOneWidget);
    expect(find.text('Lentil rice'), findsOneWidget);

    await openTab('Today');
    expect(find.byKey(const Key('slot-totals-1')), findsOneWidget);
    expect(find.byKey(const Key('slot-totals-2')), findsOneWidget);
    expect(find.text('1250 / 3250 ml'), findsOneWidget);
  });
}
