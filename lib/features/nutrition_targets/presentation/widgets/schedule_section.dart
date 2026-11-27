import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/l10n/l10n.dart';
import '../../domain/day_type.dart';

/// Abbreviated weekday name (1 = Monday) in the current locale.
String _weekdayName(BuildContext context, int weekday) =>
    // 2024-01-01 is a Monday.
    DateFormat.E(Localizations.localeOf(context).toString())
        .format(DateTime(2024, 1, weekday));

class ScheduleSection extends StatelessWidget {
  const ScheduleSection({
    super.key,
    required this.days,
    required this.onToggle,
    required this.weeklyAverageKcal,
  });

  /// Weekday (1 = Monday .. 7 = Sunday) to day type.
  final Map<int, DayType> days;
  final ValueChanged<int> onToggle;
  final double? weeklyAverageKcal;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.targetsWeeklySchedule, style: text.titleMedium),
            const SizedBox(height: 4),
            Text(l10n.targetsScheduleHint, style: text.bodySmall),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (var weekday = 1; weekday <= 7; weekday++)
                  FilterChip(
                    key: Key('schedule-$weekday'),
                    avatar: Icon(
                      days[weekday] == DayType.training
                          ? Icons.fitness_center
                          : Icons.hotel_outlined,
                      size: 18,
                    ),
                    label: Text(_weekdayName(context, weekday)),
                    tooltip: days[weekday] == DayType.training
                        ? l10n.targetsScheduleTraining
                        : l10n.targetsScheduleRest,
                    selected: days[weekday] == DayType.training,
                    showCheckmark: false,
                    onSelected: (_) => onToggle(weekday),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              weeklyAverageKcal == null
                  ? l10n.targetsWeeklyAverageNone
                  : l10n.targetsWeeklyAverage(weeklyAverageKcal!.round()),
              key: const Key('weekly-average'),
              style: text.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
