import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/formatting/date_format.dart';
import '../../recipes/presentation/widgets/confirm_delete.dart';
import '../../recipes/presentation/widgets/macro_line.dart';
import '../data/inventory_dao.dart';
import 'inventory_providers.dart';

/// Typical portion shown next to the per-100 g macros.
const double typicalPortionG = 150;

/// Remaining stock, macros and consumption history of one batch item.
class BatchItemDetailScreen extends ConsumerWidget {
  const BatchItemDetailScreen(this.batchItemId, {super.key});

  final int batchItemId;

  Future<void> _delete(BuildContext context, WidgetRef ref, String name) async {
    final navigator = Navigator.of(context);
    final dao = ref.read(inventoryDaoProvider);
    final done = await confirmAndDelete(
      context,
      title: 'Delete "$name"?',
      message: 'This batch item will be removed from your pantry.',
      blockedMessage:
          'This batch item was used in a meal, so it cannot be deleted.',
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
    return Scaffold(
      appBar: AppBar(
        title: Text(item?.recipeName ?? 'Batch item'),
        actions: [
          if (item != null)
            IconButton(
              key: const Key('delete-batch-item'),
              tooltip: 'Delete',
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _delete(context, ref, item.recipeName),
            ),
        ],
      ),
      body: item == null
          ? const Center(child: Text('This batch item no longer exists.'))
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
    final history = ref.watch(batchConsumptionProvider(item.batchItemId));
    final left = item.remainingG < 0 ? 0 : item.remainingG;
    final perGram = item.nutrientsPerCookedGram;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Cooked ${weekdayDate(item.cookedOn)}', style: text.titleSmall),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${left.round()} g left of ${item.cookedTotalG.round()} g',
                  key: const Key('detail-remaining'),
                  style: text.titleMedium,
                ),
                const SizedBox(height: 12),
                Text('Per 100 g cooked', style: text.labelMedium),
                MacroLine(perGram.scale(100)),
                const SizedBox(height: 8),
                Text(
                  'Per typical ${typicalPortionG.round()} g portion',
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
        Text('Consumption history', style: text.titleMedium),
        history.when(
          loading: () => const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => Text('Could not load history: $e'),
          data: (entries) => entries.isEmpty
              ? const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text('Not used in any meal yet.'),
                )
              : Column(
                  children: [
                    for (final e in entries)
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: Text('${weekdayDate(e.date)} · Meal ${e.slot}'),
                        trailing: Text('${e.grams.round()} g'),
                      ),
                  ],
                ),
        ),
      ],
    );
  }
}
