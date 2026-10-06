import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/formatting/date_format.dart';
import '../../inventory/data/inventory_dao.dart';
import '../../inventory/presentation/inventory_providers.dart';
import '../../inventory/presentation/log_batch_screen.dart';
import '../../inventory/presentation/widgets/recipe_picker_sheet.dart';
import '../../recipes/presentation/recipes_providers.dart';
import '../../recipes/presentation/widgets/ingredient_picker_sheet.dart';
import '../domain/batch_plan.dart';
import '../domain/plan_inputs.dart';
import '../domain/shopping_list.dart';
import 'plan_providers.dart';
import 'shopping_list_screen.dart';
import 'widgets/day_range_selector.dart';
import 'widgets/fresh_additions_section.dart';
import 'widgets/leftovers_section.dart';
import 'widgets/plan_results.dart';
import 'widgets/role_picker_card.dart';

/// Container for the Plan tab: pick the days to cover and the recipes, see how
/// much to cook, then open the shopping list or start the batch.
class PlanScreen extends ConsumerWidget {
  const PlanScreen({super.key});

  Future<void> _pickFrom(BuildContext context, WidgetRef ref) async {
    final current = ref.read(planSelectionProvider).from;
    final picked = await showDatePicker(
      context: context,
      initialDate: current,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      ref.read(planSelectionProvider.notifier).setFrom(picked);
    }
  }

  Future<void> _pickRecipe(
    BuildContext context,
    WidgetRef ref,
    PlanRole role,
  ) async {
    final all = ref.read(recipeSummariesProvider).value ?? const [];
    final picked = await showModalBottomSheet<RecipeSummary>(
      context: context,
      isScrollControlled: true,
      builder: (_) => RecipePickerSheet(recipes: all),
    );
    if (picked != null) {
      ref
          .read(planSelectionProvider.notifier)
          .setRecipe(role, picked.recipe.id);
    }
  }

  Future<void> _addFresh(BuildContext context, WidgetRef ref) async {
    final selection = ref.read(planSelectionProvider);
    final picked = await showModalBottomSheet<Ingredient>(
      context: context,
      isScrollControlled: true,
      builder: (_) => IngredientPickerSheet(
        ingredients: ref.read(ingredientsProvider).value ?? const [],
        excludeIds: {for (final f in selection.fresh) f.ingredientId},
      ),
    );
    if (picked != null) {
      ref.read(planSelectionProvider.notifier).setFresh(picked.id, 100);
    }
  }

  void _push(BuildContext context, Widget screen) =>
      Navigator.of(context)
          .push(MaterialPageRoute<void>(builder: (_) => screen));

  String _rangeTitle(BatchPlan plan) =>
      '${weekdayDate(plan.days.first.date)} - ${weekdayDate(plan.days.last.date)}';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selection = ref.watch(planSelectionProvider);
    final notifier = ref.read(planSelectionProvider.notifier);
    final plan = ref.watch(batchPlanProvider);
    final recipes = ref.watch(recipeSummariesProvider);
    final ingredients = ref.watch(ingredientsProvider);
    final stock = ref.watch(stockProvider);
    final recipeNames = {
      for (final r in recipes.value ?? const <RecipeSummary>[])
        r.recipe.id: r.recipe.name,
    };
    final foods = {
      for (final i in ingredients.value ?? const <Ingredient>[]) i.id: i,
    };
    final batchPlan = plan.value;
    final dates = consecutiveDays(selection.from, selection.dayCount);

    return Scaffold(
      appBar: AppBar(title: const Text('Plan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _section(context, 'Days to cover'),
            DayRangeSelector(
              dates: dates,
              dayTypes: [
                for (final (i, _) in dates.indexed)
                  batchPlan == null ? null : batchPlan.days[i].dayType,
              ],
              onPickFrom: () => _pickFrom(context, ref),
              onDayCount: notifier.setDayCount,
            ),
            _section(context, 'Choose recipes'),
            for (final role in PlanRole.values)
              RolePickerCard(
                key: Key('role-card-${role.name}'),
                role: role,
                recipeName: recipeNames[selection.recipeIds[role]],
                onPick: () => _pickRecipe(context, ref, role),
                onClear: () => notifier.setRecipe(role, null),
                gramsPerMeal: role.isBase
                    ? null
                    : selection.sideGramsPerMeal[role] ??
                          defaultSideGramsPerMeal[role],
                onGramsPerMeal: (g) => notifier.setSideGrams(role, g),
              ),
            const SizedBox(height: 8),
            FreshAdditionsSection(
              rows: [
                for (final f in selection.fresh)
                  if (foods[f.ingredientId] case final i?)
                    FreshRowData(
                      ingredientId: i.id,
                      name: i.name,
                      gramsPerMeal: f.gramsPerMeal,
                    ),
              ],
              onAdd: () => _addFresh(context, ref),
              onGrams: notifier.setFresh,
              onRemove: notifier.removeFresh,
            ),
            const SizedBox(height: 16),
            LeftoversSection(
              items: [
                for (final s in stock.value ?? const <StockItem>[])
                  if (s.remainingG > 0) s,
              ],
              selectedIds: selection.leftoverIds,
              onToggle: (id, use) => notifier.setLeftover(id, use: use),
            ),
            _section(context, 'Results'),
            ...plan.when(
              loading: () => const [
                Padding(
                  padding: EdgeInsets.all(32),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ],
              error: (e, _) => [Text('Could not build the plan: $e')],
              data: (p) => p == null
                  ? const [_SetupTargetsHint()]
                  : _results(context, p),
            ),
          ],
        ),
      ),
    );
  }

  Widget _section(BuildContext context, String title) => Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 8),
    child: Text(title, style: Theme.of(context).textTheme.titleMedium),
  );

  List<Widget> _results(BuildContext context, BatchPlan p) {
    final hasCoverage =
        p.recipes.any((r) => r.isNeeded) ||
        p.fresh.isNotEmpty ||
        p.leftovers.isNotEmpty;
    final cooking = p.recipes.where((r) => r.isNeeded).toList();
    final list = ShoppingList.fromPlan(p);
    return [
      for (final (i, d) in p.days.indexed)
        DayNeedCard(
          key: Key('day-card-$i'),
          need: d,
          covered: p.coveredPerDay,
          hasCoverage: hasCoverage,
        ),
      if (p.recipes.isEmpty)
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Choose a protein base and a carb base to see how much to cook.',
            key: Key('choose-recipes-hint'),
          ),
        ),
      for (final r in p.recipes) PlannedRecipeCard(planned: r),
      if (hasCoverage) PlanTotalsCard(plan: p),
      const SizedBox(height: 16),
      _PlanActions(
        onShoppingList: () => _push(
          context,
          ShoppingListScreen(
            list: list,
            title: 'Shopping list · ${_rangeTitle(p)}',
          ),
        ),
        onStartCooking: cooking.isEmpty
            ? null
            : () => _push(
                context,
                LogBatchScreen(
                  prefillItems: [
                    for (final r in cooking)
                      BatchPrefillItem(
                        recipeId: r.recipe.id,
                        rawTotalG: r.rawG,
                      ),
                  ],
                  coversFrom: p.days.first.date,
                  coversTo: p.days.last.date,
                ),
              ),
      ),
    ];
  }
}

class _PlanActions extends StatelessWidget {
  const _PlanActions({
    required this.onShoppingList,
    required this.onStartCooking,
  });

  final VoidCallback onShoppingList;
  final VoidCallback? onStartCooking;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      FilledButton.icon(
        key: const Key('shopping-list'),
        onPressed: onShoppingList,
        icon: const Icon(Icons.shopping_cart_outlined),
        label: const Text('Shopping list'),
      ),
      const SizedBox(height: 8),
      OutlinedButton.icon(
        key: const Key('start-cooking'),
        onPressed: onStartCooking,
        icon: const Icon(Icons.soup_kitchen_outlined),
        label: const Text('Start cooking'),
      ),
    ],
  );
}

class _SetupTargetsHint extends StatelessWidget {
  const _SetupTargetsHint();

  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.all(24),
    child: Text(
      'Set up your nutrition targets in Settings to plan a batch.',
      key: Key('plan-setup-hint'),
      textAlign: TextAlign.center,
    ),
  );
}
