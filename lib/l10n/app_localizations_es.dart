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
  String get shellTabToday => 'Hoy';

  @override
  String get shellTabRecipes => 'Recetas';

  @override
  String get shellTabPantry => 'Despensa';

  @override
  String get shellTabPlan => 'Plan';

  @override
  String get shellTabSettings => 'Ajustes';

  @override
  String get plannerTitle => 'Plan';

  @override
  String get plannerSectionDays => 'Días a cubrir';

  @override
  String get plannerSectionRecipes => 'Elegir recetas';

  @override
  String get plannerSectionResults => 'Resultados';

  @override
  String plannerBuildError(String error) {
    return 'No se pudo generar el plan: $error';
  }

  @override
  String get plannerChooseRecipesHint =>
      'Elige una base de proteína y una base de carbohidratos para ver cuánto cocinar.';

  @override
  String get plannerShoppingListButton => 'Lista de compras';

  @override
  String get plannerStartCooking => 'Empezar a cocinar';

  @override
  String get plannerSetupTargetsHint =>
      'Configura tus objetivos nutricionales en Ajustes para planificar una tanda.';

  @override
  String plannerShoppingTitle(String range) {
    return 'Lista de compras · $range';
  }

  @override
  String plannerDateRange(String from, String to) {
    return '$from - $to';
  }

  @override
  String get plannerFirstDay => 'Primer día';

  @override
  String get plannerNumberOfDays => 'Número de días';

  @override
  String get plannerDayTypeTraining => 'Entrenamiento';

  @override
  String get plannerDayTypeRest => 'Descanso';

  @override
  String plannerRangeDayWithType(String date, String type) {
    return '$date · $type';
  }

  @override
  String get plannerFreshTitle => 'Añadidos frescos';

  @override
  String get plannerFreshSubtitle =>
      'Se comen tal cual junto a la tanda (fruta, verduras crudas).';

  @override
  String get plannerRemove => 'Quitar';

  @override
  String get plannerAddFresh => 'Agregar ingrediente fresco';

  @override
  String get plannerGramsPerMeal => 'Gramos por comida';

  @override
  String get plannerCookedGramsPerMeal => 'Gramos cocidos por comida';

  @override
  String get plannerLeftoversTitle => 'Sobras de la despensa';

  @override
  String get plannerLeftoversSubtitle =>
      'La comida cocida que aún tienes se descuenta de lo que hay que cocinar.';

  @override
  String get plannerNoLeftovers => 'No queda comida cocida en la despensa.';

  @override
  String plannerLeftoverSubtitle(int grams, String date) {
    return '$grams g restantes · cocinado el $date';
  }

  @override
  String plannerNeed(int kcal, int protein, int carbs) {
    return 'Necesitas $kcal kcal · P $protein g · C $carbs g';
  }

  @override
  String plannerCovered(int kcal, int protein, int carbs) {
    return 'Cubierto $kcal kcal · P $protein g · C $carbs g';
  }

  @override
  String get plannerRoleProteinBase => 'Base de proteína';

  @override
  String get plannerRoleCarbBase => 'Base de carbohidratos';

  @override
  String get plannerRoleVegetable => 'Verdura (opcional)';

  @override
  String get plannerRoleSauce => 'Salsa (opcional)';

  @override
  String get plannerRoleProteinBaseHint =>
      'Dimensionada para alcanzar el objetivo de proteína';

  @override
  String get plannerRoleCarbBaseHint =>
      'Dimensionada para alcanzar el objetivo de carbohidratos';

  @override
  String get plannerRoleSideHint => 'Gramos cocidos fijos por comida';

  @override
  String get plannerChoose => 'Elegir';

  @override
  String get plannerChange => 'Cambiar';

  @override
  String get plannerNothingToCook =>
      'Nada que cocinar: el resto del plan ya lo cubre.';

  @override
  String plannerRawCooked(String raw, String cooked, String factor) {
    return 'Crudo $raw g · cocido $cooked g (rendimiento $factor)';
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
      other: '$count porciones de $grams g cocidos',
      one: '$count porción de $grams g cocidos',
    );
    return '$_temp0';
  }

  @override
  String get plannerPerPortion => 'Por porción';

  @override
  String get plannerBlockTotals => 'Totales de la tanda';

  @override
  String plannerTotalProtein(int covered, int target) {
    return 'Proteína $covered / $target g';
  }

  @override
  String plannerTotalCarbs(int covered, int target) {
    return 'Carbohidratos $covered / $target g';
  }

  @override
  String plannerTotalCalories(int covered, int target) {
    return 'Calorías $covered / $target kcal';
  }

  @override
  String plannerPerMeal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Por comida ($count comidas)',
      one: 'Por comida ($count comida)',
    );
    return '$_temp0';
  }

  @override
  String get plannerNutrientProtein => 'Proteína';

  @override
  String get plannerNutrientCarbs => 'Carbohidratos';

  @override
  String plannerResidualChip(String label, String grams, String percent) {
    return '$label $grams g ($percent%)';
  }

  @override
  String get plannerUncheckAll => 'Desmarcar todo';

  @override
  String get plannerShoppingEmpty =>
      'Aún no hay nada que comprar. Primero elige recetas en el plan.';

  @override
  String plannerShoppingProgress(int done, int total) {
    return '$done de $total marcados';
  }

  @override
  String get plannerCopyAsText => 'Copiar como texto';

  @override
  String get plannerShoppingCopied => 'Lista de compras copiada';

  @override
  String plannerAboutServings(int count, String grams) {
    return 'Aprox. $count x $grams g';
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
    return '- [ ] $grams g $name (aprox. $count x $serving g)';
  }

  @override
  String get plannerCategoryProtein => 'Proteína';

  @override
  String get plannerCategoryCarb => 'Carbohidratos';

  @override
  String get plannerCategoryVegetable => 'Verdura';

  @override
  String get plannerCategoryFruit => 'Fruta';

  @override
  String get plannerCategoryFat => 'Grasa';

  @override
  String get plannerCategoryOther => 'Otros';

  @override
  String get pantryTitle => 'Despensa';

  @override
  String get pantryComposeMeal => 'Armar una comida';

  @override
  String get pantryLogBatch => 'Registrar tanda cocinada';

  @override
  String pantryLoadError(String error) {
    return 'No se pudo cargar la despensa: $error';
  }

  @override
  String get pantryEmptyTitle => 'Tu despensa está vacía';

  @override
  String get pantryEmptyBody =>
      'Registra una tanda cocinada para llevar el control de lo que queda y armar comidas con ella.';

  @override
  String get pantryStatusEmpty => 'Vacío';

  @override
  String get pantryStatusLow => 'Poco';

  @override
  String pantryCooked(String date) {
    return 'Cocinado el $date';
  }

  @override
  String pantryGramsLeft(int left, int total) {
    return '$left g restantes de $total g';
  }

  @override
  String get pantryPer100Cooked => 'Por 100 g cocidos';

  @override
  String pantryPerTypicalPortion(int grams) {
    return 'Por porción típica de $grams g';
  }

  @override
  String get pantryConsumptionHistory => 'Historial de consumo';

  @override
  String pantryHistoryError(String error) {
    return 'No se pudo cargar el historial: $error';
  }

  @override
  String get pantryNotUsed => 'Aún no se usa en ninguna comida.';

  @override
  String pantryHistoryEntry(String date, int slot) {
    return '$date · Comida $slot';
  }

  @override
  String pantryDeleteTitle(String name) {
    return '¿Eliminar \"$name\"?';
  }

  @override
  String get pantryDeleteMessage =>
      'Este elemento de la tanda se quitará de tu despensa.';

  @override
  String get pantryDeleteBlocked =>
      'Este elemento de la tanda se usó en una comida, por lo que no se puede eliminar.';

  @override
  String get pantryBatchItemTitle => 'Elemento de la tanda';

  @override
  String get pantryDelete => 'Eliminar';

  @override
  String get pantryItemGone => 'Este elemento de la tanda ya no existe.';

  @override
  String get pantrySearchRecipes => 'Buscar recetas';

  @override
  String get pantryNoMatchingRecipes => 'No hay recetas que coincidan';

  @override
  String get pantryCookedOn => 'Cocinado el';

  @override
  String get pantryCoversFrom => 'Cubre desde';

  @override
  String get pantryCoversTo => 'Cubre hasta';

  @override
  String get pantryDatesError =>
      'La fecha final no puede ser anterior a la fecha inicial.';

  @override
  String get pantryBatchItems => 'Elementos de la tanda';

  @override
  String get pantryAddAtLeastOne => 'Agrega al menos un elemento a la tanda';

  @override
  String get pantryAddRecipe => 'Agregar receta';

  @override
  String get pantrySaveBatch => 'Guardar tanda';

  @override
  String pantrySaveError(String error) {
    return 'No se pudo guardar la tanda: $error';
  }

  @override
  String get pantryRemove => 'Quitar';

  @override
  String get pantryRawTotal => 'Total crudo';

  @override
  String get pantryCookedTotal => 'Total cocido';

  @override
  String pantryYieldExpects(String factor, int grams) {
    return 'La receta espera un rendimiento de $factor (aprox. $grams g cocidos)';
  }

  @override
  String pantryYieldMeasured(String measured, String expected) {
    return 'Rendimiento $measured (la receta espera $expected)';
  }

  @override
  String pantryYieldDeviation(int percent) {
    return 'El rendimiento medido difiere $percent% del de la receta. Vuelve a pesar si algo no cuadra.';
  }

  @override
  String get pantryUpdateYield =>
      'Actualizar el rendimiento de la receta a este valor';

  @override
  String get backupTitle => 'Copia de seguridad';

  @override
  String get backupPrivacyNote =>
      'Una copia de seguridad es un archivo JSON simple y sin cifrar con todos tus datos, incluidos tu peso corporal, tus objetivos diarios, recetas, comidas e hidratación. Compártela solo con personas y servicios de confianza.';

  @override
  String get backupExport => 'Exportar copia de seguridad';

  @override
  String get backupImport => 'Importar copia de seguridad';

  @override
  String get backupImportWarning =>
      'Al importar se borra todo lo que hay actualmente en la app y se reemplaza por el contenido de la copia de seguridad.';

  @override
  String get backupExportCancelled =>
      'Exportación cancelada. No se guardó ningún archivo.';

  @override
  String backupSaved(int rows, String counts) {
    String _temp0 = intl.Intl.pluralLogic(
      rows,
      locale: localeName,
      other: '$rows filas',
      one: '1 fila',
    );
    return 'Copia de seguridad guardada ($_temp0). $counts';
  }

  @override
  String get backupSaveFailed => 'No se pudo guardar la copia de seguridad.';

  @override
  String get backupRestoredTitle => 'Copia de seguridad restaurada';

  @override
  String backupRestoredBody(int rows, String counts) {
    String _temp0 = intl.Intl.pluralLogic(
      rows,
      locale: localeName,
      other: 'Se cargaron $rows filas.',
      one: 'Se cargó 1 fila.',
    );
    return '$_temp0 $counts';
  }

  @override
  String get backupImportFailedTitle => 'Error al importar';

  @override
  String backupImportFailedBody(String message) {
    return '$message\n\nTus datos actuales no se modificaron.';
  }

  @override
  String get backupImportFailedGeneric =>
      'No se pudo importar la copia de seguridad.';

  @override
  String get backupOk => 'Aceptar';

  @override
  String get backupCancel => 'Cancelar';

  @override
  String get backupConfirmTitle => '¿Reemplazar todos los datos?';

  @override
  String backupExportedOn(String stamp) {
    return 'Copia de seguridad exportada el $stamp.';
  }

  @override
  String get backupConfirmIntro =>
      'Todo lo que está guardado actualmente en la app se borrará y se reemplazará por:';

  @override
  String get backupEmptyBackup => 'Nada: esta copia de seguridad está vacía.';

  @override
  String get backupCannotUndo => 'Esta acción no se puede deshacer.';

  @override
  String get backupEraseAndImport => 'Borrar e importar';

  @override
  String get backupNoData => 'sin datos';

  @override
  String backupCountEntry(String label, int count) {
    return '$label: $count';
  }

  @override
  String get backupDialogSaveTitle => 'Guardar copia de seguridad';

  @override
  String get backupDialogPickTitle => 'Elegir una copia de seguridad';

  @override
  String get backupTableUserProfiles => 'Perfil';

  @override
  String get backupTableDayTypeTargetRows => 'Objetivos por tipo de día';

  @override
  String get backupTableWeekScheduleEntries => 'Días del calendario semanal';

  @override
  String get backupTableIngredients => 'Ingredientes';

  @override
  String get backupTableTools => 'Utensilios';

  @override
  String get backupTableRecipes => 'Recetas';

  @override
  String get backupTableRecipeIngredients =>
      'Líneas de ingredientes de recetas';

  @override
  String get backupTableRecipeSteps => 'Pasos de recetas';

  @override
  String get backupTableRecipeTools => 'Utensilios de recetas';

  @override
  String get backupTableBatchSessions => 'Sesiones de tanda';

  @override
  String get backupTableBatchItems => 'Elementos de la tanda';

  @override
  String get backupTableMealLogs => 'Comidas';

  @override
  String get backupTableMealComponents => 'Componentes de comidas';

  @override
  String get backupTableHydrationLogs => 'Registros de hidratación';

  @override
  String get backupTableDayLogs => 'Días de frutas y verduras';

  @override
  String get backupTableAppSettings => 'Ajustes de la app';

  @override
  String get backupErrorNotValidJson => 'Este archivo no es un JSON válido.';

  @override
  String get backupErrorNotABackup =>
      'Este archivo no es una copia de seguridad de Anti-recipes.';

  @override
  String backupErrorInvalidFormatVersion(int version) {
    return 'Versión de formato de la copia de seguridad no válida: $version.';
  }

  @override
  String backupErrorNewerFormatVersion(int version, int supported) {
    return 'Esta copia de seguridad usa el formato de archivo $version, que es más reciente de lo que esta app entiende (formato $supported). Actualiza la app e inténtalo de nuevo.';
  }

  @override
  String backupErrorInvalidSchemaVersion(int version) {
    return 'Versión de base de datos no válida: $version.';
  }

  @override
  String backupErrorNewerSchemaVersion(int version, int supported) {
    return 'Esta copia de seguridad fue creada con una versión más reciente de la app (versión de base de datos $version; esta app admite hasta la $supported). Actualiza la app e inténtalo de nuevo.';
  }

  @override
  String get backupErrorNoExportDate =>
      'La copia de seguridad no tiene una fecha de exportación válida.';

  @override
  String get backupErrorNoDataSection =>
      'La copia de seguridad no tiene una sección de datos.';

  @override
  String backupErrorUnknownTable(String table) {
    return 'La copia de seguridad contiene una tabla desconocida: \"$table\".';
  }

  @override
  String backupErrorMissingTable(String table) {
    return 'A la copia de seguridad le falta la tabla \"$table\".';
  }

  @override
  String backupErrorTableNotList(String table) {
    return '\"$table\" debe ser una lista de filas.';
  }

  @override
  String backupErrorRowNotObject(String label, int row) {
    return 'La fila $row de \"$label\" no es un objeto.';
  }

  @override
  String backupErrorUnknownColumn(String label, int row, String column) {
    return 'La fila $row de \"$label\" tiene una columna desconocida: \"$column\".';
  }

  @override
  String backupErrorMissingColumn(String label, int row, String column) {
    return 'A la fila $row de \"$label\" le falta \"$column\".';
  }

  @override
  String backupErrorMustBeDate(String label, int row, String column) {
    return 'En la fila $row de \"$label\", \"$column\" debe ser una fecha ISO 8601.';
  }

  @override
  String backupErrorMustBeBool(String label, int row, String column) {
    return 'En la fila $row de \"$label\", \"$column\" debe ser verdadero o falso.';
  }

  @override
  String backupErrorMustBeText(String label, int row, String column) {
    return 'En la fila $row de \"$label\", \"$column\" debe ser texto.';
  }

  @override
  String backupErrorMustBeWholeNumber(String label, int row, String column) {
    return 'En la fila $row de \"$label\", \"$column\" debe ser un número entero.';
  }

  @override
  String backupErrorMustBeNumber(String label, int row, String column) {
    return 'En la fila $row de \"$label\", \"$column\" debe ser un número.';
  }

  @override
  String backupErrorUnknownValue(
    String label,
    int row,
    String column,
    String value,
  ) {
    return 'En la fila $row de \"$label\", \"$column\" tiene un valor desconocido: \"$value\".';
  }

  @override
  String backupErrorMissingEnvelopeField(String field) {
    return 'La copia de seguridad no tiene un \"$field\" válido.';
  }

  @override
  String get backupErrorRestoreForeignKey =>
      'No se pudo restaurar la copia de seguridad porque una fila hace referencia a datos que no están en la copia.';

  @override
  String get backupErrorRestoreDuplicate =>
      'No se pudo restaurar la copia de seguridad porque contiene entradas duplicadas.';

  @override
  String get backupErrorRestoreOutOfRange =>
      'No se pudo restaurar la copia de seguridad porque un valor está fuera de su rango permitido.';

  @override
  String get backupErrorRestoreMissingValue =>
      'No se pudo restaurar la copia de seguridad porque falta un valor obligatorio.';

  @override
  String get backupErrorRestoreUnexpected =>
      'No se pudo restaurar la copia de seguridad debido a un error inesperado.';

  @override
  String get backupErrorNotTextFile =>
      'Este archivo no es un archivo de texto.';

  @override
  String get backupErrorUnreadable => 'No se pudo leer el archivo.';
}
