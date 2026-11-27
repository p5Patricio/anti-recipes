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
}
