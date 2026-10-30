import 'package:anti_recipes/core/database/app_database.dart';
import 'package:anti_recipes/features/recipes/domain/recipe_kind.dart';
import 'package:anti_recipes/features/recipes/presentation/recipes_screen.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/db_seed.dart' as seed;
import '../../../helpers/db_seed.dart' show ingredientIdByName;
import '../../../helpers/ui_helpers.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  Future<void> pumpScreen(WidgetTester tester) =>
      pumpWithDb(tester, db, const RecipesScreen());

  Future<int> ingredientId(String name) => ingredientIdByName(db, name);

  Future<int> seedRecipe(
    String name, {
    RecipeKind kind = RecipeKind.proteinBase,
    double yieldFactor = 0.75,
  }) => seed.seedRecipe(db, name, kind: kind, yieldFactor: yieldFactor);

  uiTest('empty state invites creating the first recipe', (tester) async {
    await pumpScreen(tester);
    expect(find.text('No recipes yet'), findsOneWidget);
    expect(find.byKey(const Key('add-recipe')), findsOneWidget);
  });

  uiTest('creates a recipe end to end and shows macros per 100 g', (
    tester,
  ) async {
    await pumpScreen(tester);
    await tapKey(tester, 'add-recipe');

    await enterKey(tester, 'recipe-name', 'Lemon chicken');
    await tapKey(tester, 'recipe-kind');
    await tester.tap(find.text('Complete').last);
    await tester.pumpAndSettle();
    await enterKey(tester, 'recipe-yield', '0.75');

    await tapKey(tester, 'add-ingredient-line');
    await tester.enterText(find.byKey(const Key('ingredient-search')), 'chick');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Chicken breast'));
    await tester.pumpAndSettle();
    final chickenId = await ingredientId('Chicken breast');
    await enterKey(tester, 'line-grams-$chickenId', '400');

    expect(find.text('Raw weight: 400 g'), findsOneWidget);
    expect(find.text('Expected cooked weight: 300 g'), findsOneWidget);

    await tapKey(tester, 'save-recipe');

    expect(find.byKey(const Key('save-recipe')), findsNothing);
    expect(find.text('Lemon chicken'), findsOneWidget);
    expect(find.text('Complete · yield 0.75'), findsOneWidget);
    // 480 kcal / 90 g protein / 10.4 g fat over 300 g cooked, per 100 g.
    expect(find.text('160 kcal · P 30 · F 3 · C 0 · Fiber 0'), findsOneWidget);
    final saved = (await db.select(db.recipes).get()).single;
    expect(saved.kind, RecipeKind.complete);
    expect(saved.expectedYieldFactor, 0.75);
  });

  uiTest('rejects a recipe without name, ingredients or valid yield', (
    tester,
  ) async {
    await pumpScreen(tester);
    await tapKey(tester, 'add-recipe');
    await enterKey(tester, 'recipe-yield', '3.5');
    await tapKey(tester, 'save-recipe');

    expect(find.text('Enter a name'), findsOneWidget);
    expect(find.text('Must be above 0 and at most 3'), findsOneWidget);
    expect(find.byKey(const Key('lines-error')), findsOneWidget);
    expect(await db.select(db.recipes).get(), isEmpty);
  });

  uiTest('steps can be reordered, tools selected and added', (tester) async {
    await pumpScreen(tester);
    await tapKey(tester, 'add-recipe');
    await enterKey(tester, 'recipe-name', 'Sheet pan chicken');
    await tapKey(tester, 'add-ingredient-line');
    await tester.tap(find.text('Chicken breast'));
    await tester.pumpAndSettle();
    final chickenId = await ingredientId('Chicken breast');
    await enterKey(tester, 'line-grams-$chickenId', '500');

    await tapKey(tester, 'add-step');
    await tapKey(tester, 'add-step');
    await enterKey(tester, 'step-technique-0', 'Season');
    await enterKey(tester, 'step-technique-1', 'Roast');
    await enterKey(tester, 'step-temp-1', '200');
    await enterKey(tester, 'step-minutes-1', '25');
    await tapKey(tester, 'step-down-0');

    final oven = (await db.select(db.tools).get()).firstWhere(
      (t) => t.name == 'Oven',
    );
    await tapKey(tester, 'tool-chip-${oven.id}');
    await tapKey(tester, 'add-tool');
    await tester.enterText(find.byKey(const Key('new-tool-name')), 'Blender');
    await tester.tap(find.byKey(const Key('confirm-add-tool')));
    await tester.pumpAndSettle();
    await tapKey(tester, 'save-recipe');

    final id = (await db.select(db.recipes).get()).single.id;
    final detail = (await db.recipesDao.getRecipeDetail(id))!;
    expect(detail.steps.map((s) => s.technique), ['Roast', 'Season']);
    expect(detail.steps.first.tempC, 200);
    expect(detail.steps.first.minutes, 25);
    expect(detail.tools.map((t) => t.name).toSet(), {'Oven', 'Blender'});
  });

  uiTest('kind chips filter the list', (tester) async {
    await seedRecipe('Grilled chicken');
    await seedRecipe('Garlic sauce', kind: RecipeKind.sauce, yieldFactor: 1);
    await pumpScreen(tester);
    expect(find.text('Grilled chicken'), findsOneWidget);
    expect(find.text('Garlic sauce'), findsOneWidget);

    await tapKey(tester, 'filter-sauce');
    expect(find.text('Grilled chicken'), findsNothing);
    expect(find.text('Garlic sauce'), findsOneWidget);

    await tapKey(tester, 'filter-carbBase');
    expect(find.text('Nothing in this group yet'), findsOneWidget);

    await tapKey(tester, 'filter-all');
    expect(find.text('Grilled chicken'), findsOneWidget);
  });

  uiTest('detail shows the recipe and edit saves changes', (tester) async {
    final id = await seedRecipe('Grilled chicken');
    await pumpScreen(tester);
    await tapKey(tester, 'recipe-card-$id');

    expect(find.text('Chicken breast'), findsOneWidget);
    expect(find.text('400 g raw'), findsOneWidget);

    await tapKey(tester, 'edit-recipe');
    await enterKey(tester, 'recipe-name', 'Smoked chicken');
    await enterKey(tester, 'recipe-yield', '0.5');
    await tapKey(tester, 'save-recipe');

    expect(find.text('Smoked chicken'), findsWidgets);
    final detail = (await db.recipesDao.getRecipeDetail(id))!;
    expect(detail.recipe.name, 'Smoked chicken');
    expect(detail.recipe.expectedYieldFactor, 0.5);
    // 480 kcal over 200 g cooked.
    expect(find.textContaining('240 kcal'), findsWidgets);
  });

  uiTest('deletes a recipe from the detail after confirmation', (tester) async {
    final id = await seedRecipe('Grilled chicken');
    await pumpScreen(tester);
    await tapKey(tester, 'recipe-card-$id');
    await tapKey(tester, 'delete-recipe');
    expect(find.text('Delete "Grilled chicken"?'), findsOneWidget);
    await tapKey(tester, 'confirm-delete');

    expect(find.text('No recipes yet'), findsOneWidget);
    expect(await db.recipesDao.getRecipeDetail(id), isNull);
  });

  uiTest('delete from the editor returns to the list', (tester) async {
    final id = await seedRecipe('Grilled chicken');
    await pumpScreen(tester);
    await tapKey(tester, 'recipe-card-$id');
    await tapKey(tester, 'edit-recipe');
    await tapKey(tester, 'delete-recipe-editor');
    await tapKey(tester, 'confirm-delete');

    expect(find.text('No recipes yet'), findsOneWidget);
  });

  uiTest('a recipe used by a batch cannot be deleted', (tester) async {
    final id = await seedRecipe('Grilled chicken');
    final session = await db
        .into(db.batchSessions)
        .insert(
          BatchSessionsCompanion.insert(
            cookedOn: DateTime(2026, 1, 1),
            coversFrom: DateTime(2026, 1, 1),
            coversTo: DateTime(2026, 1, 4),
          ),
        );
    await db
        .into(db.batchItems)
        .insert(
          BatchItemsCompanion.insert(
            batchSessionId: session,
            recipeId: id,
            rawTotalG: 400,
            cookedTotalG: 300,
          ),
        );
    await pumpScreen(tester);
    await tapKey(tester, 'recipe-card-$id');
    await tapKey(tester, 'delete-recipe');
    await tapKey(tester, 'confirm-delete');

    expect(
      find.text(
        'This recipe is used by a cooked batch, so it cannot be deleted.',
      ),
      findsOneWidget,
    );
    expect(await db.recipesDao.getRecipeDetail(id), isNotNull);
  });
}
