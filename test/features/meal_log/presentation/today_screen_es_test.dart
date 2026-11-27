import 'package:anti_recipes/core/database/app_database.dart';
import 'package:anti_recipes/core/database/database_provider.dart';
import 'package:anti_recipes/core/l10n/l10n.dart';
import 'package:anti_recipes/core/theme/app_theme.dart';
import 'package:anti_recipes/features/meal_log/presentation/today_providers.dart';
import 'package:anti_recipes/features/meal_log/presentation/today_screen.dart';
import 'package:anti_recipes/features/nutrition_targets/presentation/nutrition_targets_screen.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/db_seed.dart';
import '../../../helpers/ui_helpers.dart';

void main() {
  late AppDatabase db;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
  });
  tearDown(() => db.close());

  Future<void> pumpSpanish(WidgetTester tester, Widget home) async {
    tester.view.physicalSize = const Size(900, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          todayProvider.overrideWithValue(monday),
        ],
        child: MaterialApp(
          theme: AppTheme.dark(),
          locale: const Locale('es'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: home,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  uiTest('Today dashboard renders in Spanish', (tester) async {
    await pumpSpanish(tester, const TodayScreen());

    expect(find.text('Hoy'), findsOneWidget);
    expect(find.text('Día de entrenamiento'), findsOneWidget);
    expect(find.text('Hidratación'), findsOneWidget);
    expect(find.text('Calorías y macros'), findsOneWidget);
    expect(
      find.text('Rango 2400-2500 kcal · Quedan 2450 kcal'),
      findsOneWidget,
    );
    expect(find.text('Hoy'), findsOneWidget);
    expect(find.text('Today'), findsNothing);
  });

  uiTest('Nutrition targets screen renders in Spanish', (tester) async {
    await pumpSpanish(tester, const NutritionTargetsScreen());

    expect(find.text('Objetivos nutricionales'), findsOneWidget);
    expect(find.text('Perfil'), findsOneWidget);
    expect(find.text('Plan semanal'), findsOneWidget);
    expect(find.text('lun'), findsOneWidget);
  });
}
