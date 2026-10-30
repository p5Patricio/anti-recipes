import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/formatting/date_format.dart';
import '../../recipes/presentation/widgets/confirm_delete.dart';
import '../data/meal_log_dao.dart';
import '../domain/day_summary.dart';
import 'compose_meal_screen.dart';
import 'today_providers.dart';
import 'widgets/custom_ml_dialog.dart';
import 'widgets/day_header.dart';
import 'widgets/hydration_card.dart';
import 'widgets/macro_summary_card.dart';
import 'widgets/meal_slot_card.dart';
import 'widgets/protein_distribution_card.dart';
import 'widgets/servings_card.dart';

/// Container for the Today tab: day navigation, targets progress, meal slots,
/// hydration and fruit/vegetable portions of the selected day.
class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(selectedDateProvider);
    final isToday = date == ref.watch(todayProvider);
    final summary = ref.watch(daySummaryProvider(date));
    final selected = ref.read(selectedDateProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/branding/logo.webp', height: 32),
            const SizedBox(width: 8),
            const Text('Today'),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        children: [
          DayHeader(
            date: date,
            dayType: summary.value?.dayType,
            isToday: isToday,
            onPrevious: () => selected.shiftDays(-1),
            onNext: () => selected.shiftDays(1),
            onToday: selected.jumpToToday,
          ),
          const SizedBox(height: 8),
          ...summary.when(
            loading: () => const [
              Padding(
                padding: EdgeInsets.all(48),
                child: Center(child: CircularProgressIndicator()),
              ),
            ],
            error: (e, _) => [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Text('Could not load the day: $e'),
              ),
            ],
            data: (s) => s == null
                ? const [_SetupTargetsHint()]
                : _dayCards(context, ref, s),
          ),
        ],
      ),
    );
  }

  List<Widget> _dayCards(BuildContext context, WidgetRef ref, DaySummary s) {
    final date = s.date;
    final dao = ref.read(mealLogDaoProvider);
    final meals = ref.watch(dayMealsStreamProvider(date)).value ?? const [];
    MealView? mealIn(int slot) =>
        meals.where((m) => m.slot == slot).firstOrNull;

    return [
      MacroSummaryCard(summary: s),
      for (final slot in s.slots)
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: MealSlotCard(
            slot: slot,
            meal: mealIn(slot.slot),
            proteinPerMeal: s.proteinPerMeal,
            onCompose: () =>
                openComposeMeal(context, ref, date: date, slot: slot.slot),
            onDelete: () => confirmAndDelete(
              context,
              title: 'Delete meal ${slot.slot}?',
              message:
                  'This removes the meal from ${weekdayDate(date)} and gives '
                  'its pantry stock back.',
              blockedMessage: 'Could not delete the meal.',
              inUse: () async => false,
              delete: () => dao.deleteMeal(date, slot.slot),
            ),
          ),
        ),
      const SizedBox(height: 12),
      ProteinDistributionCard(slots: s.slots, band: s.proteinPerMeal),
      const SizedBox(height: 12),
      HydrationCard(
        water: s.water,
        onAdd: (ml) => dao.addHydration(date, ml),
        onCustom: () async {
          final ml = await showCustomMlDialog(context);
          if (ml != null) await dao.addHydration(date, ml);
        },
        onUndo: s.water.consumed > 0 ? () => dao.undoLastHydration(date) : null,
      ),
      const SizedBox(height: 12),
      ServingsCard(
        fruit: s.fruit,
        veg: s.veg,
        onFruit: (d) => dao.adjustServings(date, fruitDelta: d),
        onVeg: (d) => dao.adjustServings(date, vegDelta: d),
      ),
    ];
  }
}

class _SetupTargetsHint extends StatelessWidget {
  const _SetupTargetsHint();

  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.all(24),
    child: Text(
      'Set up your nutrition targets in Settings to see your daily progress.',
      key: Key('setup-targets-hint'),
      textAlign: TextAlign.center,
    ),
  );
}
