import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../core/nutrition/nutrients.dart';
import '../../../../core/nutrition/range.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/number_fields.dart';
import '../../../nutrition_targets/domain/day_type.dart';
import '../../../recipes/presentation/widgets/macro_line.dart';

/// Presentational live totals of the meal under composition.
///
/// Color semantics: sage when protein is within the per-meal range,
/// terracotta when it is below or above it.
class MealTotalsCard extends StatelessWidget {
  const MealTotalsCard({
    super.key,
    required this.totals,
    required this.proteinRange,
    required this.proteinStatus,
    required this.proteinOutsideG,
    required this.dayType,
    required this.remainingKcal,
    required this.remainingCarbsG,
  });

  final Nutrients totals;
  final Range proteinRange;
  final RangeStatus proteinStatus;

  /// Negative below the range, positive above it, zero within.
  final double proteinOutsideG;
  final DayType dayType;
  final double remainingKcal;
  final double remainingCarbsG;

  String _proteinText(AppLocalizations l10n) {
    final range =
        '${formatNumber(proteinRange.min)}-${formatNumber(proteinRange.max)} g';
    return switch (proteinStatus) {
      RangeStatus.within => l10n.mealLogMealProteinOnTarget(range),
      RangeStatus.below => l10n.mealLogMealProteinBelow(
        proteinOutsideG.abs().round(),
        range,
      ),
      RangeStatus.above => l10n.mealLogMealProteinAbove(
        proteinOutsideG.round(),
        range,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = Theme.of(context).textTheme;
    final color = proteinStatus == RangeStatus.within
        ? AppColors.statusWithin
        : AppColors.statusAbove;
    return Card(
      key: const Key('meal-totals'),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MacroLine(totals, style: text.titleSmall),
            const SizedBox(height: 8),
            Container(
              key: const Key('protein-status'),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                border: Border.all(color: color, width: 1.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _proteinText(l10n),
                style: text.labelLarge?.copyWith(color: AppColors.cream),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.mealLogDayRemaining(
                dayType.name,
                remainingKcal.round(),
                remainingCarbsG.round(),
              ),
              key: const Key('day-remaining'),
              style: text.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
