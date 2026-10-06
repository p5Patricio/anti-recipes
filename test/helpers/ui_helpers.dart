import 'package:anti_recipes/core/database/app_database.dart';
import 'package:anti_recipes/core/database/database_provider.dart';
import 'package:anti_recipes/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';

/// Widget test that unmounts the tree inside the test body, so drift's
/// stream-cleanup timers fire before the framework checks for pending timers.
void uiTest(String name, Future<void> Function(WidgetTester tester) body) {
  testWidgets(name, (tester) async {
    await body(tester);
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(milliseconds: 10));
  });
}

/// Mounts [home] on a tall phone-like surface backed by [db]; [overrides]
/// are applied on top of the database override.
Future<void> pumpWithDb(
  WidgetTester tester,
  AppDatabase db,
  Widget home, {
  List<Override> overrides = const [],
}) async {
  tester.view.physicalSize = const Size(900, 1600);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [appDatabaseProvider.overrideWithValue(db), ...overrides],
      child: MaterialApp(theme: AppTheme.light(), home: home),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> enterKey(WidgetTester tester, String key, String text) async {
  final finder = find.byKey(Key(key));
  await tester.ensureVisible(finder);
  await tester.enterText(finder, text);
  await tester.pump();
}

Future<void> tapKey(WidgetTester tester, String key) async {
  final finder = find.byKey(Key(key));
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

/// Current text of the [TextFormField] (or [NumberField]) with the given key.
String fieldText(WidgetTester tester, String key) => tester
    .widget<TextFormField>(
      find.descendant(
        of: find.byKey(Key(key)),
        matching: find.byType(TextFormField),
      ),
    )
    .controller!
    .text;
