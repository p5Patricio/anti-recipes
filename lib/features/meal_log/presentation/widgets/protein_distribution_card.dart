import 'package:flutter/material.dart';

import '../../../../core/nutrition/range.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/number_fields.dart';
import '../../domain/day_summary.dart';

/// Presentational mini chart: protein of each meal slot against the per-meal
/// band, drawn as plain bars.
class ProteinDistributionCard extends StatelessWidget {
  const ProteinDistributionCard({
    super.key,
    required this.slots,
    required this.band,
  });

  final List<MealSlotSummary> slots;
  final Range band;

  Color _color(MealSlotSummary s) {
    if (s.isEmpty) return AppColors.kraft;
    return s.proteinStatus == RangeStatus.within
        ? AppColors.sage
        : AppColors.terracotta;
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    // The scale always reaches past the band so it stays visible on empty days.
    final scaleMax = [
      band.max * 1.25,
      ...slots.map((s) => s.proteinG),
    ].reduce((a, b) => a > b ? a : b);
    return Card(
      key: const Key('protein-distribution'),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Protein per meal', style: text.titleMedium),
            Text(
              'Band ${formatNumber(band.min)}-${formatNumber(band.max)} g',
              style: text.bodySmall,
            ),
            const SizedBox(height: 8),
            for (final s in slots)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    SizedBox(width: 56, child: Text('Meal ${s.slot}')),
                    Expanded(
                      child: _Bar(
                        key: Key('protein-bar-${s.slot}'),
                        value: s.proteinG / scaleMax,
                        bandStart: band.min / scaleMax,
                        bandEnd: band.max / scaleMax,
                        color: _color(s),
                      ),
                    ),
                    SizedBox(
                      width: 56,
                      child: Text(
                        s.isEmpty ? '-' : '${s.proteinG.round()} g',
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({
    super.key,
    required this.value,
    required this.bandStart,
    required this.bandEnd,
    required this.color,
  });

  /// All fractions are relative to the bar width (0..1).
  final double value;
  final double bandStart;
  final double bandEnd;
  final Color color;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, c) {
      final w = c.maxWidth;
      return SizedBox(
        height: 14,
        child: Stack(
          children: [
            Positioned(
              left: bandStart * w,
              width: (bandEnd - bandStart) * w,
              top: 0,
              bottom: 0,
              child: ColoredBox(color: AppColors.sage.withValues(alpha: 0.25)),
            ),
            Positioned(
              left: 0,
              width: value.clamp(0.0, 1.0) * w,
              top: 3,
              bottom: 3,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
