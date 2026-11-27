import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../core/nutrition/nutrients.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../recipes/presentation/widgets/macro_line.dart';
import '../localized_dates.dart';

/// Presentational pantry card: recipe, remaining stock bar and per-100 g macros.
class StockCard extends StatelessWidget {
  const StockCard({
    super.key,
    required this.name,
    required this.cookedOn,
    required this.remainingG,
    required this.cookedTotalG,
    required this.remainingFraction,
    required this.isLow,
    required this.isEmpty,
    required this.per100Cooked,
    required this.onTap,
  });

  final String name;
  final DateTime cookedOn;
  final double remainingG;
  final double cookedTotalG;
  final double remainingFraction;
  final bool isLow;
  final bool isEmpty;
  final Nutrients per100Cooked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final shownRemaining = remainingG < 0 ? 0 : remainingG;
    return Opacity(
      opacity: isEmpty ? 0.55 : 1,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(name, style: text.titleMedium)),
                    if (isEmpty)
                      _StatusChip(l10n.pantryStatusEmpty, AppColors.creamMuted)
                    else if (isLow)
                      _StatusChip(l10n.pantryStatusLow, AppColors.statusAbove),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.pantryCooked(localizedShortDate(context, cookedOn)),
                  style: text.bodySmall,
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: remainingFraction,
                    minHeight: 8,
                    backgroundColor: AppColors.kraft.withValues(alpha: 0.3),
                    color: isLow
                        ? AppColors.statusAbove
                        : AppColors.statusWithin,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.pantryGramsLeft(
                    shownRemaining.round(),
                    cookedTotalG.round(),
                  ),
                  style: text.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(l10n.pantryPer100Cooked, style: text.labelSmall),
                MacroLine(per100Cooked),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip(this.label, this.color);

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      border: Border.all(color: color),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      label,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(color: color),
    ),
  );
}
