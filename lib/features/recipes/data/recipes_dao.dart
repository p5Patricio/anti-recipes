import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/ingredient_nutrients.dart';
import '../../../core/database/tables.dart';
import '../../../core/nutrition/nutrients.dart';
import '../domain/recipe_kind.dart';

part 'recipes_dao.g.dart';

class RecipeIngredientDraft {
  const RecipeIngredientDraft({required this.ingredientId, required this.rawG});
  final int ingredientId;
  final double rawG;
}

class RecipeStepDraft {
  const RecipeStepDraft({
    required this.technique,
    this.tempC,
    this.minutes,
    this.toolId,
  });
  final String technique;
  final int? tempC;
  final int? minutes;
  final int? toolId;
}

/// Everything needed to create (id == null) or fully replace a recipe.
class RecipeDraft {
  const RecipeDraft({
    this.id,
    required this.name,
    required this.kind,
    this.expectedYieldFactor = 1.0,
    this.notes,
    this.ingredients = const [],
    this.steps = const [],
    this.toolIds = const [],
  });

  final int? id;
  final String name;
  final RecipeKind kind;
  final double expectedYieldFactor;
  final String? notes;
  final List<RecipeIngredientDraft> ingredients;

  /// Persisted in list order as step positions 1..n.
  final List<RecipeStepDraft> steps;
  final List<int> toolIds;
}

/// One raw ingredient line with its ingredient's nutrients per 100 g.
class RecipeLine {
  const RecipeLine({
    required this.recipeId,
    required this.per100,
    required this.rawG,
    required this.ingredientId,
    required this.ingredientName,
    required this.category,
    this.servingG,
  });
  final int recipeId;
  final Nutrients per100;
  final double rawG;

  /// Identity of the ingredient, for aggregating shopping lists.
  final int ingredientId;
  final String ingredientName;
  final String category;
  final double? servingG;
}

class RecipeDetail {
  const RecipeDetail({
    required this.recipe,
    required this.ingredients,
    required this.steps,
    required this.tools,
  });

  final Recipe recipe;
  final List<({Ingredient ingredient, double rawG})> ingredients;
  final List<RecipeStep> steps;
  final List<Tool> tools;
}

@DriftAccessor(
  tables: [
    Ingredients,
    Tools,
    Recipes,
    RecipeIngredients,
    RecipeSteps,
    RecipeTools,
  ],
)
class RecipesDao extends DatabaseAccessor<AppDatabase> with _$RecipesDaoMixin {
  RecipesDao(super.db);

  // Ingredients

  Stream<List<Ingredient>> watchIngredients() =>
      (select(ingredients)..orderBy([(i) => OrderingTerm.asc(i.name)])).watch();

  Future<int> saveIngredient(IngredientsCompanion ingredient) async {
    if (ingredient.id.present) {
      await update(ingredients).replace(ingredient);
      return ingredient.id.value;
    }
    return into(ingredients).insert(ingredient);
  }

  /// Fails with a foreign key error while a recipe or meal still uses it.
  Future<int> deleteIngredient(int id) =>
      (delete(ingredients)..where((i) => i.id.equals(id))).go();

  // Tools

  Stream<List<Tool>> watchTools() =>
      (select(tools)..orderBy([(t) => OrderingTerm.asc(t.name)])).watch();

  Future<int> addTool(String name) =>
      into(tools).insert(ToolsCompanion.insert(name: name));

  Future<int> deleteTool(int id) =>
      (delete(tools)..where((t) => t.id.equals(id))).go();

  // Recipes

  Stream<List<Recipe>> watchRecipes() =>
      (select(recipes)..orderBy([(r) => OrderingTerm.asc(r.name)])).watch();

  /// Inserts or replaces the recipe and all of its children atomically.
  Future<int> saveRecipe(RecipeDraft draft) => transaction(() async {
    final int id;
    if (draft.id == null) {
      id = await into(recipes).insert(
        RecipesCompanion.insert(
          name: draft.name,
          kind: draft.kind,
          expectedYieldFactor: Value(draft.expectedYieldFactor),
          notes: Value(draft.notes),
        ),
      );
    } else {
      id = draft.id!;
      await (update(recipes)..where((r) => r.id.equals(id))).write(
        RecipesCompanion(
          name: Value(draft.name),
          kind: Value(draft.kind),
          expectedYieldFactor: Value(draft.expectedYieldFactor),
          notes: Value(draft.notes),
        ),
      );
      await (delete(
        recipeIngredients,
      )..where((r) => r.recipeId.equals(id))).go();
      await (delete(recipeSteps)..where((s) => s.recipeId.equals(id))).go();
      await (delete(recipeTools)..where((t) => t.recipeId.equals(id))).go();
    }
    await batch((b) {
      b.insertAll(recipeIngredients, [
        for (final i in draft.ingredients)
          RecipeIngredientsCompanion.insert(
            recipeId: id,
            ingredientId: i.ingredientId,
            rawG: i.rawG,
          ),
      ]);
      b.insertAll(recipeSteps, [
        for (final (index, s) in draft.steps.indexed)
          RecipeStepsCompanion.insert(
            recipeId: id,
            position: index + 1,
            technique: s.technique,
            tempC: Value(s.tempC),
            minutes: Value(s.minutes),
            toolId: Value(s.toolId),
          ),
      ]);
      b.insertAll(recipeTools, [
        for (final toolId in draft.toolIds.toSet())
          RecipeToolsCompanion.insert(recipeId: id, toolId: toolId),
      ]);
    });
    return id;
  });

  /// Updates only the expected cooked/raw ratio (e.g. after measuring a batch).
  Future<int> updateExpectedYield(int recipeId, double factor) =>
      (update(recipes)..where((r) => r.id.equals(recipeId))).write(
        RecipesCompanion(expectedYieldFactor: Value(factor)),
      );

  /// Fails with a foreign key error while a batch item still references it.
  Future<int> deleteRecipe(int id) =>
      (delete(recipes)..where((r) => r.id.equals(id))).go();

  /// Whether a batch item references the recipe (so it cannot be deleted).
  Future<bool> isRecipeInUse(int id) async {
    final db = attachedDatabase;
    final rows =
        await (db.select(db.batchItems)
              ..where((b) => b.recipeId.equals(id))
              ..limit(1))
            .get();
    return rows.isNotEmpty;
  }

  /// Whether a recipe line or a logged meal uses the ingredient.
  Future<bool> isIngredientInUse(int id) async {
    final db = attachedDatabase;
    final inRecipes =
        await (select(recipeIngredients)
              ..where((r) => r.ingredientId.equals(id))
              ..limit(1))
            .get();
    if (inRecipes.isNotEmpty) return true;
    final inMeals =
        await (db.select(db.mealComponents)
              ..where((m) => m.ingredientId.equals(id))
              ..limit(1))
            .get();
    return inMeals.isNotEmpty;
  }

  /// Every ingredient line of every recipe, for list-level macro summaries.
  Stream<List<RecipeLine>> watchRecipeLines() => select(recipeIngredients)
      .join([
        innerJoin(
          ingredients,
          ingredients.id.equalsExp(recipeIngredients.ingredientId),
        ),
      ])
      .watch()
      .map(
        (rows) => [
          for (final r in rows)
            RecipeLine(
              recipeId: r.read(recipeIngredients.recipeId)!,
              per100: r.readTable(ingredients).per100g,
              rawG: r.read(recipeIngredients.rawG)!,
              ingredientId: r.readTable(ingredients).id,
              ingredientName: r.readTable(ingredients).name,
              category: r.readTable(ingredients).category,
              servingG: r.readTable(ingredients).servingG,
            ),
        ],
      );

  Future<RecipeDetail?> getRecipeDetail(int id) async {
    final recipe = await (select(
      recipes,
    )..where((r) => r.id.equals(id))).getSingleOrNull();
    if (recipe == null) return null;
    final lines = await (select(recipeIngredients).join([
      innerJoin(
        ingredients,
        ingredients.id.equalsExp(recipeIngredients.ingredientId),
      ),
    ])..where(recipeIngredients.recipeId.equals(id))).get();
    final steps =
        await (select(recipeSteps)
              ..where((s) => s.recipeId.equals(id))
              ..orderBy([(s) => OrderingTerm.asc(s.position)]))
            .get();
    final toolRows = await (select(tools).join([
      innerJoin(recipeTools, recipeTools.toolId.equalsExp(tools.id)),
    ])..where(recipeTools.recipeId.equals(id))).get();
    return RecipeDetail(
      recipe: recipe,
      ingredients: [
        for (final l in lines)
          (
            ingredient: l.readTable(ingredients),
            rawG: l.read(recipeIngredients.rawG)!,
          ),
      ],
      steps: steps,
      tools: [for (final t in toolRows) t.readTable(tools)],
    );
  }

  /// Total nutrients of the recipe as written (raw weights).
  Future<Nutrients> recipeNutrients(int recipeId) async {
    final lines = await (select(recipeIngredients).join([
      innerJoin(
        ingredients,
        ingredients.id.equalsExp(recipeIngredients.ingredientId),
      ),
    ])..where(recipeIngredients.recipeId.equals(recipeId))).get();
    return Nutrients.sum([
      for (final l in lines)
        Nutrients.fromPer100g(
          l.readTable(ingredients).per100g,
          l.read(recipeIngredients.rawG)!,
        ),
    ]);
  }
}
