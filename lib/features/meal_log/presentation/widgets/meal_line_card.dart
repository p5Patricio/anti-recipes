import 'package:flutter/material.dart';

import '../../../../core/nutrition/nutrients.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/number_fields.dart';
import '../../../recipes/presentation/widgets/macro_line.dart';

/// Quick grams amounts offered for pantry components.
const quickGramAmounts = [25.0, 50.0, 100.0];

/// Presentational meal component: grams field, quick chips and its macros.
class MealLineCard extends StatelessWidget {
  const MealLineCard({
    super.key,
    required this.idKey,
    required this.label,
    required this.subtitle,
    required this.grams,
    required this.nutrients,
    required this.onRemove,
    this.warning,
    this.onAdd,
    this.onAll,
  });

  /// Stable id used in widget keys, e.g. `b3` (batch item) or `i7` (ingredient).
  final String idKey;
  final String label;
  final String subtitle;
  final TextEditingController grams;
  final Nutrients nutrients;
  final VoidCallback onRemove;

  /// Shown when the grams exceed what is left in the pantry.
  final String? warning;

  /// Adds grams (clamped to the remaining stock); null hides the chips.
  final ValueChanged<double>? onAdd;
  final VoidCallback? onAll;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(label, style: text.titleSmall)),
                IconButton(
                  key: Key('remove-$idKey'),
                  tooltip: 'Remove',
                  icon: const Icon(Icons.close),
                  onPressed: onRemove,
                ),
              ],
            ),
            Text(subtitle, style: text.bodySmall),
            const SizedBox(height: 8),
            NumberField(
              key: Key('grams-$idKey'),
              controller: grams,
              label: 'Amount',
              suffix: 'g',
              validator: numberValidator(positive: true),
            ),
            if (onAdd != null) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  for (final amount in quickGramAmounts)
                    ActionChip(
                      key: Key('chip-$idKey-${amount.round()}'),
                      label: Text('+${amount.round()} g'),
                      onPressed: () => onAdd!(amount),
                    ),
                  ActionChip(
                    key: Key('chip-$idKey-all'),
                    label: const Text('All remaining'),
                    onPressed: onAll,
                  ),
                ],
              ),
            ],
            if (warning != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  warning!,
                  key: Key('warning-$idKey'),
                  style: text.bodySmall?.copyWith(color: AppColors.error),
                ),
              ),
            const SizedBox(height: 4),
            MacroLine(nutrients, style: text.bodySmall),
          ],
        ),
      ),
    );
  }
}
