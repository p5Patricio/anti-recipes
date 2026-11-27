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
}
