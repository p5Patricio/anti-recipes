import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'anti-recipes'**
  String get appTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsNutritionTargetsTitle.
  ///
  /// In en, this message translates to:
  /// **'Nutrition targets'**
  String get settingsNutritionTargetsTitle;

  /// No description provided for @settingsNutritionTargetsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Protein, fat, day types and weekly plan'**
  String get settingsNutritionTargetsSubtitle;

  /// No description provided for @settingsBackupTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get settingsBackupTitle;

  /// No description provided for @settingsBackupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Export or restore all your data as JSON'**
  String get settingsBackupSubtitle;

  /// No description provided for @settingsLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguageTitle;

  /// No description provided for @settingsLanguageSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get settingsLanguageSystem;

  /// No description provided for @settingsLanguageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsLanguageEnglish;

  /// No description provided for @settingsLanguageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get settingsLanguageSpanish;

  /// No description provided for @shellTabToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get shellTabToday;

  /// No description provided for @shellTabRecipes.
  ///
  /// In en, this message translates to:
  /// **'Recipes'**
  String get shellTabRecipes;

  /// No description provided for @shellTabPantry.
  ///
  /// In en, this message translates to:
  /// **'Pantry'**
  String get shellTabPantry;

  /// No description provided for @shellTabPlan.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get shellTabPlan;

  /// No description provided for @shellTabSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get shellTabSettings;

  /// No description provided for @plannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get plannerTitle;

  /// No description provided for @plannerSectionDays.
  ///
  /// In en, this message translates to:
  /// **'Days to cover'**
  String get plannerSectionDays;

  /// No description provided for @plannerSectionRecipes.
  ///
  /// In en, this message translates to:
  /// **'Choose recipes'**
  String get plannerSectionRecipes;

  /// No description provided for @plannerSectionResults.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get plannerSectionResults;

  /// No description provided for @plannerBuildError.
  ///
  /// In en, this message translates to:
  /// **'Could not build the plan: {error}'**
  String plannerBuildError(String error);

  /// No description provided for @plannerChooseRecipesHint.
  ///
  /// In en, this message translates to:
  /// **'Choose a protein base and a carb base to see how much to cook.'**
  String get plannerChooseRecipesHint;

  /// No description provided for @plannerShoppingListButton.
  ///
  /// In en, this message translates to:
  /// **'Shopping list'**
  String get plannerShoppingListButton;

  /// No description provided for @plannerStartCooking.
  ///
  /// In en, this message translates to:
  /// **'Start cooking'**
  String get plannerStartCooking;

  /// No description provided for @plannerSetupTargetsHint.
  ///
  /// In en, this message translates to:
  /// **'Set up your nutrition targets in Settings to plan a batch.'**
  String get plannerSetupTargetsHint;

  /// No description provided for @plannerShoppingTitle.
  ///
  /// In en, this message translates to:
  /// **'Shopping list · {range}'**
  String plannerShoppingTitle(String range);

  /// No description provided for @plannerDateRange.
  ///
  /// In en, this message translates to:
  /// **'{from} - {to}'**
  String plannerDateRange(String from, String to);

  /// No description provided for @plannerFirstDay.
  ///
  /// In en, this message translates to:
  /// **'First day'**
  String get plannerFirstDay;

  /// No description provided for @plannerNumberOfDays.
  ///
  /// In en, this message translates to:
  /// **'Number of days'**
  String get plannerNumberOfDays;

  /// No description provided for @plannerDayTypeTraining.
  ///
  /// In en, this message translates to:
  /// **'Training'**
  String get plannerDayTypeTraining;

  /// No description provided for @plannerDayTypeRest.
  ///
  /// In en, this message translates to:
  /// **'Rest'**
  String get plannerDayTypeRest;

  /// No description provided for @plannerRangeDayWithType.
  ///
  /// In en, this message translates to:
  /// **'{date} · {type}'**
  String plannerRangeDayWithType(String date, String type);

  /// No description provided for @plannerFreshTitle.
  ///
  /// In en, this message translates to:
  /// **'Fresh additions'**
  String get plannerFreshTitle;

  /// No description provided for @plannerFreshSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Eaten as is next to the batch (fruit, raw vegetables).'**
  String get plannerFreshSubtitle;

  /// No description provided for @plannerRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get plannerRemove;

  /// No description provided for @plannerAddFresh.
  ///
  /// In en, this message translates to:
  /// **'Add fresh ingredient'**
  String get plannerAddFresh;

  /// No description provided for @plannerGramsPerMeal.
  ///
  /// In en, this message translates to:
  /// **'Grams per meal'**
  String get plannerGramsPerMeal;

  /// No description provided for @plannerCookedGramsPerMeal.
  ///
  /// In en, this message translates to:
  /// **'Cooked grams per meal'**
  String get plannerCookedGramsPerMeal;

  /// No description provided for @plannerLeftoversTitle.
  ///
  /// In en, this message translates to:
  /// **'Pantry leftovers'**
  String get plannerLeftoversTitle;

  /// No description provided for @plannerLeftoversSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Cooked food you still have is deducted from what to cook.'**
  String get plannerLeftoversSubtitle;

  /// No description provided for @plannerNoLeftovers.
  ///
  /// In en, this message translates to:
  /// **'Nothing cooked is left in the pantry.'**
  String get plannerNoLeftovers;

  /// No description provided for @plannerLeftoverSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{grams} g left · cooked {date}'**
  String plannerLeftoverSubtitle(int grams, String date);

  /// No description provided for @plannerNeed.
  ///
  /// In en, this message translates to:
  /// **'Need {kcal} kcal · P {protein} g · C {carbs} g'**
  String plannerNeed(int kcal, int protein, int carbs);

  /// No description provided for @plannerCovered.
  ///
  /// In en, this message translates to:
  /// **'Covered {kcal} kcal · P {protein} g · C {carbs} g'**
  String plannerCovered(int kcal, int protein, int carbs);

  /// No description provided for @plannerRoleProteinBase.
  ///
  /// In en, this message translates to:
  /// **'Protein base'**
  String get plannerRoleProteinBase;

  /// No description provided for @plannerRoleCarbBase.
  ///
  /// In en, this message translates to:
  /// **'Carb base'**
  String get plannerRoleCarbBase;

  /// No description provided for @plannerRoleVegetable.
  ///
  /// In en, this message translates to:
  /// **'Vegetable (optional)'**
  String get plannerRoleVegetable;

  /// No description provided for @plannerRoleSauce.
  ///
  /// In en, this message translates to:
  /// **'Sauce (optional)'**
  String get plannerRoleSauce;

  /// No description provided for @plannerRoleProteinBaseHint.
  ///
  /// In en, this message translates to:
  /// **'Sized to reach the protein target'**
  String get plannerRoleProteinBaseHint;

  /// No description provided for @plannerRoleCarbBaseHint.
  ///
  /// In en, this message translates to:
  /// **'Sized to reach the carb target'**
  String get plannerRoleCarbBaseHint;

  /// No description provided for @plannerRoleSideHint.
  ///
  /// In en, this message translates to:
  /// **'Fixed cooked grams per meal'**
  String get plannerRoleSideHint;

  /// No description provided for @plannerChoose.
  ///
  /// In en, this message translates to:
  /// **'Choose'**
  String get plannerChoose;

  /// No description provided for @plannerChange.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get plannerChange;

  /// No description provided for @plannerNothingToCook.
  ///
  /// In en, this message translates to:
  /// **'Nothing to cook: the rest of the plan already covers it.'**
  String get plannerNothingToCook;

  /// No description provided for @plannerRawCooked.
  ///
  /// In en, this message translates to:
  /// **'Raw {raw} g · cooked {cooked} g (yield {factor})'**
  String plannerRawCooked(String raw, String cooked, String factor);

  /// No description provided for @plannerIngredientLine.
  ///
  /// In en, this message translates to:
  /// **'{grams} g {name}'**
  String plannerIngredientLine(String grams, String name);

  /// No description provided for @plannerPortions.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{{count} portion of {grams} g cooked} other{{count} portions of {grams} g cooked}}'**
  String plannerPortions(int count, int grams);

  /// No description provided for @plannerPerPortion.
  ///
  /// In en, this message translates to:
  /// **'Per portion'**
  String get plannerPerPortion;

  /// No description provided for @plannerBlockTotals.
  ///
  /// In en, this message translates to:
  /// **'Block totals'**
  String get plannerBlockTotals;

  /// No description provided for @plannerTotalProtein.
  ///
  /// In en, this message translates to:
  /// **'Protein {covered} / {target} g'**
  String plannerTotalProtein(int covered, int target);

  /// No description provided for @plannerTotalCarbs.
  ///
  /// In en, this message translates to:
  /// **'Carbs {covered} / {target} g'**
  String plannerTotalCarbs(int covered, int target);

  /// No description provided for @plannerTotalCalories.
  ///
  /// In en, this message translates to:
  /// **'Calories {covered} / {target} kcal'**
  String plannerTotalCalories(int covered, int target);

  /// No description provided for @plannerPerMeal.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Per meal ({count} meal)} other{Per meal ({count} meals)}}'**
  String plannerPerMeal(int count);

  /// No description provided for @plannerNutrientProtein.
  ///
  /// In en, this message translates to:
  /// **'Protein'**
  String get plannerNutrientProtein;

  /// No description provided for @plannerNutrientCarbs.
  ///
  /// In en, this message translates to:
  /// **'Carbs'**
  String get plannerNutrientCarbs;

  /// No description provided for @plannerResidualChip.
  ///
  /// In en, this message translates to:
  /// **'{label} {grams} g ({percent}%)'**
  String plannerResidualChip(String label, String grams, String percent);

  /// No description provided for @plannerUncheckAll.
  ///
  /// In en, this message translates to:
  /// **'Uncheck all'**
  String get plannerUncheckAll;

  /// No description provided for @plannerShoppingEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nothing to buy yet. Choose recipes in the plan first.'**
  String get plannerShoppingEmpty;

  /// No description provided for @plannerShoppingProgress.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} checked'**
  String plannerShoppingProgress(int done, int total);

  /// No description provided for @plannerCopyAsText.
  ///
  /// In en, this message translates to:
  /// **'Copy as text'**
  String get plannerCopyAsText;

  /// No description provided for @plannerShoppingCopied.
  ///
  /// In en, this message translates to:
  /// **'Shopping list copied'**
  String get plannerShoppingCopied;

  /// No description provided for @plannerAboutServings.
  ///
  /// In en, this message translates to:
  /// **'About {count} x {grams} g'**
  String plannerAboutServings(int count, String grams);

  /// No description provided for @plannerChecklistLine.
  ///
  /// In en, this message translates to:
  /// **'- [ ] {grams} g {name}'**
  String plannerChecklistLine(String grams, String name);

  /// No description provided for @plannerChecklistLineWithUnits.
  ///
  /// In en, this message translates to:
  /// **'- [ ] {grams} g {name} (about {count} x {serving} g)'**
  String plannerChecklistLineWithUnits(
    String grams,
    String name,
    int count,
    String serving,
  );

  /// No description provided for @plannerCategoryProtein.
  ///
  /// In en, this message translates to:
  /// **'Protein'**
  String get plannerCategoryProtein;

  /// No description provided for @plannerCategoryCarb.
  ///
  /// In en, this message translates to:
  /// **'Carb'**
  String get plannerCategoryCarb;

  /// No description provided for @plannerCategoryVegetable.
  ///
  /// In en, this message translates to:
  /// **'Vegetable'**
  String get plannerCategoryVegetable;

  /// No description provided for @plannerCategoryFruit.
  ///
  /// In en, this message translates to:
  /// **'Fruit'**
  String get plannerCategoryFruit;

  /// No description provided for @plannerCategoryFat.
  ///
  /// In en, this message translates to:
  /// **'Fat'**
  String get plannerCategoryFat;

  /// No description provided for @plannerCategoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get plannerCategoryOther;

  /// No description provided for @pantryTitle.
  ///
  /// In en, this message translates to:
  /// **'Pantry'**
  String get pantryTitle;

  /// No description provided for @pantryComposeMeal.
  ///
  /// In en, this message translates to:
  /// **'Compose a meal'**
  String get pantryComposeMeal;

  /// No description provided for @pantryLogBatch.
  ///
  /// In en, this message translates to:
  /// **'Log batch cooked'**
  String get pantryLogBatch;

  /// No description provided for @pantryLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load pantry: {error}'**
  String pantryLoadError(String error);

  /// No description provided for @pantryEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your pantry is empty'**
  String get pantryEmptyTitle;

  /// No description provided for @pantryEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Log a cooked batch to track what is left and build meals from it.'**
  String get pantryEmptyBody;

  /// No description provided for @pantryStatusEmpty.
  ///
  /// In en, this message translates to:
  /// **'Empty'**
  String get pantryStatusEmpty;

  /// No description provided for @pantryStatusLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get pantryStatusLow;

  /// No description provided for @pantryCooked.
  ///
  /// In en, this message translates to:
  /// **'Cooked {date}'**
  String pantryCooked(String date);

  /// No description provided for @pantryGramsLeft.
  ///
  /// In en, this message translates to:
  /// **'{left} g left of {total} g'**
  String pantryGramsLeft(int left, int total);

  /// No description provided for @pantryPer100Cooked.
  ///
  /// In en, this message translates to:
  /// **'Per 100 g cooked'**
  String get pantryPer100Cooked;

  /// No description provided for @pantryPerTypicalPortion.
  ///
  /// In en, this message translates to:
  /// **'Per typical {grams} g portion'**
  String pantryPerTypicalPortion(int grams);

  /// No description provided for @pantryConsumptionHistory.
  ///
  /// In en, this message translates to:
  /// **'Consumption history'**
  String get pantryConsumptionHistory;

  /// No description provided for @pantryHistoryError.
  ///
  /// In en, this message translates to:
  /// **'Could not load history: {error}'**
  String pantryHistoryError(String error);

  /// No description provided for @pantryNotUsed.
  ///
  /// In en, this message translates to:
  /// **'Not used in any meal yet.'**
  String get pantryNotUsed;

  /// No description provided for @pantryHistoryEntry.
  ///
  /// In en, this message translates to:
  /// **'{date} · Meal {slot}'**
  String pantryHistoryEntry(String date, int slot);

  /// No description provided for @pantryDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{name}\"?'**
  String pantryDeleteTitle(String name);

  /// No description provided for @pantryDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'This batch item will be removed from your pantry.'**
  String get pantryDeleteMessage;

  /// No description provided for @pantryDeleteBlocked.
  ///
  /// In en, this message translates to:
  /// **'This batch item was used in a meal, so it cannot be deleted.'**
  String get pantryDeleteBlocked;

  /// No description provided for @pantryBatchItemTitle.
  ///
  /// In en, this message translates to:
  /// **'Batch item'**
  String get pantryBatchItemTitle;

  /// No description provided for @pantryDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get pantryDelete;

  /// No description provided for @pantryItemGone.
  ///
  /// In en, this message translates to:
  /// **'This batch item no longer exists.'**
  String get pantryItemGone;

  /// No description provided for @pantrySearchRecipes.
  ///
  /// In en, this message translates to:
  /// **'Search recipes'**
  String get pantrySearchRecipes;

  /// No description provided for @pantryNoMatchingRecipes.
  ///
  /// In en, this message translates to:
  /// **'No matching recipes'**
  String get pantryNoMatchingRecipes;

  /// No description provided for @pantryCookedOn.
  ///
  /// In en, this message translates to:
  /// **'Cooked on'**
  String get pantryCookedOn;

  /// No description provided for @pantryCoversFrom.
  ///
  /// In en, this message translates to:
  /// **'Covers from'**
  String get pantryCoversFrom;

  /// No description provided for @pantryCoversTo.
  ///
  /// In en, this message translates to:
  /// **'Covers to'**
  String get pantryCoversTo;

  /// No description provided for @pantryDatesError.
  ///
  /// In en, this message translates to:
  /// **'The end date must not be before the start date.'**
  String get pantryDatesError;

  /// No description provided for @pantryBatchItems.
  ///
  /// In en, this message translates to:
  /// **'Batch items'**
  String get pantryBatchItems;

  /// No description provided for @pantryAddAtLeastOne.
  ///
  /// In en, this message translates to:
  /// **'Add at least one batch item'**
  String get pantryAddAtLeastOne;

  /// No description provided for @pantryAddRecipe.
  ///
  /// In en, this message translates to:
  /// **'Add recipe'**
  String get pantryAddRecipe;

  /// No description provided for @pantrySaveBatch.
  ///
  /// In en, this message translates to:
  /// **'Save batch'**
  String get pantrySaveBatch;

  /// No description provided for @pantrySaveError.
  ///
  /// In en, this message translates to:
  /// **'Could not save batch: {error}'**
  String pantrySaveError(String error);

  /// No description provided for @pantryRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get pantryRemove;

  /// No description provided for @pantryRawTotal.
  ///
  /// In en, this message translates to:
  /// **'Raw total'**
  String get pantryRawTotal;

  /// No description provided for @pantryCookedTotal.
  ///
  /// In en, this message translates to:
  /// **'Cooked total'**
  String get pantryCookedTotal;

  /// No description provided for @pantryYieldExpects.
  ///
  /// In en, this message translates to:
  /// **'Recipe expects yield {factor} (about {grams} g cooked)'**
  String pantryYieldExpects(String factor, int grams);

  /// No description provided for @pantryYieldMeasured.
  ///
  /// In en, this message translates to:
  /// **'Yield {measured} (recipe expects {expected})'**
  String pantryYieldMeasured(String measured, String expected);

  /// No description provided for @pantryYieldDeviation.
  ///
  /// In en, this message translates to:
  /// **'Measured yield is {percent}% away from the recipe. Weigh again if that looks wrong.'**
  String pantryYieldDeviation(int percent);

  /// No description provided for @pantryUpdateYield.
  ///
  /// In en, this message translates to:
  /// **'Update recipe yield to this value'**
  String get pantryUpdateYield;

  /// No description provided for @backupTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get backupTitle;

  /// No description provided for @backupPrivacyNote.
  ///
  /// In en, this message translates to:
  /// **'A backup is a plain, unencrypted JSON file with all your data, including your body weight and daily targets, recipes, meals and hydration. Only share it with people and services you trust.'**
  String get backupPrivacyNote;

  /// No description provided for @backupExport.
  ///
  /// In en, this message translates to:
  /// **'Export backup'**
  String get backupExport;

  /// No description provided for @backupImport.
  ///
  /// In en, this message translates to:
  /// **'Import backup'**
  String get backupImport;

  /// No description provided for @backupImportWarning.
  ///
  /// In en, this message translates to:
  /// **'Importing erases everything currently in the app and replaces it with the contents of the backup.'**
  String get backupImportWarning;

  /// No description provided for @backupExportCancelled.
  ///
  /// In en, this message translates to:
  /// **'Export cancelled. No file was saved.'**
  String get backupExportCancelled;

  /// No description provided for @backupSaved.
  ///
  /// In en, this message translates to:
  /// **'Backup saved ({rows, plural, =1{1 row} other{{rows} rows}}). {counts}'**
  String backupSaved(int rows, String counts);

  /// No description provided for @backupSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'The backup could not be saved.'**
  String get backupSaveFailed;

  /// No description provided for @backupRestoredTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup restored'**
  String get backupRestoredTitle;

  /// No description provided for @backupRestoredBody.
  ///
  /// In en, this message translates to:
  /// **'{rows, plural, =1{1 row loaded.} other{{rows} rows loaded.}} {counts}'**
  String backupRestoredBody(int rows, String counts);

  /// No description provided for @backupImportFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Import failed'**
  String get backupImportFailedTitle;

  /// No description provided for @backupImportFailedBody.
  ///
  /// In en, this message translates to:
  /// **'{message}\n\nYour current data was not changed.'**
  String backupImportFailedBody(String message);

  /// No description provided for @backupImportFailedGeneric.
  ///
  /// In en, this message translates to:
  /// **'The backup could not be imported.'**
  String get backupImportFailedGeneric;

  /// No description provided for @backupOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get backupOk;

  /// No description provided for @backupCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get backupCancel;

  /// No description provided for @backupConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Replace all data?'**
  String get backupConfirmTitle;

  /// No description provided for @backupExportedOn.
  ///
  /// In en, this message translates to:
  /// **'Backup exported on {stamp}.'**
  String backupExportedOn(String stamp);

  /// No description provided for @backupConfirmIntro.
  ///
  /// In en, this message translates to:
  /// **'Everything currently stored in the app will be erased and replaced by:'**
  String get backupConfirmIntro;

  /// No description provided for @backupEmptyBackup.
  ///
  /// In en, this message translates to:
  /// **'Nothing: this backup is empty.'**
  String get backupEmptyBackup;

  /// No description provided for @backupCannotUndo.
  ///
  /// In en, this message translates to:
  /// **'This cannot be undone.'**
  String get backupCannotUndo;

  /// No description provided for @backupEraseAndImport.
  ///
  /// In en, this message translates to:
  /// **'Erase and import'**
  String get backupEraseAndImport;

  /// No description provided for @backupNoData.
  ///
  /// In en, this message translates to:
  /// **'no data'**
  String get backupNoData;

  /// No description provided for @backupCountEntry.
  ///
  /// In en, this message translates to:
  /// **'{label}: {count}'**
  String backupCountEntry(String label, int count);

  /// No description provided for @backupDialogSaveTitle.
  ///
  /// In en, this message translates to:
  /// **'Save backup'**
  String get backupDialogSaveTitle;

  /// No description provided for @backupDialogPickTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a backup'**
  String get backupDialogPickTitle;

  /// No description provided for @backupTableUserProfiles.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get backupTableUserProfiles;

  /// No description provided for @backupTableDayTypeTargetRows.
  ///
  /// In en, this message translates to:
  /// **'Day-type targets'**
  String get backupTableDayTypeTargetRows;

  /// No description provided for @backupTableWeekScheduleEntries.
  ///
  /// In en, this message translates to:
  /// **'Week schedule days'**
  String get backupTableWeekScheduleEntries;

  /// No description provided for @backupTableIngredients.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get backupTableIngredients;

  /// No description provided for @backupTableTools.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get backupTableTools;

  /// No description provided for @backupTableRecipes.
  ///
  /// In en, this message translates to:
  /// **'Recipes'**
  String get backupTableRecipes;

  /// No description provided for @backupTableRecipeIngredients.
  ///
  /// In en, this message translates to:
  /// **'Recipe ingredient lines'**
  String get backupTableRecipeIngredients;

  /// No description provided for @backupTableRecipeSteps.
  ///
  /// In en, this message translates to:
  /// **'Recipe steps'**
  String get backupTableRecipeSteps;

  /// No description provided for @backupTableRecipeTools.
  ///
  /// In en, this message translates to:
  /// **'Recipe tools'**
  String get backupTableRecipeTools;

  /// No description provided for @backupTableBatchSessions.
  ///
  /// In en, this message translates to:
  /// **'Batch sessions'**
  String get backupTableBatchSessions;

  /// No description provided for @backupTableBatchItems.
  ///
  /// In en, this message translates to:
  /// **'Batch items'**
  String get backupTableBatchItems;

  /// No description provided for @backupTableMealLogs.
  ///
  /// In en, this message translates to:
  /// **'Meals'**
  String get backupTableMealLogs;

  /// No description provided for @backupTableMealComponents.
  ///
  /// In en, this message translates to:
  /// **'Meal components'**
  String get backupTableMealComponents;

  /// No description provided for @backupTableHydrationLogs.
  ///
  /// In en, this message translates to:
  /// **'Hydration entries'**
  String get backupTableHydrationLogs;

  /// No description provided for @backupTableDayLogs.
  ///
  /// In en, this message translates to:
  /// **'Fruit and vegetable days'**
  String get backupTableDayLogs;

  /// No description provided for @backupTableAppSettings.
  ///
  /// In en, this message translates to:
  /// **'App settings'**
  String get backupTableAppSettings;

  /// No description provided for @backupErrorNotValidJson.
  ///
  /// In en, this message translates to:
  /// **'This file is not valid JSON.'**
  String get backupErrorNotValidJson;

  /// No description provided for @backupErrorNotABackup.
  ///
  /// In en, this message translates to:
  /// **'This file is not an Anti-recipes backup.'**
  String get backupErrorNotABackup;

  /// No description provided for @backupErrorInvalidFormatVersion.
  ///
  /// In en, this message translates to:
  /// **'Invalid backup format version {version}.'**
  String backupErrorInvalidFormatVersion(int version);

  /// No description provided for @backupErrorNewerFormatVersion.
  ///
  /// In en, this message translates to:
  /// **'This backup uses file format {version}, which is newer than this app understands (format {supported}). Update the app and try again.'**
  String backupErrorNewerFormatVersion(int version, int supported);

  /// No description provided for @backupErrorInvalidSchemaVersion.
  ///
  /// In en, this message translates to:
  /// **'Invalid database version {version}.'**
  String backupErrorInvalidSchemaVersion(int version);

  /// No description provided for @backupErrorNewerSchemaVersion.
  ///
  /// In en, this message translates to:
  /// **'This backup was made by a newer version of the app (database version {version}; this app supports up to {supported}). Update the app and try again.'**
  String backupErrorNewerSchemaVersion(int version, int supported);

  /// No description provided for @backupErrorNoExportDate.
  ///
  /// In en, this message translates to:
  /// **'The backup has no valid export date.'**
  String get backupErrorNoExportDate;

  /// No description provided for @backupErrorNoDataSection.
  ///
  /// In en, this message translates to:
  /// **'The backup has no data section.'**
  String get backupErrorNoDataSection;

  /// No description provided for @backupErrorUnknownTable.
  ///
  /// In en, this message translates to:
  /// **'The backup contains an unknown table \"{table}\".'**
  String backupErrorUnknownTable(String table);

  /// No description provided for @backupErrorMissingTable.
  ///
  /// In en, this message translates to:
  /// **'The backup is missing the \"{table}\" table.'**
  String backupErrorMissingTable(String table);

  /// No description provided for @backupErrorTableNotList.
  ///
  /// In en, this message translates to:
  /// **'\"{table}\" must be a list of rows.'**
  String backupErrorTableNotList(String table);

  /// No description provided for @backupErrorRowNotObject.
  ///
  /// In en, this message translates to:
  /// **'{label} row {row} is not an object.'**
  String backupErrorRowNotObject(String label, int row);

  /// No description provided for @backupErrorUnknownColumn.
  ///
  /// In en, this message translates to:
  /// **'{label} row {row} has an unknown column \"{column}\".'**
  String backupErrorUnknownColumn(String label, int row, String column);

  /// No description provided for @backupErrorMissingColumn.
  ///
  /// In en, this message translates to:
  /// **'{label} row {row} is missing \"{column}\".'**
  String backupErrorMissingColumn(String label, int row, String column);

  /// No description provided for @backupErrorMustBeDate.
  ///
  /// In en, this message translates to:
  /// **'{label} row {row}, \"{column}\" must be an ISO 8601 date.'**
  String backupErrorMustBeDate(String label, int row, String column);

  /// No description provided for @backupErrorMustBeBool.
  ///
  /// In en, this message translates to:
  /// **'{label} row {row}, \"{column}\" must be true or false.'**
  String backupErrorMustBeBool(String label, int row, String column);

  /// No description provided for @backupErrorMustBeText.
  ///
  /// In en, this message translates to:
  /// **'{label} row {row}, \"{column}\" must be text.'**
  String backupErrorMustBeText(String label, int row, String column);

  /// No description provided for @backupErrorMustBeWholeNumber.
  ///
  /// In en, this message translates to:
  /// **'{label} row {row}, \"{column}\" must be a whole number.'**
  String backupErrorMustBeWholeNumber(String label, int row, String column);

  /// No description provided for @backupErrorMustBeNumber.
  ///
  /// In en, this message translates to:
  /// **'{label} row {row}, \"{column}\" must be a number.'**
  String backupErrorMustBeNumber(String label, int row, String column);

  /// No description provided for @backupErrorUnknownValue.
  ///
  /// In en, this message translates to:
  /// **'{label} row {row}, \"{column}\" has an unknown value \"{value}\".'**
  String backupErrorUnknownValue(
    String label,
    int row,
    String column,
    String value,
  );

  /// No description provided for @backupErrorMissingEnvelopeField.
  ///
  /// In en, this message translates to:
  /// **'The backup has no valid \"{field}\".'**
  String backupErrorMissingEnvelopeField(String field);

  /// No description provided for @backupErrorRestoreForeignKey.
  ///
  /// In en, this message translates to:
  /// **'The backup could not be restored because a row refers to data that is not in the backup.'**
  String get backupErrorRestoreForeignKey;

  /// No description provided for @backupErrorRestoreDuplicate.
  ///
  /// In en, this message translates to:
  /// **'The backup could not be restored because it contains duplicate entries.'**
  String get backupErrorRestoreDuplicate;

  /// No description provided for @backupErrorRestoreOutOfRange.
  ///
  /// In en, this message translates to:
  /// **'The backup could not be restored because a value is outside its allowed range.'**
  String get backupErrorRestoreOutOfRange;

  /// No description provided for @backupErrorRestoreMissingValue.
  ///
  /// In en, this message translates to:
  /// **'The backup could not be restored because a required value is missing.'**
  String get backupErrorRestoreMissingValue;

  /// No description provided for @backupErrorRestoreUnexpected.
  ///
  /// In en, this message translates to:
  /// **'The backup could not be restored because of an unexpected error.'**
  String get backupErrorRestoreUnexpected;

  /// No description provided for @backupErrorNotTextFile.
  ///
  /// In en, this message translates to:
  /// **'This file is not a text file.'**
  String get backupErrorNotTextFile;

  /// No description provided for @backupErrorUnreadable.
  ///
  /// In en, this message translates to:
  /// **'The file could not be read.'**
  String get backupErrorUnreadable;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
