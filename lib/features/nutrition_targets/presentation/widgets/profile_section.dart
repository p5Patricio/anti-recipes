import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../core/widgets/number_fields.dart';
import '../targets_form_controllers.dart';
import 'range_fields.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({
    super.key,
    required this.controllers,
    required this.hints,
  });

  final TargetsFormControllers controllers;

  /// Derived values (g/kg, protein per meal) shown under the fields.
  final List<String> hints;

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
            Text(l10n.targetsProfile, style: text.titleMedium),
            const SizedBox(height: 12),
            NumberField(
              key: const Key('field-weight'),
              controller: controllers.weight,
              label: l10n.targetsBodyWeight,
              suffix: 'kg',
              validator: (v) => (v ?? '').trim().isEmpty
                  ? null
                  : numberValidator(positive: true)(v),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: NumberField(
                    key: const Key('field-protein'),
                    controller: controllers.protein,
                    label: l10n.targetsProtein,
                    suffix: 'g/day',
                    validator: numberValidator(positive: true),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: NumberField(
                    key: const Key('field-fat'),
                    controller: controllers.fat,
                    label: l10n.targetsFat,
                    suffix: 'g/day',
                    validator: numberValidator(positive: true),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            NumberField(
              key: const Key('field-meals'),
              controller: controllers.meals,
              label: l10n.targetsMealsPerDay,
              integerOnly: true,
              validator: numberValidator(positive: true),
            ),
            RangeFields(
              keyPrefix: 'field-protein-per-meal',
              label: l10n.targetsProteinPerMeal,
              unit: 'g',
              controllers: controllers.proteinPerMeal,
            ),
            for (final hint in hints)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(hint, style: text.bodySmall),
              ),
          ],
        ),
      ),
    );
  }
}
