import 'package:anti_recipes/core/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart';

void main() {
  test('upgrading a v1 database creates day_logs and keeps its data', () async {
    final raw = sqlite3.openInMemory();
    addTearDown(raw.close);
    // The raw connection outlives each AppDatabase so it can be reopened.
    AppDatabase open() =>
        AppDatabase(NativeDatabase.opened(raw, closeUnderlyingOnClose: false));

    // Build the current schema, then roll it back to what v1 looked like.
    final created = open();
    await created.mealLogDao.addHydration(DateTime(2026, 10, 5), 500);
    await created.close();
    raw.execute('DROP TABLE day_logs');
    raw.execute('PRAGMA user_version = 1');
    expect(
      raw
          .select("SELECT name FROM sqlite_master WHERE name = 'day_logs'")
          .isEmpty,
      isTrue,
    );

    final upgraded = open();
    addTearDown(upgraded.close);
    final day = DateTime(2026, 10, 5);

    // The new table is usable and the v1 data is untouched.
    await upgraded.mealLogDao.adjustServings(day, fruitDelta: 2);
    expect((await upgraded.mealLogDao.watchServings(day).first).fruit, 2);
    expect(await upgraded.mealLogDao.watchHydrationMl(day).first, 500);
    expect(await upgraded.targetsDao.loadPlan(), isNotNull);
    expect(raw.select('PRAGMA user_version').single.values.single, 2);
  });
}
