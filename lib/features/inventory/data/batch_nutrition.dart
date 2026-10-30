import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/ingredient_nutrients.dart';
import '../../../core/nutrition/nutrients.dart';
import '../../recipes/domain/yield_calculator.dart';

/// Nutrients per cooked gram for each batch item id (via [YieldCalculator]).
///
/// The recipe's ingredient lines are scaled so they add up to the batch item's
/// `rawTotalG`; the cooked weight is the measured `cookedTotalG`. Items whose
/// recipe has no ingredients map to [Nutrients.zero].
Future<Map<int, Nutrients>> nutrientsPerCookedGramByBatchItem(
  AppDatabase db,
  Iterable<BatchItem> items,
) async {
  final list = items.toList();
  if (list.isEmpty) return {};
  final recipeIds = {for (final i in list) i.recipeId};
  final lines = await (db.select(db.recipeIngredients).join([
    innerJoin(
      db.ingredients,
      db.ingredients.id.equalsExp(db.recipeIngredients.ingredientId),
    ),
  ])..where(db.recipeIngredients.recipeId.isIn(recipeIds))).get();

  final byRecipe = <int, List<({Nutrients per100, double rawG})>>{};
  for (final l in lines) {
    byRecipe.putIfAbsent(l.read(db.recipeIngredients.recipeId)!, () => []).add((
      per100: l.readTable(db.ingredients).per100g,
      rawG: l.read(db.recipeIngredients.rawG)!,
    ));
  }

  return {
    for (final item in list)
      item.id: _perCookedGram(item, byRecipe[item.recipeId] ?? const []),
  };
}

Nutrients _perCookedGram(
  BatchItem item,
  List<({Nutrients per100, double rawG})> recipeLines,
) {
  final recipeRawG = recipeLines.fold<double>(0, (s, l) => s + l.rawG);
  if (recipeLines.isEmpty ||
      !(recipeRawG > 0) ||
      !(item.rawTotalG > 0) ||
      !(item.cookedTotalG > 0)) {
    return Nutrients.zero;
  }
  final scale = item.rawTotalG / recipeRawG;
  return YieldCalculator([
    for (final l in recipeLines) RawIngredient(l.per100, l.rawG * scale),
  ], item.cookedTotalG).nutrientsPerCookedGram;
}
