import 'package:anti_recipes/core/nutrition/nutrients.dart';
import 'package:anti_recipes/core/nutrition/range.dart';
import 'package:anti_recipes/features/batch_planner/domain/batch_planner.dart';
import 'package:anti_recipes/features/batch_planner/domain/plan_inputs.dart';
import 'package:anti_recipes/features/nutrition_targets/domain/day_type.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/plan_fixtures.dart';

void main() {
  final planner = BatchPlanner(exampleEngine());

  BatchPlanInput block({
    int days = 3,
    DateTime? from,
    List<PlanComponent> components = const [],
    List<FreshAddition> fresh = const [],
    List<PantryLeftover> leftovers = const [],
  }) => BatchPlanInput.fromDay(
    from ?? mon,
    days,
    mealsPerDay: 3,
    components: components,
    fresh: fresh,
    leftovers: leftovers,
  );

  group('rounding', () {
    test('rounds up to the next step and ignores float noise', () {
      expect(roundUpToStep(0), 0);
      expect(roundUpToStep(-3), 0);
      expect(roundUpToStep(1), 5);
      expect(roundUpToStep(5), 5);
      expect(roundUpToStep(401), 405);
      expect(roundUpToStep(400.0000000001), 400);
      expect(roundUpToStep(12, 10), 20);
    });
  });

  group('targets of a block', () {
    test('training days weigh more than rest days (Mon-Wed)', () {
      final plan = planner.plan(block());

      expect(plan.days.map((d) => d.dayType), [
        DayType.training,
        DayType.training,
        DayType.rest,
      ]);
      expect(plan.days.map((d) => d.carbsG), [295, 295, 251.25]);
      expect(plan.days.map((d) => d.kcal), [2450, 2450, 2275]);
      expect(plan.target.proteinG, 480);
      expect(plan.target.carbsG, 841.25);
      expect(plan.target.kcal, 7175);
      expect(plan.target.fatG, 210);
      expect(plan.mealCount, 9);
      expect(plan.recipes, isEmpty);
      expect(plan.proteinToCookG, 480);
    });

    test('a rest-only block needs fewer carbs than a training one', () {
      final training = planner.plan(
        block(days: 1, components: [carb(riceRecipe())]),
      );
      final rest = planner.plan(
        block(
          days: 1,
          from: DateTime(2026, 10, 7),
          components: [carb(riceRecipe())],
        ),
      );

      expect(training.days.single.dayType, DayType.training);
      expect(rest.days.single.dayType, DayType.rest);
      expect(
        training.recipeFor(PlanRole.carbBase)!.rawG,
        greaterThan(rest.recipeFor(PlanRole.carbBase)!.rawG),
      );
      // 295 g / 0.8 g carbs per raw gram = 368.75 g, rounded up.
      expect(training.recipeFor(PlanRole.carbBase)!.rawG, 370);
      // 251.25 g / 0.8 = 314.06 g.
      expect(rest.recipeFor(PlanRole.carbBase)!.rawG, 315);
    });
  });

  group('single protein base', () {
    final plan = planner.plan(block(components: [protein(chickenRecipe())]));
    final chicken = plan.recipeFor(PlanRole.proteinBase)!;

    test('sizes the base for the block protein, rounded up to 5 g', () {
      // 480 g protein / 0.225 g per raw gram = 2133.3 g raw.
      expect(chicken.rawG, 2135);
      expect(chicken.lines.single.rawG, 2135);
      expect(chicken.cookedG, closeTo(1601.25, 1e-9));
      expect(chicken.nutrients.proteinG, closeTo(480.375, 1e-9));
      expect(chicken.isNeeded, isTrue);
    });

    test('splits the batch into one portion per meal', () {
      expect(chicken.portions, 9);
      expect(chicken.gramsPerPortion, closeTo(1601.25 / 9, 1e-9));
      expect(chicken.perPortion.proteinG, closeTo(480.375 / 9, 1e-9));
    });

    test('reports the residual against the targets', () {
      expect(plan.proteinResidualG, closeTo(0.375, 1e-9));
      expect(plan.proteinStatus, RangeStatus.within);
      // Chicken has no carbs, so the carb target is missed entirely.
      expect(plan.carbsResidualG, closeTo(-841.25, 1e-9));
      expect(plan.carbsStatus, RangeStatus.below);
      expect(plan.perMeal.proteinG, closeTo(480.375 / 9, 1e-9));
      expect(plan.coveredPerDay.proteinG, closeTo(480.375 / 3, 1e-9));
    });
  });

  group('yield factor', () {
    test('changes the cooked weight but not the raw need of a base', () {
      final firm = planner.plan(
        block(components: [protein(chickenRecipe(yieldFactor: 0.75))]),
      );
      final dry = planner.plan(
        block(components: [protein(chickenRecipe(yieldFactor: 0.5))]),
      );
      final a = firm.recipeFor(PlanRole.proteinBase)!;
      final b = dry.recipeFor(PlanRole.proteinBase)!;

      expect(a.rawG, b.rawG);
      expect(b.cookedG, closeTo(a.cookedG * 0.5 / 0.75, 1e-9));
      expect(b.gramsPerPortion, lessThan(a.gramsPerPortion));
    });

    test('changes the raw weight of a side sized in cooked grams', () {
      PlanRecipe broccoli(double yieldFactor) => PlanRecipe(
        id: 5,
        name: 'Roasted broccoli',
        yieldFactor: yieldFactor,
        lines: [line(5, 'Broccoli', 'vegetable', broccoliPer100, 200)],
      );
      PlanComponent side(double yieldFactor) => PlanComponent(
        role: PlanRole.vegetable,
        recipe: broccoli(yieldFactor),
        cookedGPerMeal: 150,
      );

      final high = planner.plan(block(components: [side(0.8)]));
      final low = planner.plan(block(components: [side(0.5)]));

      // 150 g * 9 meals = 1350 g cooked.
      expect(high.recipeFor(PlanRole.vegetable)!.rawG, 1690);
      expect(low.recipeFor(PlanRole.vegetable)!.rawG, 2700);
      expect(
        high.recipeFor(PlanRole.vegetable)!.gramsPerPortion,
        closeTo(1690 * 0.8 / 9, 1e-9),
      );
    });
  });

  group('protein and carb bases', () {
    // Protein base that also carries carbs: 0.23 g protein and 0.04375 g
    // carbs per cooked gram.
    final chickenAndPotato = PlanRecipe(
      id: 1,
      name: 'Chicken and potato',
      yieldFactor: 0.8,
      lines: [chickenLine(), line(4, 'Potato', 'carb', potatoPer100, 100)],
    );

    test('accounts for what each base contributes to the other need', () {
      final plan = planner.plan(
        block(components: [protein(chickenAndPotato), carb(riceRecipe())]),
      );
      final p = plan.recipeFor(PlanRole.proteinBase)!;
      final c = plan.recipeFor(PlanRole.carbBase)!;

      // Both targets are met together, within the 5 g rounding steps.
      expect(plan.covered.proteinG, closeTo(480, 10));
      expect(plan.covered.carbsG, closeTo(841.25, 15));
      expect(plan.proteinStatus, RangeStatus.within);
      expect(plan.carbsStatus, RangeStatus.within);

      // Solving each nutrient alone would over-cook both bases.
      expect(p.cookedG, lessThan(480 / 0.23));
      expect(c.cookedG, lessThan(841.25 / 0.32));
      expect(p.cookedG, closeTo(1792.6, 15));
      expect(c.cookedG, closeTo(2383.9, 20));
    });

    test('leftover rice shrinks both bases', () {
      final base = planner.plan(
        block(components: [protein(chickenAndPotato), carb(riceRecipe())]),
      );
      final reduced = planner.plan(
        block(
          components: [protein(chickenAndPotato), carb(riceRecipe())],
          leftovers: const [
            PantryLeftover(
              batchItemId: 1,
              name: 'Cooked rice',
              remainingG: 500,
              perCookedGram: Nutrients(proteinG: 0.0284, carbsG: 0.32),
            ),
          ],
        ),
      );

      expect(
        reduced.recipeFor(PlanRole.carbBase)!.cookedG,
        lessThan(base.recipeFor(PlanRole.carbBase)!.cookedG),
      );
      expect(reduced.covered.carbsG, closeTo(841.25, 15));
    });

    test('drops a carb base the protein base already over-supplies', () {
      // 0.148 g protein and 0.4 g carbs per cooked gram: sizing it for
      // protein alone already exceeds the carb target.
      final rich = PlanRecipe(
        id: 1,
        name: 'Rice and chicken',
        yieldFactor: 1,
        lines: [
          line(1, 'Chicken breast', 'protein', chickenPer100, 100),
          line(2, 'White rice', 'carb', ricePer100, 100),
        ],
      );
      final plan = planner.plan(
        block(components: [protein(rich), carb(riceRecipe())]),
      );

      expect(plan.recipeFor(PlanRole.carbBase)!.isNeeded, isFalse);
      expect(
        plan.recipeFor(PlanRole.proteinBase)!.nutrients.proteinG,
        closeTo(480, 6),
      );
      expect(plan.carbsResidualG, greaterThan(0));
      expect(plan.carbsStatus, RangeStatus.above);
    });

    test('drops a protein base when the carb base over-supplies protein', () {
      // Lentil-like carb base: 0.625 g protein per gram of carbs, above the
      // block's 0.57 protein-to-carb ratio.
      final lentils = PlanRecipe(
        id: 2,
        name: 'Lentils',
        yieldFactor: 1,
        lines: [
          line(
            6,
            'Lentils',
            'carb',
            const Nutrients(kcal: 350, proteinG: 25, carbsG: 40),
            1000,
          ),
        ],
      );
      final plan = planner.plan(
        block(components: [protein(chickenRecipe()), carb(lentils)]),
      );

      expect(plan.recipeFor(PlanRole.proteinBase)!.isNeeded, isFalse);
      expect(
        plan.recipeFor(PlanRole.carbBase)!.nutrients.carbsG,
        closeTo(841.25, 3),
      );
      expect(plan.proteinStatus, RangeStatus.above);
    });

    test('a base without the nutrient is not scaled up', () {
      final plan = planner.plan(
        block(
          components: [
            PlanComponent(
              role: PlanRole.proteinBase,
              recipe: PlanRecipe(
                id: 7,
                name: 'Plain oil',
                yieldFactor: 1,
                lines: [oilLine(100)],
              ),
            ),
          ],
        ),
      );

      expect(plan.recipeFor(PlanRole.proteinBase)!.isNeeded, isFalse);
      expect(plan.covered, Nutrients.zero);
    });
  });

  group('deductions', () {
    test('pantry leftovers are deducted from the protein need', () {
      final plan = planner.plan(
        block(
          components: [protein(chickenRecipe())],
          leftovers: const [
            PantryLeftover(
              batchItemId: 9,
              name: 'Grilled chicken',
              remainingG: 300,
              perCookedGram: Nutrients(proteinG: 0.3),
            ),
          ],
        ),
      );

      expect(plan.proteinToCookG, closeTo(390, 1e-9));
      // 390 / 0.225 = 1733.3 g raw.
      expect(plan.recipeFor(PlanRole.proteinBase)!.rawG, 1735);
      expect(plan.leftoverNutrients.proteinG, closeTo(90, 1e-9));
      expect(plan.covered.proteinG, closeTo(480.375, 1e-9));
    });

    test('leftovers that cover everything leave nothing to cook', () {
      final plan = planner.plan(
        block(
          components: [protein(chickenRecipe())],
          leftovers: const [
            PantryLeftover(
              batchItemId: 9,
              name: 'Grilled chicken',
              remainingG: 2000,
              perCookedGram: Nutrients(proteinG: 0.3),
            ),
          ],
        ),
      );

      expect(plan.proteinToCookG, 0);
      expect(plan.recipeFor(PlanRole.proteinBase)!.isNeeded, isFalse);
      expect(plan.proteinStatus, RangeStatus.above);
    });

    test('fresh additions are deducted and totalled over the block', () {
      final plan = planner.plan(
        block(
          components: [protein(chickenRecipe())],
          fresh: [
            FreshAddition(
              ingredientId: 8,
              name: 'Banana',
              category: 'fruit',
              per100: bananaPer100,
              gramsPerMeal: 100,
              servingG: 118,
            ),
          ],
        ),
      );

      final banana = plan.fresh.single;
      expect(banana.totalG, 900);
      expect(banana.nutrients.carbsG, closeTo(205.2, 1e-9));
      expect(plan.freshNutrients.proteinG, closeTo(9.9, 1e-9));
      expect(plan.proteinToCookG, closeTo(470.1, 1e-9));
      expect(plan.carbsToCookG, closeTo(841.25 - 205.2, 1e-9));
      // 470.1 / 0.225 = 2089.3 g raw.
      expect(plan.recipeFor(PlanRole.proteinBase)!.rawG, 2090);
      expect(plan.covered.carbsG, closeTo(205.2, 1e-9));
    });

    test('fixed sides are deducted and sized per meal', () {
      final plan = planner.plan(
        block(
          components: [
            protein(chickenRecipe()),
            PlanComponent(
              role: PlanRole.sauce,
              recipe: PlanRecipe(
                id: 5,
                name: 'Tomato sauce',
                yieldFactor: 1,
                lines: [
                  line(
                    5,
                    'Tomato',
                    'vegetable',
                    const Nutrients(kcal: 20, proteinG: 1, carbsG: 4),
                    100,
                  ),
                ],
              ),
              cookedGPerMeal: 40,
            ),
          ],
        ),
      );

      final sauce = plan.recipeFor(PlanRole.sauce)!;
      // 40 g * 9 meals.
      expect(sauce.rawG, 360);
      expect(sauce.portions, 9);
      expect(sauce.gramsPerPortion, 40);
      expect(plan.proteinToCookG, closeTo(480 - 3.6, 1e-9));
      expect(plan.recipes.map((r) => r.role), [
        PlanRole.proteinBase,
        PlanRole.sauce,
      ]);
    });
  });

  group('rounding of scaled lines', () {
    test('every scaled line is a multiple of 5 g', () {
      final plan = planner.plan(
        block(
          days: 5,
          components: [
            protein(
              PlanRecipe(
                id: 1,
                name: 'Chicken with oil',
                yieldFactor: 0.7,
                lines: [chickenLine(333), oilLine(11)],
              ),
            ),
          ],
        ),
      );

      final lines = plan.recipes.single.lines;
      expect(lines, hasLength(2));
      for (final l in lines) {
        expect(l.rawG % 5, 0);
      }
      expect(
        plan.recipes.single.rawG,
        lines.fold<double>(0, (s, l) => s + l.rawG),
      );
    });
  });

  group('validation', () {
    test('covers between 1 and 7 days', () {
      expect(() => block(days: 0), throwsArgumentError);
      expect(() => block(days: 8), throwsArgumentError);
      expect(block(days: 7).dates.last, DateTime(2026, 10, 11));
    });

    test('rejects two recipes for one role and an empty yield', () {
      expect(
        () => block(
          components: [protein(chickenRecipe()), protein(chickenRecipe(id: 3))],
        ),
        throwsArgumentError,
      );
      expect(() => chickenRecipe(yieldFactor: 0), throwsArgumentError);
      expect(
        () => BatchPlanInput.fromDay(mon, 1, mealsPerDay: 0),
        throwsArgumentError,
      );
    });
  });
}
