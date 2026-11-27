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
