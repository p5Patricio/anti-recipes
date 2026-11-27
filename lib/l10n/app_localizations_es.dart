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
}
