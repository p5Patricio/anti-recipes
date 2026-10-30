import 'package:flutter/material.dart';

import '../../domain/day_type.dart';

const _weekdayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

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
    final text = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Weekly schedule', style: text.titleMedium),
            const SizedBox(height: 4),
            Text(
              'Selected chips are training days; the rest are rest days.',
              style: text.bodySmall,
            ),
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
                    label: Text(_weekdayNames[weekday - 1]),
                    tooltip: days[weekday] == DayType.training
                        ? 'Training'
                        : 'Rest',
                    selected: days[weekday] == DayType.training,
                    showCheckmark: false,
                    onSelected: (_) => onToggle(weekday),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              weeklyAverageKcal == null
                  ? 'Weekly average: -'
                  : 'Weekly average: ${weeklyAverageKcal!.round()} kcal/day',
              key: const Key('weekly-average'),
              style: text.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
