import 'package:flutter/material.dart';

import '../../domain/plan_inputs.dart';
import 'grams_per_meal_field.dart';

extension PlanRoleLabel on PlanRole {
  String get label => switch (this) {
    PlanRole.proteinBase => 'Protein base',
    PlanRole.carbBase => 'Carb base',
    PlanRole.vegetable => 'Vegetable (optional)',
    PlanRole.sauce => 'Sauce (optional)',
  };

  String get description => switch (this) {
    PlanRole.proteinBase => 'Sized to reach the protein target',
    PlanRole.carbBase => 'Sized to reach the carb target',
    PlanRole.vegetable => 'Fixed cooked grams per meal',
    PlanRole.sauce => 'Fixed cooked grams per meal',
  };
}

/// Presentational slot for one [PlanRole]: shows the chosen recipe and, for
/// the fixed side roles, the cooked grams per meal.
class RolePickerCard extends StatelessWidget {
  const RolePickerCard({
    super.key,
    required this.role,
    required this.recipeName,
    required this.onPick,
    required this.onClear,
    this.gramsPerMeal,
    this.onGramsPerMeal,
  });

  final PlanRole role;

  /// Null while no recipe is chosen.
  final String? recipeName;
  final VoidCallback onPick;
  final VoidCallback onClear;

  /// Only for the side roles.
  final double? gramsPerMeal;
  final ValueChanged<double>? onGramsPerMeal;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final name = recipeName;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(role.label, style: text.titleSmall),
                      Text(
                        name ?? role.description,
                        key: Key('role-recipe-${role.name}'),
                        style: name == null ? text.bodySmall : text.bodyLarge,
                      ),
                    ],
                  ),
                ),
                if (name != null)
                  IconButton(
                    key: Key('clear-role-${role.name}'),
                    tooltip: 'Remove',
                    icon: const Icon(Icons.close),
                    onPressed: onClear,
                  ),
                OutlinedButton(
                  key: Key('pick-role-${role.name}'),
                  onPressed: onPick,
                  child: Text(name == null ? 'Choose' : 'Change'),
                ),
              ],
            ),
            if (name != null && gramsPerMeal != null) ...[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GramsPerMealField(
                  key: Key('side-grams-${role.name}'),
                  initial: gramsPerMeal!,
                  label: 'Cooked grams per meal',
                  onChanged: onGramsPerMeal ?? (_) {},
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
