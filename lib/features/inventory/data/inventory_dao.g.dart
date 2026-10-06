// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_dao.dart';

// ignore_for_file: type=lint
mixin _$InventoryDaoMixin on DatabaseAccessor<AppDatabase> {
  $BatchSessionsTable get batchSessions => attachedDatabase.batchSessions;
  $RecipesTable get recipes => attachedDatabase.recipes;
  $BatchItemsTable get batchItems => attachedDatabase.batchItems;
  $IngredientsTable get ingredients => attachedDatabase.ingredients;
  $RecipeIngredientsTable get recipeIngredients =>
      attachedDatabase.recipeIngredients;
  $MealLogsTable get mealLogs => attachedDatabase.mealLogs;
  $MealComponentsTable get mealComponents => attachedDatabase.mealComponents;
  InventoryDaoManager get managers => InventoryDaoManager(this);
}

class InventoryDaoManager {
  final _$InventoryDaoMixin _db;
  InventoryDaoManager(this._db);
  $$BatchSessionsTableTableManager get batchSessions =>
      $$BatchSessionsTableTableManager(_db.attachedDatabase, _db.batchSessions);
  $$RecipesTableTableManager get recipes =>
      $$RecipesTableTableManager(_db.attachedDatabase, _db.recipes);
  $$BatchItemsTableTableManager get batchItems =>
      $$BatchItemsTableTableManager(_db.attachedDatabase, _db.batchItems);
  $$IngredientsTableTableManager get ingredients =>
      $$IngredientsTableTableManager(_db.attachedDatabase, _db.ingredients);
  $$RecipeIngredientsTableTableManager get recipeIngredients =>
      $$RecipeIngredientsTableTableManager(
        _db.attachedDatabase,
        _db.recipeIngredients,
      );
  $$MealLogsTableTableManager get mealLogs =>
      $$MealLogsTableTableManager(_db.attachedDatabase, _db.mealLogs);
  $$MealComponentsTableTableManager get mealComponents =>
      $$MealComponentsTableTableManager(
        _db.attachedDatabase,
        _db.mealComponents,
      );
}
