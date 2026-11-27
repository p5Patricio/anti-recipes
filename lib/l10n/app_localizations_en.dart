// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'anti-recipes';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsNutritionTargetsTitle => 'Nutrition targets';

  @override
  String get settingsNutritionTargetsSubtitle =>
      'Protein, fat, day types and weekly plan';

  @override
  String get settingsBackupTitle => 'Backup';

  @override
  String get settingsBackupSubtitle =>
      'Export or restore all your data as JSON';

  @override
  String get settingsLanguageTitle => 'Language';

  @override
  String get settingsLanguageSystem => 'System default';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageSpanish => 'Español';

  @override
  String get shellTabToday => 'Today';

  @override
  String get shellTabRecipes => 'Recipes';

  @override
  String get shellTabPantry => 'Pantry';

  @override
  String get shellTabPlan => 'Plan';

  @override
  String get shellTabSettings => 'Settings';

  @override
  String get plannerTitle => 'Plan';

  @override
  String get plannerSectionDays => 'Days to cover';

  @override
  String get plannerSectionRecipes => 'Choose recipes';

  @override
  String get plannerSectionResults => 'Results';

  @override
  String plannerBuildError(String error) {
    return 'Could not build the plan: $error';
  }

  @override
  String get plannerChooseRecipesHint =>
      'Choose a protein base and a carb base to see how much to cook.';

  @override
  String get plannerShoppingListButton => 'Shopping list';

  @override
  String get plannerStartCooking => 'Start cooking';

  @override
  String get plannerSetupTargetsHint =>
      'Set up your nutrition targets in Settings to plan a batch.';

  @override
  String plannerShoppingTitle(String range) {
    return 'Shopping list · $range';
  }

  @override
  String plannerDateRange(String from, String to) {
    return '$from - $to';
  }

  @override
  String get plannerFirstDay => 'First day';

  @override
  String get plannerNumberOfDays => 'Number of days';

  @override
  String get plannerDayTypeTraining => 'Training';

  @override
  String get plannerDayTypeRest => 'Rest';

  @override
  String plannerRangeDayWithType(String date, String type) {
    return '$date · $type';
  }

  @override
  String get plannerFreshTitle => 'Fresh additions';

  @override
  String get plannerFreshSubtitle =>
      'Eaten as is next to the batch (fruit, raw vegetables).';

  @override
  String get plannerRemove => 'Remove';

  @override
  String get plannerAddFresh => 'Add fresh ingredient';

  @override
  String get plannerGramsPerMeal => 'Grams per meal';

  @override
  String get plannerCookedGramsPerMeal => 'Cooked grams per meal';

  @override
  String get plannerLeftoversTitle => 'Pantry leftovers';

  @override
  String get plannerLeftoversSubtitle =>
      'Cooked food you still have is deducted from what to cook.';

  @override
  String get plannerNoLeftovers => 'Nothing cooked is left in the pantry.';

  @override
  String plannerLeftoverSubtitle(int grams, String date) {
    return '$grams g left · cooked $date';
  }

  @override
  String plannerNeed(int kcal, int protein, int carbs) {
    return 'Need $kcal kcal · P $protein g · C $carbs g';
  }

  @override
  String plannerCovered(int kcal, int protein, int carbs) {
    return 'Covered $kcal kcal · P $protein g · C $carbs g';
  }

  @override
  String get plannerRoleProteinBase => 'Protein base';

  @override
  String get plannerRoleCarbBase => 'Carb base';

  @override
  String get plannerRoleVegetable => 'Vegetable (optional)';

  @override
  String get plannerRoleSauce => 'Sauce (optional)';

  @override
  String get plannerRoleProteinBaseHint => 'Sized to reach the protein target';

  @override
  String get plannerRoleCarbBaseHint => 'Sized to reach the carb target';

  @override
  String get plannerRoleSideHint => 'Fixed cooked grams per meal';

  @override
  String get plannerChoose => 'Choose';

  @override
  String get plannerChange => 'Change';

  @override
  String get plannerNothingToCook =>
      'Nothing to cook: the rest of the plan already covers it.';

  @override
  String plannerRawCooked(String raw, String cooked, String factor) {
    return 'Raw $raw g · cooked $cooked g (yield $factor)';
  }

  @override
  String plannerIngredientLine(String grams, String name) {
    return '$grams g $name';
  }

  @override
  String plannerPortions(int count, int grams) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count portions of $grams g cooked',
      one: '$count portion of $grams g cooked',
    );
    return '$_temp0';
  }

  @override
  String get plannerPerPortion => 'Per portion';

  @override
  String get plannerBlockTotals => 'Block totals';

  @override
  String plannerTotalProtein(int covered, int target) {
    return 'Protein $covered / $target g';
  }

  @override
  String plannerTotalCarbs(int covered, int target) {
    return 'Carbs $covered / $target g';
  }

  @override
  String plannerTotalCalories(int covered, int target) {
    return 'Calories $covered / $target kcal';
  }

  @override
  String plannerPerMeal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Per meal ($count meals)',
      one: 'Per meal ($count meal)',
    );
    return '$_temp0';
  }

  @override
  String get plannerNutrientProtein => 'Protein';

  @override
  String get plannerNutrientCarbs => 'Carbs';

  @override
  String plannerResidualChip(String label, String grams, String percent) {
    return '$label $grams g ($percent%)';
  }

  @override
  String get plannerUncheckAll => 'Uncheck all';

  @override
  String get plannerShoppingEmpty =>
      'Nothing to buy yet. Choose recipes in the plan first.';

  @override
  String plannerShoppingProgress(int done, int total) {
    return '$done of $total checked';
  }

  @override
  String get plannerCopyAsText => 'Copy as text';

  @override
  String get plannerShoppingCopied => 'Shopping list copied';

  @override
  String plannerAboutServings(int count, String grams) {
    return 'About $count x $grams g';
  }

  @override
  String plannerChecklistLine(String grams, String name) {
    return '- [ ] $grams g $name';
  }

  @override
  String plannerChecklistLineWithUnits(
    String grams,
    String name,
    int count,
    String serving,
  ) {
    return '- [ ] $grams g $name (about $count x $serving g)';
  }

  @override
  String get plannerCategoryProtein => 'Protein';

  @override
  String get plannerCategoryCarb => 'Carb';

  @override
  String get plannerCategoryVegetable => 'Vegetable';

  @override
  String get plannerCategoryFruit => 'Fruit';

  @override
  String get plannerCategoryFat => 'Fat';

  @override
  String get plannerCategoryOther => 'Other';

  @override
  String get pantryTitle => 'Pantry';

  @override
  String get pantryComposeMeal => 'Compose a meal';

  @override
  String get pantryLogBatch => 'Log batch cooked';

  @override
  String pantryLoadError(String error) {
    return 'Could not load pantry: $error';
  }

  @override
  String get pantryEmptyTitle => 'Your pantry is empty';

  @override
  String get pantryEmptyBody =>
      'Log a cooked batch to track what is left and build meals from it.';

  @override
  String get pantryStatusEmpty => 'Empty';

  @override
  String get pantryStatusLow => 'Low';

  @override
  String pantryCooked(String date) {
    return 'Cooked $date';
  }

  @override
  String pantryGramsLeft(int left, int total) {
    return '$left g left of $total g';
  }

  @override
  String get pantryPer100Cooked => 'Per 100 g cooked';

  @override
  String pantryPerTypicalPortion(int grams) {
    return 'Per typical $grams g portion';
  }

  @override
  String get pantryConsumptionHistory => 'Consumption history';

  @override
  String pantryHistoryError(String error) {
    return 'Could not load history: $error';
  }

  @override
  String get pantryNotUsed => 'Not used in any meal yet.';

  @override
  String pantryHistoryEntry(String date, int slot) {
    return '$date · Meal $slot';
  }

  @override
  String pantryDeleteTitle(String name) {
    return 'Delete \"$name\"?';
  }

  @override
  String get pantryDeleteMessage =>
      'This batch item will be removed from your pantry.';

  @override
  String get pantryDeleteBlocked =>
      'This batch item was used in a meal, so it cannot be deleted.';

  @override
  String get pantryBatchItemTitle => 'Batch item';

  @override
  String get pantryDelete => 'Delete';

  @override
  String get pantryItemGone => 'This batch item no longer exists.';

  @override
  String get pantrySearchRecipes => 'Search recipes';

  @override
  String get pantryNoMatchingRecipes => 'No matching recipes';

  @override
  String get pantryCookedOn => 'Cooked on';

  @override
  String get pantryCoversFrom => 'Covers from';

  @override
  String get pantryCoversTo => 'Covers to';

  @override
  String get pantryDatesError =>
      'The end date must not be before the start date.';

  @override
  String get pantryBatchItems => 'Batch items';

  @override
  String get pantryAddAtLeastOne => 'Add at least one batch item';

  @override
  String get pantryAddRecipe => 'Add recipe';

  @override
  String get pantrySaveBatch => 'Save batch';

  @override
  String pantrySaveError(String error) {
    return 'Could not save batch: $error';
  }

  @override
  String get pantryRemove => 'Remove';

  @override
  String get pantryRawTotal => 'Raw total';

  @override
  String get pantryCookedTotal => 'Cooked total';

  @override
  String pantryYieldExpects(String factor, int grams) {
    return 'Recipe expects yield $factor (about $grams g cooked)';
  }

  @override
  String pantryYieldMeasured(String measured, String expected) {
    return 'Yield $measured (recipe expects $expected)';
  }

  @override
  String pantryYieldDeviation(int percent) {
    return 'Measured yield is $percent% away from the recipe. Weigh again if that looks wrong.';
  }

  @override
  String get pantryUpdateYield => 'Update recipe yield to this value';

  @override
  String get backupTitle => 'Backup';

  @override
  String get backupPrivacyNote =>
      'A backup is a plain, unencrypted JSON file with all your data, including your body weight and daily targets, recipes, meals and hydration. Only share it with people and services you trust.';

  @override
  String get backupExport => 'Export backup';

  @override
  String get backupImport => 'Import backup';

  @override
  String get backupImportWarning =>
      'Importing erases everything currently in the app and replaces it with the contents of the backup.';

  @override
  String get backupExportCancelled => 'Export cancelled. No file was saved.';

  @override
  String backupSaved(int rows, String counts) {
    String _temp0 = intl.Intl.pluralLogic(
      rows,
      locale: localeName,
      other: '$rows rows',
      one: '1 row',
    );
    return 'Backup saved ($_temp0). $counts';
  }

  @override
  String get backupSaveFailed => 'The backup could not be saved.';

  @override
  String get backupRestoredTitle => 'Backup restored';

  @override
  String backupRestoredBody(int rows, String counts) {
    String _temp0 = intl.Intl.pluralLogic(
      rows,
      locale: localeName,
      other: '$rows rows loaded.',
      one: '1 row loaded.',
    );
    return '$_temp0 $counts';
  }

  @override
  String get backupImportFailedTitle => 'Import failed';

  @override
  String backupImportFailedBody(String message) {
    return '$message\n\nYour current data was not changed.';
  }

  @override
  String get backupImportFailedGeneric => 'The backup could not be imported.';

  @override
  String get backupOk => 'OK';

  @override
  String get backupCancel => 'Cancel';

  @override
  String get backupConfirmTitle => 'Replace all data?';

  @override
  String backupExportedOn(String stamp) {
    return 'Backup exported on $stamp.';
  }

  @override
  String get backupConfirmIntro =>
      'Everything currently stored in the app will be erased and replaced by:';

  @override
  String get backupEmptyBackup => 'Nothing: this backup is empty.';

  @override
  String get backupCannotUndo => 'This cannot be undone.';

  @override
  String get backupEraseAndImport => 'Erase and import';

  @override
  String get backupNoData => 'no data';

  @override
  String backupCountEntry(String label, int count) {
    return '$label: $count';
  }

  @override
  String get backupDialogSaveTitle => 'Save backup';

  @override
  String get backupDialogPickTitle => 'Choose a backup';

  @override
  String get backupTableUserProfiles => 'Profile';

  @override
  String get backupTableDayTypeTargetRows => 'Day-type targets';

  @override
  String get backupTableWeekScheduleEntries => 'Week schedule days';

  @override
  String get backupTableIngredients => 'Ingredients';

  @override
  String get backupTableTools => 'Tools';

  @override
  String get backupTableRecipes => 'Recipes';

  @override
  String get backupTableRecipeIngredients => 'Recipe ingredient lines';

  @override
  String get backupTableRecipeSteps => 'Recipe steps';

  @override
  String get backupTableRecipeTools => 'Recipe tools';

  @override
  String get backupTableBatchSessions => 'Batch sessions';

  @override
  String get backupTableBatchItems => 'Batch items';

  @override
  String get backupTableMealLogs => 'Meals';

  @override
  String get backupTableMealComponents => 'Meal components';

  @override
  String get backupTableHydrationLogs => 'Hydration entries';

  @override
  String get backupTableDayLogs => 'Fruit and vegetable days';

  @override
  String get backupTableAppSettings => 'App settings';

  @override
  String get backupErrorNotValidJson => 'This file is not valid JSON.';

  @override
  String get backupErrorNotABackup =>
      'This file is not an Anti-recipes backup.';

  @override
  String backupErrorInvalidFormatVersion(int version) {
    return 'Invalid backup format version $version.';
  }

  @override
  String backupErrorNewerFormatVersion(int version, int supported) {
    return 'This backup uses file format $version, which is newer than this app understands (format $supported). Update the app and try again.';
  }

  @override
  String backupErrorInvalidSchemaVersion(int version) {
    return 'Invalid database version $version.';
  }

  @override
  String backupErrorNewerSchemaVersion(int version, int supported) {
    return 'This backup was made by a newer version of the app (database version $version; this app supports up to $supported). Update the app and try again.';
  }

  @override
  String get backupErrorNoExportDate => 'The backup has no valid export date.';

  @override
  String get backupErrorNoDataSection => 'The backup has no data section.';

  @override
  String backupErrorUnknownTable(String table) {
    return 'The backup contains an unknown table \"$table\".';
  }

  @override
  String backupErrorMissingTable(String table) {
    return 'The backup is missing the \"$table\" table.';
  }

  @override
  String backupErrorTableNotList(String table) {
    return '\"$table\" must be a list of rows.';
  }

  @override
  String backupErrorRowNotObject(String label, int row) {
    return '$label row $row is not an object.';
  }

  @override
  String backupErrorUnknownColumn(String label, int row, String column) {
    return '$label row $row has an unknown column \"$column\".';
  }

  @override
  String backupErrorMissingColumn(String label, int row, String column) {
    return '$label row $row is missing \"$column\".';
  }

  @override
  String backupErrorMustBeDate(String label, int row, String column) {
    return '$label row $row, \"$column\" must be an ISO 8601 date.';
  }

  @override
  String backupErrorMustBeBool(String label, int row, String column) {
    return '$label row $row, \"$column\" must be true or false.';
  }

  @override
  String backupErrorMustBeText(String label, int row, String column) {
    return '$label row $row, \"$column\" must be text.';
  }

  @override
  String backupErrorMustBeWholeNumber(String label, int row, String column) {
    return '$label row $row, \"$column\" must be a whole number.';
  }

  @override
  String backupErrorMustBeNumber(String label, int row, String column) {
    return '$label row $row, \"$column\" must be a number.';
  }

  @override
  String backupErrorUnknownValue(
    String label,
    int row,
    String column,
    String value,
  ) {
    return '$label row $row, \"$column\" has an unknown value \"$value\".';
  }

  @override
  String backupErrorMissingEnvelopeField(String field) {
    return 'The backup has no valid \"$field\".';
  }

  @override
  String get backupErrorRestoreForeignKey =>
      'The backup could not be restored because a row refers to data that is not in the backup.';

  @override
  String get backupErrorRestoreDuplicate =>
      'The backup could not be restored because it contains duplicate entries.';

  @override
  String get backupErrorRestoreOutOfRange =>
      'The backup could not be restored because a value is outside its allowed range.';

  @override
  String get backupErrorRestoreMissingValue =>
      'The backup could not be restored because a required value is missing.';

  @override
  String get backupErrorRestoreUnexpected =>
      'The backup could not be restored because of an unexpected error.';

  @override
  String get backupErrorNotTextFile => 'This file is not a text file.';

  @override
  String get backupErrorUnreadable => 'The file could not be read.';
}
