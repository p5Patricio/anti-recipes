import 'package:flutter/material.dart';

import '../../domain/day_summary.dart';
import 'metric_bar.dart';
import 'status_style.dart';

/// Quick amounts (ml) offered for hydration.
const hydrationQuickAmounts = [250, 500, 750];

/// Presentational hydration progress with quick-add, custom and undo actions.
class HydrationCard extends StatelessWidget {
  const HydrationCard({
    super.key,
    required this.water,
    required this.onAdd,
    required this.onCustom,
    required this.onUndo,
  });

  final MetricProgress water;
  final ValueChanged<int> onAdd;
  final VoidCallback onCustom;

  /// Null disables the button (nothing logged yet).
  final VoidCallback? onUndo;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Card(
      key: const Key('hydration-card'),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text('Hydration', style: text.titleMedium)),
                StatusChip(
                  key: const Key('status-water'),
                  status: water.status,
                ),
              ],
            ),
            const SizedBox(height: 12),
            MetricBar(
              key: const Key('bar-water'),
              label: 'Water',
              progress: water,
              unit: 'ml',
              detail: 'Goal ${rangeText(water, 'ml')}',
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final ml in hydrationQuickAmounts)
                  FilledButton.tonal(
                    key: Key('hydration-add-$ml'),
                    onPressed: () => onAdd(ml),
                    child: Text('+$ml ml'),
                  ),
                OutlinedButton(
                  key: const Key('hydration-custom'),
                  onPressed: onCustom,
                  child: const Text('Custom'),
                ),
                TextButton.icon(
                  key: const Key('hydration-undo'),
                  onPressed: onUndo,
                  icon: const Icon(Icons.undo),
                  label: const Text('Undo last'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
