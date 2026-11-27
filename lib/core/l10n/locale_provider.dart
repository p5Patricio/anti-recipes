import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/database_provider.dart';

const appLocaleSettingKey = 'app_locale';

/// Languages the app ships translations for.
const supportedLanguageCodes = ['en', 'es'];

/// The user's language override, or null to follow the system language.
class LocaleNotifier extends Notifier<Locale?> {
  @override
  Locale? build() {
    unawaited(_load());
    return null;
  }

  Future<void> _load() async {
    final code = await ref
        .read(settingsDaoProvider)
        .getSetting(appLocaleSettingKey);
    if (code != null && supportedLanguageCodes.contains(code)) {
      state = Locale(code);
    }
  }

  /// Sets the language override; pass null to follow the system language.
  Future<void> setLocale(Locale? locale) async {
    state = locale;
    final dao = ref.read(settingsDaoProvider);
    if (locale == null) {
      await dao.deleteSetting(appLocaleSettingKey);
    } else {
      await dao.setSetting(appLocaleSettingKey, locale.languageCode);
    }
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale?>(
  LocaleNotifier.new,
);
