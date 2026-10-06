// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_log_dao.dart';

// ignore_for_file: type=lint
mixin _$MealLogDaoMixin on DatabaseAccessor<AppDatabase> {
  $MealLogsTable get mealLogs => attachedDatabase.mealLogs;
  $BatchSessionsTable get batchSessions => attachedDatabase.batchSessions;
  $RecipesTable get recipes => attachedDatabase.recipes;
  $BatchItemsTable get batchItems => attachedDatabase.batchItems;
  $IngredientsTable get ingredients => attachedDatabase.ingredients;
  $MealComponentsTable get mealComponents => attachedDatabase.mealComponents;
  $HydrationLogsTable get hydrationLogs => attachedDatabase.hydrationLogs;
  $DayLogsTable get dayLogs => attachedDatabase.dayLogs;
  $RecipeIngredientsTable get recipeIngredients =>
      attachedDatabase.recipeIngredients;
  MealLogDaoManager get managers => MealLogDaoManager(this);
}

class MealLogDaoManager {
  final _$MealLogDaoMixin _db;
  MealLogDaoManager(this._db);
  $$MealLogsTableTableManager get mealLogs =>
      $$MealLogsTableTableManager(_db.attachedDatabase, _db.mealLogs);
  $$BatchSessionsTableTableManager get batchSessions =>
      $$BatchSessionsTableTableManager(_db.attachedDatabase, _db.batchSessions);
  $$RecipesTableTableManager get recipes =>
      $$RecipesTableTableManager(_db.attachedDatabase, _db.recipes);
  $$BatchItemsTableTableManager get batchItems =>
      $$BatchItemsTableTableManager(_db.attachedDatabase, _db.batchItems);
  $$IngredientsTableTableManager get ingredients =>
      $$IngredientsTableTableManager(_db.attachedDatabase, _db.ingredients);
  $$MealComponentsTableTableManager get mealComponents =>
      $$MealComponentsTableTableManager(
        _db.attachedDatabase,
        _db.mealComponents,
      );
  $$HydrationLogsTableTableManager get hydrationLogs =>
      $$HydrationLogsTableTableManager(_db.attachedDatabase, _db.hydrationLogs);
  $$DayLogsTableTableManager get dayLogs =>
      $$DayLogsTableTableManager(_db.attachedDatabase, _db.dayLogs);
  $$RecipeIngredientsTableTableManager get recipeIngredients =>
      $$RecipeIngredientsTableTableManager(
        _db.attachedDatabase,
        _db.recipeIngredients,
      );
}
