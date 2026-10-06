import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/date_utils.dart';
import '../../../core/database/tables.dart';
import '../../../core/nutrition/nutrients.dart';
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

/// One cooked batch item with its live remaining quantity.
class StockItem {
  const StockItem({
    required this.batchItemId,
    required this.batchSessionId,
    required this.cookedOn,
    required this.recipeId,
    required this.recipeName,
    required this.cookedTotalG,
    required this.consumedG,
    required this.nutrientsPerCookedGram,
  });

  final int batchItemId;
  final int batchSessionId;
  final DateTime cookedOn;
  final int recipeId;
  final String recipeName;
  final double cookedTotalG;
  final double consumedG;
  final Nutrients nutrientsPerCookedGram;

  double get remainingG => cookedTotalG - consumedG;
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
    'SELECT 1',
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
          cookedTotalG: r.readTable(batchItems).cookedTotalG,
          consumedG: consumed[r.readTable(batchItems).id] ?? 0,
          nutrientsPerCookedGram:
              perGram[r.readTable(batchItems).id] ?? Nutrients.zero,
        ),
    ];
  }
}
