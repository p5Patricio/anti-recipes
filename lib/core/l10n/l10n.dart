import 'package:flutter/widgets.dart';

import '../../l10n/app_localizations.dart';

export '../../l10n/app_localizations.dart';

extension AppLocalizationsContext on BuildContext {
  /// Shortcut for `AppLocalizations.of(this)`.
  AppLocalizations get l10n => AppLocalizations.of(this);
}
