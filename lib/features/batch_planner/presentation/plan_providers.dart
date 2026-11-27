import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/database/date_utils.dart';
import '../../../core/database/ingredient_nutrients.dart';
import '../../inventory/presentation/inventory_providers.dart';
import '../../meal_log/presentation/today_providers.dart';
import '../../nutrition_targets/presentation/targets_providers.dart';
import '../../recipes/presentation/recipes_providers.dart';
import '../domain/batch_plan.dart';
import '../domain/batch_planner.dart';
import '../domain/plan_inputs.dart';

/// Cooked grams per meal offered for the fixed side roles.
const defaultSideGramsPerMeal = <PlanRole, double>{
  PlanRole.vegetable: 150,
  PlanRole.sauce: 30,
};

/// A fresh ingredient chosen for the plan.
class FreshSelection {
  const FreshSelection(this.ingredientId, this.gramsPerMeal);

  final int ingredientId;
  final double gramsPerMeal;

  Map<String, dynamic> toJson() => {
    'ingredientId': ingredientId,
    'gramsPerMeal': gramsPerMeal,
  };

  factory FreshSelection.fromJson(Map<String, dynamic> json) => FreshSelection(
    (json['ingredientId'] as num).toInt(),
    (json['gramsPerMeal'] as num).toDouble(),
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FreshSelection &&
          other.ingredientId == ingredientId &&
          other.gramsPerMeal == gramsPerMeal;

  @override
  int get hashCode => Object.hash(ingredientId, gramsPerMeal);
}

/// What the user picked on the Plan tab. Persisted in AppSettings.
class PlanSelection {
  const PlanSelection({
    required this.from,
    this.dayCount = 3,
    this.recipeIds = const {},
    this.sideGramsPerMeal = defaultSideGramsPerMeal,
    this.fresh = const [],
    this.leftoverIds = const {},
  });

  final DateTime from;

  /// 1..[BatchPlanInput.maxPlanDays].
  final int dayCount;
  final Map<PlanRole, int> recipeIds;
  final Map<PlanRole, double> sideGramsPerMeal;
  final List<FreshSelection> fresh;

  /// Batch item ids whose remaining stock counts toward the block.
  final Set<int> leftoverIds;

  DateTime get to => consecutiveDays(from, dayCount).last;

  PlanSelection copyWith({
    DateTime? from,
    int? dayCount,
    Map<PlanRole, int>? recipeIds,
    Map<PlanRole, double>? sideGramsPerMeal,
    List<FreshSelection>? fresh,
    Set<int>? leftoverIds,
  }) => PlanSelection(
    from: from ?? this.from,
    dayCount: dayCount ?? this.dayCount,
    recipeIds: recipeIds ?? this.recipeIds,
    sideGramsPerMeal: sideGramsPerMeal ?? this.sideGramsPerMeal,
    fresh: fresh ?? this.fresh,
    leftoverIds: leftoverIds ?? this.leftoverIds,
  );

  Map<String, dynamic> toJson() => {
    'from': dateOnly(from).toIso8601String(),
    'dayCount': dayCount,
    'recipeIds': {for (final e in recipeIds.entries) e.key.name: e.value},
    'sideGramsPerMeal': {
      for (final e in sideGramsPerMeal.entries) e.key.name: e.value,
    },
    'fresh': [for (final f in fresh) f.toJson()],
    'leftoverIds': leftoverIds.toList()..sort(),
  };

  factory PlanSelection.fromJson(
    Map<String, dynamic> json, {
    DateTime? fallbackFrom,
  }) {
    DateTime parseDate(dynamic v) {
      if (v is String) {
        try {
          return dateOnly(DateTime.parse(v));
        } catch (_) {}
      }
      return fallbackFrom ?? dateOnly(DateTime.now());
    }

    final recipeIds = <PlanRole, int>{};
    if (json['recipeIds'] is Map) {
      for (final entry in (json['recipeIds'] as Map).entries) {
        final role = PlanRole.values
            .where((r) => r.name == entry.key)
            .firstOrNull;
        if (role != null && entry.value is num) {
          recipeIds[role] = (entry.value as num).toInt();
        }
      }
    }

    final sideGrams = Map<PlanRole, double>.from(defaultSideGramsPerMeal);
    if (json['sideGramsPerMeal'] is Map) {
      for (final entry in (json['sideGramsPerMeal'] as Map).entries) {
        final role = PlanRole.values
            .where((r) => r.name == entry.key)
            .firstOrNull;
        if (role != null && entry.value is num) {
          sideGrams[role] = (entry.value as num).toDouble();
        }
      }
    }

    final fresh = <FreshSelection>[];
    if (json['fresh'] is List) {
      for (final item in json['fresh'] as List) {
        if (item is Map<String, dynamic>) {
          try {
            fresh.add(FreshSelection.fromJson(item));
          } catch (_) {}
        }
      }
    }

    final leftoverIds = <int>{};
    if (json['leftoverIds'] is List) {
      for (final id in json['leftoverIds'] as List) {
        if (id is num) leftoverIds.add(id.toInt());
      }
    }

    final rawDayCount = json['dayCount'];
    final dayCount = (rawDayCount is num ? rawDayCount.toInt() : 3).clamp(
      1,
      BatchPlanInput.maxPlanDays,
    );

    return PlanSelection(
      from: parseDate(json['from']),
      dayCount: dayCount,
      recipeIds: recipeIds,
      sideGramsPerMeal: sideGrams,
      fresh: fresh,
      leftoverIds: leftoverIds,
    );
  }
}

class PlanSelectionNotifier extends Notifier<PlanSelection> {
  static const settingKey = 'active_plan_selection';

  @override
  PlanSelection build() {
    _loadPersisted();
    return PlanSelection(from: ref.read(todayProvider));
  }

  Future<void> _loadPersisted() async {
    try {
      final dao = ref.read(settingsDaoProvider);
      final raw = await dao.getSetting(settingKey);
      if (raw != null) {
        final json = jsonDecode(raw) as Map<String, dynamic>;
        state = PlanSelection.fromJson(
          json,
          fallbackFrom: ref.read(todayProvider),
        );
      }
    } catch (_) {}
  }

  void _persist() {
    try {
      final dao = ref.read(settingsDaoProvider);
      final encoded = jsonEncode(state.toJson());
      dao.setSetting(settingKey, encoded).catchError((_) {});
    } catch (_) {}
  }

  void setFrom(DateTime date) {
    state = state.copyWith(from: dateOnly(date));
    _persist();
  }

  void setDayCount(int count) {
    state = state.copyWith(
      dayCount: count.clamp(1, BatchPlanInput.maxPlanDays).toInt(),
    );
    _persist();
  }

  /// Picks [recipeId] for [role], or clears the role when null.
  void setRecipe(PlanRole role, int? recipeId) {
    final next = {...state.recipeIds};
    if (recipeId == null) {
      next.remove(role);
    } else {
      next[role] = recipeId;
    }
    state = state.copyWith(recipeIds: next);
    _persist();
  }

  void setSideGrams(PlanRole role, double gramsPerMeal) {
    state = state.copyWith(
      sideGramsPerMeal: {...state.sideGramsPerMeal, role: gramsPerMeal},
    );
    _persist();
  }

  /// Adds the ingredient, or updates its grams when already present.
  void setFresh(int ingredientId, double gramsPerMeal) {
    final entry = FreshSelection(ingredientId, gramsPerMeal);
    final exists = state.fresh.any((f) => f.ingredientId == ingredientId);
    state = state.copyWith(
      fresh: exists
          ? [
              for (final f in state.fresh)
                f.ingredientId == ingredientId ? entry : f,
            ]
          : [...state.fresh, entry],
    );
    _persist();
  }

  void removeFresh(int ingredientId) {
    state = state.copyWith(
      fresh: [
        for (final f in state.fresh)
          if (f.ingredientId != ingredientId) f,
      ],
    );
    _persist();
  }

  void setLeftover(int batchItemId, {required bool use}) {
    final next = {...state.leftoverIds};
    if (use) {
      next.add(batchItemId);
    } else {
      next.remove(batchItemId);
    }
    state = state.copyWith(leftoverIds: next);
    _persist();
  }
}

final planSelectionProvider =
    NotifierProvider<PlanSelectionNotifier, PlanSelection>(
      PlanSelectionNotifier.new,
    );

/// Every recipe with the ingredient identity the planner needs.
final planRecipesProvider = Provider<AsyncValue<Map<int, PlanRecipe>>>((ref) {
  final recipes = ref.watch(recipesProvider);
  final lines = ref.watch(recipeLinesProvider);
  if (recipes.hasError) return AsyncError(recipes.error!, recipes.stackTrace!);
  if (lines.hasError) return AsyncError(lines.error!, lines.stackTrace!);
  if (!recipes.hasValue || !lines.hasValue) return const AsyncLoading();
  final byRecipe = <int, List<PlanIngredientLine>>{};
  for (final l in lines.requireValue) {
    byRecipe
        .putIfAbsent(l.recipeId, () => [])
        .add(
          PlanIngredientLine(
            ingredientId: l.ingredientId,
            name: l.ingredientName,
            category: l.category,
            per100: l.per100,
            rawG: l.rawG,
            servingG: l.servingG,
          ),
        );
  }
  return AsyncData({
    for (final r in recipes.requireValue)
      r.id: PlanRecipe(
        id: r.id,
        name: r.name,
        yieldFactor: r.expectedYieldFactor,
        lines: byRecipe[r.id] ?? const [],
      ),
  });
});

/// The plan for the current selection; data(null) while no nutrition plan
/// exists yet.
final batchPlanProvider = Provider<AsyncValue<BatchPlan?>>((ref) {
  final selection = ref.watch(planSelectionProvider);
  final engine = ref.watch(nutritionEngineProvider);
  final recipes = ref.watch(planRecipesProvider);
  final ingredients = ref.watch(ingredientsProvider);
  final stock = ref.watch(stockProvider);
  final all = <AsyncValue<Object?>>[engine, recipes, ingredients, stock];
  final failed = all.where((v) => v.hasError).firstOrNull;
  if (failed != null) return AsyncError(failed.error!, failed.stackTrace!);
  if (all.any((v) => !v.hasValue)) return const AsyncLoading();
  final e = engine.requireValue;
  if (e == null) return const AsyncData(null);

  final recipeById = recipes.requireValue;
  final ingredientById = {for (final i in ingredients.requireValue) i.id: i};
  final input = BatchPlanInput.fromDay(
    selection.from,
    selection.dayCount,
    mealsPerDay: e.plan.mealsPerDay,
    components: [
      for (final role in PlanRole.values)
        if (recipeById[selection.recipeIds[role]] case final recipe?)
          PlanComponent(
            role: role,
            recipe: recipe,
            cookedGPerMeal: role.isBase
                ? 0
                : selection.sideGramsPerMeal[role] ??
                      defaultSideGramsPerMeal[role] ??
                      0,
          ),
    ],
    fresh: [
      for (final f in selection.fresh)
        if (ingredientById[f.ingredientId] case final i?)
          FreshAddition(
            ingredientId: i.id,
            name: i.name,
            category: i.category,
            per100: i.per100g,
            gramsPerMeal: f.gramsPerMeal,
            servingG: i.servingG,
          ),
    ],
    leftovers: [
      for (final s in stock.requireValue)
        if (selection.leftoverIds.contains(s.batchItemId) && s.remainingG > 0)
          PantryLeftover(
            batchItemId: s.batchItemId,
            name: s.recipeName,
            remainingG: s.remainingG,
            perCookedGram: s.nutrientsPerCookedGram,
          ),
    ],
  );
  return AsyncData(BatchPlanner(e).plan(input));
});
