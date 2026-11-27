import '../../../l10n/app_localizations.dart';
import '../domain/backup_exception.dart';

/// Localized plural noun for a backup table, keyed by its SQL name.
///
/// Unknown names are shown as they are.
String backupTableLabel(AppLocalizations l10n, String table) => switch (table) {
  'user_profiles' => l10n.backupTableUserProfiles,
  'day_type_target_rows' => l10n.backupTableDayTypeTargetRows,
  'week_schedule_entries' => l10n.backupTableWeekScheduleEntries,
  'ingredients' => l10n.backupTableIngredients,
  'tools' => l10n.backupTableTools,
  'recipes' => l10n.backupTableRecipes,
  'recipe_ingredients' => l10n.backupTableRecipeIngredients,
  'recipe_steps' => l10n.backupTableRecipeSteps,
  'recipe_tools' => l10n.backupTableRecipeTools,
  'batch_sessions' => l10n.backupTableBatchSessions,
  'batch_items' => l10n.backupTableBatchItems,
  'meal_logs' => l10n.backupTableMealLogs,
  'meal_components' => l10n.backupTableMealComponents,
  'hydration_logs' => l10n.backupTableHydrationLogs,
  'day_logs' => l10n.backupTableDayLogs,
  'app_settings' => l10n.backupTableAppSettings,
  _ => table,
};

/// "Recipes: 3, Meals: 5" for the non-empty tables, in [tableOrder].
String describeRowCounts(
  AppLocalizations l10n,
  Map<String, int> counts,
  Iterable<String> tableOrder,
) {
  final parts = [
    for (final name in tableOrder)
      if ((counts[name] ?? 0) > 0)
        l10n.backupCountEntry(backupTableLabel(l10n, name), counts[name]!),
  ];
  return parts.isEmpty ? l10n.backupNoData : parts.join(', ');
}

/// The user-facing message for a [BackupException].
String backupErrorMessage(AppLocalizations l10n, BackupException e) {
  final table = e.table ?? '';
  final label = backupTableLabel(l10n, table);
  final row = e.row ?? 0;
  final column = e.column ?? '';
  return switch (e.failure) {
    BackupFailure.notValidJson => l10n.backupErrorNotValidJson,
    BackupFailure.notABackup => l10n.backupErrorNotABackup,
    BackupFailure.invalidFormatVersion => l10n.backupErrorInvalidFormatVersion(
      e.version ?? 0,
    ),
    BackupFailure.newerFormatVersion => l10n.backupErrorNewerFormatVersion(
      e.version ?? 0,
      e.supportedVersion ?? 0,
    ),
    BackupFailure.invalidSchemaVersion => l10n.backupErrorInvalidSchemaVersion(
      e.version ?? 0,
    ),
    BackupFailure.newerSchemaVersion => l10n.backupErrorNewerSchemaVersion(
      e.version ?? 0,
      e.supportedVersion ?? 0,
    ),
    BackupFailure.noExportDate => l10n.backupErrorNoExportDate,
    BackupFailure.noDataSection => l10n.backupErrorNoDataSection,
    BackupFailure.unknownTable => l10n.backupErrorUnknownTable(table),
    BackupFailure.missingTable => l10n.backupErrorMissingTable(table),
    BackupFailure.tableNotList => l10n.backupErrorTableNotList(table),
    BackupFailure.rowNotObject => l10n.backupErrorRowNotObject(label, row),
    BackupFailure.unknownColumn => l10n.backupErrorUnknownColumn(
      label,
      row,
      column,
    ),
    BackupFailure.missingColumn => l10n.backupErrorMissingColumn(
      label,
      row,
      column,
    ),
    BackupFailure.mustBeDate => l10n.backupErrorMustBeDate(label, row, column),
    BackupFailure.mustBeBool => l10n.backupErrorMustBeBool(label, row, column),
    BackupFailure.mustBeText => l10n.backupErrorMustBeText(label, row, column),
    BackupFailure.mustBeWholeNumber => l10n.backupErrorMustBeWholeNumber(
      label,
      row,
      column,
    ),
    BackupFailure.mustBeNumber => l10n.backupErrorMustBeNumber(
      label,
      row,
      column,
    ),
    BackupFailure.unknownValue => l10n.backupErrorUnknownValue(
      label,
      row,
      column,
      e.value ?? '',
    ),
    BackupFailure.missingEnvelopeField => l10n.backupErrorMissingEnvelopeField(
      e.field ?? '',
    ),
    BackupFailure.restoreForeignKey => l10n.backupErrorRestoreForeignKey,
    BackupFailure.restoreDuplicate => l10n.backupErrorRestoreDuplicate,
    BackupFailure.restoreOutOfRange => l10n.backupErrorRestoreOutOfRange,
    BackupFailure.restoreMissingValue => l10n.backupErrorRestoreMissingValue,
    BackupFailure.restoreUnexpected => l10n.backupErrorRestoreUnexpected,
    BackupFailure.notTextFile => l10n.backupErrorNotTextFile,
    BackupFailure.unreadable => l10n.backupErrorUnreadable,
  };
}
