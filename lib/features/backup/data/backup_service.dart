import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../domain/backup_document.dart';
import '../domain/backup_exception.dart';
import 'backup_codec.dart';

/// Exports the database to JSON and restores it from a backup.
class BackupService {
  BackupService(this._db, {BackupCodec? codec, DateTime Function()? clock})
    : _codec = codec ?? BackupCodec(_db),
      _clock = clock ?? DateTime.now;

  final AppDatabase _db;
  final BackupCodec _codec;
  final DateTime Function() _clock;

  Future<BackupDocument> exportDocument() => _codec.dump(now: _clock());

  Future<String> exportJson() async => (await exportDocument()).encode();

  /// Validates [json] without touching the database, so the caller can show
  /// what an import would load before asking for confirmation.
  BackupDocument inspect(String json) => _codec.decode(json);

  /// Replaces the stored data with the backup in a single transaction.
  ///
  /// Throws [BackupException] on any problem and then leaves the database
  /// exactly as it was.
  Future<ImportResult> importJson(
    String json, {
    ImportMode mode = ImportMode.replaceAll,
  }) async {
    final document = _codec.decode(json);
    switch (mode) {
      case ImportMode.replaceAll:
        await _replaceAll(document);
    }
    return ImportResult(document.rowCounts);
  }

  Future<void> _replaceAll(BackupDocument document) async {
    try {
      await _db.transaction(() async {
        // Children first, so restrict rules never block a delete.
        for (final spec in _codec.specs.reversed) {
          await _db.delete(_codec.tableFor(spec)).go();
        }
        for (final spec in _codec.specs) {
          final table = _codec.tableFor(spec);
          final rows = document.tables[spec.name] ?? const [];
          await _db.batch((b) {
            for (var i = 0; i < rows.length; i++) {
              b.insert(
                table,
                // Never makes this an Insertable of every generated row type,
                // which drift's generated validation checks at runtime.
                RawValuesInsertable<Never>(
                  _codec.insertValues(spec, rows[i], i),
                ),
              );
            }
          });
        }
      });
    } on BackupException {
      rethrow;
    } catch (e) {
      throw BackupException(
        'The backup could not be restored because ${_reason(e)}.',
        cause: e,
      );
    }
  }

  String _reason(Object error) {
    final text = error.toString().toUpperCase();
    if (text.contains('FOREIGN KEY')) {
      return 'a row refers to data that is not in the backup';
    }
    if (text.contains('UNIQUE')) {
      return 'it contains duplicate entries';
    }
    if (text.contains('CHECK')) {
      return 'a value is outside its allowed range';
    }
    if (text.contains('NOT NULL')) {
      return 'a required value is missing';
    }
    return 'of an unexpected error';
  }
}
