import 'package:anti_recipes/core/database/app_database.dart';
import 'package:anti_recipes/core/database/database_provider.dart';
import 'package:anti_recipes/core/l10n/l10n.dart';
import 'package:anti_recipes/core/theme/app_theme.dart';
import 'package:anti_recipes/features/recipes/presentation/recipes_screen.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/ui_helpers.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  uiTest('recipes screen renders Spanish copy for the es locale', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: MaterialApp(
          theme: AppTheme.dark(),
          locale: const Locale('es'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const RecipesScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Recetas'), findsOneWidget);
    expect(find.text('Todas'), findsOneWidget);
    expect(find.text('Base de proteína'), findsOneWidget);
    expect(find.text('Aún no hay recetas'), findsOneWidget);
    expect(find.text('No recipes yet'), findsNothing);
  });
}
