import 'package:anti_recipes/core/database/app_database.dart';
import 'package:anti_recipes/features/inventory/data/inventory_dao.dart';
import 'package:anti_recipes/features/recipes/domain/recipe_kind.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/db_seed.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  group('consumption history', () {
    test('lists the meals that used the item, newest first', () async {
      final recipeId = await seedRecipe(db, 'Grilled chicken');
      final itemId = await seedBatchItem(db, recipeId);
      await logBatchMeal(db, itemId, 120, date: DateTime(2026, 10, 2), slot: 2);
      await logBatchMeal(db, itemId, 80, date: DateTime(2026, 10, 3), slot: 1);
      await logBatchMeal(db, itemId, 60, date: DateTime(2026, 10, 3), slot: 3);

      final history = await db.inventoryDao.loadConsumption(itemId);

      expect(history.map((e) => (e.date.day, e.slot, e.grams)), [
        (3, 3, 60.0),
        (3, 1, 80.0),
        (2, 2, 120.0),
      ]);
    });

    test('only includes the requested item', () async {
      final recipeId = await seedRecipe(db, 'Grilled chicken');
      final a = await seedBatchItem(db, recipeId);
      final b = await seedBatchItem(db, recipeId);
      await logBatchMeal(db, a, 100);

      expect(await db.inventoryDao.loadConsumption(b), isEmpty);
      expect(await db.inventoryDao.loadConsumption(a), hasLength(1));
    });
  });

  group('safe delete', () {
    test('deletes an unused item and its now-empty session', () async {
      final recipeId = await seedRecipe(db, 'Grilled chicken');
      final itemId = await seedBatchItem(db, recipeId);

      expect(await db.inventoryDao.isBatchItemConsumed(itemId), isFalse);
      expect(await db.inventoryDao.deleteBatchItemIfUnused(itemId), isTrue);

      expect(await db.select(db.batchItems).get(), isEmpty);
      expect(await db.select(db.batchSessions).get(), isEmpty);
    });

    test('keeps the session while it still has other items', () async {
      final recipeId = await seedRecipe(db, 'Grilled chicken');
      await db.inventoryDao.createBatch(
        cookedOn: monday,
        coversFrom: monday,
        coversTo: monday,
        items: [
          BatchItemDraft(recipeId: recipeId, rawTotalG: 400, cookedTotalG: 300),
          BatchItemDraft(recipeId: recipeId, rawTotalG: 200, cookedTotalG: 150),
        ],
      );
      final first = (await db.select(db.batchItems).get()).first;

      expect(await db.inventoryDao.deleteBatchItemIfUnused(first.id), isTrue);

      expect(await db.select(db.batchItems).get(), hasLength(1));
      expect(await db.select(db.batchSessions).get(), hasLength(1));
    });

    test('refuses to delete an item that was consumed', () async {
      final recipeId = await seedRecipe(db, 'Grilled chicken');
      final itemId = await seedBatchItem(db, recipeId);
      await logBatchMeal(db, itemId, 100);

      expect(await db.inventoryDao.isBatchItemConsumed(itemId), isTrue);
      expect(await db.inventoryDao.deleteBatchItemIfUnused(itemId), isFalse);
      expect(await db.select(db.batchItems).get(), hasLength(1));
    });

    test('returns false for an unknown item', () async {
      expect(await db.inventoryDao.deleteBatchItemIfUnused(999), isFalse);
    });
  });

  group('recipe yield', () {
    test('updateExpectedYield changes only the yield factor', () async {
      final id = await seedRecipe(db, 'Grilled chicken', yieldFactor: 0.75);

      expect(await db.recipesDao.updateExpectedYield(id, 0.9), 1);

      final detail = (await db.recipesDao.getRecipeDetail(id))!;
      expect(detail.recipe.expectedYieldFactor, 0.9);
      expect(detail.recipe.name, 'Grilled chicken');
      expect(detail.ingredients, hasLength(1));
    });
  });

  group('stock levels', () {
    test('exposes recipe kind and remaining fraction', () async {
      final recipeId = await seedRecipe(
        db,
        'Grilled chicken',
        kind: RecipeKind.proteinBase,
      );
      final itemId = await seedBatchItem(db, recipeId);
      await logBatchMeal(db, itemId, 150);

      final stock = (await db.inventoryDao.loadStock()).single;

      expect(stock.recipeKind, RecipeKind.proteinBase);
      expect(stock.remainingFraction, 0.5);
      expect(stock.isLow, isFalse);
      expect(stock.isEmpty, isFalse);
    });

    test('is low below 15% and empty at zero or below', () async {
      final recipeId = await seedRecipe(db, 'Grilled chicken');
      final itemId = await seedBatchItem(db, recipeId);

      await logBatchMeal(db, itemId, 255);
      var stock = (await db.inventoryDao.loadStock()).single;
      expect(stock.remainingFraction, closeTo(0.15, 1e-9));
      expect(stock.isLow, isFalse);

      await logBatchMeal(db, itemId, 256);
      stock = (await db.inventoryDao.loadStock()).single;
      expect(stock.isLow, isTrue);

      await logBatchMeal(db, itemId, 300);
      stock = (await db.inventoryDao.loadStock()).single;
      expect(stock.isEmpty, isTrue);
      expect(stock.isLow, isFalse);

      await logBatchMeal(db, itemId, 340);
      stock = (await db.inventoryDao.loadStock()).single;
      expect(stock.remainingG, -40);
      expect(stock.remainingFraction, 0);
      expect(stock.isEmpty, isTrue);
    });
  });
}
