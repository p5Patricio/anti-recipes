import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/l10n/l10n.dart';
import '../../../../core/widgets/number_fields.dart';

/// Optional whole-number validator (empty is fine).
String? optionalWholeNumber(AppLocalizations l10n, String? value) {
  final text = (value ?? '').trim();
  if (text.isEmpty) return null;
  final n = int.tryParse(text);
  if (n == null) return l10n.recipesWholeNumber;
  if (n < 0) return l10n.coreWidgetsMustBeZeroOrMore;
  return null;
}

/// Presentational editor for one recipe step.
class StepEditorCard extends StatelessWidget {
  const StepEditorCard({
    super.key,
    required this.index,
    required this.technique,
    required this.tempC,
    required this.minutes,
    required this.tools,
    required this.toolId,
    required this.onToolChanged,
    required this.onMoveUp,
    required this.onMoveDown,
    required this.onRemove,
  });

  final int index;
  final TextEditingController technique;
  final TextEditingController tempC;
  final TextEditingController minutes;
  final List<Tool> tools;
  final int? toolId;
  final ValueChanged<int?> onToolChanged;

  /// Null disables the button (first / last step).
  final VoidCallback? onMoveUp;
  final VoidCallback? onMoveDown;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  context.l10n.recipesStepTitle(index + 1),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Spacer(),
                IconButton(
                  key: Key('step-up-$index'),
                  tooltip: context.l10n.recipesMoveUp,
                  icon: const Icon(Icons.arrow_upward),
                  onPressed: onMoveUp,
                ),
                IconButton(
                  key: Key('step-down-$index'),
                  tooltip: context.l10n.recipesMoveDown,
                  icon: const Icon(Icons.arrow_downward),
                  onPressed: onMoveDown,
                ),
                IconButton(
                  key: Key('step-remove-$index'),
                  tooltip: context.l10n.recipesRemoveStep,
                  icon: const Icon(Icons.close),
                  onPressed: onRemove,
                ),
              ],
            ),
            TextFormField(
              key: Key('step-technique-$index'),
              controller: technique,
              minLines: 1,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: context.l10n.recipesFieldTechnique,
              ),
              validator: (v) => (v ?? '').trim().isEmpty
                  ? context.l10n.recipesDescribeStep
                  : null,
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: NumberField(
                    key: Key('step-temp-$index'),
                    controller: tempC,
                    label: context.l10n.recipesFieldTemp,
                    suffix: '°C',
                    integerOnly: true,
                    validator: (v) => optionalWholeNumber(context.l10n, v),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: NumberField(
                    key: Key('step-minutes-$index'),
                    controller: minutes,
                    label: context.l10n.recipesFieldTime,
                    suffix: 'min',
                    integerOnly: true,
                    validator: (v) => optionalWholeNumber(context.l10n, v),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<int?>(
              key: Key('step-tool-$index'),
              initialValue: toolId,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: context.l10n.recipesFieldToolOptional,
              ),
              items: [
                DropdownMenuItem<int?>(
                  value: null,
                  child: Text(context.l10n.recipesToolNone),
                ),
                for (final t in tools)
                  DropdownMenuItem<int?>(value: t.id, child: Text(t.name)),
              ],
              onChanged: onToolChanged,
            ),
          ],
        ),
      ),
    );
  }
}
