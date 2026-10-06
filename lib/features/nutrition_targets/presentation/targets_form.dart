import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../domain/day_type.dart';
import '../domain/nutrition_engine.dart';
import '../domain/nutrition_plan.dart';
import 'targets_form_controllers.dart';
import 'widgets/day_type_card.dart';
import 'widgets/profile_section.dart';
import 'widgets/schedule_section.dart';

/// Container: owns form state and persistence; sections are presentational.
class TargetsForm extends ConsumerStatefulWidget {
  const TargetsForm({
    super.key,
    required this.initialPlan,
    required this.initialSchedule,
    required this.initialWeightKg,
  });

  final NutritionPlan initialPlan;
  final WeekSchedule initialSchedule;
  final double? initialWeightKg;

  @override
  ConsumerState<TargetsForm> createState() => _TargetsFormState();
}

class _TargetsFormState extends ConsumerState<TargetsForm> {
  final _formKey = GlobalKey<FormState>();
  late final TargetsFormControllers _c;
  late Map<int, DayType> _days;

  @override
  void initState() {
    super.initState();
    _c = TargetsFormControllers(widget.initialPlan, widget.initialWeightKg);
    _days = Map.of(widget.initialSchedule.days);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  void _refresh() => setState(() {});

  List<String> _hints() {
    final weight = _c.weightKg;
    final protein = parseNumber(_c.protein.text);
    final fat = parseNumber(_c.fat.text);
    final meals = int.tryParse(_c.meals.text.trim());
    return [
      if (weight != null && weight > 0 && protein != null)
        'Protein: ${(protein / weight).toStringAsFixed(2)} g/kg',
      if (weight != null && weight > 0 && fat != null)
        'Fat: ${(fat / weight).toStringAsFixed(2)} g/kg',
      if (protein != null && meals != null && meals > 0)
        'Protein per meal target: ${(protein / meals).toStringAsFixed(1)} g',
    ];
  }

  Future<void> _save() async {
    final messenger = ScaffoldMessenger.of(context);
    if (!_formKey.currentState!.validate()) return;
    final NutritionPlan plan;
    final WeekSchedule schedule;
    try {
      plan = _c.read();
      schedule = WeekSchedule(_days);
    } on ArgumentError catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('Invalid input: ${e.message}')),
      );
      return;
    }
    final dao = ref.read(targetsDaoProvider);
    await dao.savePlan(plan);
    await dao.saveSchedule(schedule);
    await dao.saveBodyWeightKg(_c.weightKg);
    messenger.showSnackBar(
      const SnackBar(content: Text('Nutrition targets saved')),
    );
  }

  Future<void> _reset() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset to example defaults?'),
        content: const Text(
          'This replaces the values in the form. Nothing changes until you save.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    _c.fill(NutritionPlan.exampleDefaults(), _c.weightKg);
    _days = Map.of(WeekSchedule.exampleDefaults().days);
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    final plan = _c.tryRead();
    final engine = plan == null
        ? null
        : NutritionEngine(plan, WeekSchedule(_days));
    return Form(
      key: _formKey,
      onChanged: _refresh,
      // Not a lazy ListView: validation must reach every field.
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileSection(controllers: _c, hints: _hints()),
            for (final type in DayType.values) ...[
              const SizedBox(height: 12),
              DayTypeCard(
                type: type,
                fields: _c.dayTypes[type]!,
                derivedCarbsG: plan?.derivedCarbsG(type),
                carbsOutsideRange:
                    plan != null &&
                    !plan
                        .targetsFor(type)
                        .carbs
                        .contains(plan.derivedCarbsG(type)),
              ),
            ],
            const SizedBox(height: 12),
            ScheduleSection(
              days: _days,
              weeklyAverageKcal: engine?.weeklyAverageKcal(),
              onToggle: (weekday) {
                _days[weekday] = _days[weekday] == DayType.training
                    ? DayType.rest
                    : DayType.training;
                _refresh();
              },
            ),
            const SizedBox(height: 16),
            FilledButton(
              key: const Key('save-targets'),
              onPressed: _save,
              child: const Text('Save'),
            ),
            const SizedBox(height: 8),
            TextButton(
              key: const Key('reset-targets'),
              onPressed: _reset,
              child: const Text('Reset to example defaults'),
            ),
          ],
        ),
      ),
    );
  }
}
