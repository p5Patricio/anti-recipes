import 'package:anti_recipes/app.dart';
import 'package:anti_recipes/core/database/app_database.dart';
import 'package:anti_recipes/core/database/database_provider.dart';
import 'package:anti_recipes/core/l10n/locale_provider.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/ui_helpers.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(900, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: const AntiRecipesApp(),
      ),
    );
    await tester.pumpAndSettle();
  }

  uiTest('choosing Spanish switches the app language and persists it', (
    tester,
  ) async {
    await pumpApp(tester);
    await tester.tap(find.text('Settings').last);
    await tester.pumpAndSettle();

    await tapKey(tester, 'language-tile');
    await tapKey(tester, 'language-option-es');

    expect(find.text('Ajustes'), findsWidgets);
    expect(find.text('Idioma'), findsOneWidget);
    expect(await db.settingsDao.getSetting(appLocaleSettingKey), 'es');

    final tools = {for (final t in await db.select(db.tools).get()) t.name};
    expect(tools, contains('Horno'));
    expect(tools, isNot(contains('Oven')));
  });

  uiTest('a stored language preference is applied on startup', (tester) async {
    await db.settingsDao.setSetting(appLocaleSettingKey, 'es');
    await pumpApp(tester);

    expect(find.text('Ajustes'), findsWidgets);
    expect(find.text('Settings'), findsNothing);
  });

  uiTest('choosing the system default clears the stored preference', (
    tester,
  ) async {
    await db.settingsDao.setSetting(appLocaleSettingKey, 'es');
    await pumpApp(tester);
    await tester.tap(find.text('Ajustes').last);
    await tester.pumpAndSettle();

    await tapKey(tester, 'language-tile');
    await tapKey(tester, 'language-option-system');

    expect(await db.settingsDao.getSetting(appLocaleSettingKey), isNull);
  });
}
