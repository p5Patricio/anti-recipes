import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../meal_log/presentation/widgets/status_style.dart';
import '../../../nutrition_targets/domain/day_type.dart';
import '../../../inventory/presentation/localized_dates.dart';
import '../../domain/plan_inputs.dart';

/// Presentational: start date, number of days (1..7) and the covered days
/// with their day type.
class DayRangeSelector extends StatelessWidget {
  const DayRangeSelector({
    super.key,
    required this.dates,
    required this.dayTypes,
    required this.onPickFrom,
    required this.onDayCount,
  });

  final List<DateTime> dates;

  /// Same length as [dates]; null entries while the day type is unknown.
  final List<DayType?> dayTypes;
  final VoidCallback onPickFrom;
  final ValueChanged<int> onDayCount;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          key: const Key('plan-from'),
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.event_outlined),
          title: Text(l10n.plannerFirstDay),
          trailing: Text(localizedWeekdayDate(context, dates.first)),
          onTap: onPickFrom,
        ),
        Text(l10n.plannerNumberOfDays, style: text.labelLarge),
        const SizedBox(height: 4),
        Wrap(
          spacing: 8,
          children: [
            for (var n = 1; n <= BatchPlanInput.maxPlanDays; n++)
              ChoiceChip(
                key: Key('plan-days-$n'),
                label: Text('$n'),
                selected: dates.length == n,
                onSelected: (_) => onDayCount(n),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: [
            for (final (i, date) in dates.indexed)
              TintedChip(
                key: Key('range-day-$i'),
                label: dayTypes[i] == null
                    ? localizedWeekdayDate(context, date)
                    : l10n.plannerRangeDayWithType(
                        localizedWeekdayDate(context, date),
                        dayTypes[i] == DayType.training
                            ? l10n.plannerDayTypeTraining
                            : l10n.plannerDayTypeRest,
                      ),
                color: dayTypes[i] == DayType.training
                    ? AppColors.blossom
                    : AppColors.kraft,
              ),
          ],
        ),
      ],
    );
  }
}
