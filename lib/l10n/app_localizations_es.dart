// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'anti-recipes';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsNutritionTargetsTitle => 'Objetivos nutricionales';

  @override
  String get settingsNutritionTargetsSubtitle =>
      'Proteína, grasa, tipos de día y plan semanal';

  @override
  String get settingsBackupTitle => 'Copia de seguridad';

  @override
  String get settingsBackupSubtitle =>
      'Exporta o restaura todos tus datos como JSON';

  @override
  String get settingsLanguageTitle => 'Idioma';

  @override
  String get settingsLanguageSystem => 'Predeterminado del sistema';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguageSpanish => 'Español';

  @override
  String get coreWidgetsComingSoon => 'Próximamente';

  @override
  String get coreWidgetsEnterNumber => 'Ingresa un número';

  @override
  String get coreWidgetsMustBeAboveZero => 'Debe ser mayor que 0';

  @override
  String get coreWidgetsMustBeZeroOrMore => 'Debe ser 0 o más';

  @override
  String get recipesTitle => 'Recetas';

  @override
  String get recipesIngredientsTooltip => 'Ingredientes';

  @override
  String get recipesNewRecipeTooltip => 'Nueva receta';

  @override
  String get recipesFilterAll => 'Todas';

  @override
  String recipesLoadError(String error) {
    return 'No se pudieron cargar las recetas: $error';
  }

  @override
  String get recipesEmptyFilteredTitle => 'Aún no hay nada en este grupo';

  @override
  String get recipesEmptyFilteredBody =>
      'Elige otro grupo o agrega una receta de este tipo.';

  @override
  String get recipesEmptyTitle => 'Aún no hay recetas';

  @override
  String get recipesEmptyBody =>
      'Toca + para crear tu primera receta y empezar a cocinar por tandas.';

  @override
  String get recipesKindProteinBase => 'Base de proteína';

  @override
  String get recipesKindCarbBase => 'Base de carbohidratos';

  @override
  String get recipesKindSauce => 'Salsa';

  @override
  String get recipesKindVegetable => 'Verdura';

  @override
  String get recipesKindComplete => 'Completa';

  @override
  String recipesCardKindYield(String kind, String yieldFactor) {
    return '$kind · rendimiento $yieldFactor';
  }

  @override
  String get recipesPer100Cooked => 'Por 100 g cocido';

  @override
  String recipesMacroLine(
    int kcal,
    int protein,
    int fat,
    int carbs,
    int fiber,
  ) {
    return '$kcal kcal · P $protein · G $fat · C $carbs · Fibra $fiber';
  }

  @override
  String get recipesSummaryTitle => 'Resumen';

  @override
  String recipesSummaryRawWeight(int grams) {
    return 'Peso crudo: $grams g';
  }

  @override
  String recipesSummaryCookedWeight(int grams) {
    return 'Peso cocido esperado: $grams g';
  }

  @override
  String get recipesSummaryTotal => 'Total';

  @override
  String get recipesIngredientsTitle => 'Ingredientes';

  @override
  String get recipesNewIngredientTooltip => 'Nuevo ingrediente';

  @override
  String recipesIngredientsLoadError(String error) {
    return 'No se pudieron cargar los ingredientes: $error';
  }

  @override
  String get recipesIngredientsEmpty =>
      'Aún no hay ingredientes. Toca + para agregar uno.';

  @override
  String recipesIngredientSubtitle(
    String category,
    int kcal,
    int protein,
    int fat,
    int carbs,
  ) {
    return '$category · $kcal kcal · P $protein · G $fat · C $carbs por 100 g crudo';
  }

  @override
  String get recipesCategoryProtein => 'proteína';

  @override
  String get recipesCategoryCarb => 'carbohidrato';

  @override
  String get recipesCategoryVegetable => 'verdura';

  @override
  String get recipesCategoryFruit => 'fruta';

  @override
  String get recipesCategoryFat => 'grasa';

  @override
  String get recipesCategoryOther => 'otro';

  @override
  String get recipesEditIngredientTitle => 'Editar ingrediente';

  @override
  String get recipesNewIngredientTitle => 'Nuevo ingrediente';

  @override
  String get recipesDeleteTooltip => 'Eliminar';

  @override
  String get recipesFieldName => 'Nombre';

  @override
  String get recipesFieldCategory => 'Categoría';

  @override
  String get recipesPer100Raw => 'Por 100 g crudo';

  @override
  String get recipesFieldCalories => 'Calorías';

  @override
  String get recipesFieldProtein => 'Proteína';

  @override
  String get recipesFieldFat => 'Grasa';

  @override
  String get recipesFieldCarbs => 'Carbohidratos';

  @override
  String get recipesFieldFiber => 'Fibra';

  @override
  String recipesEnergyWarning(int kcal) {
    return 'Las calorías difieren en más de 15% de lo que suman las proteínas, grasas y carbohidratos (suman unas $kcal kcal). Aun así puedes guardar.';
  }

  @override
  String get recipesCountsAsFruit => 'Cuenta como una porción de fruta';

  @override
  String get recipesCountsAsVegetable => 'Cuenta como una porción de verdura';

  @override
  String get recipesServingLabel => 'Tamaño de porción (opcional)';

  @override
  String get recipesSaveIngredient => 'Guardar ingrediente';

  @override
  String get recipesEnterName => 'Ingresa un nombre';

  @override
  String get recipesIngredientNameTaken =>
      'Ya existe un ingrediente con este nombre';

  @override
  String recipesSaveIngredientError(String error) {
    return 'No se pudo guardar el ingrediente: $error';
  }

  @override
  String recipesDeleteIngredientTitle(String name) {
    return '¿Eliminar \"$name\"?';
  }

  @override
  String get recipesDeleteIngredientMessage =>
      'El ingrediente se quitará de tu biblioteca.';

  @override
  String get recipesIngredientInUse =>
      'Este ingrediente se usa en una receta o en una comida registrada, por lo que no se puede eliminar.';

  @override
  String get recipesCancel => 'Cancelar';

  @override
  String get recipesDelete => 'Eliminar';

  @override
  String get recipesNewRecipeTitle => 'Nueva receta';

  @override
  String get recipesEditRecipeTitle => 'Editar receta';

  @override
  String recipesLoadRecipeError(String error) {
    return 'No se pudo cargar la receta: $error';
  }

  @override
  String get recipesRecipeMissing => 'Esta receta ya no existe.';

  @override
  String get recipesFieldKind => 'Tipo';

  @override
  String get recipesYieldLabel =>
      'Factor de rendimiento esperado (cocido / crudo)';

  @override
  String get recipesYieldHelper =>
      'Peso cocido dividido entre peso crudo. La carne se encoge (aprox. 0.75); el arroz y la pasta absorben agua (aprox. 2.5).';

  @override
  String get recipesYieldRange => 'Debe ser mayor que 0 y como máximo 3';

  @override
  String get recipesLineRawLabel => 'Crudo';

  @override
  String get recipesRemoveIngredientTooltip => 'Quitar ingrediente';

  @override
  String get recipesLinesError => 'Agrega al menos un ingrediente';

  @override
  String get recipesAddIngredient => 'Agregar ingrediente';

  @override
  String get recipesSectionTools => 'Utensilios';

  @override
  String get recipesAddTool => 'Agregar utensilio';

  @override
  String get recipesSectionSteps => 'Pasos';

  @override
  String get recipesAddStep => 'Agregar paso';

  @override
  String get recipesFieldNotes => 'Notas (opcional)';

  @override
  String get recipesSaveRecipe => 'Guardar receta';

  @override
  String get recipesDeleteRecipe => 'Eliminar receta';

  @override
  String recipesSaveRecipeError(String error) {
    return 'No se pudo guardar la receta: $error';
  }

  @override
  String recipesDeleteRecipeTitle(String name) {
    return '¿Eliminar \"$name\"?';
  }

  @override
  String get recipesDeleteRecipeMessage =>
      'La receta y sus pasos se eliminarán. Esta acción no se puede deshacer.';

  @override
  String get recipesRecipeInUse =>
      'Esta receta se usa en una tanda cocinada, por lo que no se puede eliminar.';

  @override
  String get recipesToolNameLabel => 'Nombre del utensilio';

  @override
  String get recipesAddConfirm => 'Agregar';

  @override
  String get recipesDetailTitleFallback => 'Receta';

  @override
  String get recipesEditTooltip => 'Editar';

  @override
  String recipesRawGramsLine(int grams) {
    return '$grams g crudo';
  }

  @override
  String get recipesNoToolsSelected => 'No hay utensilios seleccionados.';

  @override
  String get recipesNoSteps => 'Aún no hay pasos.';

  @override
  String get recipesSectionNotes => 'Notas';

  @override
  String recipesStepTitle(int number) {
    return 'Paso $number';
  }

  @override
  String get recipesMoveUp => 'Subir';

  @override
  String get recipesMoveDown => 'Bajar';

  @override
  String get recipesRemoveStep => 'Quitar paso';

  @override
  String get recipesFieldTechnique => 'Técnica';

  @override
  String get recipesDescribeStep => 'Describe el paso';

  @override
  String get recipesFieldTemp => 'Temp.';

  @override
  String get recipesFieldTime => 'Tiempo';

  @override
  String get recipesFieldToolOptional => 'Utensilio (opcional)';

  @override
  String get recipesToolNone => 'Ninguno';

  @override
  String get recipesWholeNumber => 'Número entero';

  @override
  String get recipesSearchIngredients => 'Buscar ingredientes';

  @override
  String get recipesNoMatchingIngredients => 'No hay ingredientes coincidentes';
}
