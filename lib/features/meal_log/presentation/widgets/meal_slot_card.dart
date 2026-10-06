import 'package:flutter/material.dart';

import '../../../../core/nutrition/range.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/number_fields.dart';
import '../../data/meal_log_dao.dart';
import '../../domain/day_summary.dart';
import 'status_style.dart';

/// Presentational meal slot: an empty slot offers "Compose meal"; a filled one
/// shows totals, the protein chip, its components and edit/delete actions.
class MealSlotCard extends StatelessWidget {
  const MealSlotCard({
    super.key,
    required this.slot,
    required this.meal,
    required this.proteinPerMeal,
    required this.onCompose,
    required this.onDelete,
  });

  final MealSlotSummary slot;

  /// The logged meal of this slot; null when the slot is empty.
  final MealView? meal;
  final Range proteinPerMeal;

  /// Opens the composer for this slot (compose when empty, edit when filled).
  final VoidCallback onCompose;
  final VoidCallback onDelete;

  String get _proteinText {
    final range =
        '${formatNumber(proteinPerMeal.min)}-${formatNumber(proteinPerMeal.max)} g';
    final grams = slot.proteinG.round();
    return switch (slot.proteinStatus!) {
      RangeStatus.within => 'Protein $grams g · on target',
      RangeStatus.below => 'Protein $grams g · below $range',
      RangeStatus.above => 'Protein $grams g · above $range',
    };
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final nutrients = slot.nutrients;
    final m = meal;
    return Card(
      key: Key('slot-card-${slot.slot}'),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Meal ${slot.slot}', style: text.titleMedium),
                ),
                if (m != null) ...[
                  IconButton(
                    key: Key('edit-meal-${slot.slot}'),
                    tooltip: 'Edit meal',
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: onCompose,
                  ),
                  IconButton(
                    key: Key('delete-meal-${slot.slot}'),
                    tooltip: 'Delete meal',
                    icon: const Icon(Icons.delete_outline),
                    onPressed: onDelete,
                  ),
                ],
              ],
            ),
            if (nutrients == null || m == null)
              Align(
                alignment: Alignment.centerLeft,
                child: FilledButton.icon(
                  key: Key('compose-slot-${slot.slot}'),
                  onPressed: onCompose,
                  icon: const Icon(Icons.restaurant_outlined),
                  label: const Text('Compose meal'),
                ),
              )
            else ...[
              Text(
                '${nutrients.kcal.round()} kcal · P ${nutrients.proteinG.round()} '
                '· F ${nutrients.fatG.round()} · C ${nutrients.carbsG.round()}',
                key: Key('slot-totals-${slot.slot}'),
                style: text.titleSmall,
              ),
              const SizedBox(height: 8),
              TintedChip(
                key: Key('slot-protein-${slot.slot}'),
                label: _proteinText,
                color: slot.proteinStatus == RangeStatus.within
                    ? AppColors.sage
                    : AppColors.terracotta,
              ),
              const SizedBox(height: 8),
              Text(
                m.components
                    .map((c) => '${c.label} ${c.grams.round()} g')
                    .join(' · '),
                key: Key('slot-components-${slot.slot}'),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: text.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
