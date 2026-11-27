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

  /// No description provided for @coreWidgetsComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get coreWidgetsComingSoon;

  /// No description provided for @coreWidgetsEnterNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a number'**
  String get coreWidgetsEnterNumber;

  /// No description provided for @coreWidgetsMustBeAboveZero.
  ///
  /// In en, this message translates to:
  /// **'Must be above 0'**
  String get coreWidgetsMustBeAboveZero;

  /// No description provided for @coreWidgetsMustBeZeroOrMore.
  ///
  /// In en, this message translates to:
  /// **'Must be 0 or more'**
  String get coreWidgetsMustBeZeroOrMore;

  /// No description provided for @recipesTitle.
  ///
  /// In en, this message translates to:
  /// **'Recipes'**
  String get recipesTitle;

  /// No description provided for @recipesIngredientsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get recipesIngredientsTooltip;

  /// No description provided for @recipesNewRecipeTooltip.
  ///
  /// In en, this message translates to:
  /// **'New recipe'**
  String get recipesNewRecipeTooltip;

  /// No description provided for @recipesFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get recipesFilterAll;

  /// No description provided for @recipesLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load recipes: {error}'**
  String recipesLoadError(String error);

  /// No description provided for @recipesEmptyFilteredTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing in this group yet'**
  String get recipesEmptyFilteredTitle;

  /// No description provided for @recipesEmptyFilteredBody.
  ///
  /// In en, this message translates to:
  /// **'Pick another group or add a recipe of this kind.'**
  String get recipesEmptyFilteredBody;

  /// No description provided for @recipesEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No recipes yet'**
  String get recipesEmptyTitle;

  /// No description provided for @recipesEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Tap + to create your first recipe and start batch cooking.'**
  String get recipesEmptyBody;

  /// No description provided for @recipesKindProteinBase.
  ///
  /// In en, this message translates to:
  /// **'Protein base'**
  String get recipesKindProteinBase;

  /// No description provided for @recipesKindCarbBase.
  ///
  /// In en, this message translates to:
  /// **'Carb base'**
  String get recipesKindCarbBase;

  /// No description provided for @recipesKindSauce.
  ///
  /// In en, this message translates to:
  /// **'Sauce'**
  String get recipesKindSauce;

  /// No description provided for @recipesKindVegetable.
  ///
  /// In en, this message translates to:
  /// **'Vegetable'**
  String get recipesKindVegetable;

  /// No description provided for @recipesKindComplete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get recipesKindComplete;

  /// No description provided for @recipesCardKindYield.
  ///
  /// In en, this message translates to:
  /// **'{kind} · yield {yieldFactor}'**
  String recipesCardKindYield(String kind, String yieldFactor);

  /// No description provided for @recipesPer100Cooked.
  ///
  /// In en, this message translates to:
  /// **'Per 100 g cooked'**
  String get recipesPer100Cooked;

  /// No description provided for @recipesMacroLine.
  ///
  /// In en, this message translates to:
  /// **'{kcal} kcal · P {protein} · F {fat} · C {carbs} · Fiber {fiber}'**
  String recipesMacroLine(int kcal, int protein, int fat, int carbs, int fiber);

  /// No description provided for @recipesSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get recipesSummaryTitle;

  /// No description provided for @recipesSummaryRawWeight.
  ///
  /// In en, this message translates to:
  /// **'Raw weight: {grams} g'**
  String recipesSummaryRawWeight(int grams);

  /// No description provided for @recipesSummaryCookedWeight.
  ///
  /// In en, this message translates to:
  /// **'Expected cooked weight: {grams} g'**
  String recipesSummaryCookedWeight(int grams);

  /// No description provided for @recipesSummaryTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get recipesSummaryTotal;

  /// No description provided for @recipesIngredientsTitle.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get recipesIngredientsTitle;

  /// No description provided for @recipesNewIngredientTooltip.
  ///
  /// In en, this message translates to:
  /// **'New ingredient'**
  String get recipesNewIngredientTooltip;

  /// No description provided for @recipesIngredientsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load ingredients: {error}'**
  String recipesIngredientsLoadError(String error);

  /// No description provided for @recipesIngredientsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No ingredients yet. Tap + to add one.'**
  String get recipesIngredientsEmpty;

  /// No description provided for @recipesIngredientSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{category} · {kcal} kcal · P {protein} · F {fat} · C {carbs} per 100 g raw'**
  String recipesIngredientSubtitle(
    String category,
    int kcal,
    int protein,
    int fat,
    int carbs,
  );

  /// No description provided for @recipesCategoryProtein.
  ///
  /// In en, this message translates to:
  /// **'protein'**
  String get recipesCategoryProtein;

  /// No description provided for @recipesCategoryCarb.
  ///
  /// In en, this message translates to:
  /// **'carb'**
  String get recipesCategoryCarb;

  /// No description provided for @recipesCategoryVegetable.
  ///
  /// In en, this message translates to:
  /// **'vegetable'**
  String get recipesCategoryVegetable;

  /// No description provided for @recipesCategoryFruit.
  ///
  /// In en, this message translates to:
  /// **'fruit'**
  String get recipesCategoryFruit;

  /// No description provided for @recipesCategoryFat.
  ///
  /// In en, this message translates to:
  /// **'fat'**
  String get recipesCategoryFat;

  /// No description provided for @recipesCategoryOther.
  ///
  /// In en, this message translates to:
  /// **'other'**
  String get recipesCategoryOther;

  /// No description provided for @recipesEditIngredientTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit ingredient'**
  String get recipesEditIngredientTitle;

  /// No description provided for @recipesNewIngredientTitle.
  ///
  /// In en, this message translates to:
  /// **'New ingredient'**
  String get recipesNewIngredientTitle;

  /// No description provided for @recipesDeleteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get recipesDeleteTooltip;

  /// No description provided for @recipesFieldName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get recipesFieldName;

  /// No description provided for @recipesFieldCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get recipesFieldCategory;

  /// No description provided for @recipesPer100Raw.
  ///
  /// In en, this message translates to:
  /// **'Per 100 g raw'**
  String get recipesPer100Raw;

  /// No description provided for @recipesFieldCalories.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get recipesFieldCalories;

  /// No description provided for @recipesFieldProtein.
  ///
  /// In en, this message translates to:
  /// **'Protein'**
  String get recipesFieldProtein;

  /// No description provided for @recipesFieldFat.
  ///
  /// In en, this message translates to:
  /// **'Fat'**
  String get recipesFieldFat;

  /// No description provided for @recipesFieldCarbs.
  ///
  /// In en, this message translates to:
  /// **'Carbs'**
  String get recipesFieldCarbs;

  /// No description provided for @recipesFieldFiber.
  ///
  /// In en, this message translates to:
  /// **'Fiber'**
  String get recipesFieldFiber;

  /// No description provided for @recipesEnergyWarning.
  ///
  /// In en, this message translates to:
  /// **'Calories differ from protein, fat and carbs by more than 15% (they add up to about {kcal} kcal). You can still save.'**
  String recipesEnergyWarning(int kcal);

  /// No description provided for @recipesCountsAsFruit.
  ///
  /// In en, this message translates to:
  /// **'Counts as a fruit portion'**
  String get recipesCountsAsFruit;

  /// No description provided for @recipesCountsAsVegetable.
  ///
  /// In en, this message translates to:
  /// **'Counts as a vegetable portion'**
  String get recipesCountsAsVegetable;

  /// No description provided for @recipesServingLabel.
  ///
  /// In en, this message translates to:
  /// **'Serving size (optional)'**
  String get recipesServingLabel;

  /// No description provided for @recipesSaveIngredient.
  ///
  /// In en, this message translates to:
  /// **'Save ingredient'**
  String get recipesSaveIngredient;

  /// No description provided for @recipesEnterName.
  ///
  /// In en, this message translates to:
  /// **'Enter a name'**
  String get recipesEnterName;

  /// No description provided for @recipesIngredientNameTaken.
  ///
  /// In en, this message translates to:
  /// **'An ingredient with this name already exists'**
  String get recipesIngredientNameTaken;

  /// No description provided for @recipesSaveIngredientError.
  ///
  /// In en, this message translates to:
  /// **'Could not save ingredient: {error}'**
  String recipesSaveIngredientError(String error);

  /// No description provided for @recipesDeleteIngredientTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{name}\"?'**
  String recipesDeleteIngredientTitle(String name);

  /// No description provided for @recipesDeleteIngredientMessage.
  ///
  /// In en, this message translates to:
  /// **'The ingredient will be removed from your library.'**
  String get recipesDeleteIngredientMessage;

  /// No description provided for @recipesIngredientInUse.
  ///
  /// In en, this message translates to:
  /// **'This ingredient is used in a recipe or a logged meal, so it cannot be deleted.'**
  String get recipesIngredientInUse;

  /// No description provided for @recipesCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get recipesCancel;

  /// No description provided for @recipesDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get recipesDelete;

  /// No description provided for @recipesNewRecipeTitle.
  ///
  /// In en, this message translates to:
  /// **'New recipe'**
  String get recipesNewRecipeTitle;

  /// No description provided for @recipesEditRecipeTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit recipe'**
  String get recipesEditRecipeTitle;

  /// No description provided for @recipesLoadRecipeError.
  ///
  /// In en, this message translates to:
  /// **'Could not load recipe: {error}'**
  String recipesLoadRecipeError(String error);

  /// No description provided for @recipesRecipeMissing.
  ///
  /// In en, this message translates to:
  /// **'This recipe no longer exists.'**
  String get recipesRecipeMissing;

  /// No description provided for @recipesFieldKind.
  ///
  /// In en, this message translates to:
  /// **'Kind'**
  String get recipesFieldKind;

  /// No description provided for @recipesYieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Expected yield factor (cooked / raw)'**
  String get recipesYieldLabel;

  /// No description provided for @recipesYieldHelper.
  ///
  /// In en, this message translates to:
  /// **'Cooked weight divided by raw weight. Meat shrinks (about 0.75); rice and pasta absorb water (about 2.5).'**
  String get recipesYieldHelper;

  /// No description provided for @recipesYieldRange.
  ///
  /// In en, this message translates to:
  /// **'Must be above 0 and at most 3'**
  String get recipesYieldRange;

  /// No description provided for @recipesLineRawLabel.
  ///
  /// In en, this message translates to:
  /// **'Raw'**
  String get recipesLineRawLabel;

  /// No description provided for @recipesRemoveIngredientTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove ingredient'**
  String get recipesRemoveIngredientTooltip;

  /// No description provided for @recipesLinesError.
  ///
  /// In en, this message translates to:
  /// **'Add at least one ingredient'**
  String get recipesLinesError;

  /// No description provided for @recipesAddIngredient.
  ///
  /// In en, this message translates to:
  /// **'Add ingredient'**
  String get recipesAddIngredient;

  /// No description provided for @recipesSectionTools.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get recipesSectionTools;

  /// No description provided for @recipesAddTool.
  ///
  /// In en, this message translates to:
  /// **'Add tool'**
  String get recipesAddTool;

  /// No description provided for @recipesSectionSteps.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get recipesSectionSteps;

  /// No description provided for @recipesAddStep.
  ///
  /// In en, this message translates to:
  /// **'Add step'**
  String get recipesAddStep;

  /// No description provided for @recipesFieldNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)'**
  String get recipesFieldNotes;

  /// No description provided for @recipesSaveRecipe.
  ///
  /// In en, this message translates to:
  /// **'Save recipe'**
  String get recipesSaveRecipe;

  /// No description provided for @recipesDeleteRecipe.
  ///
  /// In en, this message translates to:
  /// **'Delete recipe'**
  String get recipesDeleteRecipe;

  /// No description provided for @recipesSaveRecipeError.
  ///
  /// In en, this message translates to:
  /// **'Could not save recipe: {error}'**
  String recipesSaveRecipeError(String error);

  /// No description provided for @recipesDeleteRecipeTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{name}\"?'**
  String recipesDeleteRecipeTitle(String name);

  /// No description provided for @recipesDeleteRecipeMessage.
  ///
  /// In en, this message translates to:
  /// **'The recipe and its steps will be removed. This cannot be undone.'**
  String get recipesDeleteRecipeMessage;

  /// No description provided for @recipesRecipeInUse.
  ///
  /// In en, this message translates to:
  /// **'This recipe is used by a cooked batch, so it cannot be deleted.'**
  String get recipesRecipeInUse;

  /// No description provided for @recipesToolNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Tool name'**
  String get recipesToolNameLabel;

  /// No description provided for @recipesAddConfirm.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get recipesAddConfirm;

  /// No description provided for @recipesDetailTitleFallback.
  ///
  /// In en, this message translates to:
  /// **'Recipe'**
  String get recipesDetailTitleFallback;

  /// No description provided for @recipesEditTooltip.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get recipesEditTooltip;

  /// No description provided for @recipesRawGramsLine.
  ///
  /// In en, this message translates to:
  /// **'{grams} g raw'**
  String recipesRawGramsLine(int grams);

  /// No description provided for @recipesNoToolsSelected.
  ///
  /// In en, this message translates to:
  /// **'No tools selected.'**
  String get recipesNoToolsSelected;

  /// No description provided for @recipesNoSteps.
  ///
  /// In en, this message translates to:
  /// **'No steps yet.'**
  String get recipesNoSteps;

  /// No description provided for @recipesSectionNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get recipesSectionNotes;

  /// No description provided for @recipesStepTitle.
  ///
  /// In en, this message translates to:
  /// **'Step {number}'**
  String recipesStepTitle(int number);

  /// No description provided for @recipesMoveUp.
  ///
  /// In en, this message translates to:
  /// **'Move up'**
  String get recipesMoveUp;

  /// No description provided for @recipesMoveDown.
  ///
  /// In en, this message translates to:
  /// **'Move down'**
  String get recipesMoveDown;

  /// No description provided for @recipesRemoveStep.
  ///
  /// In en, this message translates to:
  /// **'Remove step'**
  String get recipesRemoveStep;

  /// No description provided for @recipesFieldTechnique.
  ///
  /// In en, this message translates to:
  /// **'Technique'**
  String get recipesFieldTechnique;

  /// No description provided for @recipesDescribeStep.
  ///
  /// In en, this message translates to:
  /// **'Describe the step'**
  String get recipesDescribeStep;

  /// No description provided for @recipesFieldTemp.
  ///
  /// In en, this message translates to:
  /// **'Temp'**
  String get recipesFieldTemp;

  /// No description provided for @recipesFieldTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get recipesFieldTime;

  /// No description provided for @recipesFieldToolOptional.
  ///
  /// In en, this message translates to:
  /// **'Tool (optional)'**
  String get recipesFieldToolOptional;

  /// No description provided for @recipesToolNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get recipesToolNone;

  /// No description provided for @recipesWholeNumber.
  ///
  /// In en, this message translates to:
  /// **'Whole number'**
  String get recipesWholeNumber;

  /// No description provided for @recipesSearchIngredients.
  ///
  /// In en, this message translates to:
  /// **'Search ingredients'**
  String get recipesSearchIngredients;

  /// No description provided for @recipesNoMatchingIngredients.
  ///
  /// In en, this message translates to:
  /// **'No matching ingredients'**
  String get recipesNoMatchingIngredients;

  /// No description provided for @mealLogToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get mealLogToday;

  /// No description provided for @mealLogLoadDayError.
  ///
  /// In en, this message translates to:
  /// **'Could not load the day: {error}'**
  String mealLogLoadDayError(String error);

  /// No description provided for @mealLogDeleteMealTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete meal {slot}?'**
  String mealLogDeleteMealTitle(int slot);

  /// No description provided for @mealLogDeleteMealMessage.
  ///
  /// In en, this message translates to:
  /// **'This removes the meal from {date} and gives its pantry stock back.'**
  String mealLogDeleteMealMessage(String date);

  /// No description provided for @mealLogDeleteMealFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not delete the meal.'**
  String get mealLogDeleteMealFailed;

  /// No description provided for @mealLogSetupTargetsHint.
  ///
  /// In en, this message translates to:
  /// **'Set up your nutrition targets in Settings to see your daily progress.'**
  String get mealLogSetupTargetsHint;

  /// No description provided for @mealLogStatusOnTarget.
  ///
  /// In en, this message translates to:
  /// **'On target'**
  String get mealLogStatusOnTarget;

  /// No description provided for @mealLogStatusBelow.
  ///
  /// In en, this message translates to:
  /// **'Below'**
  String get mealLogStatusBelow;

  /// No description provided for @mealLogStatusAbove.
  ///
  /// In en, this message translates to:
  /// **'Above'**
  String get mealLogStatusAbove;

  /// No description provided for @mealLogCaloriesStatus.
  ///
  /// In en, this message translates to:
  /// **'{status, select, within{Calories · On target} below{Calories · Below} above{Calories · Above} other{Calories}}'**
  String mealLogCaloriesStatus(String status);

  /// No description provided for @mealLogFiberStatus.
  ///
  /// In en, this message translates to:
  /// **'{status, select, within{Fiber · On target} below{Fiber · Below} above{Fiber · Above} other{Fiber}}'**
  String mealLogFiberStatus(String status);

  /// No description provided for @mealLogPreviousDay.
  ///
  /// In en, this message translates to:
  /// **'Previous day'**
  String get mealLogPreviousDay;

  /// No description provided for @mealLogNextDay.
  ///
  /// In en, this message translates to:
  /// **'Next day'**
  String get mealLogNextDay;

  /// No description provided for @mealLogTrainingDay.
  ///
  /// In en, this message translates to:
  /// **'Training day'**
  String get mealLogTrainingDay;

  /// No description provided for @mealLogRestDay.
  ///
  /// In en, this message translates to:
  /// **'Rest day'**
  String get mealLogRestDay;

  /// No description provided for @mealLogHydrationTitle.
  ///
  /// In en, this message translates to:
  /// **'Hydration'**
  String get mealLogHydrationTitle;

  /// No description provided for @mealLogWater.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get mealLogWater;

  /// No description provided for @mealLogGoalRange.
  ///
  /// In en, this message translates to:
  /// **'Goal {range}'**
  String mealLogGoalRange(String range);

  /// No description provided for @mealLogCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get mealLogCustom;

  /// No description provided for @mealLogUndoLast.
  ///
  /// In en, this message translates to:
  /// **'Undo last'**
  String get mealLogUndoLast;

  /// No description provided for @mealLogMacrosTitle.
  ///
  /// In en, this message translates to:
  /// **'Calories & macros'**
  String get mealLogMacrosTitle;

  /// No description provided for @mealLogCalories.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get mealLogCalories;

  /// No description provided for @mealLogProtein.
  ///
  /// In en, this message translates to:
  /// **'Protein'**
  String get mealLogProtein;

  /// No description provided for @mealLogFat.
  ///
  /// In en, this message translates to:
  /// **'Fat'**
  String get mealLogFat;

  /// No description provided for @mealLogCarbs.
  ///
  /// In en, this message translates to:
  /// **'Carbs'**
  String get mealLogCarbs;

  /// No description provided for @mealLogFiber.
  ///
  /// In en, this message translates to:
  /// **'Fiber'**
  String get mealLogFiber;

  /// No description provided for @mealLogRemaining.
  ///
  /// In en, this message translates to:
  /// **'{state, select, left{{amount} {unit} left} over{{amount} {unit} over} other{{amount} {unit}}}'**
  String mealLogRemaining(String state, int amount, String unit);

  /// No description provided for @mealLogRangeWithRemaining.
  ///
  /// In en, this message translates to:
  /// **'{state, select, left{Range {range} · {amount} {unit} left} over{Range {range} · {amount} {unit} over} other{Range {range}}}'**
  String mealLogRangeWithRemaining(
    String state,
    String range,
    int amount,
    String unit,
  );

  /// No description provided for @mealLogConfiguredWithRemaining.
  ///
  /// In en, this message translates to:
  /// **'{state, select, left{Configured {range} · {amount} {unit} left} over{Configured {range} · {amount} {unit} over} other{Configured {range}}}'**
  String mealLogConfiguredWithRemaining(
    String state,
    String range,
    int amount,
    String unit,
  );

  /// No description provided for @mealLogRangeOnly.
  ///
  /// In en, this message translates to:
  /// **'Range {range}'**
  String mealLogRangeOnly(String range);

  /// No description provided for @mealLogCarbsDerivedInfo.
  ///
  /// In en, this message translates to:
  /// **'Carbs target {grams} g is derived from calories and sits outside the configured range.'**
  String mealLogCarbsDerivedInfo(int grams);

  /// No description provided for @mealLogMealN.
  ///
  /// In en, this message translates to:
  /// **'Meal {slot}'**
  String mealLogMealN(int slot);

  /// No description provided for @mealLogEditMeal.
  ///
  /// In en, this message translates to:
  /// **'Edit meal'**
  String get mealLogEditMeal;

  /// No description provided for @mealLogDeleteMeal.
  ///
  /// In en, this message translates to:
  /// **'Delete meal'**
  String get mealLogDeleteMeal;

  /// No description provided for @mealLogComposeMeal.
  ///
  /// In en, this message translates to:
  /// **'Compose meal'**
  String get mealLogComposeMeal;

  /// No description provided for @mealLogSlotTotals.
  ///
  /// In en, this message translates to:
  /// **'{kcal} kcal · P {protein} · F {fat} · C {carbs}'**
  String mealLogSlotTotals(int kcal, int protein, int fat, int carbs);

  /// No description provided for @mealLogSlotProteinOnTarget.
  ///
  /// In en, this message translates to:
  /// **'Protein {grams} g · on target'**
  String mealLogSlotProteinOnTarget(int grams);

  /// No description provided for @mealLogSlotProteinBelow.
  ///
  /// In en, this message translates to:
  /// **'Protein {grams} g · below {range}'**
  String mealLogSlotProteinBelow(int grams, String range);

  /// No description provided for @mealLogSlotProteinAbove.
  ///
  /// In en, this message translates to:
  /// **'Protein {grams} g · above {range}'**
  String mealLogSlotProteinAbove(int grams, String range);

  /// No description provided for @mealLogMealProteinOnTarget.
  ///
  /// In en, this message translates to:
  /// **'Protein on target ({range})'**
  String mealLogMealProteinOnTarget(String range);

  /// No description provided for @mealLogMealProteinBelow.
  ///
  /// In en, this message translates to:
  /// **'Protein {grams} g below {range}'**
  String mealLogMealProteinBelow(int grams, String range);

  /// No description provided for @mealLogMealProteinAbove.
  ///
  /// In en, this message translates to:
  /// **'Protein {grams} g above {range}'**
  String mealLogMealProteinAbove(int grams, String range);

  /// No description provided for @mealLogDayRemaining.
  ///
  /// In en, this message translates to:
  /// **'{dayType, select, training{Left today after this meal (training day): {kcal} kcal · {carbs} g carbs} rest{Left today after this meal (rest day): {kcal} kcal · {carbs} g carbs} other{Left today after this meal: {kcal} kcal · {carbs} g carbs}}'**
  String mealLogDayRemaining(String dayType, int kcal, int carbs);

  /// No description provided for @mealLogPantryEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nothing left in the pantry.'**
  String get mealLogPantryEmpty;

  /// No description provided for @mealLogPantryItemSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{grams} g left · cooked {date}'**
  String mealLogPantryItemSubtitle(int grams, String date);

  /// No description provided for @mealLogProteinPerMealTitle.
  ///
  /// In en, this message translates to:
  /// **'Protein per meal'**
  String get mealLogProteinPerMealTitle;

  /// No description provided for @mealLogProteinBand.
  ///
  /// In en, this message translates to:
  /// **'Band {range}'**
  String mealLogProteinBand(String range);

  /// No description provided for @mealLogServingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Fruit & vegetables'**
  String get mealLogServingsTitle;

  /// No description provided for @mealLogFruit.
  ///
  /// In en, this message translates to:
  /// **'Fruit'**
  String get mealLogFruit;

  /// No description provided for @mealLogVegetables.
  ///
  /// In en, this message translates to:
  /// **'Vegetables'**
  String get mealLogVegetables;

  /// No description provided for @mealLogPortionsGoal.
  ///
  /// In en, this message translates to:
  /// **'Goal {range} portions'**
  String mealLogPortionsGoal(String range);

  /// No description provided for @mealLogRemovePortion.
  ///
  /// In en, this message translates to:
  /// **'Remove a portion of {label}'**
  String mealLogRemovePortion(String label);

  /// No description provided for @mealLogAddPortion.
  ///
  /// In en, this message translates to:
  /// **'Add a portion of {label}'**
  String mealLogAddPortion(String label);

  /// No description provided for @mealLogAddWaterTitle.
  ///
  /// In en, this message translates to:
  /// **'Add water'**
  String get mealLogAddWaterTitle;

  /// No description provided for @mealLogAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get mealLogAmount;

  /// No description provided for @mealLogAtMostMl.
  ///
  /// In en, this message translates to:
  /// **'At most {max} ml'**
  String mealLogAtMostMl(int max);

  /// No description provided for @mealLogCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get mealLogCancel;

  /// No description provided for @mealLogAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get mealLogAdd;

  /// No description provided for @mealLogRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get mealLogRemove;

  /// No description provided for @mealLogAllRemaining.
  ///
  /// In en, this message translates to:
  /// **'All remaining'**
  String get mealLogAllRemaining;

  /// No description provided for @mealLogComposerLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load the composer: {error}'**
  String mealLogComposerLoadError(String error);

  /// No description provided for @mealLogComposeSetupHint.
  ///
  /// In en, this message translates to:
  /// **'Set up your nutrition targets in Settings to compose meals.'**
  String get mealLogComposeSetupHint;

  /// No description provided for @mealLogNoProteinToSuggest.
  ///
  /// In en, this message translates to:
  /// **'This item has no protein to suggest from.'**
  String get mealLogNoProteinToSuggest;

  /// No description provided for @mealLogOnlyLeftBelowTarget.
  ///
  /// In en, this message translates to:
  /// **'Only {grams} g left, so protein stays below the target.'**
  String mealLogOnlyLeftBelowTarget(int grams);

  /// No description provided for @mealLogNotEnoughTitle.
  ///
  /// In en, this message translates to:
  /// **'Not enough in the pantry'**
  String get mealLogNotEnoughTitle;

  /// No description provided for @mealLogNotEnoughMessage.
  ///
  /// In en, this message translates to:
  /// **'You entered more than what is left of {names}. Saving will leave the stock below zero.'**
  String mealLogNotEnoughMessage(String names);

  /// No description provided for @mealLogSaveAnyway.
  ///
  /// In en, this message translates to:
  /// **'Save anyway'**
  String get mealLogSaveAnyway;

  /// No description provided for @mealLogSaveError.
  ///
  /// In en, this message translates to:
  /// **'Could not save meal: {error}'**
  String mealLogSaveError(String error);

  /// No description provided for @mealLogFromPantry.
  ///
  /// In en, this message translates to:
  /// **'From pantry · {grams} g available'**
  String mealLogFromPantry(int grams);

  /// No description provided for @mealLogFreshIngredient.
  ///
  /// In en, this message translates to:
  /// **'Fresh ingredient'**
  String get mealLogFreshIngredient;

  /// No description provided for @mealLogOnlyLeftInPantry.
  ///
  /// In en, this message translates to:
  /// **'Only {grams} g left in the pantry.'**
  String mealLogOnlyLeftInPantry(int grams);

  /// No description provided for @mealLogAddAtLeastOne.
  ///
  /// In en, this message translates to:
  /// **'Add at least one component'**
  String get mealLogAddAtLeastOne;

  /// No description provided for @mealLogAddFromPantry.
  ///
  /// In en, this message translates to:
  /// **'Add from pantry'**
  String get mealLogAddFromPantry;

  /// No description provided for @mealLogAddFresh.
  ///
  /// In en, this message translates to:
  /// **'Add fresh ingredient'**
  String get mealLogAddFresh;

  /// No description provided for @mealLogSuggestProtein.
  ///
  /// In en, this message translates to:
  /// **'Suggest to reach protein target'**
  String get mealLogSuggestProtein;

  /// No description provided for @mealLogSuggestHint.
  ///
  /// In en, this message translates to:
  /// **'Add a protein-base item from the pantry to get a suggestion.'**
  String get mealLogSuggestHint;

  /// No description provided for @mealLogSaveMeal.
  ///
  /// In en, this message translates to:
  /// **'Save meal'**
  String get mealLogSaveMeal;

  /// No description provided for @targetsTitle.
  ///
  /// In en, this message translates to:
  /// **'Nutrition targets'**
  String get targetsTitle;

  /// No description provided for @targetsLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load targets: {error}'**
  String targetsLoadError(String error);

  /// No description provided for @targetsHintProteinPerKg.
  ///
  /// In en, this message translates to:
  /// **'Protein: {value} g/kg'**
  String targetsHintProteinPerKg(String value);

  /// No description provided for @targetsHintFatPerKg.
  ///
  /// In en, this message translates to:
  /// **'Fat: {value} g/kg'**
  String targetsHintFatPerKg(String value);

  /// No description provided for @targetsHintProteinPerMeal.
  ///
  /// In en, this message translates to:
  /// **'Protein per meal target: {value} g'**
  String targetsHintProteinPerMeal(String value);

  /// No description provided for @targetsInvalidIncomplete.
  ///
  /// In en, this message translates to:
  /// **'Invalid input: Fill in all fields'**
  String get targetsInvalidIncomplete;

  /// No description provided for @targetsInvalidMeals.
  ///
  /// In en, this message translates to:
  /// **'Invalid input: Meals per day must be a whole number'**
  String get targetsInvalidMeals;

  /// No description provided for @targetsInvalidValues.
  ///
  /// In en, this message translates to:
  /// **'Invalid input: check the values and try again'**
  String get targetsInvalidValues;

  /// No description provided for @targetsSaved.
  ///
  /// In en, this message translates to:
  /// **'Nutrition targets saved'**
  String get targetsSaved;

  /// No description provided for @targetsResetTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset to example defaults?'**
  String get targetsResetTitle;

  /// No description provided for @targetsResetMessage.
  ///
  /// In en, this message translates to:
  /// **'This replaces the values in the form. Nothing changes until you save.'**
  String get targetsResetMessage;

  /// No description provided for @targetsCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get targetsCancel;

  /// No description provided for @targetsReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get targetsReset;

  /// No description provided for @targetsSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get targetsSave;

  /// No description provided for @targetsResetToDefaults.
  ///
  /// In en, this message translates to:
  /// **'Reset to example defaults'**
  String get targetsResetToDefaults;

  /// No description provided for @targetsProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get targetsProfile;

  /// No description provided for @targetsBodyWeight.
  ///
  /// In en, this message translates to:
  /// **'Body weight (optional)'**
  String get targetsBodyWeight;

  /// No description provided for @targetsProtein.
  ///
  /// In en, this message translates to:
  /// **'Protein'**
  String get targetsProtein;

  /// No description provided for @targetsFat.
  ///
  /// In en, this message translates to:
  /// **'Fat'**
  String get targetsFat;

  /// No description provided for @targetsMealsPerDay.
  ///
  /// In en, this message translates to:
  /// **'Meals per day'**
  String get targetsMealsPerDay;

  /// No description provided for @targetsProteinPerMeal.
  ///
  /// In en, this message translates to:
  /// **'Protein per meal'**
  String get targetsProteinPerMeal;

  /// No description provided for @targetsFieldCalories.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get targetsFieldCalories;

  /// No description provided for @targetsFieldCarbs.
  ///
  /// In en, this message translates to:
  /// **'Carbs'**
  String get targetsFieldCarbs;

  /// No description provided for @targetsFieldFiber.
  ///
  /// In en, this message translates to:
  /// **'Fiber'**
  String get targetsFieldFiber;

  /// No description provided for @targetsFieldWater.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get targetsFieldWater;

  /// No description provided for @targetsFieldFruit.
  ///
  /// In en, this message translates to:
  /// **'Fruit'**
  String get targetsFieldFruit;

  /// No description provided for @targetsFieldVegetables.
  ///
  /// In en, this message translates to:
  /// **'Vegetables'**
  String get targetsFieldVegetables;

  /// No description provided for @targetsUnitPortions.
  ///
  /// In en, this message translates to:
  /// **'portions'**
  String get targetsUnitPortions;

  /// No description provided for @targetsRangeMin.
  ///
  /// In en, this message translates to:
  /// **'{label} min'**
  String targetsRangeMin(String label);

  /// No description provided for @targetsRangeMax.
  ///
  /// In en, this message translates to:
  /// **'{label} max'**
  String targetsRangeMax(String label);

  /// No description provided for @targetsMustBeAtLeastMin.
  ///
  /// In en, this message translates to:
  /// **'Must be at least min'**
  String get targetsMustBeAtLeastMin;

  /// No description provided for @targetsTrainingDay.
  ///
  /// In en, this message translates to:
  /// **'Training day'**
  String get targetsTrainingDay;

  /// No description provided for @targetsRestDay.
  ///
  /// In en, this message translates to:
  /// **'Rest day'**
  String get targetsRestDay;

  /// No description provided for @targetsDerivedCarbsNone.
  ///
  /// In en, this message translates to:
  /// **'Derived carbs: -'**
  String get targetsDerivedCarbsNone;

  /// No description provided for @targetsDerivedCarbs.
  ///
  /// In en, this message translates to:
  /// **'Derived carbs at mid calories: {grams} g'**
  String targetsDerivedCarbs(int grams);

  /// No description provided for @targetsCarbsOutsideRange.
  ///
  /// In en, this message translates to:
  /// **'Derived carbs are outside the configured range'**
  String get targetsCarbsOutsideRange;

  /// No description provided for @targetsCarbsExplain.
  ///
  /// In en, this message translates to:
  /// **'Carbs are derived from calories left after protein and fat.'**
  String get targetsCarbsExplain;

  /// No description provided for @targetsWeeklySchedule.
  ///
  /// In en, this message translates to:
  /// **'Weekly schedule'**
  String get targetsWeeklySchedule;

  /// No description provided for @targetsScheduleHint.
  ///
  /// In en, this message translates to:
  /// **'Selected chips are training days; the rest are rest days.'**
  String get targetsScheduleHint;

  /// No description provided for @targetsScheduleTraining.
  ///
  /// In en, this message translates to:
  /// **'Training'**
  String get targetsScheduleTraining;

  /// No description provided for @targetsScheduleRest.
  ///
  /// In en, this message translates to:
  /// **'Rest'**
  String get targetsScheduleRest;

  /// No description provided for @targetsWeeklyAverageNone.
  ///
  /// In en, this message translates to:
  /// **'Weekly average: -'**
  String get targetsWeeklyAverageNone;

  /// No description provided for @targetsWeeklyAverage.
  ///
  /// In en, this message translates to:
  /// **'Weekly average: {kcal} kcal/day'**
  String targetsWeeklyAverage(int kcal);

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
