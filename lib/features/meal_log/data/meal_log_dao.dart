import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/date_utils.dart';
import '../../../core/database/ingredient_nutrients.dart';
import '../../../core/database/tables.dart';
import '../../../core/nutrition/nutrients.dart';
import '../../inventory/data/batch_nutrition.dart';
import '../../nutrition_targets/domain/day_type.dart';

part 'meal_log_dao.g.dart';

/// Exactly one of [batchItemId] / [ingredientId] must be set.
class MealComponentDraft {
  const MealComponentDraft({
    this.batchItemId,
    this.ingredientId,
    required this.grams,
  });
  final int? batchItemId;
  final int? ingredientId;
  final double grams;
}

class MealComponentView {
  const MealComponentView({
    required this.id,
    required this.batchItemId,
    required this.ingredientId,
    required this.label,
    required this.grams,
    required this.nutrients,
  });
  final int id;
  final int? batchItemId;
  final int? ingredientId;
  final String label;
  final double grams;
  final Nutrients nutrients;
}

class MealView {
  const MealView({
    required this.id,
    required this.date,
    required this.slot,
    required this.dayType,
    required this.components,
  });
  final int id;
  final DateTime date;
  final int slot;
  final DayType dayType;
  final List<MealComponentView> components;

  Nutrients get nutrients => Nutrients.sum(components.map((c) => c.nutrients));
}

@DriftAccessor(
  tables: [
    MealLogs,
    MealComponents,
    HydrationLogs,
    BatchItems,
    Recipes,
    RecipeIngredients,
    Ingredients,
  ],
)
class MealLogDao extends DatabaseAccessor<AppDatabase> with _$MealLogDaoMixin {
  MealLogDao(super.db);

  /// Creates the meal for `(date, slot)` or replaces its components.
  Future<int> upsertMeal({
    required DateTime date,
    required int slot,
    required DayType dayType,
    required List<MealComponentDraft> components,
  }) => transaction(() async {
    final day = dateOnly(date);
    final existing =
        await (select(mealLogs)
              ..where((m) => m.date.equals(day) & m.slot.equals(slot)))
            .getSingleOrNull();
    final int id;
    if (existing == null) {
      id = await into(mealLogs).insert(
        MealLogsCompanion.insert(date: day, slot: slot, dayType: dayType),
      );
    } else {
      id = existing.id;
      await (update(mealLogs)..where((m) => m.id.equals(id))).write(
        MealLogsCompanion(dayType: Value(dayType)),
      );
      await (delete(mealComponents)..where((c) => c.mealLogId.equals(id))).go();
    }
    await batch((b) {
      b.insertAll(mealComponents, [
        for (final c in components)
          MealComponentsCompanion.insert(
            mealLogId: id,
            batchItemId: Value(c.batchItemId),
            ingredientId: Value(c.ingredientId),
            grams: c.grams,
          ),
      ]);
    });
    return id;
  });

  Future<int> deleteMeal(DateTime date, int slot) => (delete(
    mealLogs,
  )..where((m) => m.date.equals(dateOnly(date)) & m.slot.equals(slot))).go();

  Stream<List<MealView>> watchDay(DateTime date) => customSelect(
    'SELECT 1',
    readsFrom: {
      mealLogs,
      mealComponents,
      batchItems,
      recipes,
      recipeIngredients,
      ingredients,
    },
  ).watch().asyncMap((_) => loadDay(date));

  Future<List<MealView>> loadDay(DateTime date) async {
    final meals =
        await (select(mealLogs)
              ..where((m) => m.date.equals(dateOnly(date)))
              ..orderBy([(m) => OrderingTerm.asc(m.slot)]))
            .get();
    if (meals.isEmpty) return const [];

    final components =
        await (select(mealComponents)
              ..where((c) => c.mealLogId.isIn(meals.map((m) => m.id)))
              ..orderBy([(c) => OrderingTerm.asc(c.id)]))
            .get();

    final batchIds = {
      for (final c in components)
        if (c.batchItemId != null) c.batchItemId!,
    };
    final items = batchIds.isEmpty
        ? <BatchItem>[]
        : await (select(batchItems)..where((i) => i.id.isIn(batchIds))).get();
    final perGram = await nutrientsPerCookedGramByBatchItem(
      attachedDatabase,
      items,
    );
    final recipeNames = <int, String>{
      for (final r in await (select(
        recipes,
      )..where((r) => r.id.isIn(items.map((i) => i.recipeId)))).get())
        r.id: r.name,
    };
    final itemRecipe = {for (final i in items) i.id: i.recipeId};

    final ingredientIds = {
      for (final c in components)
        if (c.ingredientId != null) c.ingredientId!,
    };
    final foods = {
      for (final i in await (select(
        ingredients,
      )..where((i) => i.id.isIn(ingredientIds))).get())
        i.id: i,
    };

    MealComponentView view(MealComponent c) {
      if (c.batchItemId != null) {
        return MealComponentView(
          id: c.id,
          batchItemId: c.batchItemId,
          ingredientId: null,
          label: recipeNames[itemRecipe[c.batchItemId]] ?? '',
          grams: c.grams,
          nutrients: (perGram[c.batchItemId] ?? Nutrients.zero).scale(c.grams),
        );
      }
      final food = foods[c.ingredientId]!;
      return MealComponentView(
        id: c.id,
        batchItemId: null,
        ingredientId: c.ingredientId,
        label: food.name,
        grams: c.grams,
        nutrients: Nutrients.fromPer100g(food.per100g, c.grams),
      );
    }

    return [
      for (final m in meals)
        MealView(
          id: m.id,
          date: m.date,
          slot: m.slot,
          dayType: m.dayType,
          components: [
            for (final c in components)
              if (c.mealLogId == m.id) view(c),
          ],
        ),
    ];
  }

  Future<int> addHydration(DateTime date, int ml, {DateTime? loggedAt}) =>
      into(hydrationLogs).insert(
        HydrationLogsCompanion.insert(
          date: dateOnly(date),
          ml: ml,
          loggedAt: Value(loggedAt ?? DateTime.now()),
        ),
      );

  Stream<int> watchHydrationMl(DateTime date) {
    final total = hydrationLogs.ml.sum();
    return (selectOnly(hydrationLogs)
          ..addColumns([total])
          ..where(hydrationLogs.date.equals(dateOnly(date))))
        .watchSingle()
        .map((row) => row.read(total) ?? 0);
  }
}
