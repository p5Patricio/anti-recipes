import 'package:anti_recipes/core/database/app_database.dart';
import 'package:anti_recipes/features/meal_log/data/meal_log_dao.dart';
import 'package:anti_recipes/features/nutrition_targets/domain/day_type.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  final day = DateTime(2026, 10, 5);

  setUp(() => db = AppDatabase(NativeDatabase.memory()));
  tearDown(() => db.close());

  group('servings', () {
    test('an untouched day has no portions', () async {
      expect(await db.mealLogDao.watchServings(day).first, const DayServings());
      expect(await db.select(db.dayLogs).get(), isEmpty);
    });

    test('adjusting creates the row and increments each kind', () async {
      await db.mealLogDao.adjustServings(day, fruitDelta: 1);
      await db.mealLogDao.adjustServings(day, vegDelta: 2);
      await db.mealLogDao.adjustServings(
        DateTime(2026, 10, 5, 18, 30),
        fruitDelta: 1,
      );

      expect(
        await db.mealLogDao.watchServings(day).first,
        const DayServings(fruit: 2, veg: 2),
      );
      expect(await db.select(db.dayLogs).get(), hasLength(1));
    });

    test('portions never go below zero and days are independent', () async {
      await db.mealLogDao.adjustServings(day, fruitDelta: 1);
      await db.mealLogDao.adjustServings(day, fruitDelta: -3, vegDelta: -1);

      expect(await db.mealLogDao.watchServings(day).first, const DayServings());
      expect(
        await db.mealLogDao.watchServings(DateTime(2026, 10, 6)).first,
        const DayServings(),
      );
    });

    test('the stream re-emits after a change', () async {
      final emitted = <DayServings>[];
      final sub = db.mealLogDao.watchServings(day).listen(emitted.add);
      addTearDown(sub.cancel);
      await pumpEventQueue();
      await db.mealLogDao.adjustServings(day, vegDelta: 1);
      await pumpEventQueue();

      expect(emitted.last, const DayServings(veg: 1));
    });
  });

  group('undo hydration', () {
    test(
      'removes the most recent entry of the day and returns its ml',
      () async {
        await db.mealLogDao.addHydration(day, 250);
        await db.mealLogDao.addHydration(day, 500);
        await db.mealLogDao.addHydration(DateTime(2026, 10, 6), 750);

        expect(await db.mealLogDao.undoLastHydration(day), 500);
        expect(await db.mealLogDao.watchHydrationMl(day).first, 250);
        expect(await db.mealLogDao.undoLastHydration(day), 250);
        expect(await db.mealLogDao.watchHydrationMl(day).first, 0);
        // The next day was never touched.
        expect(
          await db.mealLogDao.watchHydrationMl(DateTime(2026, 10, 6)).first,
          750,
        );
      },
    );

    test('returns null when the day has nothing logged', () async {
      expect(await db.mealLogDao.undoLastHydration(day), isNull);
    });
  });

  test('watchDay keeps emitting while other watchers are active', () async {
    // Drift shares streams that have identical SQL; the watchers must not
    // collapse into the first one that was opened.
    final plan = db.targetsDao.watchPlan().listen((_) {});
    final stock = db.inventoryDao.watchStock().listen((_) {});
    addTearDown(plan.cancel);
    addTearDown(stock.cancel);
    final counts = <int>[];
    final sub = db.mealLogDao.watchDay(day).listen((m) => counts.add(m.length));
    addTearDown(sub.cancel);
    await pumpEventQueue();

    await db.mealLogDao.upsertMeal(
      date: day,
      slot: 1,
      dayType: DayType.training,
      components: const [],
    );
    await pumpEventQueue();

    expect(counts, [0, 1]);
  });
}
