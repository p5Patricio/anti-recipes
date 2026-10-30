// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipes_dao.dart';

// ignore_for_file: type=lint
mixin _$RecipesDaoMixin on DatabaseAccessor<AppDatabase> {
  $IngredientsTable get ingredients => attachedDatabase.ingredients;
  $ToolsTable get tools => attachedDatabase.tools;
  $RecipesTable get recipes => attachedDatabase.recipes;
  $RecipeIngredientsTable get recipeIngredients =>
      attachedDatabase.recipeIngredients;
  $RecipeStepsTable get recipeSteps => attachedDatabase.recipeSteps;
  $RecipeToolsTable get recipeTools => attachedDatabase.recipeTools;
  RecipesDaoManager get managers => RecipesDaoManager(this);
}

class RecipesDaoManager {
  final _$RecipesDaoMixin _db;
  RecipesDaoManager(this._db);
  $$IngredientsTableTableManager get ingredients =>
      $$IngredientsTableTableManager(_db.attachedDatabase, _db.ingredients);
  $$ToolsTableTableManager get tools =>
      $$ToolsTableTableManager(_db.attachedDatabase, _db.tools);
  $$RecipesTableTableManager get recipes =>
      $$RecipesTableTableManager(_db.attachedDatabase, _db.recipes);
  $$RecipeIngredientsTableTableManager get recipeIngredients =>
      $$RecipeIngredientsTableTableManager(
        _db.attachedDatabase,
        _db.recipeIngredients,
      );
  $$RecipeStepsTableTableManager get recipeSteps =>
      $$RecipeStepsTableTableManager(_db.attachedDatabase, _db.recipeSteps);
  $$RecipeToolsTableTableManager get recipeTools =>
      $$RecipeToolsTableTableManager(_db.attachedDatabase, _db.recipeTools);
}
