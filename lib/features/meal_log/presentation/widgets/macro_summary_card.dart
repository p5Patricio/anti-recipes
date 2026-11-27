import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n.dart';
import '../../domain/day_summary.dart';
import 'metric_bar.dart';
import 'status_style.dart';

/// Presentational calories and macros summary of the day.
class MacroSummaryCard extends StatelessWidget {
  const MacroSummaryCard({super.key, required this.summary});

  final DaySummary summary;

  String _left(AppLocalizations l10n, MetricProgress p, String unit) =>
      l10n.mealLogRemaining(
        p.remaining >= 0 ? 'left' : 'over',
        p.remaining.abs().round(),
        unit,
      );

  String _withRange(
    String Function(String, String, int, String) build,
    MetricProgress p,
    String unit,
  ) => build(
    p.remaining >= 0 ? 'left' : 'over',
    rangeText(p, unit),
    p.remaining.abs().round(),
    unit,
  );

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final s = summary;
    final l10n = context.l10n;
    return Card(
      key: const Key('macro-summary'),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.mealLogMacrosTitle, style: text.titleMedium),
            const SizedBox(height: 12),
            MetricBar(
              key: const Key('bar-kcal'),
              label: l10n.mealLogCalories,
              progress: s.kcal,
              unit: 'kcal',
              detail: _withRange(
                l10n.mealLogRangeWithRemaining,
                s.kcal,
                'kcal',
              ),
            ),
            const SizedBox(height: 12),
            MetricBar(
              key: const Key('bar-protein'),
              label: l10n.mealLogProtein,
              progress: s.protein,
              unit: 'g',
              detail: _left(l10n, s.protein, 'g'),
            ),
            const SizedBox(height: 12),
            MetricBar(
              key: const Key('bar-fat'),
              label: l10n.mealLogFat,
              progress: s.fat,
              unit: 'g',
              detail: _left(l10n, s.fat, 'g'),
            ),
            const SizedBox(height: 12),
            MetricBar(
              key: const Key('bar-carbs'),
              label: l10n.mealLogCarbs,
              progress: s.carbs,
              unit: 'g',
              detail: _withRange(
                l10n.mealLogConfiguredWithRemaining,
                s.carbs,
                'g',
              ),
            ),
            const SizedBox(height: 12),
            MetricBar(
              key: const Key('bar-fiber'),
              label: l10n.mealLogFiber,
              progress: s.fiber,
              unit: 'g',
              detail: l10n.mealLogRangeOnly(rangeText(s.fiber, 'g')),
            ),
            if (s.carbsOutsideConfiguredRange) ...[
              const SizedBox(height: 12),
              Row(
                key: const Key('carbs-info'),
                children: [
                  const Icon(Icons.info_outline, size: 16),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      l10n.mealLogCarbsDerivedInfo(s.carbs.target.round()),
                      style: text.bodySmall,
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                StatusChip(
                  key: const Key('status-kcal'),
                  status: s.kcal.status,
                  label: l10n.mealLogCaloriesStatus(s.kcal.status.name),
                ),
                StatusChip(
                  key: const Key('status-fiber'),
                  status: s.fiber.status,
                  label: l10n.mealLogFiberStatus(s.fiber.status.name),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
