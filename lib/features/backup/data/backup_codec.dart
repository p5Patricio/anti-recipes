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
      throw BackupException(BackupFailure.notValidJson, cause: e);
    }
    if (root is! Map<String, dynamic> ||
        root['format'] != BackupDocument.formatName) {
      throw const BackupException(BackupFailure.notABackup);
    }
    final version = _requireInt(root, 'version');
    if (version < 1) {
      throw BackupException(
        BackupFailure.invalidFormatVersion,
        version: version,
      );
    }
    if (version > BackupDocument.formatVersion) {
      throw BackupException(
        BackupFailure.newerFormatVersion,
        version: version,
        supportedVersion: BackupDocument.formatVersion,
      );
    }
    final schemaVersion = _requireInt(root, 'schemaVersion');
    if (schemaVersion < 1) {
      throw BackupException(
        BackupFailure.invalidSchemaVersion,
        version: schemaVersion,
      );
    }
    if (schemaVersion > _db.schemaVersion) {
      throw BackupException(
        BackupFailure.newerSchemaVersion,
        version: schemaVersion,
        supportedVersion: _db.schemaVersion,
      );
    }
    final exportedRaw = root['exportedAt'];
    final exportedAt = exportedRaw is String
        ? DateTime.tryParse(exportedRaw)
        : null;
    if (exportedAt == null) {
      throw const BackupException(BackupFailure.noExportDate);
    }
    final data = root['data'];
    if (data is! Map<String, dynamic>) {
      throw const BackupException(BackupFailure.noDataSection);
    }

    final known = specs.map((s) => s.name).toSet();
    for (final key in data.keys) {
      if (!known.contains(key)) {
        throw BackupException(BackupFailure.unknownTable, table: key);
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
        throw BackupException(BackupFailure.missingTable, table: spec.name);
      }
      if (raw is! List) {
        throw BackupException(BackupFailure.tableNotList, table: spec.name);
      }
      final rows = <Map<String, Object?>>[];
      for (var i = 0; i < raw.length; i++) {
        final row = raw[i];
        if (row is! Map<String, dynamic>) {
          throw BackupException(
            BackupFailure.rowNotObject,
            table: spec.name,
            row: i + 1,
          );
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
    for (final key in row.keys) {
      if (!columns.containsKey(key)) {
        throw BackupException(
          BackupFailure.unknownColumn,
          table: spec.name,
          row: index + 1,
          column: key,
        );
      }
    }
    final values = <String, Expression>{};
    for (final c in table.$columns) {
      final raw = row[c.$name];
      if (raw == null) {
        if (row.containsKey(c.$name) && c.$nullable) {
          values[c.$name] = const Constant<Object>(null);
        } else if (c.requiredDuringInsert) {
          throw BackupException(
            BackupFailure.missingColumn,
            table: spec.name,
            row: index + 1,
            column: c.$name,
          );
        }
        // Otherwise the database default or autoincrement supplies it.
        continue;
      }
      values[c.$name] = _decodeCell(c, raw, spec.name, index + 1);
    }
    return values;
  }

  Expression<Object> _decodeCell(
    GeneratedColumn<Object> column,
    Object raw,
    String table,
    int row,
  ) {
    BackupException bad(BackupFailure failure) =>
        BackupException(failure, table: table, row: row, column: column.$name);
    final type = column.type;
    if (type == DriftSqlType.dateTime) {
      final parsed = raw is String ? DateTime.tryParse(raw) : null;
      if (parsed == null) throw bad(BackupFailure.mustBeDate);
      return Variable<DateTime>(parsed);
    }
    if (type == DriftSqlType.bool) {
      if (raw is! bool) throw bad(BackupFailure.mustBeBool);
      return Variable<bool>(raw);
    }
    if (type == DriftSqlType.string) {
      if (raw is! String) throw bad(BackupFailure.mustBeText);
      if (column is GeneratedColumnWithTypeConverter) {
        try {
          column.converter.fromSql(raw);
        } catch (_) {
          throw BackupException(
            BackupFailure.unknownValue,
            table: table,
            row: row,
            column: column.$name,
            value: raw.toString(),
          );
        }
      }
      return Variable<String>(raw);
    }
    if (type == DriftSqlType.int) {
      if (raw is int) return Variable<int>(raw);
      if (raw is double && raw == raw.truncateToDouble()) {
        return Variable<int>(raw.toInt());
      }
      throw bad(BackupFailure.mustBeWholeNumber);
    }
    if (type == DriftSqlType.double) {
      if (raw is! num) throw bad(BackupFailure.mustBeNumber);
      return Variable<double>(raw.toDouble());
    }
    throw StateError(
      'Unsupported column type $type for $table.${column.$name}',
    );
  }

  int _requireInt(Map<String, dynamic> root, String key) {
    final v = root[key];
    if (v is! int) {
      throw BackupException(BackupFailure.missingEnvelopeField, field: key);
    }
    return v;
  }
}
