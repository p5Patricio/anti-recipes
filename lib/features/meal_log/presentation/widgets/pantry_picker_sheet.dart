import 'package:flutter/material.dart';

import '../../../../core/formatting/date_format.dart';
import '../../../inventory/data/inventory_dao.dart';

/// Bottom sheet listing pantry items with stock left; pops with the choice.
class PantryPickerSheet extends StatelessWidget {
  const PantryPickerSheet({super.key, required this.items});

  final List<StockItem> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.6,
      child: items.isEmpty
          ? const Center(child: Text('Nothing left in the pantry.'))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, i) {
                final s = items[i];
                return ListTile(
                  key: Key('pick-stock-${s.batchItemId}'),
                  title: Text(s.recipeName),
                  subtitle: Text(
                    '${s.remainingG.round()} g left · cooked '
                    '${shortDate(s.cookedOn)}',
                  ),
                  onTap: () => Navigator.pop(context, s),
                );
              },
            ),
    );
  }
}
