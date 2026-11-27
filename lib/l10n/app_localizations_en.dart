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
  String get coreWidgetsComingSoon => 'Coming soon';

  @override
  String get coreWidgetsEnterNumber => 'Enter a number';

  @override
  String get coreWidgetsMustBeAboveZero => 'Must be above 0';

  @override
  String get coreWidgetsMustBeZeroOrMore => 'Must be 0 or more';

  @override
  String get recipesTitle => 'Recipes';

  @override
  String get recipesIngredientsTooltip => 'Ingredients';

  @override
  String get recipesNewRecipeTooltip => 'New recipe';

  @override
  String get recipesFilterAll => 'All';

  @override
  String recipesLoadError(String error) {
    return 'Could not load recipes: $error';
  }

  @override
  String get recipesEmptyFilteredTitle => 'Nothing in this group yet';

  @override
  String get recipesEmptyFilteredBody =>
      'Pick another group or add a recipe of this kind.';

  @override
  String get recipesEmptyTitle => 'No recipes yet';

  @override
  String get recipesEmptyBody =>
      'Tap + to create your first recipe and start batch cooking.';

  @override
  String get recipesKindProteinBase => 'Protein base';

  @override
  String get recipesKindCarbBase => 'Carb base';

  @override
  String get recipesKindSauce => 'Sauce';

  @override
  String get recipesKindVegetable => 'Vegetable';

  @override
  String get recipesKindComplete => 'Complete';

  @override
  String recipesCardKindYield(String kind, String yieldFactor) {
    return '$kind · yield $yieldFactor';
  }

  @override
  String get recipesPer100Cooked => 'Per 100 g cooked';

  @override
  String recipesMacroLine(
    int kcal,
    int protein,
    int fat,
    int carbs,
    int fiber,
  ) {
    return '$kcal kcal · P $protein · F $fat · C $carbs · Fiber $fiber';
  }

  @override
  String get recipesSummaryTitle => 'Summary';

  @override
  String recipesSummaryRawWeight(int grams) {
    return 'Raw weight: $grams g';
  }

  @override
  String recipesSummaryCookedWeight(int grams) {
    return 'Expected cooked weight: $grams g';
  }

  @override
  String get recipesSummaryTotal => 'Total';

  @override
  String get recipesIngredientsTitle => 'Ingredients';

  @override
  String get recipesNewIngredientTooltip => 'New ingredient';

  @override
  String recipesIngredientsLoadError(String error) {
    return 'Could not load ingredients: $error';
  }

  @override
  String get recipesIngredientsEmpty => 'No ingredients yet. Tap + to add one.';

  @override
  String recipesIngredientSubtitle(
    String category,
    int kcal,
    int protein,
    int fat,
    int carbs,
  ) {
    return '$category · $kcal kcal · P $protein · F $fat · C $carbs per 100 g raw';
  }

  @override
  String get recipesCategoryProtein => 'protein';

  @override
  String get recipesCategoryCarb => 'carb';

  @override
  String get recipesCategoryVegetable => 'vegetable';

  @override
  String get recipesCategoryFruit => 'fruit';

  @override
  String get recipesCategoryFat => 'fat';

  @override
  String get recipesCategoryOther => 'other';

  @override
  String get recipesEditIngredientTitle => 'Edit ingredient';

  @override
  String get recipesNewIngredientTitle => 'New ingredient';

  @override
  String get recipesDeleteTooltip => 'Delete';

  @override
  String get recipesFieldName => 'Name';

  @override
  String get recipesFieldCategory => 'Category';

  @override
  String get recipesPer100Raw => 'Per 100 g raw';

  @override
  String get recipesFieldCalories => 'Calories';

  @override
  String get recipesFieldProtein => 'Protein';

  @override
  String get recipesFieldFat => 'Fat';

  @override
  String get recipesFieldCarbs => 'Carbs';

  @override
  String get recipesFieldFiber => 'Fiber';

  @override
  String recipesEnergyWarning(int kcal) {
    return 'Calories differ from protein, fat and carbs by more than 15% (they add up to about $kcal kcal). You can still save.';
  }

  @override
  String get recipesCountsAsFruit => 'Counts as a fruit portion';

  @override
  String get recipesCountsAsVegetable => 'Counts as a vegetable portion';

  @override
  String get recipesServingLabel => 'Serving size (optional)';

  @override
  String get recipesSaveIngredient => 'Save ingredient';

  @override
  String get recipesEnterName => 'Enter a name';

  @override
  String get recipesIngredientNameTaken =>
      'An ingredient with this name already exists';

  @override
  String recipesSaveIngredientError(String error) {
    return 'Could not save ingredient: $error';
  }

  @override
  String recipesDeleteIngredientTitle(String name) {
    return 'Delete \"$name\"?';
  }

  @override
  String get recipesDeleteIngredientMessage =>
      'The ingredient will be removed from your library.';

  @override
  String get recipesIngredientInUse =>
      'This ingredient is used in a recipe or a logged meal, so it cannot be deleted.';

  @override
  String get recipesCancel => 'Cancel';

  @override
  String get recipesDelete => 'Delete';

  @override
  String get recipesNewRecipeTitle => 'New recipe';

  @override
  String get recipesEditRecipeTitle => 'Edit recipe';

  @override
  String recipesLoadRecipeError(String error) {
    return 'Could not load recipe: $error';
  }

  @override
  String get recipesRecipeMissing => 'This recipe no longer exists.';

  @override
  String get recipesFieldKind => 'Kind';

  @override
  String get recipesYieldLabel => 'Expected yield factor (cooked / raw)';

  @override
  String get recipesYieldHelper =>
      'Cooked weight divided by raw weight. Meat shrinks (about 0.75); rice and pasta absorb water (about 2.5).';

  @override
  String get recipesYieldRange => 'Must be above 0 and at most 3';

  @override
  String get recipesLineRawLabel => 'Raw';

  @override
  String get recipesRemoveIngredientTooltip => 'Remove ingredient';

  @override
  String get recipesLinesError => 'Add at least one ingredient';

  @override
  String get recipesAddIngredient => 'Add ingredient';

  @override
  String get recipesSectionTools => 'Tools';

  @override
  String get recipesAddTool => 'Add tool';

  @override
  String get recipesSectionSteps => 'Steps';

  @override
  String get recipesAddStep => 'Add step';

  @override
  String get recipesFieldNotes => 'Notes (optional)';

  @override
  String get recipesSaveRecipe => 'Save recipe';

  @override
  String get recipesDeleteRecipe => 'Delete recipe';

  @override
  String recipesSaveRecipeError(String error) {
    return 'Could not save recipe: $error';
  }

  @override
  String recipesDeleteRecipeTitle(String name) {
    return 'Delete \"$name\"?';
  }

  @override
  String get recipesDeleteRecipeMessage =>
      'The recipe and its steps will be removed. This cannot be undone.';

  @override
  String get recipesRecipeInUse =>
      'This recipe is used by a cooked batch, so it cannot be deleted.';

  @override
  String get recipesToolNameLabel => 'Tool name';

  @override
  String get recipesAddConfirm => 'Add';

  @override
  String get recipesDetailTitleFallback => 'Recipe';

  @override
  String get recipesEditTooltip => 'Edit';

  @override
  String recipesRawGramsLine(int grams) {
    return '$grams g raw';
  }

  @override
  String get recipesNoToolsSelected => 'No tools selected.';

  @override
  String get recipesNoSteps => 'No steps yet.';

  @override
  String get recipesSectionNotes => 'Notes';

  @override
  String recipesStepTitle(int number) {
    return 'Step $number';
  }

  @override
  String get recipesMoveUp => 'Move up';

  @override
  String get recipesMoveDown => 'Move down';

  @override
  String get recipesRemoveStep => 'Remove step';

  @override
  String get recipesFieldTechnique => 'Technique';

  @override
  String get recipesDescribeStep => 'Describe the step';

  @override
  String get recipesFieldTemp => 'Temp';

  @override
  String get recipesFieldTime => 'Time';

  @override
  String get recipesFieldToolOptional => 'Tool (optional)';

  @override
  String get recipesToolNone => 'None';

  @override
  String get recipesWholeNumber => 'Whole number';

  @override
  String get recipesSearchIngredients => 'Search ingredients';

  @override
  String get recipesNoMatchingIngredients => 'No matching ingredients';

  @override
  String get mealLogToday => 'Today';

  @override
  String mealLogLoadDayError(String error) {
    return 'Could not load the day: $error';
  }

  @override
  String mealLogDeleteMealTitle(int slot) {
    return 'Delete meal $slot?';
  }

  @override
  String mealLogDeleteMealMessage(String date) {
    return 'This removes the meal from $date and gives its pantry stock back.';
  }

  @override
  String get mealLogDeleteMealFailed => 'Could not delete the meal.';

  @override
  String get mealLogSetupTargetsHint =>
      'Set up your nutrition targets in Settings to see your daily progress.';

  @override
  String get mealLogStatusOnTarget => 'On target';

  @override
  String get mealLogStatusBelow => 'Below';

  @override
  String get mealLogStatusAbove => 'Above';

  @override
  String mealLogCaloriesStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'within': 'Calories · On target',
      'below': 'Calories · Below',
      'above': 'Calories · Above',
      'other': 'Calories',
    });
    return '$_temp0';
  }

  @override
  String mealLogFiberStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'within': 'Fiber · On target',
      'below': 'Fiber · Below',
      'above': 'Fiber · Above',
      'other': 'Fiber',
    });
    return '$_temp0';
  }

  @override
  String get mealLogPreviousDay => 'Previous day';

  @override
  String get mealLogNextDay => 'Next day';

  @override
  String get mealLogTrainingDay => 'Training day';

  @override
  String get mealLogRestDay => 'Rest day';

  @override
  String get mealLogHydrationTitle => 'Hydration';

  @override
  String get mealLogWater => 'Water';

  @override
  String mealLogGoalRange(String range) {
    return 'Goal $range';
  }

  @override
  String get mealLogCustom => 'Custom';

  @override
  String get mealLogUndoLast => 'Undo last';

  @override
  String get mealLogMacrosTitle => 'Calories & macros';

  @override
  String get mealLogCalories => 'Calories';

  @override
  String get mealLogProtein => 'Protein';

  @override
  String get mealLogFat => 'Fat';

  @override
  String get mealLogCarbs => 'Carbs';

  @override
  String get mealLogFiber => 'Fiber';

  @override
  String mealLogRemaining(String state, int amount, String unit) {
    String _temp0 = intl.Intl.selectLogic(state, {
      'left': '$amount $unit left',
      'over': '$amount $unit over',
      'other': '$amount $unit',
    });
    return '$_temp0';
  }

  @override
  String mealLogRangeWithRemaining(
    String state,
    String range,
    int amount,
    String unit,
  ) {
    String _temp0 = intl.Intl.selectLogic(state, {
      'left': 'Range $range · $amount $unit left',
      'over': 'Range $range · $amount $unit over',
      'other': 'Range $range',
    });
    return '$_temp0';
  }

  @override
  String mealLogConfiguredWithRemaining(
    String state,
    String range,
    int amount,
    String unit,
  ) {
    String _temp0 = intl.Intl.selectLogic(state, {
      'left': 'Configured $range · $amount $unit left',
      'over': 'Configured $range · $amount $unit over',
      'other': 'Configured $range',
    });
    return '$_temp0';
  }

  @override
  String mealLogRangeOnly(String range) {
    return 'Range $range';
  }

  @override
  String mealLogCarbsDerivedInfo(int grams) {
    return 'Carbs target $grams g is derived from calories and sits outside the configured range.';
  }

  @override
  String mealLogMealN(int slot) {
    return 'Meal $slot';
  }

  @override
  String get mealLogEditMeal => 'Edit meal';

  @override
  String get mealLogDeleteMeal => 'Delete meal';

  @override
  String get mealLogComposeMeal => 'Compose meal';

  @override
  String mealLogSlotTotals(int kcal, int protein, int fat, int carbs) {
    return '$kcal kcal · P $protein · F $fat · C $carbs';
  }

  @override
  String mealLogSlotProteinOnTarget(int grams) {
    return 'Protein $grams g · on target';
  }

  @override
  String mealLogSlotProteinBelow(int grams, String range) {
    return 'Protein $grams g · below $range';
  }

  @override
  String mealLogSlotProteinAbove(int grams, String range) {
    return 'Protein $grams g · above $range';
  }

  @override
  String mealLogMealProteinOnTarget(String range) {
    return 'Protein on target ($range)';
  }

  @override
  String mealLogMealProteinBelow(int grams, String range) {
    return 'Protein $grams g below $range';
  }

  @override
  String mealLogMealProteinAbove(int grams, String range) {
    return 'Protein $grams g above $range';
  }

  @override
  String mealLogDayRemaining(String dayType, int kcal, int carbs) {
    String _temp0 = intl.Intl.selectLogic(dayType, {
      'training':
          'Left today after this meal (training day): $kcal kcal · $carbs g carbs',
      'rest':
          'Left today after this meal (rest day): $kcal kcal · $carbs g carbs',
      'other': 'Left today after this meal: $kcal kcal · $carbs g carbs',
    });
    return '$_temp0';
  }

  @override
  String get mealLogPantryEmpty => 'Nothing left in the pantry.';

  @override
  String mealLogPantryItemSubtitle(int grams, String date) {
    return '$grams g left · cooked $date';
  }

  @override
  String get mealLogProteinPerMealTitle => 'Protein per meal';

  @override
  String mealLogProteinBand(String range) {
    return 'Band $range';
  }

  @override
  String get mealLogServingsTitle => 'Fruit & vegetables';

  @override
  String get mealLogFruit => 'Fruit';

  @override
  String get mealLogVegetables => 'Vegetables';

  @override
  String mealLogPortionsGoal(String range) {
    return 'Goal $range portions';
  }

  @override
  String mealLogRemovePortion(String label) {
    return 'Remove a portion of $label';
  }

  @override
  String mealLogAddPortion(String label) {
    return 'Add a portion of $label';
  }

  @override
  String get mealLogAddWaterTitle => 'Add water';

  @override
  String get mealLogAmount => 'Amount';

  @override
  String mealLogAtMostMl(int max) {
    return 'At most $max ml';
  }

  @override
  String get mealLogCancel => 'Cancel';

  @override
  String get mealLogAdd => 'Add';

  @override
  String get mealLogRemove => 'Remove';

  @override
  String get mealLogAllRemaining => 'All remaining';

  @override
  String mealLogComposerLoadError(String error) {
    return 'Could not load the composer: $error';
  }

  @override
  String get mealLogComposeSetupHint =>
      'Set up your nutrition targets in Settings to compose meals.';

  @override
  String get mealLogNoProteinToSuggest =>
      'This item has no protein to suggest from.';

  @override
  String mealLogOnlyLeftBelowTarget(int grams) {
    return 'Only $grams g left, so protein stays below the target.';
  }

  @override
  String get mealLogNotEnoughTitle => 'Not enough in the pantry';

  @override
  String mealLogNotEnoughMessage(String names) {
    return 'You entered more than what is left of $names. Saving will leave the stock below zero.';
  }

  @override
  String get mealLogSaveAnyway => 'Save anyway';

  @override
  String mealLogSaveError(String error) {
    return 'Could not save meal: $error';
  }

  @override
  String mealLogFromPantry(int grams) {
    return 'From pantry · $grams g available';
  }

  @override
  String get mealLogFreshIngredient => 'Fresh ingredient';

  @override
  String mealLogOnlyLeftInPantry(int grams) {
    return 'Only $grams g left in the pantry.';
  }

  @override
  String get mealLogAddAtLeastOne => 'Add at least one component';

  @override
  String get mealLogAddFromPantry => 'Add from pantry';

  @override
  String get mealLogAddFresh => 'Add fresh ingredient';

  @override
  String get mealLogSuggestProtein => 'Suggest to reach protein target';

  @override
  String get mealLogSuggestHint =>
      'Add a protein-base item from the pantry to get a suggestion.';

  @override
  String get mealLogSaveMeal => 'Save meal';

  @override
  String get targetsTitle => 'Nutrition targets';

  @override
  String targetsLoadError(String error) {
    return 'Could not load targets: $error';
  }

  @override
  String targetsHintProteinPerKg(String value) {
    return 'Protein: $value g/kg';
  }

  @override
  String targetsHintFatPerKg(String value) {
    return 'Fat: $value g/kg';
  }

  @override
  String targetsHintProteinPerMeal(String value) {
    return 'Protein per meal target: $value g';
  }

  @override
  String get targetsInvalidIncomplete => 'Invalid input: Fill in all fields';

  @override
  String get targetsInvalidMeals =>
      'Invalid input: Meals per day must be a whole number';

  @override
  String get targetsInvalidValues =>
      'Invalid input: check the values and try again';

  @override
  String get targetsSaved => 'Nutrition targets saved';

  @override
  String get targetsResetTitle => 'Reset to example defaults?';

  @override
  String get targetsResetMessage =>
      'This replaces the values in the form. Nothing changes until you save.';

  @override
  String get targetsCancel => 'Cancel';

  @override
  String get targetsReset => 'Reset';

  @override
  String get targetsSave => 'Save';

  @override
  String get targetsResetToDefaults => 'Reset to example defaults';

  @override
  String get targetsProfile => 'Profile';

  @override
  String get targetsBodyWeight => 'Body weight (optional)';

  @override
  String get targetsProtein => 'Protein';

  @override
  String get targetsFat => 'Fat';

  @override
  String get targetsMealsPerDay => 'Meals per day';

  @override
  String get targetsProteinPerMeal => 'Protein per meal';

  @override
  String get targetsFieldCalories => 'Calories';

  @override
  String get targetsFieldCarbs => 'Carbs';

  @override
  String get targetsFieldFiber => 'Fiber';

  @override
  String get targetsFieldWater => 'Water';

  @override
  String get targetsFieldFruit => 'Fruit';

  @override
  String get targetsFieldVegetables => 'Vegetables';

  @override
  String get targetsUnitPortions => 'portions';

  @override
  String targetsRangeMin(String label) {
    return '$label min';
  }

  @override
  String targetsRangeMax(String label) {
    return '$label max';
  }

  @override
  String get targetsMustBeAtLeastMin => 'Must be at least min';

  @override
  String get targetsTrainingDay => 'Training day';

  @override
  String get targetsRestDay => 'Rest day';

  @override
  String get targetsDerivedCarbsNone => 'Derived carbs: -';

  @override
  String targetsDerivedCarbs(int grams) {
    return 'Derived carbs at mid calories: $grams g';
  }

  @override
  String get targetsCarbsOutsideRange =>
      'Derived carbs are outside the configured range';

  @override
  String get targetsCarbsExplain =>
      'Carbs are derived from calories left after protein and fat.';

  @override
  String get targetsWeeklySchedule => 'Weekly schedule';

  @override
  String get targetsScheduleHint =>
      'Selected chips are training days; the rest are rest days.';

  @override
  String get targetsScheduleTraining => 'Training';

  @override
  String get targetsScheduleRest => 'Rest';

  @override
  String get targetsWeeklyAverageNone => 'Weekly average: -';

  @override
  String targetsWeeklyAverage(int kcal) {
    return 'Weekly average: $kcal kcal/day';
  }

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
