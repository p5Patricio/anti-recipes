import 'package:flutter/material.dart';

import '../../domain/day_summary.dart';
import 'metric_bar.dart';
import 'status_style.dart';

/// Presentational calories and macros summary of the day.
class MacroSummaryCard extends StatelessWidget {
  const MacroSummaryCard({super.key, required this.summary});

  final DaySummary summary;

  String _left(MetricProgress p, String unit) => p.remaining >= 0
      ? '${p.remaining.round()} $unit left'
      : '${(-p.remaining).round()} $unit over';

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final s = summary;
    return Card(
      key: const Key('macro-summary'),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Calories & macros', style: text.titleMedium),
            const SizedBox(height: 12),
            MetricBar(
              key: const Key('bar-kcal'),
              label: 'Calories',
              progress: s.kcal,
              unit: 'kcal',
              detail:
                  'Range ${rangeText(s.kcal, 'kcal')} · ${_left(s.kcal, 'kcal')}',
            ),
            const SizedBox(height: 12),
            MetricBar(
              key: const Key('bar-protein'),
              label: 'Protein',
              progress: s.protein,
              unit: 'g',
              detail: _left(s.protein, 'g'),
            ),
            const SizedBox(height: 12),
            MetricBar(
              key: const Key('bar-fat'),
              label: 'Fat',
              progress: s.fat,
              unit: 'g',
              detail: _left(s.fat, 'g'),
            ),
            const SizedBox(height: 12),
            MetricBar(
              key: const Key('bar-carbs'),
              label: 'Carbs',
              progress: s.carbs,
              unit: 'g',
              detail:
                  'Configured ${rangeText(s.carbs, 'g')} · ${_left(s.carbs, 'g')}',
            ),
            const SizedBox(height: 12),
            MetricBar(
              key: const Key('bar-fiber'),
              label: 'Fiber',
              progress: s.fiber,
              unit: 'g',
              detail: 'Range ${rangeText(s.fiber, 'g')}',
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
                      'Carbs target ${s.carbs.target.round()} g '
                      'is derived from calories and sits outside the configured '
                      'range.',
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
                  prefix: 'Calories',
                ),
                StatusChip(
                  key: const Key('status-fiber'),
                  status: s.fiber.status,
                  prefix: 'Fiber',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
