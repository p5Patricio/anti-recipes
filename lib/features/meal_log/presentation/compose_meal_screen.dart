import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/database/date_utils.dart';
import '../../../core/formatting/date_format.dart';
import '../../inventory/presentation/inventory_providers.dart';
import '../../nutrition_targets/presentation/targets_providers.dart';
import '../../recipes/presentation/recipes_providers.dart';
import 'compose_meal_form.dart';
import 'meal_log_providers.dart';

const _slots = [1, 2, 3];

/// Opens the composer for [date] (default today) on the first empty meal slot.
Future<void> openComposeMeal(
  BuildContext context,
  WidgetRef ref, {
  DateTime? date,
}) async {
  final day = dateOnly(date ?? DateTime.now());
  final navigator = Navigator.of(context);
  final meals = await ref.read(mealLogDaoProvider).loadDay(day);
  final taken = {for (final m in meals) m.slot};
  final slot = _slots.firstWhere((s) => !taken.contains(s), orElse: () => 1);
  await navigator.push(
    MaterialPageRoute<void>(
      builder: (_) => ComposeMealScreen(date: day, slot: slot),
    ),
  );
}

/// Compose (or edit) the meal of one `(date, slot)` from pantry stock and
/// fresh ingredients, with live protein and day-remaining feedback.
class ComposeMealScreen extends StatefulWidget {
  const ComposeMealScreen({super.key, required this.date, this.slot = 1});

  final DateTime date;
  final int slot;

  @override
  State<ComposeMealScreen> createState() => _ComposeMealScreenState();
}

class _ComposeMealScreenState extends State<ComposeMealScreen> {
  late int _slot = widget.slot;

  @override
  Widget build(BuildContext context) {
    final date = dateOnly(widget.date);
    return Scaffold(
      appBar: AppBar(title: const Text('Compose meal')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Row(
              children: [
                Text(
                  weekdayDate(date),
                  key: const Key('compose-date'),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                for (final s in _slots)
                  Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: ChoiceChip(
                      key: Key('slot-$s'),
                      label: Text('Meal $s'),
                      selected: _slot == s,
                      onSelected: (_) => setState(() => _slot = s),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            // A new key rebuilds the form with that slot's saved meal.
            child: _ComposeBody(key: ValueKey(_slot), date: date, slot: _slot),
          ),
        ],
      ),
    );
  }
}

class _ComposeBody extends ConsumerWidget {
  const _ComposeBody({super.key, required this.date, required this.slot});

  final DateTime date;
  final int slot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meals = ref.watch(dayMealsProvider(date));
    final stock = ref.watch(stockProvider);
    final engine = ref.watch(nutritionEngineProvider);
    final foods = ref.watch(ingredientsProvider);
    final all = <AsyncValue<Object?>>[meals, stock, engine, foods];
    final failed = all.where((v) => v.hasError).firstOrNull;
    if (failed != null) {
      return Center(
        child: Text('Could not load the composer: ${failed.error}'),
      );
    }
    if (all.any((v) => !v.hasValue)) {
      return const Center(child: CircularProgressIndicator());
    }
    final e = engine.requireValue;
    if (e == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Set up your nutrition targets in Settings to compose meals.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return ComposeMealForm(
      date: date,
      slot: slot,
      dayMeals: meals.requireValue,
      stock: stock.requireValue,
      ingredients: foods.requireValue,
      engine: e,
    );
  }
}
