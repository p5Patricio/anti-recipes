import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/tables.dart';
import '../../../core/nutrition/range.dart';
import '../domain/day_type.dart';
import '../domain/nutrition_plan.dart';

part 'targets_dao.g.dart';

@DriftAccessor(tables: [UserProfiles, DayTypeTargetRows, WeekScheduleEntries])
class TargetsDao extends DatabaseAccessor<AppDatabase> with _$TargetsDaoMixin {
  TargetsDao(super.db);

  static const _profileId = 1;

  /// Null until a profile and a row for every [DayType] exist.
  Future<NutritionPlan?> loadPlan() async {
    final profile = await (select(
      userProfiles,
    )..where((p) => p.id.equals(_profileId))).getSingleOrNull();
    final rows = await select(dayTypeTargetRows).get();
    if (profile == null || rows.length != DayType.values.length) return null;
    return NutritionPlan(
      proteinGPerDay: profile.proteinGPerDay,
      fatGPerDay: profile.fatGPerDay,
      mealsPerDay: profile.mealsPerDay,
      proteinPerMeal: Range(
        profile.proteinPerMealMin,
        profile.proteinPerMealMax,
      ),
      dayTypes: {
        for (final r in rows)
          r.dayType: DayTypeTargets(
            kcal: Range(r.kcalMin, r.kcalMax),
            carbs: Range(r.carbsMin, r.carbsMax),
            fiber: Range(r.fiberMin, r.fiberMax),
            waterMl: Range(r.waterMlMin, r.waterMlMax),
            fruitPortions: Range(r.fruitMin, r.fruitMax),
            vegPortions: Range(r.vegMin, r.vegMax),
          ),
      },
    );
  }

  /// Re-emits whenever the profile or any day-type row changes.
  Stream<NutritionPlan?> watchPlan() => customSelect(
    'SELECT 1',
    readsFrom: {userProfiles, dayTypeTargetRows},
  ).watch().asyncMap((_) => loadPlan());

  Future<void> savePlan(NutritionPlan plan) => transaction(() async {
    await into(userProfiles).insertOnConflictUpdate(
      UserProfilesCompanion(
        id: const Value(_profileId),
        proteinGPerDay: Value(plan.proteinGPerDay),
        fatGPerDay: Value(plan.fatGPerDay),
        mealsPerDay: Value(plan.mealsPerDay),
        proteinPerMealMin: Value(plan.proteinPerMeal.min),
        proteinPerMealMax: Value(plan.proteinPerMeal.max),
      ),
    );
    for (final entry in plan.dayTypes.entries) {
      final t = entry.value;
      await into(dayTypeTargetRows).insertOnConflictUpdate(
        DayTypeTargetRowsCompanion.insert(
          dayType: entry.key,
          kcalMin: t.kcal.min,
          kcalMax: t.kcal.max,
          carbsMin: t.carbs.min,
          carbsMax: t.carbs.max,
          fiberMin: t.fiber.min,
          fiberMax: t.fiber.max,
          waterMlMin: t.waterMl.min,
          waterMlMax: t.waterMl.max,
          fruitMin: t.fruitPortions.min,
          fruitMax: t.fruitPortions.max,
          vegMin: t.vegPortions.min,
          vegMax: t.vegPortions.max,
        ),
      );
    }
  });

  Future<double?> loadBodyWeightKg() async => (await (select(
    userProfiles,
  )..where((p) => p.id.equals(_profileId))).getSingleOrNull())?.bodyWeightKg;

  Future<void> saveBodyWeightKg(double? kg) =>
      (update(userProfiles)..where((p) => p.id.equals(_profileId))).write(
        UserProfilesCompanion(bodyWeightKg: Value(kg)),
      );

  Future<WeekSchedule?> loadSchedule() async =>
      _toSchedule(await select(weekScheduleEntries).get());

  Stream<WeekSchedule?> watchSchedule() =>
      select(weekScheduleEntries).watch().map(_toSchedule);

  WeekSchedule? _toSchedule(List<WeekScheduleEntry> rows) => rows.length != 7
      ? null
      : WeekSchedule({for (final r in rows) r.weekday: r.dayType});

  Future<void> saveSchedule(WeekSchedule schedule) => batch((b) {
    b.insertAllOnConflictUpdate(weekScheduleEntries, [
      for (final e in schedule.days.entries)
        WeekScheduleEntriesCompanion.insert(
          weekday: Value(e.key),
          dayType: e.value,
        ),
    ]);
  });
}
