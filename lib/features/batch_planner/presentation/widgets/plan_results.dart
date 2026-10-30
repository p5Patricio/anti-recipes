import 'package:flutter/material.dart';

import '../../../../core/formatting/date_format.dart';
import '../../../../core/formatting/grams_format.dart';
import '../../../../core/nutrition/nutrients.dart';
import '../../../../core/nutrition/range.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../meal_log/presentation/widgets/day_header.dart';
import '../../../meal_log/presentation/widgets/status_style.dart';
import '../../../recipes/presentation/widgets/macro_line.dart';
import '../../domain/batch_plan.dart';
import 'role_picker_card.dart';

String _need(double kcal, double protein, double carbs) =>
    '${kcal.round()} kcal · P ${protein.round()} g · C ${carbs.round()} g';

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
                  child: Text(weekdayDate(need.date), style: text.titleSmall),
                ),
                DayTypeBadge(need.dayType),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'Need ${_need(need.kcal, need.proteinG, need.carbsG)}',
              key: Key('day-need-${need.date.day}'),
              style: text.bodyMedium,
            ),
            if (hasCoverage)
              Text(
                'Covered ${_need(covered.kcal, covered.proteinG, covered.carbsG)}',
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
            Text(planned.role.label, style: text.bodySmall),
            const SizedBox(height: 8),
            if (!planned.isNeeded)
              Text(
                'Nothing to cook: the rest of the plan already covers it.',
                key: Key('not-needed-$role'),
                style: text.bodyMedium,
              )
            else ...[
              Text(
                'Raw ${formatGrams(planned.rawG)} g · cooked '
                '${formatGrams(planned.cookedG)} g '
                '(yield ${planned.recipe.yieldFactor.toStringAsFixed(2)})',
                key: Key('raw-cooked-$role'),
                style: text.titleSmall,
              ),
              const SizedBox(height: 6),
              for (final l in planned.lines)
                Text(
                  '${formatGrams(l.rawG)} g ${l.name}',
                  key: Key('line-$role-${l.ingredientId}'),
                  style: text.bodyMedium,
                ),
              const SizedBox(height: 8),
              Text(
                '${planned.portions} portions of '
                '${planned.gramsPerPortion.round()} g cooked',
                key: Key('portions-$role'),
                style: text.bodyMedium,
              ),
              Text('Per portion', style: text.labelSmall),
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
    String key,
    String label,
    double residual,
    double target,
    RangeStatus status,
  ) {
    final percent = target > 0 ? residual / target * 100 : 0.0;
    return TintedChip(
      key: Key(key),
      label: '$label ${signed(residual)} g (${signed(percent)}%)',
      color: status == RangeStatus.within
          ? AppColors.sage
          : AppColors.terracotta,
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final t = plan.target;
    final c = plan.covered;
    return Card(
      key: const Key('plan-totals'),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Block totals', style: text.titleMedium),
            const SizedBox(height: 8),
            Text(
              'Protein ${c.proteinG.round()} / ${t.proteinG.round()} g',
              key: const Key('total-protein'),
            ),
            Text(
              'Carbs ${c.carbsG.round()} / ${t.carbsG.round()} g',
              key: const Key('total-carbs'),
            ),
            Text(
              'Calories ${c.kcal.round()} / ${t.kcal.round()} kcal',
              key: const Key('total-kcal'),
            ),
            const SizedBox(height: 8),
            Text('Per meal (${plan.mealCount} meals)', style: text.labelSmall),
            MacroLine(plan.perMeal, key: const Key('per-meal')),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                _chip(
                  'residual-protein',
                  'Protein',
                  plan.proteinResidualG,
                  t.proteinG,
                  plan.proteinStatus,
                ),
                _chip(
                  'residual-carbs',
                  'Carbs',
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
