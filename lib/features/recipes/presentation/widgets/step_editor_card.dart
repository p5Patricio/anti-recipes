import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/widgets/number_fields.dart';

/// Optional whole-number validator (empty is fine).
String? optionalWholeNumber(String? value) {
  final text = (value ?? '').trim();
  if (text.isEmpty) return null;
  final n = int.tryParse(text);
  if (n == null) return 'Whole number';
  if (n < 0) return 'Must be 0 or more';
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
                  'Step ${index + 1}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Spacer(),
                IconButton(
                  key: Key('step-up-$index'),
                  tooltip: 'Move up',
                  icon: const Icon(Icons.arrow_upward),
                  onPressed: onMoveUp,
                ),
                IconButton(
                  key: Key('step-down-$index'),
                  tooltip: 'Move down',
                  icon: const Icon(Icons.arrow_downward),
                  onPressed: onMoveDown,
                ),
                IconButton(
                  key: Key('step-remove-$index'),
                  tooltip: 'Remove step',
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
              decoration: const InputDecoration(labelText: 'Technique'),
              validator: (v) =>
                  (v ?? '').trim().isEmpty ? 'Describe the step' : null,
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: NumberField(
                    key: Key('step-temp-$index'),
                    controller: tempC,
                    label: 'Temp',
                    suffix: '°C',
                    integerOnly: true,
                    validator: optionalWholeNumber,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: NumberField(
                    key: Key('step-minutes-$index'),
                    controller: minutes,
                    label: 'Time',
                    suffix: 'min',
                    integerOnly: true,
                    validator: optionalWholeNumber,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<int?>(
              key: Key('step-tool-$index'),
              initialValue: toolId,
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Tool (optional)'),
              items: [
                const DropdownMenuItem<int?>(value: null, child: Text('None')),
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
