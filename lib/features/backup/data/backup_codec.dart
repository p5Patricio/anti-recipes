import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../domain/backup_document.dart';
import '../domain/backup_exception.dart';
import 'backup_schema.dart';

/// Turns the whole database into a [BackupDocument] and back.
///
/// Serialization is table-driven from drift's column metadata, so a column
/// added to an existing table is exported automatically. A new table must be
/// listed in `backupTables`; the constructor throws until it is.
class BackupCodec {
  BackupCodec(this._db, {List<BackupTableSpec> specs = backupTables})
    : specs = List.unmodifiable(specs),
      _tables = _bind(_db, specs);

  final AppDatabase _db;
  final List<BackupTableSpec> specs;
  final Map<String, TableInfo<Table, dynamic>> _tables;

  static Map<String, TableInfo<Table, dynamic>> _bind(
    AppDatabase db,
    List<BackupTableSpec> specs,
  ) {
    final actual = {for (final t in db.allTables) t.actualTableName: t};
    final listed = specs.map((s) => s.name).toSet();
    final missing = actual.keys.where((n) => !listed.contains(n)).toList();
    final unknown = listed.where((n) => !actual.containsKey(n)).toList();
    if (missing.isNotEmpty ||
        unknown.isNotEmpty ||
        listed.length != specs.length) {
      throw StateError(
        'Backup schema is out of sync with the database. '
        'Tables missing from the backup: $missing. '
        'Backup tables that do not exist: $unknown.',
      );
    }
    return {for (final s in specs) s.name: actual[s.name]!};
  }

  /// The drift table behind a spec.
  TableInfo<Table, dynamic> tableFor(BackupTableSpec spec) =>
      _tables[spec.name]!;

  // Export

  /// Reads every table in one transaction so the document is a consistent
  /// snapshot.
  Future<BackupDocument> dump({DateTime? now}) => _db.transaction(() async {
    final tables = <String, List<Map<String, Object?>>>{};
    for (final spec in specs) {
      final table = tableFor(spec);
      final rows = await _db
          .customSelect('SELECT * FROM "${spec.name}" ORDER BY rowid')
          .get();
      tables[spec.name] = [
        for (final row in rows)
          {for (final c in table.$columns) c.$name: _readCell(row, c)},
      ];
    }
    return BackupDocument(
      schemaVersion: _db.schemaVersion,
      exportedAt: (now ?? DateTime.now()).toUtc(),
      tables: tables,
    );
  });

  Object? _readCell(QueryRow row, GeneratedColumn<Object> column) {
    final name = column.$name;
    final type = column.type;
    if (type == DriftSqlType.dateTime) {
      return row.readNullable<DateTime>(name)?.toUtc().toIso8601String();
    }
    if (type == DriftSqlType.bool) return row.readNullable<bool>(name);
    if (type == DriftSqlType.string) return row.readNullable<String>(name);
    if (type == DriftSqlType.int) return row.readNullable<int>(name);
    if (type == DriftSqlType.double) return row.readNullable<double>(name);
    throw StateError(
      'Column ${column.tableName}.$name has a type the backup cannot '
      'serialize: $type',
    );
  }

  // Import

  /// Parses and validates [json]. Throws [BackupException] with a message
  /// fit for the user; nothing is written to the database.
  BackupDocument decode(String json) {
    final Object? root;
    try {
      root = jsonDecode(json);
    } on FormatException catch (e) {
      throw BackupException('This file is not valid JSON.', cause: e);
    }
    if (root is! Map<String, dynamic> ||
        root['format'] != BackupDocument.formatName) {
      throw const BackupException('This file is not an Anti-recipes backup.');
    }
    final version = _requireInt(root, 'version');
    if (version < 1) {
      throw BackupException('Invalid backup format version $version.');
    }
    if (version > BackupDocument.formatVersion) {
      throw BackupException(
        'This backup uses file format $version, which is newer than this '
        'app understands (format ${BackupDocument.formatVersion}). '
        'Update the app and try again.',
      );
    }
    final schemaVersion = _requireInt(root, 'schemaVersion');
    if (schemaVersion < 1) {
      throw BackupException('Invalid database version $schemaVersion.');
    }
    if (schemaVersion > _db.schemaVersion) {
      throw BackupException(
        'This backup was made by a newer version of the app (database '
        'version $schemaVersion; this app supports up to '
        '${_db.schemaVersion}). Update the app and try again.',
      );
    }
    final exportedRaw = root['exportedAt'];
    final exportedAt = exportedRaw is String
        ? DateTime.tryParse(exportedRaw)
        : null;
    if (exportedAt == null) {
      throw const BackupException('The backup has no valid export date.');
    }
    final data = root['data'];
    if (data is! Map<String, dynamic>) {
      throw const BackupException('The backup has no data section.');
    }

    final known = specs.map((s) => s.name).toSet();
    for (final key in data.keys) {
      if (!known.contains(key)) {
        throw BackupException('The backup contains an unknown table "$key".');
      }
    }

    final tables = <String, List<Map<String, Object?>>>{};
    for (final spec in specs) {
      final raw = data[spec.name];
      if (raw == null) {
        if (spec.since > schemaVersion) {
          tables[spec.name] = const [];
          continue;
        }
        throw BackupException(
          'The backup is missing the "${spec.name}" table.',
        );
      }
      if (raw is! List) {
        throw BackupException('"${spec.name}" must be a list of rows.');
      }
      final rows = <Map<String, Object?>>[];
      for (var i = 0; i < raw.length; i++) {
        final row = raw[i];
        if (row is! Map<String, dynamic>) {
          throw BackupException('${spec.label} row ${i + 1} is not an object.');
        }
        // Validate every cell now so a bad file is rejected before any write.
        insertValues(spec, row, i);
        rows.add(Map<String, Object?>.of(row));
      }
      tables[spec.name] = rows;
    }
    return BackupDocument(
      version: version,
      schemaVersion: schemaVersion,
      exportedAt: exportedAt.toUtc(),
      tables: tables,
    );
  }

  /// Typed column values for inserting [row] (the [index]-th of [spec]).
  Map<String, Expression> insertValues(
    BackupTableSpec spec,
    Map<String, Object?> row,
    int index,
  ) {
    final table = tableFor(spec);
    final columns = {for (final c in table.$columns) c.$name: c};
    String where() => '${spec.label} row ${index + 1}';
    for (final key in row.keys) {
      if (!columns.containsKey(key)) {
        throw BackupException('${where()} has an unknown column "$key".');
      }
    }
    final values = <String, Expression>{};
    for (final c in table.$columns) {
      final raw = row[c.$name];
      if (raw == null) {
        if (row.containsKey(c.$name) && c.$nullable) {
          values[c.$name] = const Constant<Object>(null);
        } else if (c.requiredDuringInsert) {
          throw BackupException('${where()} is missing "${c.$name}".');
        }
        // Otherwise the database default or autoincrement supplies it.
        continue;
      }
      values[c.$name] = _decodeCell(c, raw, '${where()}, "${c.$name}"');
    }
    return values;
  }

  Expression<Object> _decodeCell(
    GeneratedColumn<Object> column,
    Object raw,
    String where,
  ) {
    BackupException bad(String expected) =>
        BackupException('$where must be $expected.');
    final type = column.type;
    if (type == DriftSqlType.dateTime) {
      final parsed = raw is String ? DateTime.tryParse(raw) : null;
      if (parsed == null) throw bad('an ISO 8601 date');
      return Variable<DateTime>(parsed);
    }
    if (type == DriftSqlType.bool) {
      if (raw is! bool) throw bad('true or false');
      return Variable<bool>(raw);
    }
    if (type == DriftSqlType.string) {
      if (raw is! String) throw bad('text');
      if (column is GeneratedColumnWithTypeConverter) {
        try {
          column.converter.fromSql(raw);
        } catch (_) {
          throw BackupException('$where has an unknown value "$raw".');
        }
      }
      return Variable<String>(raw);
    }
    if (type == DriftSqlType.int) {
      if (raw is int) return Variable<int>(raw);
      if (raw is double && raw == raw.truncateToDouble()) {
        return Variable<int>(raw.toInt());
      }
      throw bad('a whole number');
    }
    if (type == DriftSqlType.double) {
      if (raw is! num) throw bad('a number');
      return Variable<double>(raw.toDouble());
    }
    throw StateError('Unsupported column type $type for $where');
  }

  int _requireInt(Map<String, dynamic> root, String key) {
    final v = root[key];
    if (v is! int) {
      throw BackupException('The backup has no valid "$key".');
    }
    return v;
  }
}
