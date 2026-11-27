import 'package:anti_recipes/core/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart';

void main() {
  test(
    'upgrading a v2 database creates app_settings and keeps its data',
    () async {
      final raw = sqlite3.openInMemory();
      addTearDown(raw.close);
      AppDatabase open() => AppDatabase(
        NativeDatabase.opened(raw, closeUnderlyingOnClose: false),
      );

      // Build the schema and write v2 data
      final created = open();
      final day = DateTime(2026, 10, 5);
      await created.mealLogDao.addHydration(day, 500);
      await created.mealLogDao.adjustServings(day, fruitDelta: 2, vegDelta: 3);
      await created.close();

      // Roll back to v2 state
      raw.execute('DROP TABLE app_settings');
      raw.execute('PRAGMA user_version = 2');
      expect(
        raw
            .select(
              "SELECT name FROM sqlite_master WHERE name = 'app_settings'",
            )
            .isEmpty,
        isTrue,
      );

      // Reopen to trigger v2 -> v3 migration
      final upgraded = open();
      addTearDown(upgraded.close);

      // Interacting with the database triggers lazy open and onUpgrade
      await upgraded.settingsDao.setSetting('test_key', 'test_value');
      expect(await upgraded.settingsDao.getSetting('test_key'), 'test_value');

      // Verify app_settings exists in sqlite_master
      expect(
        raw
            .select(
              "SELECT name FROM sqlite_master WHERE name = 'app_settings'",
            )
            .isNotEmpty,
        isTrue,
      );

      // Verify v2 data is intact
      expect(await upgraded.mealLogDao.watchHydrationMl(day).first, 500);
      final servings = await upgraded.mealLogDao.watchServings(day).first;
      expect(servings.fruit, 2);
      expect(servings.veg, 3);
      expect(raw.select('PRAGMA user_version').single.values.single, 3);
    },
  );

  test('upgrading a v1 database creates day_logs and app_settings and keeps its data', () async {
    final raw = sqlite3.openInMemory();
    addTearDown(raw.close);
    AppDatabase open() =>
        AppDatabase(NativeDatabase.opened(raw, closeUnderlyingOnClose: false));

    final created = open();
    final day = DateTime(2026, 10, 5);
    await created.mealLogDao.addHydration(day, 500);
    await created.close();

    // Roll back to v1 state
    raw.execute('DROP TABLE day_logs');
    raw.execute('DROP TABLE app_settings');
    raw.execute('PRAGMA user_version = 1');
    expect(
      raw
          .select(
            "SELECT name FROM sqlite_master WHERE name IN ('day_logs', 'app_settings')",
          )
          .isEmpty,
      isTrue,
    );

    // Reopen to trigger v1 -> v3 migration
    final upgraded = open();
    addTearDown(upgraded.close);

    // Verify both new tables exist and are functional
    await upgraded.mealLogDao.adjustServings(day, fruitDelta: 2);
    expect((await upgraded.mealLogDao.watchServings(day).first).fruit, 2);
    expect(await upgraded.mealLogDao.watchHydrationMl(day).first, 500);

    await upgraded.settingsDao.setSetting('test_key', 'test_value');
    expect(await upgraded.settingsDao.getSetting('test_key'), 'test_value');

    expect(await upgraded.targetsDao.loadPlan(), isNotNull);
    expect(raw.select('PRAGMA user_version').single.values.single, 3);
  });
}
