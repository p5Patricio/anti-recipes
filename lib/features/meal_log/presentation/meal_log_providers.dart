import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../data/meal_log_dao.dart';

/// One-shot load of the meals logged on a day (pass a date-only value).
///
/// Deliberately not a stream: the composer must not be rewritten under the
/// user while they are editing.
final dayMealsProvider = FutureProvider.autoDispose
    .family<List<MealView>, DateTime>(
      (ref, date) => ref.read(mealLogDaoProvider).loadDay(date),
    );
