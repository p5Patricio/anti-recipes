import 'package:anti_recipes/core/formatting/grams_format.dart';
import 'package:anti_recipes/features/batch_planner/domain/batch_planner.dart';
import 'package:anti_recipes/features/batch_planner/domain/plan_inputs.dart';
import 'package:anti_recipes/features/batch_planner/domain/shopping_list.dart';
import 'package:anti_recipes/features/batch_planner/presentation/shopping_list_text.dart';
import 'package:anti_recipes/l10n/app_localizations_en.dart';
import 'package:anti_recipes/l10n/app_localizations_es.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/plan_fixtures.dart';

void main() {
  final planner = BatchPlanner(exampleEngine());
  final en = AppLocalizationsEn();
  final es = AppLocalizationsEs();

  FreshAddition banana(double gramsPerMeal) => FreshAddition(
    ingredientId: 8,
    name: 'Banana',
    category: 'fruit',
    per100: bananaPer100,
    gramsPerMeal: gramsPerMeal,
    servingG: 118,
  );

  ShoppingList list() => ShoppingList.fromPlan(
    planner.plan(
      BatchPlanInput.fromDay(
        mon,
        3,
        mealsPerDay: 3,
        components: [protein(chickenRecipe())],
        fresh: [banana(100)],
      ),
    ),
  );

  group('text export', () {
    test('writes a checklist grouped by category', () {
      expect(
        shoppingListText(en, list(), title: 'Shopping list'),
        'Shopping list\n'
        '\n'
        'Fruit\n'
        '- [ ] 900 g Banana (about 8 x 118 g)\n'
        '\n'
        'Protein\n'
        '- [ ] 2,090 g Chicken breast',
      );
    });

    test('an empty list exports as empty text', () {
      final empty = ShoppingList.fromPlan(
        planner.plan(
          BatchPlanInput.fromDay(mon, 3, mealsPerDay: 3, components: []),
        ),
      );

      expect(shoppingListText(en, empty), '');
    });

    test('is translated to Spanish', () {
      expect(
        shoppingListText(es, list(), title: 'Lista de compras'),
        'Lista de compras\n'
        '\n'
        'Fruta\n'
        '- [ ] 900 g Banana (aprox. 8 x 118 g)\n'
        '\n'
        'Proteína\n'
        '- [ ] 2,090 g Chicken breast',
      );
    });

    test('formats grams with thousands separators', () {
      expect(formatGrams(0), '0');
      expect(formatGrams(999.4), '999');
      expect(formatGrams(1200), '1,200');
      expect(formatGrams(1234567), '1,234,567');
    });

    test('labels categories, falling back to the capitalized code', () {
      expect(shoppingCategoryLabel(en, 'protein'), 'Protein');
      expect(shoppingCategoryLabel(en, ''), 'Other');
      expect(shoppingCategoryLabel(es, ''), 'Otros');
      expect(shoppingCategoryLabel(en, 'spice'), 'Spice');
    });
  });
}
