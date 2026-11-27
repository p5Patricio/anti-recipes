import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../core/widgets/number_fields.dart';
import '../../domain/day_summary.dart';
import 'status_style.dart';

/// Presentational fruit and vegetable portion steppers with status chips.
class ServingsCard extends StatelessWidget {
  const ServingsCard({
    super.key,
    required this.fruit,
    required this.veg,
    required this.onFruit,
    required this.onVeg,
  });

  final MetricProgress fruit;
  final MetricProgress veg;

  /// Receive +1 or -1.
  final ValueChanged<int> onFruit;
  final ValueChanged<int> onVeg;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Card(
      key: const Key('servings-card'),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.l10n.mealLogServingsTitle, style: text.titleMedium),
            const SizedBox(height: 8),
            _ServingRow(
              id: 'fruit',
              label: context.l10n.mealLogFruit,
              progress: fruit,
              onStep: onFruit,
            ),
            _ServingRow(
              id: 'veg',
              label: context.l10n.mealLogVegetables,
              progress: veg,
              onStep: onVeg,
            ),
          ],
        ),
      ),
    );
  }
}

class _ServingRow extends StatelessWidget {
  const _ServingRow({
    required this.id,
    required this.label,
    required this.progress,
    required this.onStep,
  });

  final String id;
  final String label;
  final MetricProgress progress;
  final ValueChanged<int> onStep;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final range = progress.range!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: text.titleSmall),
                Text(
                  context.l10n.mealLogPortionsGoal(
                    '${formatNumber(range.min)}-${formatNumber(range.max)}',
                  ),
                  style: text.bodySmall,
                ),
              ],
            ),
          ),
          StatusChip(key: Key('$id-status'), status: progress.status),
          IconButton(
            key: Key('$id-minus'),
            tooltip: context.l10n.mealLogRemovePortion(label),
            icon: const Icon(Icons.remove_circle_outline),
            onPressed: progress.consumed > 0 ? () => onStep(-1) : null,
          ),
          SizedBox(
            width: 28,
            child: Text(
              '${progress.consumed.round()}',
              key: Key('$id-count'),
              textAlign: TextAlign.center,
              style: text.titleMedium,
            ),
          ),
          IconButton(
            key: Key('$id-plus'),
            tooltip: context.l10n.mealLogAddPortion(label),
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () => onStep(1),
          ),
        ],
      ),
    );
  }
}
