import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../core/nutrition/range.dart';
import '../../../../core/theme/app_colors.dart';

/// Sage when within the range, kraft while still below it, terracotta above.
Color statusColor(RangeStatus status) => switch (status) {
  RangeStatus.within => AppColors.statusWithin,
  RangeStatus.below => AppColors.statusBelow,
  RangeStatus.above => AppColors.statusAbove,
};

String statusLabel(AppLocalizations l10n, RangeStatus status) =>
    switch (status) {
      RangeStatus.within => l10n.mealLogStatusOnTarget,
      RangeStatus.below => l10n.mealLogStatusBelow,
      RangeStatus.above => l10n.mealLogStatusAbove,
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
          ?.copyWith(color: AppColors.cream),
    ),
  );
}

/// Chip showing [status]; [label] overrides the plain status text, e.g.
/// "Fiber · Below".
class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status, this.label});

  final RangeStatus status;
  final String? label;

  @override
  Widget build(BuildContext context) => TintedChip(
    label: label ?? statusLabel(context.l10n, status),
    color: statusColor(status),
  );
}
