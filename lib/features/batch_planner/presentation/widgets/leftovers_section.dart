import 'package:flutter/material.dart';

import '../../../../core/formatting/date_format.dart';
import '../../../inventory/data/inventory_dao.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Pantry leftovers', style: text.titleMedium),
        Text(
          'Cooked food you still have is deducted from what to cook.',
          style: text.bodySmall,
        ),
        const SizedBox(height: 4),
        if (items.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Nothing cooked is left in the pantry.',
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
                '${s.remainingG.round()} g left · cooked '
                '${shortDate(s.cookedOn)}',
              ),
              value: selectedIds.contains(s.batchItemId),
              onChanged: (v) => onToggle(s.batchItemId, v),
            ),
      ],
    );
  }
}
