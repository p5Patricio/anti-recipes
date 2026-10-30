import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/day_type.dart';
import '../targets_form_controllers.dart';
import 'number_fields.dart';

String dayTypeLabel(DayType type) =>
    type == DayType.training ? 'Training day' : 'Rest day';

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
    final text = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(dayTypeLabel(type), style: text.titleMedium),
            const SizedBox(height: 8),
            for (final field in TargetField.values)
              RangeFields(
                keyPrefix: '${type.name}-${field.name}',
                label: field.label,
                unit: field.unit,
                controllers: fields[field]!,
              ),
            const SizedBox(height: 4),
            Text(
              derivedCarbsG == null
                  ? 'Derived carbs: -'
                  : 'Derived carbs at mid calories: '
                        '${derivedCarbsG!.round()} g',
              key: Key('${type.name}-derived-carbs'),
              style: text.bodyMedium,
            ),
            if (carbsOutsideRange) ...[
              const SizedBox(height: 8),
              Chip(
                key: Key('${type.name}-carbs-warning'),
                avatar: const Icon(
                  Icons.warning_amber_rounded,
                  color: AppColors.graphite,
                ),
                backgroundColor: AppColors.terracotta,
                label: const Text(
                  'Derived carbs are outside the configured range',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Carbs are derived from calories left after protein and fat.',
                style: text.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
