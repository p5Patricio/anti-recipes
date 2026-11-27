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
}
