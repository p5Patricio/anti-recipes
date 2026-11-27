import 'package:drift/drift.dart';

import 'app_database.dart';
import 'tables.dart';

part 'settings_dao.g.dart';

@DriftAccessor(tables: [AppSettings])
class SettingsDao extends DatabaseAccessor<AppDatabase>
    with _$SettingsDaoMixin {
  SettingsDao(super.db);

  /// Returns the setting string for [key], or null if not stored.
  Future<String?> getSetting(String key) async {
    final row = await (select(
      appSettings,
    )..where((s) => s.key.equals(key))).getSingleOrNull();
    return row?.value;
  }

  /// Sets or updates the setting string for [key].
  Future<void> setSetting(String key, String value) async {
    await into(appSettings).insertOnConflictUpdate(
      AppSettingsCompanion.insert(key: key, value: value),
    );
  }

  /// Deletes the setting stored under [key].
  Future<int> deleteSetting(String key) =>
      (delete(appSettings)..where((s) => s.key.equals(key))).go();

  /// Watches a single setting using a distinct SQL trigger per key to avoid stream collisions.
  Stream<String?> watchSetting(String key) => customSelect(
    'SELECT 1 AS watch_app_setting_$key',
    readsFrom: {appSettings},
  ).watch().asyncMap((_) => getSetting(key));

  /// Loads all settings as a map.
  Future<Map<String, String>> loadAll() async {
    final rows = await select(appSettings).get();
    return {for (final r in rows) r.key: r.value};
  }
}
