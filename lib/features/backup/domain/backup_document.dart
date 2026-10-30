import 'dart:convert';

/// How an import combines the backup with the current data.
enum ImportMode {
  /// Erases everything currently stored, then loads the backup.
  replaceAll,
}

/// Row counts per table after a successful import.
class ImportResult {
  const ImportResult(this.rowCounts);

  /// Table name -> number of rows loaded.
  final Map<String, int> rowCounts;

  int get totalRows => rowCounts.values.fold(0, (a, b) => a + b);
}

/// A parsed backup file: envelope metadata plus raw column values per table.
///
/// Column names are the SQL names, enums are their stored names and
/// timestamps are UTC ISO 8601 strings, so the document is plain JSON data.
class BackupDocument {
  const BackupDocument({
    required this.schemaVersion,
    required this.exportedAt,
    required this.tables,
    this.version = formatVersion,
  });

  static const formatName = 'anti-recipes-backup';

  /// Version of the envelope layout (not of the database schema).
  static const formatVersion = 1;

  final int version;

  /// Database schema version the backup was taken from.
  final int schemaVersion;
  final DateTime exportedAt;

  /// Table name -> rows in export order.
  final Map<String, List<Map<String, Object?>>> tables;

  Map<String, int> get rowCounts => {
    for (final e in tables.entries) e.key: e.value.length,
  };

  int get totalRows => rowCounts.values.fold(0, (a, b) => a + b);

  Map<String, Object?> toJson() => {
    'format': formatName,
    'version': version,
    'schemaVersion': schemaVersion,
    'exportedAt': exportedAt.toUtc().toIso8601String(),
    'data': tables,
  };

  String encode() => const JsonEncoder.withIndent('  ').convert(toJson());
}

/// "anti-recipes-backup-20261006-1530.json" for the given local time.
String backupFileName(DateTime localTime) {
  String two(int v) => v.toString().padLeft(2, '0');
  final t = localTime;
  return 'anti-recipes-backup-${t.year.toString().padLeft(4, '0')}'
      '${two(t.month)}${two(t.day)}-${two(t.hour)}${two(t.minute)}.json';
}
