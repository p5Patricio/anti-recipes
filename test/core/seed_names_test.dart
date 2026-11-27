import 'package:anti_recipes/core/database/app_database.dart';
import 'package:anti_recipes/core/database/seed_names.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  Future<Set<String>> ingredientNames() async => {
    for (final r in await db.select(db.ingredients).get()) r.name,
  };
  Future<Set<String>> toolNames() async => {
    for (final r in await db.select(db.tools).get()) r.name,
  };

  test(
    'every seeded name has a translation and nothing else is mapped',
    () async {
      expect(await ingredientNames(), seedIngredientNames.keys.toSet());
      expect(await toolNames(), seedToolNames.keys.toSet());
    },
  );

  test('es renames the seeded rows and keeps their ids', () async {
    final before = {
      for (final r in await db.select(db.ingredients).get()) r.id: r.name,
    };
    await syncSeedNames(db, 'es');

    final after = {
      for (final r in await db.select(db.ingredients).get()) r.id: r.name,
    };
    expect(after.keys, before.keys);
    for (final id in before.keys) {
      expect(after[id], seedIngredientNames[before[id]]);
    }
    expect(await toolNames(), seedToolNames.values.toSet());
  });

  test(
    'en restores the English names, and repeating a sync changes nothing',
    () async {
      await syncSeedNames(db, 'es');
      await syncSeedNames(db, 'es');
      await syncSeedNames(db, 'en');
      await syncSeedNames(db, 'en');

      expect(await ingredientNames(), seedIngredientNames.keys.toSet());
      expect(await toolNames(), seedToolNames.keys.toSet());
    },
  );

  test('an unsupported language code is treated as English', () async {
    await syncSeedNames(db, 'es');
    await syncSeedNames(db, 'fr');

    expect(await ingredientNames(), seedIngredientNames.keys.toSet());
  });

  test('rows the user renamed or created are left alone', () async {
    await (db.update(db.ingredients)..where((i) => i.name.equals('Egg'))).write(
      const IngredientsCompanion(name: Value('Free-range egg')),
    );
    await db.recipesDao.addTool('Wok');

    await syncSeedNames(db, 'es');

    final ingredients = await ingredientNames();
    expect(ingredients, contains('Free-range egg'));
    expect(ingredients, isNot(contains('Huevo')));
    expect(await toolNames(), contains('Wok'));
  });

  test('a name the user already uses blocks only that rename', () async {
    await (db.update(db.ingredients)..where((i) => i.name.equals('Egg'))).write(
      const IngredientsCompanion(name: Value('Huevo')),
    );
    await (db.update(db.ingredients)
          ..where((i) => i.name.equals('Chicken breast')))
        .write(const IngredientsCompanion(name: Value('Egg')));

    await syncSeedNames(db, 'es');

    final ingredients = await ingredientNames();
    // "Egg" would have become "Huevo", which already exists: both stay as is.
    expect(ingredients, containsAll(['Egg', 'Huevo']));
    expect(ingredients, contains('Papa'));
    expect(ingredients, isNot(contains('Potato')));
  });
}
