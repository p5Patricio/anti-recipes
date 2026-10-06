import 'package:flutter/material.dart';

import 'grams_per_meal_field.dart';

/// One fresh ingredient row, ready to render.
class FreshRowData {
  const FreshRowData({
    required this.ingredientId,
    required this.name,
    required this.gramsPerMeal,
  });

  final int ingredientId;
  final String name;
  final double gramsPerMeal;
}

/// Presentational list of fresh ingredients eaten next to the batch, with the
/// grams per meal of each.
class FreshAdditionsSection extends StatelessWidget {
  const FreshAdditionsSection({
    super.key,
    required this.rows,
    required this.onAdd,
    required this.onGrams,
    required this.onRemove,
  });

  final List<FreshRowData> rows;
  final VoidCallback onAdd;
  final void Function(int ingredientId, double gramsPerMeal) onGrams;
  final ValueChanged<int> onRemove;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Fresh additions', style: text.titleMedium),
        Text(
          'Eaten as is next to the batch (fruit, raw vegetables).',
          style: text.bodySmall,
        ),
        const SizedBox(height: 8),
        for (final r in rows)
          Card(
            key: Key('fresh-row-${r.ingredientId}'),
            margin: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(r.name, style: text.titleSmall),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 3,
                    child: GramsPerMealField(
                      key: Key('fresh-grams-${r.ingredientId}'),
                      initial: r.gramsPerMeal,
                      onChanged: (g) => onGrams(r.ingredientId, g),
                    ),
                  ),
                  IconButton(
                    key: Key('remove-fresh-${r.ingredientId}'),
                    tooltip: 'Remove',
                    icon: const Icon(Icons.close),
                    onPressed: () => onRemove(r.ingredientId),
                  ),
                ],
              ),
            ),
          ),
        Align(
          alignment: Alignment.centerLeft,
          child: OutlinedButton.icon(
            key: const Key('add-fresh'),
            onPressed: onAdd,
            icon: const Icon(Icons.add),
            label: const Text('Add fresh ingredient'),
          ),
        ),
      ],
    );
  }
}
