import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/widgets/number_fields.dart';
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

  List<String> _hints(AppLocalizations l10n) {
    final weight = _c.weightKg;
    final protein = parseNumber(_c.protein.text);
    final fat = parseNumber(_c.fat.text);
    final meals = int.tryParse(_c.meals.text.trim());
    return [
      if (weight != null && weight > 0 && protein != null)
        l10n.targetsHintProteinPerKg((protein / weight).toStringAsFixed(2)),
      if (weight != null && weight > 0 && fat != null)
        l10n.targetsHintFatPerKg((fat / weight).toStringAsFixed(2)),
      if (protein != null && meals != null && meals > 0)
        l10n.targetsHintProteinPerMeal((protein / meals).toStringAsFixed(1)),
    ];
  }

  Future<void> _save() async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    if (!_formKey.currentState!.validate()) return;
    final NutritionPlan plan;
    final WeekSchedule schedule;
    try {
      plan = _c.read();
      schedule = WeekSchedule(_days);
    } on TargetsInputException catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(switch (e.error) {
            TargetsInputError.incomplete => l10n.targetsInvalidIncomplete,
            TargetsInputError.mealsNotInteger => l10n.targetsInvalidMeals,
            TargetsInputError.invalid => l10n.targetsInvalidValues,
          }),
        ),
      );
      return;
    } on ArgumentError {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.targetsInvalidValues)),
      );
      return;
    }
    final dao = ref.read(targetsDaoProvider);
    await dao.savePlan(plan);
    await dao.saveSchedule(schedule);
    await dao.saveBodyWeightKg(_c.weightKg);
    messenger.showSnackBar(SnackBar(content: Text(l10n.targetsSaved)));
  }

  Future<void> _reset() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.targetsResetTitle),
        content: Text(context.l10n.targetsResetMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.l10n.targetsCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(context.l10n.targetsReset),
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
            ProfileSection(controllers: _c, hints: _hints(context.l10n)),
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
              child: Text(context.l10n.targetsSave),
            ),
            const SizedBox(height: 8),
            TextButton(
              key: const Key('reset-targets'),
              onPressed: _reset,
              child: Text(context.l10n.targetsResetToDefaults),
            ),
          ],
        ),
      ),
    );
  }
}
