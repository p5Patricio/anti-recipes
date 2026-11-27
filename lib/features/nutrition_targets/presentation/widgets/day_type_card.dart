import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/day_type.dart';
import '../targets_form_controllers.dart';
import 'range_fields.dart';

String dayTypeLabel(AppLocalizations l10n, DayType type) =>
    type == DayType.training ? l10n.targetsTrainingDay : l10n.targetsRestDay;

class DayTypeCard extends StatelessWidget {
  const DayTypeCard({
    super.key,
    required this.type,
    required this.fields,
    required this.derivedCarbsG,
    required this.carbsOutsideRange,
  });

  final DayType type;
  final Map<TargetField, RangeControllers> fields;

  /// Carbs left after protein and fat at the kcal midpoint; null if invalid.
  final double? derivedCarbsG;
  final bool carbsOutsideRange;

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
            Text(dayTypeLabel(l10n, type), style: text.titleMedium),
            const SizedBox(height: 8),
            for (final field in TargetField.values)
              RangeFields(
                keyPrefix: '${type.name}-${field.name}',
                label: field.label(l10n),
                unit: field.unit(l10n),
                controllers: fields[field]!,
              ),
            const SizedBox(height: 4),
            Text(
              derivedCarbsG == null
                  ? l10n.targetsDerivedCarbsNone
                  : l10n.targetsDerivedCarbs(derivedCarbsG!.round()),
              key: Key('${type.name}-derived-carbs'),
              style: text.bodyMedium,
            ),
            if (carbsOutsideRange) ...[
              const SizedBox(height: 8),
              Chip(
                key: Key('${type.name}-carbs-warning'),
                avatar: const Icon(
                  Icons.warning_amber_rounded,
                  color: AppColors.ink,
                ),
                backgroundColor: AppColors.statusAbove,
                label: Text(
                  l10n.targetsCarbsOutsideRange,
                  style: const TextStyle(color: AppColors.ink),
                ),
              ),
              const SizedBox(height: 4),
              Text(l10n.targetsCarbsExplain, style: text.bodySmall),
            ],
          ],
        ),
      ),
    );
  }
}
