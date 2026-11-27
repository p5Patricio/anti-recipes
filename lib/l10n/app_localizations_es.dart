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

  @override
  String get mealLogToday => 'Hoy';

  @override
  String mealLogLoadDayError(String error) {
    return 'No se pudo cargar el día: $error';
  }

  @override
  String mealLogDeleteMealTitle(int slot) {
    return '¿Eliminar la comida $slot?';
  }

  @override
  String mealLogDeleteMealMessage(String date) {
    return 'Esto quita la comida de $date y devuelve su stock a la despensa.';
  }

  @override
  String get mealLogDeleteMealFailed => 'No se pudo eliminar la comida.';

  @override
  String get mealLogSetupTargetsHint =>
      'Configura tus objetivos nutricionales en Ajustes para ver tu progreso diario.';

  @override
  String get mealLogStatusOnTarget => 'En el objetivo';

  @override
  String get mealLogStatusBelow => 'Por debajo';

  @override
  String get mealLogStatusAbove => 'Por encima';

  @override
  String mealLogCaloriesStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'within': 'Calorías · En el objetivo',
      'below': 'Calorías · Por debajo',
      'above': 'Calorías · Por encima',
      'other': 'Calorías',
    });
    return '$_temp0';
  }

  @override
  String mealLogFiberStatus(String status) {
    String _temp0 = intl.Intl.selectLogic(status, {
      'within': 'Fibra · En el objetivo',
      'below': 'Fibra · Por debajo',
      'above': 'Fibra · Por encima',
      'other': 'Fibra',
    });
    return '$_temp0';
  }

  @override
  String get mealLogPreviousDay => 'Día anterior';

  @override
  String get mealLogNextDay => 'Día siguiente';

  @override
  String get mealLogTrainingDay => 'Día de entrenamiento';

  @override
  String get mealLogRestDay => 'Día de descanso';

  @override
  String get mealLogHydrationTitle => 'Hidratación';

  @override
  String get mealLogWater => 'Agua';

  @override
  String mealLogGoalRange(String range) {
    return 'Meta $range';
  }

  @override
  String get mealLogCustom => 'Otra cantidad';

  @override
  String get mealLogUndoLast => 'Deshacer último';

  @override
  String get mealLogMacrosTitle => 'Calorías y macros';

  @override
  String get mealLogCalories => 'Calorías';

  @override
  String get mealLogProtein => 'Proteína';

  @override
  String get mealLogFat => 'Grasa';

  @override
  String get mealLogCarbs => 'Carbohidratos';

  @override
  String get mealLogFiber => 'Fibra';

  @override
  String mealLogRemaining(String state, int amount, String unit) {
    String _temp0 = intl.Intl.selectLogic(state, {
      'left': 'Quedan $amount $unit',
      'over': '$amount $unit de más',
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
      'left': 'Rango $range · Quedan $amount $unit',
      'over': 'Rango $range · $amount $unit de más',
      'other': 'Rango $range',
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
      'left': 'Configurado $range · Quedan $amount $unit',
      'over': 'Configurado $range · $amount $unit de más',
      'other': 'Configurado $range',
    });
    return '$_temp0';
  }

  @override
  String mealLogRangeOnly(String range) {
    return 'Rango $range';
  }

  @override
  String mealLogCarbsDerivedInfo(int grams) {
    return 'El objetivo de carbohidratos de $grams g se deriva de las calorías y queda fuera del rango configurado.';
  }

  @override
  String mealLogMealN(int slot) {
    return 'Comida $slot';
  }

  @override
  String get mealLogEditMeal => 'Editar comida';

  @override
  String get mealLogDeleteMeal => 'Eliminar comida';

  @override
  String get mealLogComposeMeal => 'Armar comida';

  @override
  String mealLogSlotTotals(int kcal, int protein, int fat, int carbs) {
    return '$kcal kcal · P $protein · G $fat · C $carbs';
  }

  @override
  String mealLogSlotProteinOnTarget(int grams) {
    return 'Proteína $grams g · en el objetivo';
  }

  @override
  String mealLogSlotProteinBelow(int grams, String range) {
    return 'Proteína $grams g · por debajo de $range';
  }

  @override
  String mealLogSlotProteinAbove(int grams, String range) {
    return 'Proteína $grams g · por encima de $range';
  }

  @override
  String mealLogMealProteinOnTarget(String range) {
    return 'Proteína en el objetivo ($range)';
  }

  @override
  String mealLogMealProteinBelow(int grams, String range) {
    return 'Proteína $grams g por debajo de $range';
  }

  @override
  String mealLogMealProteinAbove(int grams, String range) {
    return 'Proteína $grams g por encima de $range';
  }

  @override
  String mealLogDayRemaining(String dayType, int kcal, int carbs) {
    String _temp0 = intl.Intl.selectLogic(dayType, {
      'training':
          'Restante hoy después de esta comida (día de entrenamiento): $kcal kcal · $carbs g de carbohidratos',
      'rest':
          'Restante hoy después de esta comida (día de descanso): $kcal kcal · $carbs g de carbohidratos',
      'other':
          'Restante hoy después de esta comida: $kcal kcal · $carbs g de carbohidratos',
    });
    return '$_temp0';
  }

  @override
  String get mealLogPantryEmpty => 'No queda nada en la despensa.';

  @override
  String mealLogPantryItemSubtitle(int grams, String date) {
    return 'Quedan $grams g · cocinado el $date';
  }

  @override
  String get mealLogProteinPerMealTitle => 'Proteína por comida';

  @override
  String mealLogProteinBand(String range) {
    return 'Banda $range';
  }

  @override
  String get mealLogServingsTitle => 'Frutas y verduras';

  @override
  String get mealLogFruit => 'Fruta';

  @override
  String get mealLogVegetables => 'Verduras';

  @override
  String mealLogPortionsGoal(String range) {
    return 'Meta $range porciones';
  }

  @override
  String mealLogRemovePortion(String label) {
    return 'Quitar una porción de $label';
  }

  @override
  String mealLogAddPortion(String label) {
    return 'Agregar una porción de $label';
  }

  @override
  String get mealLogAddWaterTitle => 'Agregar agua';

  @override
  String get mealLogAmount => 'Cantidad';

  @override
  String mealLogAtMostMl(int max) {
    return 'Máximo $max ml';
  }

  @override
  String get mealLogCancel => 'Cancelar';

  @override
  String get mealLogAdd => 'Agregar';

  @override
  String get mealLogRemove => 'Quitar';

  @override
  String get mealLogAllRemaining => 'Todo lo que queda';

  @override
  String mealLogComposerLoadError(String error) {
    return 'No se pudo cargar el armado de comidas: $error';
  }

  @override
  String get mealLogComposeSetupHint =>
      'Configura tus objetivos nutricionales en Ajustes para armar comidas.';

  @override
  String get mealLogNoProteinToSuggest =>
      'Este ingrediente no tiene proteína para calcular una sugerencia.';

  @override
  String mealLogOnlyLeftBelowTarget(int grams) {
    return 'Solo quedan $grams g, por lo que la proteína queda por debajo del objetivo.';
  }

  @override
  String get mealLogNotEnoughTitle => 'No hay suficiente en la despensa';

  @override
  String mealLogNotEnoughMessage(String names) {
    return 'Ingresaste más de lo que queda de $names. Al guardar, el stock quedará por debajo de cero.';
  }

  @override
  String get mealLogSaveAnyway => 'Guardar de todos modos';

  @override
  String mealLogSaveError(String error) {
    return 'No se pudo guardar la comida: $error';
  }

  @override
  String mealLogFromPantry(int grams) {
    return 'De la despensa · $grams g disponibles';
  }

  @override
  String get mealLogFreshIngredient => 'Ingrediente fresco';

  @override
  String mealLogOnlyLeftInPantry(int grams) {
    return 'Solo quedan $grams g en la despensa.';
  }

  @override
  String get mealLogAddAtLeastOne => 'Agrega al menos un componente';

  @override
  String get mealLogAddFromPantry => 'Agregar de la despensa';

  @override
  String get mealLogAddFresh => 'Agregar ingrediente fresco';

  @override
  String get mealLogSuggestProtein =>
      'Sugerir para alcanzar el objetivo de proteína';

  @override
  String get mealLogSuggestHint =>
      'Agrega un ingrediente base de proteína de la despensa para obtener una sugerencia.';

  @override
  String get mealLogSaveMeal => 'Guardar comida';

  @override
  String get targetsTitle => 'Objetivos nutricionales';

  @override
  String targetsLoadError(String error) {
    return 'No se pudieron cargar los objetivos: $error';
  }

  @override
  String targetsHintProteinPerKg(String value) {
    return 'Proteína: $value g/kg';
  }

  @override
  String targetsHintFatPerKg(String value) {
    return 'Grasa: $value g/kg';
  }

  @override
  String targetsHintProteinPerMeal(String value) {
    return 'Objetivo de proteína por comida: $value g';
  }

  @override
  String get targetsInvalidIncomplete =>
      'Datos no válidos: completa todos los campos';

  @override
  String get targetsInvalidMeals =>
      'Datos no válidos: las comidas por día deben ser un número entero';

  @override
  String get targetsInvalidValues =>
      'Datos no válidos: revisa los valores e inténtalo de nuevo';

  @override
  String get targetsSaved => 'Objetivos nutricionales guardados';

  @override
  String get targetsResetTitle => '¿Restablecer a los valores de ejemplo?';

  @override
  String get targetsResetMessage =>
      'Esto reemplaza los valores del formulario. No cambia nada hasta que guardes.';

  @override
  String get targetsCancel => 'Cancelar';

  @override
  String get targetsReset => 'Restablecer';

  @override
  String get targetsSave => 'Guardar';

  @override
  String get targetsResetToDefaults => 'Restablecer a los valores de ejemplo';

  @override
  String get targetsProfile => 'Perfil';

  @override
  String get targetsBodyWeight => 'Peso corporal (opcional)';

  @override
  String get targetsProtein => 'Proteína';

  @override
  String get targetsFat => 'Grasa';

  @override
  String get targetsMealsPerDay => 'Comidas por día';

  @override
  String get targetsProteinPerMeal => 'Proteína por comida';

  @override
  String get targetsFieldCalories => 'Calorías';

  @override
  String get targetsFieldCarbs => 'Carbohidratos';

  @override
  String get targetsFieldFiber => 'Fibra';

  @override
  String get targetsFieldWater => 'Agua';

  @override
  String get targetsFieldFruit => 'Fruta';

  @override
  String get targetsFieldVegetables => 'Verduras';

  @override
  String get targetsUnitPortions => 'porciones';

  @override
  String targetsRangeMin(String label) {
    return '$label mín.';
  }

  @override
  String targetsRangeMax(String label) {
    return '$label máx.';
  }

  @override
  String get targetsMustBeAtLeastMin => 'Debe ser al menos el mínimo';

  @override
  String get targetsTrainingDay => 'Día de entrenamiento';

  @override
  String get targetsRestDay => 'Día de descanso';

  @override
  String get targetsDerivedCarbsNone => 'Carbohidratos derivados: -';

  @override
  String targetsDerivedCarbs(int grams) {
    return 'Carbohidratos derivados con calorías medias: $grams g';
  }

  @override
  String get targetsCarbsOutsideRange =>
      'Los carbohidratos derivados están fuera del rango configurado';

  @override
  String get targetsCarbsExplain =>
      'Los carbohidratos se derivan de las calorías que quedan después de la proteína y la grasa.';

  @override
  String get targetsWeeklySchedule => 'Plan semanal';

  @override
  String get targetsScheduleHint =>
      'Las etiquetas seleccionadas son días de entrenamiento; el resto son días de descanso.';

  @override
  String get targetsScheduleTraining => 'Entrenamiento';

  @override
  String get targetsScheduleRest => 'Descanso';

  @override
  String get targetsWeeklyAverageNone => 'Promedio semanal: -';

  @override
  String targetsWeeklyAverage(int kcal) {
    return 'Promedio semanal: $kcal kcal/día';
  }
}
