import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/database/date_utils.dart';
import '../../nutrition_targets/presentation/targets_providers.dart';
import '../data/meal_log_dao.dart';
import '../domain/day_summary.dart';

/// The current local calendar day; overridable so tests can pin the date.
final todayProvider = Provider<DateTime>((ref) => dateOnly(DateTime.now()));

/// Day shown on the Today tab (local midnight); starts on [todayProvider].
class SelectedDateNotifier extends Notifier<DateTime> {
  @override
  DateTime build() => ref.read(todayProvider);

  void shiftDays(int days) {
    final d = state;
    state = DateTime(d.year, d.month, d.day + days);
  }

  void jumpToToday() => state = ref.read(todayProvider);
}

final selectedDateProvider = NotifierProvider<SelectedDateNotifier, DateTime>(
  SelectedDateNotifier.new,
);

/// Live meals of a day (pass a date-only value).
final dayMealsStreamProvider = StreamProvider.autoDispose
    .family<List<MealView>, DateTime>(
      (ref, date) => ref.watch(mealLogDaoProvider).watchDay(date),
    );

final hydrationMlProvider = StreamProvider.autoDispose.family<int, DateTime>(
  (ref, date) => ref.watch(mealLogDaoProvider).watchHydrationMl(date),
);

final servingsProvider = StreamProvider.autoDispose
    .family<DayServings, DateTime>(
      (ref, date) => ref.watch(mealLogDaoProvider).watchServings(date),
    );

/// Everything the dashboard needs for a day; data(null) while no nutrition
/// plan exists yet.
final daySummaryProvider = Provider.autoDispose
    .family<AsyncValue<DaySummary?>, DateTime>((ref, date) {
      final engine = ref.watch(nutritionEngineProvider);
      final meals = ref.watch(dayMealsStreamProvider(date));
      final water = ref.watch(hydrationMlProvider(date));
      final servings = ref.watch(servingsProvider(date));
      final all = <AsyncValue<Object?>>[engine, meals, water, servings];
      final failed = all.where((v) => v.hasError).firstOrNull;
      if (failed != null) return AsyncError(failed.error!, failed.stackTrace!);
      if (all.any((v) => !v.hasValue)) return const AsyncLoading();
      final e = engine.requireValue;
      if (e == null) return const AsyncData(null);
      return AsyncData(
        summarizeDay(
          e,
          date,
          meals: [
            for (final m in meals.requireValue)
              (slot: m.slot, nutrients: m.nutrients),
          ],
          waterMl: water.requireValue,
          fruitPortions: servings.requireValue.fruit,
          vegPortions: servings.requireValue.veg,
        ),
      );
    });
