import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/date_utils.dart';
import '../../../core/database/tables.dart';
import '../../../core/nutrition/nutrients.dart';
import '../../recipes/domain/recipe_kind.dart';
import 'batch_nutrition.dart';

part 'inventory_dao.g.dart';

class BatchItemDraft {
  const BatchItemDraft({
    required this.recipeId,
    required this.rawTotalG,
    required this.cookedTotalG,
  });
  final int recipeId;
  final double rawTotalG;
  final double cookedTotalG;
}

/// Fraction of the cooked total below which a batch item counts as low stock.
const double lowStockFraction = 0.15;

/// One cooked batch item with its live remaining quantity.
class StockItem {
  const StockItem({
    required this.batchItemId,
    required this.batchSessionId,
    required this.cookedOn,
    required this.recipeId,
    required this.recipeName,
    required this.recipeKind,
    required this.cookedTotalG,
    required this.consumedG,
    required this.nutrientsPerCookedGram,
  });

  final int batchItemId;
  final int batchSessionId;
  final DateTime cookedOn;
  final int recipeId;
  final String recipeName;
  final RecipeKind recipeKind;
  final double cookedTotalG;
  final double consumedG;
  final Nutrients nutrientsPerCookedGram;

  double get remainingG => cookedTotalG - consumedG;

  /// 0..1, never negative even when meals were logged beyond the stock.
  double get remainingFraction =>
      cookedTotalG > 0 ? (remainingG / cookedTotalG).clamp(0.0, 1.0) : 0;

  bool get isEmpty => remainingG <= 0;

  bool get isLow => !isEmpty && remainingFraction < lowStockFraction;
}

/// One meal that consumed part of a batch item.
class ConsumptionEntry {
  const ConsumptionEntry({
    required this.mealLogId,
    required this.date,
    required this.slot,
    required this.grams,
  });
  final int mealLogId;
  final DateTime date;
  final int slot;
  final double grams;
}

@DriftAccessor(
  tables: [
    BatchSessions,
    BatchItems,
    Recipes,
    RecipeIngredients,
    Ingredients,
    MealComponents,
  ],
)
class InventoryDao extends DatabaseAccessor<AppDatabase>
    with _$InventoryDaoMixin {
  InventoryDao(super.db);

  Future<int> createBatch({
    required DateTime cookedOn,
    required DateTime coversFrom,
    required DateTime coversTo,
    required List<BatchItemDraft> items,
  }) => transaction(() async {
    final sessionId = await into(batchSessions).insert(
      BatchSessionsCompanion.insert(
        cookedOn: dateOnly(cookedOn),
        coversFrom: dateOnly(coversFrom),
        coversTo: dateOnly(coversTo),
      ),
    );
    await batch((b) {
      b.insertAll(batchItems, [
        for (final i in items)
          BatchItemsCompanion.insert(
            batchSessionId: sessionId,
            recipeId: i.recipeId,
            rawTotalG: i.rawTotalG,
            cookedTotalG: i.cookedTotalG,
          ),
      ]);
    });
    return sessionId;
  });

  /// Stock per batch item, newest batch first. `consumedG` and `remainingG`
  /// are always derived from logged meal components, never stored.
  Stream<List<StockItem>> watchStock() => customSelect(
    // Drift shares streams by SQL text alone, so every watcher needs its own.
    'SELECT 1 AS watch_stock',
    readsFrom: {
      batchSessions,
      batchItems,
      recipes,
      recipeIngredients,
      ingredients,
      mealComponents,
    },
  ).watch().asyncMap((_) => loadStock());

  Future<List<StockItem>> loadStock() async {
    final rows =
        await (select(batchItems).join([
              innerJoin(
                batchSessions,
                batchSessions.id.equalsExp(batchItems.batchSessionId),
              ),
              innerJoin(recipes, recipes.id.equalsExp(batchItems.recipeId)),
            ])..orderBy([
              OrderingTerm.desc(batchSessions.cookedOn),
              OrderingTerm.desc(batchItems.id),
            ]))
            .get();

    final consumedSum = mealComponents.grams.sum();
    final consumedRows =
        await (selectOnly(mealComponents)
              ..addColumns([mealComponents.batchItemId, consumedSum])
              ..where(mealComponents.batchItemId.isNotNull())
              ..groupBy([mealComponents.batchItemId]))
            .get();
    final consumed = {
      for (final r in consumedRows)
        r.read(mealComponents.batchItemId)!: r.read(consumedSum) ?? 0.0,
    };

    final perGram = await nutrientsPerCookedGramByBatchItem(
      attachedDatabase,
      rows.map((r) => r.readTable(batchItems)),
    );

    return [
      for (final r in rows)
        StockItem(
          batchItemId: r.readTable(batchItems).id,
          batchSessionId: r.readTable(batchSessions).id,
          cookedOn: r.readTable(batchSessions).cookedOn,
          recipeId: r.readTable(recipes).id,
          recipeName: r.readTable(recipes).name,
          recipeKind: r.readTable(recipes).kind,
          cookedTotalG: r.readTable(batchItems).cookedTotalG,
          consumedG: consumed[r.readTable(batchItems).id] ?? 0,
          nutrientsPerCookedGram:
              perGram[r.readTable(batchItems).id] ?? Nutrients.zero,
        ),
    ];
  }

  /// Meals that consumed the batch item, newest first.
  Future<List<ConsumptionEntry>> loadConsumption(int batchItemId) async {
    final db = attachedDatabase;
    final rows =
        await (db.select(db.mealComponents).join([
                innerJoin(
                  db.mealLogs,
                  db.mealLogs.id.equalsExp(db.mealComponents.mealLogId),
                ),
              ])
              ..where(db.mealComponents.batchItemId.equals(batchItemId))
              ..orderBy([
                OrderingTerm.desc(db.mealLogs.date),
                OrderingTerm.desc(db.mealLogs.slot),
              ]))
            .get();
    return [
      for (final r in rows)
        ConsumptionEntry(
          mealLogId: r.readTable(db.mealLogs).id,
          date: r.readTable(db.mealLogs).date,
          slot: r.readTable(db.mealLogs).slot,
          grams: r.readTable(db.mealComponents).grams,
        ),
    ];
  }

  Future<bool> isBatchItemConsumed(int batchItemId) async {
    final rows =
        await (select(mealComponents)
              ..where((c) => c.batchItemId.equals(batchItemId))
              ..limit(1))
            .get();
    return rows.isNotEmpty;
  }

  /// Deletes a batch item that was never consumed; returns false (and changes
  /// nothing) otherwise. A session left without items is removed with it.
  Future<bool> deleteBatchItemIfUnused(int batchItemId) =>
      transaction(() async {
        if (await isBatchItemConsumed(batchItemId)) return false;
        final item = await (select(
          batchItems,
        )..where((i) => i.id.equals(batchItemId))).getSingleOrNull();
        if (item == null) return false;
        await (delete(batchItems)..where((i) => i.id.equals(batchItemId))).go();
        final siblings =
            await (select(batchItems)
                  ..where((i) => i.batchSessionId.equals(item.batchSessionId))
                  ..limit(1))
                .get();
        if (siblings.isEmpty) {
          await (delete(
            batchSessions,
          )..where((s) => s.id.equals(item.batchSessionId))).go();
        }
        return true;
      });
}
