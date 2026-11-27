import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/l10n/l10n.dart';
import '../../recipes/presentation/widgets/confirm_delete.dart';
import '../../recipes/presentation/widgets/macro_line.dart';
import '../data/inventory_dao.dart';
import 'inventory_providers.dart';
import 'localized_dates.dart';

/// Typical portion shown next to the per-100 g macros.
const double typicalPortionG = 150;

/// Remaining stock, macros and consumption history of one batch item.
class BatchItemDetailScreen extends ConsumerWidget {
  const BatchItemDetailScreen(this.batchItemId, {super.key});

  final int batchItemId;

  Future<void> _delete(BuildContext context, WidgetRef ref, String name) async {
    final navigator = Navigator.of(context);
    final l10n = context.l10n;
    final dao = ref.read(inventoryDaoProvider);
    final done = await confirmAndDelete(
      context,
      title: l10n.pantryDeleteTitle(name),
      message: l10n.pantryDeleteMessage,
      blockedMessage: l10n.pantryDeleteBlocked,
      inUse: () => dao.isBatchItemConsumed(batchItemId),
      delete: () async {
        if (!await dao.deleteBatchItemIfUnused(batchItemId)) {
          throw StateError('Batch item is in use');
        }
      },
    );
    if (done) navigator.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(stockItemProvider(batchItemId)).value;
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(item?.recipeName ?? l10n.pantryBatchItemTitle),
        actions: [
          if (item != null)
            IconButton(
              key: const Key('delete-batch-item'),
              tooltip: l10n.pantryDelete,
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _delete(context, ref, item.recipeName),
            ),
        ],
      ),
      body: item == null
          ? Center(child: Text(l10n.pantryItemGone))
          : _DetailBody(item),
    );
  }
}

class _DetailBody extends ConsumerWidget {
  const _DetailBody(this.item);

  final StockItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final history = ref.watch(batchConsumptionProvider(item.batchItemId));
    final left = item.remainingG < 0 ? 0 : item.remainingG;
    final perGram = item.nutrientsPerCookedGram;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          l10n.pantryCooked(localizedWeekdayDate(context, item.cookedOn)),
          style: text.titleSmall,
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.pantryGramsLeft(left.round(), item.cookedTotalG.round()),
                  key: const Key('detail-remaining'),
                  style: text.titleMedium,
                ),
                const SizedBox(height: 12),
                Text(l10n.pantryPer100Cooked, style: text.labelMedium),
                MacroLine(perGram.scale(100)),
                const SizedBox(height: 8),
                Text(
                  l10n.pantryPerTypicalPortion(typicalPortionG.round()),
                  style: text.labelMedium,
                ),
                MacroLine(
                  perGram.scale(typicalPortionG),
                  key: const Key('detail-portion'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(l10n.pantryConsumptionHistory, style: text.titleMedium),
        history.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => Text(l10n.pantryHistoryError('$e')),
          data: (entries) => entries.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(l10n.pantryNotUsed),
                )
              : Column(
                  children: [
                    for (final e in entries)
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          l10n.pantryHistoryEntry(
                            localizedWeekdayDate(context, e.date),
                            e.slot,
                          ),
                        ),
                        trailing: Text('${e.grams.round()} g'),
                      ),
                  ],
                ),
        ),
      ],
    );
  }
}
