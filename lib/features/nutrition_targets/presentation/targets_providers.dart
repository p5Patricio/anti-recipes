import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../domain/nutrition_engine.dart';
import '../domain/nutrition_plan.dart';

final planProvider = StreamProvider<NutritionPlan?>(
  (ref) => ref.watch(targetsDaoProvider).watchPlan(),
);

final scheduleProvider = StreamProvider<WeekSchedule?>(
  (ref) => ref.watch(targetsDaoProvider).watchSchedule(),
);

/// Engine built from the stored plan and schedule; null until both exist.
final nutritionEngineProvider = Provider<AsyncValue<NutritionEngine?>>((ref) {
  final plan = ref.watch(planProvider);
  final schedule = ref.watch(scheduleProvider);
  if (plan.hasError) return AsyncError(plan.error!, plan.stackTrace!);
  if (schedule.hasError) {
    return AsyncError(schedule.error!, schedule.stackTrace!);
  }
  if (!plan.hasValue || !schedule.hasValue) return const AsyncLoading();
  final p = plan.requireValue;
  final s = schedule.requireValue;
  return AsyncData(p == null || s == null ? null : NutritionEngine(p, s));
});

/// Targets for the current local day.
final todayTargetsProvider = Provider<AsyncValue<DailyTargets?>>((ref) {
  final engine = ref.watch(nutritionEngineProvider);
  return engine.whenData((e) => e?.targetsFor(DateTime.now()));
});
