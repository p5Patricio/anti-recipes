import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../inventory/data/inventory_dao.dart';
import 'localized_dates.dart';

/// Bottom sheet listing pantry items with stock left; pops with the choice.
class PantryPickerSheet extends StatelessWidget {
  const PantryPickerSheet({super.key, required this.items});

  final List<StockItem> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.6,
      child: items.isEmpty
          ? Center(child: Text(context.l10n.mealLogPantryEmpty))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, i) {
                final s = items[i];
                return ListTile(
                  key: Key('pick-stock-${s.batchItemId}'),
                  title: Text(s.recipeName),
                  subtitle: Text(
                    context.l10n.mealLogPantryItemSubtitle(
                      s.remainingG.round(),
                      localizedShortDate(context, s.cookedOn),
                    ),
                  ),
                  onTap: () => Navigator.pop(context, s),
                );
              },
            ),
    );
  }
}
