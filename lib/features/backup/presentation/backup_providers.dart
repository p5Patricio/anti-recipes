import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/widgets.dart' show Locale;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/l10n/locale_provider.dart';
import '../../../l10n/app_localizations.dart';
import '../data/backup_service.dart';
import '../data/file_picker_backup_file_gateway.dart';
import '../domain/backup_file_gateway.dart';

/// The platform file dialogs live outside the widget tree, so their titles
/// are resolved here with the same rule as the app: the user's override, else
/// the system language, else English.
final backupFileGatewayProvider = Provider<BackupFileGateway>((ref) {
  final override = ref.watch(localeProvider);
  final code =
      override?.languageCode ?? PlatformDispatcher.instance.locale.languageCode;
  final supported = AppLocalizations.supportedLocales.any(
    (l) => l.languageCode == code,
  );
  final l10n = lookupAppLocalizations(Locale(supported ? code : 'en'));
  return FilePickerBackupFileGateway(
    saveDialogTitle: l10n.backupDialogSaveTitle,
    pickDialogTitle: l10n.backupDialogPickTitle,
  );
});

final backupServiceProvider = Provider<BackupService>(
  (ref) => BackupService(ref.watch(appDatabaseProvider)),
);
