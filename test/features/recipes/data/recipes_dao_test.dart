import 'package:anti_recipes/core/database/app_database.dart';
import 'package:anti_recipes/features/recipes/data/recipes_dao.dart';
import 'package:anti_recipes/features/recipes/domain/recipe_kind.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late RecipesDao dao;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    dao = db.recipesDao;
  });
  tearDown(() => db.close());

  Future<int> ingredientId(String name) async => (await (db.select(
    db.ingredients,
  )..where((i) => i.name.equals(name))).getSingle()).id;

  Future<int> saveRecipe() async => dao.saveRecipe(
    RecipeDraft(
      name: 'Plain chicken',
      kind: RecipeKind.proteinBase,
      expectedYieldFactor: 0.75,
      ingredients: [
        RecipeIngredientDraft(
          ingredientId: await ingredientId('Chicken breast'),
          rawG: 500,
        ),
      ],
    ),
  );

  IngredientsCompanion newIngredient(String name) =>
      IngredientsCompanion.insert(
        name: name,
        category: 'protein',
        kcal100: 100,
        protein100: 20,
        fat100: 2,
        carbs100: 0,
        fiber100: 0,
      );

  group('ingredients', () {
    test('saveIngredient inserts then updates in place', () async {
      final id = await dao.saveIngredient(newIngredient('Tofu'));
      await dao.saveIngredient(
        IngredientsCompanion(
          id: Value(id),
          name: const Value('Firm tofu'),
          category: const Value('protein'),
          isFruit: const Value(false),
          isVegetable: const Value(false),
          servingG: const Value(100),
          kcal100: const Value(144),
          protein100: const Value(15),
          fat100: const Value(9),
          carbs100: const Value(3),
          fiber100: const Value(2),
        ),
      );
      final row = await (db.select(
        db.ingredients,
      )..where((i) => i.id.equals(id))).getSingle();
      expect(row.name, 'Firm tofu');
      expect(row.servingG, 100);
      expect(row.kcal100, 144);
    });

    test('unused ingredient can be deleted', () async {
      final id = await dao.saveIngredient(newIngredient('Tofu'));
      expect(await dao.isIngredientInUse(id), isFalse);
      expect(await dao.deleteIngredient(id), 1);
    });

    test(
      'ingredient used by a recipe is reported and cannot be deleted',
      () async {
        await saveRecipe();
        final id = await ingredientId('Chicken breast');
        expect(await dao.isIngredientInUse(id), isTrue);
        await expectLater(dao.deleteIngredient(id), throwsA(anything));
      },
    );
  });

  group('recipes', () {
    test('deleteRecipe removes the recipe and its children', () async {
      final id = await saveRecipe();
      expect(await dao.deleteRecipe(id), 1);
      expect(await dao.getRecipeDetail(id), isNull);
      expect(await db.select(db.recipeIngredients).get(), isEmpty);
    });

    test('recipe referenced by a batch item is in use and protected', () async {
      final id = await saveRecipe();
      expect(await dao.isRecipeInUse(id), isFalse);
      final session = await db
          .into(db.batchSessions)
          .insert(
            BatchSessionsCompanion.insert(
              cookedOn: DateTime(2026, 1, 1),
              coversFrom: DateTime(2026, 1, 1),
              coversTo: DateTime(2026, 1, 4),
            ),
          );
      await db
          .into(db.batchItems)
          .insert(
            BatchItemsCompanion.insert(
              batchSessionId: session,
              recipeId: id,
              rawTotalG: 500,
              cookedTotalG: 375,
            ),
          );
      expect(await dao.isRecipeInUse(id), isTrue);
      await expectLater(dao.deleteRecipe(id), throwsA(anything));
      expect(await dao.getRecipeDetail(id), isNotNull);
    });

    test(
      'watchRecipeLines exposes per-100 g nutrients and raw grams',
      () async {
        final id = await saveRecipe();
        final lines = await dao.watchRecipeLines().first;
        expect(lines, hasLength(1));
        expect(lines.single.recipeId, id);
        expect(lines.single.rawG, 500);
        expect(lines.single.per100.proteinG, 22.5);
        expect(lines.single.ingredientName, 'Chicken breast');
        expect(lines.single.category, 'protein');
        expect(lines.single.servingG, isNull);
        expect(lines.single.ingredientId, greaterThan(0));
      },
    );
  });

  group('tools', () {
    test('addTool appends and rejects duplicates', () async {
      final id = await dao.addTool('Blender');
      expect(id, greaterThan(0));
      final names = (await dao.watchTools().first).map((t) => t.name);
      expect(names, contains('Blender'));
      await expectLater(dao.addTool('Blender'), throwsA(anything));
    });
  });
}
