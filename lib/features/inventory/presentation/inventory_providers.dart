import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../data/inventory_dao.dart';

/// Live stock of every batch item, newest batch first.
final stockProvider = StreamProvider<List<StockItem>>(
  (ref) => ref.watch(inventoryDaoProvider).watchStock(),
);

/// One stock item by batch item id; data(null) once it no longer exists.
final stockItemProvider = Provider.family<AsyncValue<StockItem?>, int>(
  (ref, id) => ref
      .watch(stockProvider)
      .whenData((all) => all.where((s) => s.batchItemId == id).firstOrNull),
);

/// Meals that consumed the item; reloads whenever the stock changes.
final batchConsumptionProvider = FutureProvider.autoDispose
    .family<List<ConsumptionEntry>, int>((ref, id) {
      ref.watch(stockProvider);
      return ref.watch(inventoryDaoProvider).loadConsumption(id);
    });
