import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n.dart';
import '../../domain/plan_inputs.dart';
import 'grams_per_meal_field.dart';

extension PlanRoleLabel on PlanRole {
  String label(AppLocalizations l10n) => switch (this) {
    PlanRole.proteinBase => l10n.plannerRoleProteinBase,
    PlanRole.carbBase => l10n.plannerRoleCarbBase,
    PlanRole.vegetable => l10n.plannerRoleVegetable,
    PlanRole.sauce => l10n.plannerRoleSauce,
  };

  String description(AppLocalizations l10n) => switch (this) {
    PlanRole.proteinBase => l10n.plannerRoleProteinBaseHint,
    PlanRole.carbBase => l10n.plannerRoleCarbBaseHint,
    PlanRole.vegetable || PlanRole.sauce => l10n.plannerRoleSideHint,
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
    final l10n = context.l10n;
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
                      Text(role.label(l10n), style: text.titleSmall),
                      Text(
                        name ?? role.description(l10n),
                        key: Key('role-recipe-${role.name}'),
                        style: name == null ? text.bodySmall : text.bodyLarge,
                      ),
                    ],
                  ),
                ),
                if (name != null)
                  IconButton(
                    key: Key('clear-role-${role.name}'),
                    tooltip: l10n.plannerRemove,
                    icon: const Icon(Icons.close),
                    onPressed: onClear,
                  ),
                OutlinedButton(
                  key: Key('pick-role-${role.name}'),
                  onPressed: onPick,
                  child: Text(
                    name == null ? l10n.plannerChoose : l10n.plannerChange,
                  ),
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
                  label: l10n.plannerCookedGramsPerMeal,
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
