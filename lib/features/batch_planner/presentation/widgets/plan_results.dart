import 'package:flutter/material.dart';

import '../../../../core/formatting/grams_format.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/nutrition/nutrients.dart';
import '../../../../core/nutrition/range.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../meal_log/presentation/widgets/day_header.dart';
import '../../../meal_log/presentation/widgets/status_style.dart';
import '../../../recipes/presentation/widgets/macro_line.dart';
import '../../../inventory/presentation/localized_dates.dart';
import '../../domain/batch_plan.dart';
import 'role_picker_card.dart';

/// What one day asks for against what the plan puts on the plate.
class DayNeedCard extends StatelessWidget {
  const DayNeedCard({
    super.key,
    required this.need,
    required this.covered,
    required this.hasCoverage,
  });

  final DayNeed need;

  /// Average nutrients one day receives from the plan.
  final Nutrients covered;

  /// False while no recipe, fresh addition or leftover is planned.
  final bool hasCoverage;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final l10n = context.l10n;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    localizedWeekdayDate(context, need.date),
                    style: text.titleSmall,
                  ),
                ),
                DayTypeBadge(need.dayType),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              l10n.plannerNeed(
                need.kcal.round(),
                need.proteinG.round(),
                need.carbsG.round(),
              ),
              key: Key('day-need-${need.date.day}'),
              style: text.bodyMedium,
            ),
            if (hasCoverage)
              Text(
                l10n.plannerCovered(
                  covered.kcal.round(),
                  covered.proteinG.round(),
                  covered.carbsG.round(),
                ),
                key: Key('day-covered-${need.date.day}'),
                style: text.bodyMedium,
              ),
          ],
        ),
      ),
    );
  }
}

/// One scaled recipe: raw and cooked totals, ingredient lines, portions.
class PlannedRecipeCard extends StatelessWidget {
  const PlannedRecipeCard({super.key, required this.planned});

  final PlannedRecipe planned;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final role = planned.role.name;
    return Card(
      key: Key('plan-recipe-$role'),
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(planned.recipe.name, style: text.titleMedium),
            Text(planned.role.label(l10n), style: text.bodySmall),
            const SizedBox(height: 8),
            if (!planned.isNeeded)
              Text(
                l10n.plannerNothingToCook,
                key: Key('not-needed-$role'),
                style: text.bodyMedium,
              )
            else ...[
              Text(
                l10n.plannerRawCooked(
                  formatGrams(planned.rawG),
                  formatGrams(planned.cookedG),
                  planned.recipe.yieldFactor.toStringAsFixed(2),
                ),
                key: Key('raw-cooked-$role'),
                style: text.titleSmall,
              ),
              const SizedBox(height: 6),
              for (final l in planned.lines)
                Text(
                  l10n.plannerIngredientLine(formatGrams(l.rawG), l.name),
                  key: Key('line-$role-${l.ingredientId}'),
                  style: text.bodyMedium,
                ),
              const SizedBox(height: 8),
              Text(
                l10n.plannerPortions(
                  planned.portions,
                  planned.gramsPerPortion.round(),
                ),
                key: Key('portions-$role'),
                style: text.bodyMedium,
              ),
              Text(l10n.plannerPerPortion, style: text.labelSmall),
              MacroLine(planned.perPortion, key: Key('per-portion-$role')),
            ],
          ],
        ),
      ),
    );
  }
}

/// Block totals against the targets, with residual chips: sage within +-5%,
/// terracotta otherwise.
class PlanTotalsCard extends StatelessWidget {
  const PlanTotalsCard({super.key, required this.plan});

  final BatchPlan plan;

  static String signed(double v) => '${v >= 0 ? '+' : '-'}${v.abs().round()}';

  Widget _chip(
    AppLocalizations l10n,
    String key,
    String name,
    double residual,
    double target,
    RangeStatus status,
  ) {
    final percent = target > 0 ? residual / target * 100 : 0.0;
    final label = l10n.plannerResidualChip(
      name,
      signed(residual),
      signed(percent),
    );
    return TintedChip(
      key: Key(key),
      label: label,
      color: status == RangeStatus.within
          ? AppColors.statusWithin
          : AppColors.statusAbove,
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final t = plan.target;
    final c = plan.covered;
    return Card(
      key: const Key('plan-totals'),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.plannerBlockTotals, style: text.titleMedium),
            const SizedBox(height: 8),
            Text(
              l10n.plannerTotalProtein(c.proteinG.round(), t.proteinG.round()),
              key: const Key('total-protein'),
            ),
            Text(
              l10n.plannerTotalCarbs(c.carbsG.round(), t.carbsG.round()),
              key: const Key('total-carbs'),
            ),
            Text(
              l10n.plannerTotalCalories(c.kcal.round(), t.kcal.round()),
              key: const Key('total-kcal'),
            ),
            const SizedBox(height: 8),
            Text(l10n.plannerPerMeal(plan.mealCount), style: text.labelSmall),
            MacroLine(plan.perMeal, key: const Key('per-meal')),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                _chip(
                  l10n,
                  'residual-protein',
                  l10n.plannerNutrientProtein,
                  plan.proteinResidualG,
                  t.proteinG,
                  plan.proteinStatus,
                ),
                _chip(
                  l10n,
                  'residual-carbs',
                  l10n.plannerNutrientCarbs,
                  plan.carbsResidualG,
                  t.carbsG,
                  plan.carbsStatus,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
