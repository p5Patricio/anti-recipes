import 'package:flutter/material.dart';

import '../../../../core/database/app_database.dart';

/// Searchable bottom sheet; pops with the chosen [Ingredient].
class IngredientPickerSheet extends StatefulWidget {
  const IngredientPickerSheet({
    super.key,
    required this.ingredients,
    this.excludeIds = const {},
  });

  final List<Ingredient> ingredients;

  /// Ingredients already on the recipe; they cannot be picked twice.
  final Set<int> excludeIds;

  @override
  State<IngredientPickerSheet> createState() => _IngredientPickerSheetState();
}

class _IngredientPickerSheetState extends State<IngredientPickerSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final query = _query.trim().toLowerCase();
    final matches = [
      for (final i in widget.ingredients)
        if (!widget.excludeIds.contains(i.id) &&
            i.name.toLowerCase().contains(query))
          i,
    ];
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.7,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                key: const Key('ingredient-search'),
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Search ingredients',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (v) => setState(() => _query = v),
              ),
            ),
            Expanded(
              child: matches.isEmpty
                  ? const Center(child: Text('No matching ingredients'))
                  : ListView.builder(
                      itemCount: matches.length,
                      itemBuilder: (context, i) {
                        final ingredient = matches[i];
                        return ListTile(
                          key: Key('pick-ingredient-${ingredient.id}'),
                          title: Text(ingredient.name),
                          subtitle: Text(ingredient.category),
                          onTap: () => Navigator.pop(context, ingredient),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
