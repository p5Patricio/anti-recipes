import 'package:anti_recipes/core/formatting/grams_format.dart';
import 'package:anti_recipes/features/batch_planner/domain/batch_plan.dart';
import 'package:anti_recipes/features/batch_planner/domain/batch_planner.dart';
import 'package:anti_recipes/features/batch_planner/domain/plan_inputs.dart';
import 'package:anti_recipes/features/batch_planner/domain/shopping_list.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/plan_fixtures.dart';

void main() {
  final planner = BatchPlanner(exampleEngine());

  FreshAddition banana(double gramsPerMeal) => FreshAddition(
    ingredientId: 8,
    name: 'Banana',
    category: 'fruit',
    per100: bananaPer100,
    gramsPerMeal: gramsPerMeal,
    servingG: 118,
  );

  BatchPlan plan({
    List<PlanComponent> components = const [],
    List<FreshAddition> fresh = const [],
  }) => planner.plan(
    BatchPlanInput.fromDay(
      mon,
      3,
      mealsPerDay: 3,
      components: components,
      fresh: fresh,
    ),
  );

  PlanRecipe withOil(PlanRecipe base, double oilG) => PlanRecipe(
    id: base.id,
    name: base.name,
    yieldFactor: base.yieldFactor,
    lines: [...base.lines, oilLine(oilG)],
  );

  double lineG(PlannedRecipe r, int ingredientId) => r.lines
      .where((l) => l.ingredientId == ingredientId)
      .fold(0, (s, l) => s + l.rawG);

  group('aggregation', () {
    final p = plan(
      components: [
        protein(withOil(chickenRecipe(), 10)),
        carb(withOil(riceRecipe(), 5)),
      ],
    );
    final list = ShoppingList.fromPlan(p);

    test('sums an ingredient shared by two recipes into one item', () {
      final oil = list.items.where((i) => i.ingredientId == 3).single;
      final expected =
          lineG(p.recipeFor(PlanRole.proteinBase)!, 3) +
          lineG(p.recipeFor(PlanRole.carbBase)!, 3);

      expect(expected, greaterThan(0));
      expect(oil.totalG, expected);
      expect(list.items, hasLength(3));
    });

    test('totals the scaled raw weights of every recipe line', () {
      final chicken = list.items.firstWhere((i) => i.ingredientId == 1);
      final rice = list.items.firstWhere((i) => i.ingredientId == 2);

      expect(chicken.totalG, lineG(p.recipeFor(PlanRole.proteinBase)!, 1));
      expect(rice.totalG, lineG(p.recipeFor(PlanRole.carbBase)!, 2));
      expect(chicken.totalG % 5, 0);
    });

    test('sorts by category and then by name', () {
      expect(list.items.map((i) => i.name), [
        'White rice',
        'Olive oil',
        'Chicken breast',
      ]);
      expect(list.byCategory.keys, ['carb', 'fat', 'protein']);
    });

    test('sorts names inside a category regardless of case', () {
      final mixed = ShoppingList.fromPlan(
        plan(
          fresh: [
            banana(50),
            FreshAddition(
              ingredientId: 9,
              name: 'apple',
              category: 'fruit',
              per100: bananaPer100,
              gramsPerMeal: 50,
            ),
          ],
        ),
      );

      expect(mixed.items.map((i) => i.name), ['apple', 'Banana']);
    });
  });

  group('fresh additions and servings', () {
    test('fresh grams are added over every meal of the block', () {
      final list = ShoppingList.fromPlan(plan(fresh: [banana(100)]));

      expect(list.items.single.totalG, 900);
      expect(list.items.single.servingCount, 8);
    });

    test('a fresh ingredient also used in a recipe is summed', () {
      final recipe = PlanRecipe(
        id: 1,
        name: 'Chicken and banana',
        yieldFactor: 0.75,
        lines: [chickenLine(), line(8, 'Banana', 'fruit', bananaPer100, 100)],
      );
      final p = plan(components: [protein(recipe)], fresh: [banana(100)]);
      final item = ShoppingList.fromPlan(p).items
          .firstWhere((i) => i.ingredientId == 8);

      expect(item.totalG, lineG(p.recipes.single, 8) + 900);
    });

    test('no serving count without a known serving size', () {
      final list = ShoppingList.fromPlan(
        plan(components: [protein(chickenRecipe())]),
      );

      expect(list.items.single.servingCount, isNull);
    });

    test('recipes that need nothing contribute no items', () {
      final empty = ShoppingList.fromPlan(plan());

      expect(empty.isEmpty, isTrue);
      expect(empty.toText(), '');
    });
  });

  group('text export', () {
    test('writes a checklist grouped by category', () {
      final list = ShoppingList.fromPlan(
        plan(components: [protein(chickenRecipe())], fresh: [banana(100)]),
      );

      expect(
        list.toText(title: 'Shopping list'),
        'Shopping list\n'
        '\n'
        'Fruit\n'
        '- [ ] 900 g Banana (about 8 x 118 g)\n'
        '\n'
        'Protein\n'
        '- [ ] 2,090 g Chicken breast',
      );
    });

    test('formats grams with thousands separators', () {
      expect(formatGrams(0), '0');
      expect(formatGrams(999.4), '999');
      expect(formatGrams(1200), '1,200');
      expect(formatGrams(1234567), '1,234,567');
      expect(categoryLabel('protein'), 'Protein');
      expect(categoryLabel(''), 'Other');
    });
  });
}
