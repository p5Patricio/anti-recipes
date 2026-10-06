import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/inventory/data/inventory_dao.dart';
import '../../features/meal_log/data/meal_log_dao.dart';
import '../../features/nutrition_targets/data/targets_dao.dart';
import '../../features/recipes/data/recipes_dao.dart';
import 'app_database.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase.open();
  ref.onDispose(db.close);
  return db;
});

final targetsDaoProvider = Provider<TargetsDao>(
  (ref) => ref.watch(appDatabaseProvider).targetsDao,
);

final recipesDaoProvider = Provider<RecipesDao>(
  (ref) => ref.watch(appDatabaseProvider).recipesDao,
);

final inventoryDaoProvider = Provider<InventoryDao>(
  (ref) => ref.watch(appDatabaseProvider).inventoryDao,
);

final mealLogDaoProvider = Provider<MealLogDao>(
  (ref) => ref.watch(appDatabaseProvider).mealLogDao,
);
