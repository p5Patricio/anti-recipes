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
