import 'package:flutter/material.dart';

import '../../../../core/nutrition/range.dart';
import '../../../../core/theme/app_colors.dart';

/// Sage when within the range, kraft while still below it, terracotta above.
Color statusColor(RangeStatus status) => switch (status) {
  RangeStatus.within => AppColors.sage,
  RangeStatus.below => AppColors.kraft,
  RangeStatus.above => AppColors.terracotta,
};

String statusLabel(RangeStatus status) => switch (status) {
  RangeStatus.within => 'On target',
  RangeStatus.below => 'Below',
  RangeStatus.above => 'Above',
};

/// Small rounded label tinted with [color] and outlined in it.
class TintedChip extends StatelessWidget {
  const TintedChip({super.key, required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.2),
      border: Border.all(color: color, width: 1.5),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      label,
      style: Theme.of(context).textTheme.labelMedium
          ?.copyWith(color: AppColors.graphite),
    ),
  );
}

/// Chip showing [status] with an optional [prefix], e.g. "Fiber · Below".
class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status, this.prefix});

  final RangeStatus status;
  final String? prefix;

  @override
  Widget build(BuildContext context) => TintedChip(
    label: prefix == null
        ? statusLabel(status)
        : '$prefix · ${statusLabel(status)}',
    color: statusColor(status),
  );
}
