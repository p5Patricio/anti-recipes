/// One table of the database as the backup format knows it.
class BackupTableSpec {
  const BackupTableSpec(this.name, {this.since = 1});

  /// SQL table name, also the key in the backup's `data` object.
  final String name;

  /// Database schema version that introduced the table. Backups taken before
  /// it may omit the table, which then loads as empty.
  final int since;
}

/// Every table, in dependency order: parents before the tables that
/// reference them. Imports insert in this order and delete in reverse, so
/// foreign keys stay enforced throughout.
///
/// Adding a table to `AppDatabase` without listing it here fails the backup
/// coverage test and makes `BackupCodec` refuse to start.
const backupTables = <BackupTableSpec>[
  BackupTableSpec('user_profiles'),
  BackupTableSpec('day_type_target_rows'),
  BackupTableSpec('week_schedule_entries'),
  BackupTableSpec('ingredients'),
  BackupTableSpec('tools'),
  BackupTableSpec('recipes'),
  BackupTableSpec('recipe_ingredients'),
  BackupTableSpec('recipe_steps'),
  BackupTableSpec('recipe_tools'),
  BackupTableSpec('batch_sessions'),
  BackupTableSpec('batch_items'),
  BackupTableSpec('meal_logs'),
  BackupTableSpec('meal_components'),
  BackupTableSpec('hydration_logs'),
  BackupTableSpec('day_logs', since: 2),
  BackupTableSpec('app_settings', since: 3),
];
