/// Why a backup could not be created, read or restored.
///
/// Presentation maps each reason (plus the parameters carried by
/// [BackupException]) to a localized message; the domain carries no text.
enum BackupFailure {
  notValidJson,
  notABackup,
  invalidFormatVersion,
  newerFormatVersion,
  invalidSchemaVersion,
  newerSchemaVersion,
  noExportDate,
  noDataSection,
  unknownTable,
  missingTable,
  tableNotList,
  rowNotObject,
  unknownColumn,
  missingColumn,
  mustBeDate,
  mustBeBool,
  mustBeText,
  mustBeWholeNumber,
  mustBeNumber,
  unknownValue,
  missingEnvelopeField,
  restoreForeignKey,
  restoreDuplicate,
  restoreOutOfRange,
  restoreMissingValue,
  restoreUnexpected,
  notTextFile,
  unreadable,
}

/// A backup could not be created, read or restored.
///
/// [failure] says why; the optional fields are the values the user-facing
/// message mentions. Which ones are set depends on [failure].
class BackupException implements Exception {
  const BackupException(
    this.failure, {
    this.cause,
    this.version,
    this.supportedVersion,
    this.table,
    this.row,
    this.column,
    this.value,
    this.field,
  });

  final BackupFailure failure;

  /// The underlying error, kept for diagnostics only.
  final Object? cause;

  /// Format or database version found in the file.
  final int? version;

  /// Highest version this app understands.
  final int? supportedVersion;

  /// SQL table name the problem refers to.
  final String? table;

  /// 1-based row number inside [table].
  final int? row;

  /// SQL column name.
  final String? column;

  /// Offending raw value, as text.
  final String? value;

  /// Envelope field that is missing or invalid (for example `version`).
  final String? field;

  @override
  String toString() => 'BackupException: ${failure.name}';
}
