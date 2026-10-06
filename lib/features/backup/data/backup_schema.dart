/// One table of the database as the backup format knows it.
class BackupTableSpec {
  const BackupTableSpec(this.name, this.label, {this.since = 1});

  /// SQL table name, also the key in the backup's `data` object.
  final String name;

  /// User-facing plural noun used in confirmations and summaries.
  final String label;

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
  BackupTableSpec('user_profiles', 'Profile'),
  BackupTableSpec('day_type_target_rows', 'Day-type targets'),
  BackupTableSpec('week_schedule_entries', 'Week schedule days'),
  BackupTableSpec('ingredients', 'Ingredients'),
  BackupTableSpec('tools', 'Tools'),
  BackupTableSpec('recipes', 'Recipes'),
  BackupTableSpec('recipe_ingredients', 'Recipe ingredient lines'),
  BackupTableSpec('recipe_steps', 'Recipe steps'),
  BackupTableSpec('recipe_tools', 'Recipe tools'),
  BackupTableSpec('batch_sessions', 'Batch sessions'),
  BackupTableSpec('batch_items', 'Batch items'),
  BackupTableSpec('meal_logs', 'Meals'),
  BackupTableSpec('meal_components', 'Meal components'),
  BackupTableSpec('hydration_logs', 'Hydration entries'),
  BackupTableSpec('day_logs', 'Fruit and vegetable days', since: 2),
];

/// "Recipes: 3, Meals: 5" for the non-empty tables, in schema order.
String describeRowCounts(
  Map<String, int> counts, {
  List<BackupTableSpec> specs = backupTables,
}) {
  final parts = [
    for (final s in specs)
      if ((counts[s.name] ?? 0) > 0) '${s.label}: ${counts[s.name]}',
  ];
  return parts.isEmpty ? 'no data' : parts.join(', ');
}
