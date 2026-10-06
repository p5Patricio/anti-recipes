import 'package:anti_recipes/core/database/app_database.dart';
import 'package:anti_recipes/core/database/database_provider.dart';
import 'package:anti_recipes/core/theme/app_theme.dart';
import 'package:anti_recipes/features/recipes/data/recipes_dao.dart';
import 'package:anti_recipes/features/recipes/domain/recipe_kind.dart';
import 'package:anti_recipes/features/recipes/presentation/ingredient_library_screen.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  /// Unmounts the tree inside the test so drift's stream-cleanup timers fire
  /// before the framework's pending-timer invariant is checked.
  void uiTest(String name, Future<void> Function(WidgetTester tester) body) {
    testWidgets(name, (tester) async {
      await body(tester);
      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(milliseconds: 10));
    });
  }

  Future<void> pumpScreen(WidgetTester tester) async {
    tester.view.physicalSize = const Size(900, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(db)],
        child: MaterialApp(
          theme: AppTheme.light(),
          home: const IngredientLibraryScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> enter(WidgetTester tester, String key, String text) async {
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

  Future<Ingredient> byName(String name) => (db.select(
    db.ingredients,
  )..where((i) => i.name.equals(name))).getSingle();

  Future<void> fillMacros(
    WidgetTester tester, {
    String kcal = '144',
    String protein = '15',
    String fat = '9',
    String carbs = '3',
    String fiber = '2',
  }) async {
    await enter(tester, 'ingredient-kcal', kcal);
    await enter(tester, 'ingredient-protein', protein);
    await enter(tester, 'ingredient-fat', fat);
    await enter(tester, 'ingredient-carbs', carbs);
    await enter(tester, 'ingredient-fiber', fiber);
  }

  uiTest('lists the seeded ingredients', (tester) async {
    await pumpScreen(tester);
    expect(find.text('Chicken breast'), findsOneWidget);
  });

  uiTest('validates required fields and does not save', (tester) async {
    await pumpScreen(tester);
    await tapKey(tester, 'add-ingredient');
    await tapKey(tester, 'save-ingredient');

    expect(find.text('Enter a name'), findsOneWidget);
    expect(find.text('Enter a number'), findsNWidgets(5));
    expect(find.byKey(const Key('save-ingredient')), findsOneWidget);
  });

  uiTest('rejects a duplicate name', (tester) async {
    await pumpScreen(tester);
    await tapKey(tester, 'add-ingredient');
    await enter(tester, 'ingredient-name', 'chicken BREAST');
    await fillMacros(tester);
    await tapKey(tester, 'save-ingredient');

    expect(
      find.text('An ingredient with this name already exists'),
      findsOneWidget,
    );
  });

  uiTest('creates an ingredient', (tester) async {
    await pumpScreen(tester);
    await tapKey(tester, 'add-ingredient');
    await enter(tester, 'ingredient-name', 'Firm tofu');
    await fillMacros(tester);
    await enter(tester, 'ingredient-serving', '100');
    await tapKey(tester, 'ingredient-is-vegetable');
    await tapKey(tester, 'save-ingredient');

    final tofu = await byName('Firm tofu');
    expect(tofu.kcal100, 144);
    expect(tofu.fiber100, 2);
    expect(tofu.servingG, 100);
    expect(tofu.isVegetable, isTrue);
    expect(tofu.isFruit, isFalse);
    expect(find.text('Firm tofu'), findsOneWidget);
  });

  uiTest('warns about inconsistent calories but still saves', (tester) async {
    await pumpScreen(tester);
    await tapKey(tester, 'add-ingredient');
    await enter(tester, 'ingredient-name', 'Mystery bar');
    await fillMacros(tester, kcal: '500', protein: '10', fat: '5', carbs: '20');
    expect(find.byKey(const Key('energy-warning')), findsOneWidget);

    await fillMacros(tester, kcal: '165', protein: '10', fat: '5', carbs: '20');
    expect(find.byKey(const Key('energy-warning')), findsNothing);

    await fillMacros(tester, kcal: '500', protein: '10', fat: '5', carbs: '20');
    await tapKey(tester, 'save-ingredient');
    expect((await byName('Mystery bar')).kcal100, 500);
  });

  uiTest('edits an ingredient', (tester) async {
    await pumpScreen(tester);
    final rice = await byName('White rice');
    await tapKey(tester, 'ingredient-${rice.id}');
    await enter(tester, 'ingredient-name', 'Jasmine rice');
    await tapKey(tester, 'save-ingredient');

    expect((await byName('Jasmine rice')).id, rice.id);
    expect(find.text('Jasmine rice'), findsOneWidget);
  });

  uiTest('deletes an unused ingredient', (tester) async {
    await pumpScreen(tester);
    final oil = await byName('Olive oil');
    await tapKey(tester, 'ingredient-${oil.id}');
    await tapKey(tester, 'delete-ingredient');
    await tapKey(tester, 'confirm-delete');

    expect(find.text('Olive oil'), findsNothing);
    expect(
      await (db.select(
        db.ingredients,
      )..where((i) => i.id.equals(oil.id))).get(),
      isEmpty,
    );
  });

  uiTest('an ingredient used by a recipe cannot be deleted', (tester) async {
    final chicken = await byName('Chicken breast');
    await db.recipesDao.saveRecipe(
      RecipeDraft(
        name: 'Plain chicken',
        kind: RecipeKind.proteinBase,
        ingredients: [
          RecipeIngredientDraft(ingredientId: chicken.id, rawG: 300),
        ],
      ),
    );
    await pumpScreen(tester);
    await tapKey(tester, 'ingredient-${chicken.id}');
    await tapKey(tester, 'delete-ingredient');
    await tapKey(tester, 'confirm-delete');

    expect(find.textContaining('cannot be deleted'), findsOneWidget);
    expect((await byName('Chicken breast')).id, chicken.id);
  });
}
