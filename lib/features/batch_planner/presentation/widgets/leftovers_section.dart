import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../inventory/data/inventory_dao.dart';
import '../../../inventory/presentation/localized_dates.dart';

/// Presentational toggles for cooked pantry items that count toward the block.
class LeftoversSection extends StatelessWidget {
  const LeftoversSection({
    super.key,
    required this.items,
    required this.selectedIds,
    required this.onToggle,
  });

  /// Pantry items that still have stock.
  final List<StockItem> items;
  final Set<int> selectedIds;
  final void Function(int batchItemId, bool use) onToggle;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.plannerLeftoversTitle, style: text.titleMedium),
        Text(l10n.plannerLeftoversSubtitle, style: text.bodySmall),
        const SizedBox(height: 4),
        if (items.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              l10n.plannerNoLeftovers,
              key: const Key('no-leftovers'),
              style: text.bodyMedium,
            ),
          )
        else
          for (final s in items)
            SwitchListTile(
              key: Key('leftover-${s.batchItemId}'),
              contentPadding: EdgeInsets.zero,
              title: Text(s.recipeName),
              subtitle: Text(
                l10n.plannerLeftoverSubtitle(
                  s.remainingG.round(),
                  localizedShortDate(context, s.cookedOn),
                ),
              ),
              value: selectedIds.contains(s.batchItemId),
              onChanged: (v) => onToggle(s.batchItemId, v),
            ),
      ],
    );
  }
}
