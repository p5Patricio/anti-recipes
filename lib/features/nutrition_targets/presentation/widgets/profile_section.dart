import 'package:flutter/material.dart';

import '../targets_form_controllers.dart';
import 'number_fields.dart';

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
    final text = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Profile', style: text.titleMedium),
            const SizedBox(height: 12),
            NumberField(
              key: const Key('field-weight'),
              controller: controllers.weight,
              label: 'Body weight (optional)',
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
                    label: 'Protein',
                    suffix: 'g/day',
                    validator: numberValidator(positive: true),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: NumberField(
                    key: const Key('field-fat'),
                    controller: controllers.fat,
                    label: 'Fat',
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
              label: 'Meals per day',
              integerOnly: true,
              validator: numberValidator(positive: true),
            ),
            RangeFields(
              keyPrefix: 'field-protein-per-meal',
              label: 'Protein per meal',
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
