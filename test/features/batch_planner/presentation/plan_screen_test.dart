import 'package:anti_recipes/core/database/app_database.dart';
import 'package:anti_recipes/core/theme/app_colors.dart';
import 'package:anti_recipes/features/batch_planner/presentation/plan_screen.dart';
import 'package:anti_recipes/features/meal_log/presentation/today_providers.dart';
import 'package:anti_recipes/features/recipes/data/recipes_dao.dart';
import 'package:anti_recipes/features/recipes/domain/recipe_kind.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/db_seed.dart';
import '../../../helpers/ui_helpers.dart';

void main() {
  late AppDatabase db;
  late int chicken;

  /// 400 g raw chicken, yield 0.75: 0.225 g protein per raw gram.
  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    chicken = await seedRecipe(db, 'Grilled chicken');
  });
  tearDown(() => db.close());

  /// Plan tab with "today" pinned to Monday: Mon-Wed is training, training,
  /// rest.
  Future<void> pumpPlan(WidgetTester tester) => pumpWithDb(
    tester,
    db,
    const PlanScreen(),
    overrides: [todayProvider.overrideWithValue(monday)],
  );

  Future<int> seedRecipeOf(
    String name,
    RecipeKind kind,
    double yieldFactor,
    Map<String, double> lines,
  ) async => db.recipesDao.saveRecipe(
    RecipeDraft(
      name: name,
      kind: kind,
      expectedYieldFactor: yieldFactor,
      ingredients: [
        for (final e in lines.entries)
          RecipeIngredientDraft(
            ingredientId: await ingredientIdByName(db, e.key),
            rawG: e.value,
          ),
      ],
    ),
  );

  Future<void> pickRecipe(WidgetTester tester, String role, int id) async {
    await tapKey(tester, 'pick-role-$role');
    await tapKey(tester, 'pick-recipe-$id');
  }

  Color chipColor(WidgetTester tester, String key) {
    final box = tester.widget<Container>(
      find.descendant(
        of: find.byKey(Key(key)),
        matching: find.byType(Container),
      ),
    );
    return ((box.decoration! as BoxDecoration).border! as Border).top.color;
  }

  uiTest('shows the covered days with their day type before any recipe', (
    tester,
  ) async {
    await pumpPlan(tester);

    expect(find.text('Days to cover'), findsOneWidget);
    expect(find.text('Mon, Oct 5 · Training'), findsOneWidget);
    expect(find.text('Tue, Oct 6 · Training'), findsOneWidget);
    expect(find.text('Wed, Oct 7 · Rest'), findsOneWidget);
    expect(
      tester.widget<ChoiceChip>(find.byKey(const Key('plan-days-3'))).selected,
      isTrue,
    );
    expect(find.text('Need 2450 kcal · P 160 g · C 295 g'), findsNWidgets(2));
    expect(find.text('Need 2275 kcal · P 160 g · C 251 g'), findsOneWidget);
    expect(find.byKey(const Key('choose-recipes-hint')), findsOneWidget);
    expect(find.byKey(const Key('plan-totals')), findsNothing);
    expect(
      tester
          .widget<OutlinedButton>(find.byKey(const Key('start-cooking')))
          .onPressed,
      isNull,
    );
  });

  uiTest('choosing a protein base and a number of days sizes the batch', (
    tester,
  ) async {
    await pumpPlan(tester);

    await pickRecipe(tester, 'proteinBase', chicken);
    expect(find.text('Grilled chicken'), findsWidgets);
    expect(
      find.text('Raw 2,135 g · cooked 1,601 g (yield 0.75)'),
      findsOneWidget,
    );
    expect(find.text('2,135 g Chicken breast'), findsOneWidget);
    expect(find.text('9 portions of 178 g cooked'), findsOneWidget);
    // One base only, so a portion and the average meal are the same.
    expect(
      find.text('285 kcal · P 53 · F 6 · C 0 · Fiber 0'),
      findsNWidgets(2),
    );
    expect(find.text('Protein 480 / 480 g'), findsOneWidget);
    expect(find.text('Carbs 0 / 841 g'), findsOneWidget);
    expect(find.text('Covered 854 kcal · P 160 g · C 0 g'), findsNWidgets(3));
    expect(find.text('Protein +0 g (+0%)'), findsOneWidget);
    expect(find.text('Carbs -841 g (-100%)'), findsOneWidget);
    expect(chipColor(tester, 'residual-protein'), AppColors.sage);
    expect(chipColor(tester, 'residual-carbs'), AppColors.terracotta);

    await tapKey(tester, 'plan-days-2');
    expect(find.text('Mon, Oct 5 · Training'), findsOneWidget);
    expect(find.text('Wed, Oct 7 · Rest'), findsNothing);
    expect(
      find.text('Raw 1,425 g · cooked 1,069 g (yield 0.75)'),
      findsOneWidget,
    );
    expect(find.text('6 portions of 178 g cooked'), findsOneWidget);
    expect(find.text('Protein 321 / 320 g'), findsOneWidget);
  });

  uiTest('protein and carb bases both reach their targets', (tester) async {
    final rice = await seedRecipeOf('Rice', RecipeKind.carbBase, 2.5, {
      'White rice': 200,
    });
    await pumpPlan(tester);

    await pickRecipe(tester, 'proteinBase', chicken);
    await pickRecipe(tester, 'carbBase', rice);

    // The carb base also carries protein, so the chicken shrinks.
    expect(
      find.text('Raw 1,805 g · cooked 1,354 g (yield 0.75)'),
      findsOneWidget,
    );
    expect(
      find.text('Raw 1,055 g · cooked 2,638 g (yield 2.50)'),
      findsOneWidget,
    );
    expect(find.text('Protein 481 / 480 g'), findsOneWidget);
    expect(find.text('Carbs 844 / 841 g'), findsOneWidget);
    expect(chipColor(tester, 'residual-protein'), AppColors.sage);
    expect(chipColor(tester, 'residual-carbs'), AppColors.sage);
  });

  uiTest('a vegetable side is sized in cooked grams per meal', (tester) async {
    final broccoli = await seedRecipeOf(
      'Roasted broccoli',
      RecipeKind.vegetable,
      0.8,
      {'Broccoli': 200},
    );
    await pumpPlan(tester);

    await pickRecipe(tester, 'vegetable', broccoli);
    expect(fieldText(tester, 'side-grams-vegetable'), '150');
    expect(
      find.text('Raw 1,690 g · cooked 1,352 g (yield 0.80)'),
      findsOneWidget,
    );

    await enterKey(tester, 'side-grams-vegetable', '100');
    expect(
      find.text('Raw 1,125 g · cooked 900 g (yield 0.80)'),
      findsOneWidget,
    );

    await tapKey(tester, 'clear-role-vegetable');
    expect(find.byKey(const Key('plan-recipe-vegetable')), findsNothing);
  });

  uiTest('fresh additions and pantry leftovers shrink the batch', (
    tester,
  ) async {
    final item = await seedBatchItem(db, chicken);
    final banana = await ingredientIdByName(db, 'Banana');
    await pumpPlan(tester);
    await pickRecipe(tester, 'proteinBase', chicken);
    expect(find.textContaining('Raw 2,135 g'), findsOneWidget);

    await tapKey(tester, 'add-fresh');
    await tapKey(tester, 'pick-ingredient-$banana');
    expect(fieldText(tester, 'fresh-grams-$banana'), '100');
    // 100 g banana x 9 meals = 9.9 g protein.
    expect(find.textContaining('Raw 2,090 g'), findsOneWidget);

    await enterKey(tester, 'fresh-grams-$banana', '50');
    expect(find.textContaining('Raw 2,115 g'), findsOneWidget);

    await tapKey(tester, 'leftover-$item');
    // 300 g cooked chicken already holds 90 g protein.
    expect(find.textContaining('Raw 1,715 g'), findsOneWidget);
    expect(find.text('Protein 481 / 480 g'), findsOneWidget);

    await tapKey(tester, 'remove-fresh-$banana');
    expect(find.byKey(Key('fresh-row-$banana')), findsNothing);
    expect(find.textContaining('Raw 1,735 g'), findsOneWidget);

    await tapKey(tester, 'leftover-$item');
    expect(find.textContaining('Raw 2,135 g'), findsOneWidget);
  });

  uiTest('the shopping list aggregates items and ticks them off', (
    tester,
  ) async {
    final protein = await seedRecipeOf(
      'Chicken with oil',
      RecipeKind.proteinBase,
      0.75,
      {'Chicken breast': 400, 'Olive oil': 10},
    );
    final carb = await seedRecipeOf('Rice with oil', RecipeKind.carbBase, 2.5, {
      'White rice': 200,
      'Olive oil': 5,
    });
    final oil = await ingredientIdByName(db, 'Olive oil');
    final rice = await ingredientIdByName(db, 'White rice');
    final chickenId = await ingredientIdByName(db, 'Chicken breast');
    String? copied;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          copied = (call.arguments as Map)['text'] as String;
        }
        return null;
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );
    await pumpPlan(tester);
    await pickRecipe(tester, 'proteinBase', protein);
    await pickRecipe(tester, 'carbBase', carb);

    await tapKey(tester, 'shopping-list');

    expect(
      find.text('Shopping list · Mon, Oct 5 - Wed, Oct 7'),
      findsOneWidget,
    );
    expect(find.text('1,055 g White rice'), findsOneWidget);
    // 50 g in the protein base plus 30 g in the carb base.
    expect(find.text('80 g Olive oil'), findsOneWidget);
    expect(find.text('1,805 g Chicken breast'), findsOneWidget);
    expect(find.text('Carb'), findsOneWidget);
    expect(find.text('Fat'), findsOneWidget);
    expect(find.text('Protein'), findsOneWidget);
    expect(find.text('0 of 3 checked'), findsOneWidget);

    Checkbox box(int id) => tester.widget<Checkbox>(
      find.descendant(
        of: find.byKey(Key('shop-item-$id')),
        matching: find.byType(Checkbox),
      ),
    );
    await tapKey(tester, 'shop-item-$oil');
    expect(box(oil).value, isTrue);
    expect(box(rice).value, isFalse);
    expect(find.text('1 of 3 checked'), findsOneWidget);
    await tapKey(tester, 'shop-item-$chickenId');
    expect(find.text('2 of 3 checked'), findsOneWidget);
    await tapKey(tester, 'shop-item-$oil');
    expect(box(oil).value, isFalse);
    expect(find.text('1 of 3 checked'), findsOneWidget);
    await tapKey(tester, 'uncheck-all');
    expect(find.text('0 of 3 checked'), findsOneWidget);

    await tapKey(tester, 'copy-shopping-list');
    expect(find.text('Shopping list copied'), findsOneWidget);
    expect(copied, startsWith('Shopping list · Mon, Oct 5 - Wed, Oct 7\n'));
    expect(copied, contains('- [ ] 1,805 g Chicken breast'));
    expect(copied, contains('- [ ] 80 g Olive oil'));
    expect(copied, contains('Carb\n- [ ] 1,055 g White rice'));
  });

  uiTest('start cooking opens the log batch screen prefilled', (tester) async {
    await pumpPlan(tester);
    await pickRecipe(tester, 'proteinBase', chicken);

    await tapKey(tester, 'start-cooking');

    expect(find.byKey(const Key('save-batch')), findsOneWidget);
    expect(find.text('Grilled chicken'), findsOneWidget);
    expect(fieldText(tester, 'batch-raw-0'), '2135');
    expect(fieldText(tester, 'batch-cooked-0'), '');
    expect(
      find.descendant(
        of: find.byKey(const Key('pick-covers-from')),
        matching: find.text('Mon, Oct 5'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byKey(const Key('pick-covers-to')),
        matching: find.text('Wed, Oct 7'),
      ),
      findsOneWidget,
    );

    await enterKey(tester, 'batch-cooked-0', '1600');
    await tapKey(tester, 'save-batch');

    expect(find.byKey(const Key('save-batch')), findsNothing);
    final saved = (await db.select(db.batchItems).get()).single;
    expect(
      (saved.recipeId, saved.rawTotalG, saved.cookedTotalG),
      (chicken, 2135.0, 1600.0),
    );
    final session = (await db.select(db.batchSessions).get()).single;
    expect(session.coversFrom, DateTime(2026, 10, 5));
    expect(session.coversTo, DateTime(2026, 10, 7));
    // The new batch is now pantry stock that can be deducted from a plan.
    expect(find.byKey(Key('leftover-${saved.id}')), findsOneWidget);
  });

  uiTest('asks to set up targets when no plan exists', (tester) async {
    await db.delete(db.userProfiles).go();
    await pumpPlan(tester);

    expect(find.byKey(const Key('plan-setup-hint')), findsOneWidget);
    expect(find.byKey(const Key('plan-from')), findsOneWidget);
    expect(find.byKey(const Key('shopping-list')), findsNothing);
  });
}
