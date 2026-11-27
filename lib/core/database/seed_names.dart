import 'package:drift/drift.dart';

import 'app_database.dart';

/// English and Spanish names of the rows seeded on first run
/// (`_starterIngredients` and `_starterTools` in `app_database.dart`).
///
/// The names are stored data, not UI strings, so they are translated by
/// renaming the seeded rows when the app language changes (see
/// [syncSeedNames]).
const seedIngredientNames = <String, String>{
  'Chicken breast': 'Pechuga de pollo',
  'Lean ground beef 90/10': 'Carne molida magra 90/10',
  'Egg': 'Huevo',
  'White rice': 'Arroz blanco',
  'Rolled oats': 'Avena en hojuelas',
  'Potato': 'Papa',
  'Broccoli': 'Brócoli',
  'Banana': 'Plátano',
  'Apple': 'Manzana',
  'Olive oil': 'Aceite de oliva',
};

const seedToolNames = <String, String>{
  'Oven': 'Horno',
  'Air fryer': 'Freidora de aire',
  'Cast iron skillet': 'Sartén de hierro fundido',
  'Kitchen scale': 'Báscula de cocina',
  'Rice cooker': 'Arrocera',
  'Sheet pan': 'Bandeja para hornear',
};

/// Renames the seeded ingredients and tools to [languageCode] (`es` or `en`;
/// any other code is treated as English).
///
/// A row is renamed only when its current name is exactly the seeded name in
/// the other language and no row already uses the target name, so names the
/// user edited, and names that would collide with the unique constraint, are
/// left alone. The call is idempotent.
Future<void> syncSeedNames(AppDatabase db, String languageCode) async {
  final toSpanish = languageCode == 'es';
  await db.transaction(() async {
    for (final entry in seedIngredientNames.entries) {
      final (from, to) = toSpanish
          ? (entry.key, entry.value)
          : (entry.value, entry.key);
      await _rename(db, db.ingredients, from, to);
    }
    for (final entry in seedToolNames.entries) {
      final (from, to) = toSpanish
          ? (entry.key, entry.value)
          : (entry.value, entry.key);
      await _rename(db, db.tools, from, to);
    }
  });
}

Future<void> _rename(
  AppDatabase db,
  TableInfo<Table, dynamic> table,
  String from,
  String to,
) async {
  final taken = await db
      .customSelect(
        'SELECT 1 FROM ${table.actualTableName} WHERE name = ? LIMIT 1',
        variables: [Variable<String>(to)],
        readsFrom: {table},
      )
      .get();
  if (taken.isNotEmpty) return;
  await db.customUpdate(
    'UPDATE ${table.actualTableName} SET name = ? WHERE name = ?',
    variables: [Variable<String>(to), Variable<String>(from)],
    updates: {table},
  );
}
