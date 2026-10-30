import 'package:flutter/material.dart';

import '../../../../core/formatting/date_format.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../nutrition_targets/domain/day_type.dart';
import 'status_style.dart';

/// Presentational day selector: arrows, date, "Today" jump chip, day-type badge.
class DayHeader extends StatelessWidget {
  const DayHeader({
    super.key,
    required this.date,
    required this.dayType,
    required this.isToday,
    required this.onPrevious,
    required this.onNext,
    required this.onToday,
  });

  final DateTime date;

  /// Null while the day type is not known (no plan yet).
  final DayType? dayType;
  final bool isToday;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onToday;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Row(
      children: [
        IconButton(
          key: const Key('prev-day'),
          tooltip: 'Previous day',
          icon: const Icon(Icons.chevron_left),
          onPressed: onPrevious,
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                weekdayDate(date),
                key: const Key('today-date'),
                style: text.titleMedium,
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 8,
                alignment: WrapAlignment.center,
                children: [
                  if (dayType != null) DayTypeBadge(dayType!),
                  if (!isToday)
                    ActionChip(
                      key: const Key('jump-today'),
                      label: const Text('Today'),
                      onPressed: onToday,
                    ),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          key: const Key('next-day'),
          tooltip: 'Next day',
          icon: const Icon(Icons.chevron_right),
          onPressed: onNext,
        ),
      ],
    );
  }
}

/// "Training day" in sage, "Rest day" in kraft.
class DayTypeBadge extends StatelessWidget {
  const DayTypeBadge(this.dayType, {super.key});

  final DayType dayType;

  @override
  Widget build(BuildContext context) {
    final training = dayType == DayType.training;
    return TintedChip(
      key: const Key('day-type-badge'),
      label: training ? 'Training day' : 'Rest day',
      color: training ? AppColors.sage : AppColors.kraft,
    );
  }
}
