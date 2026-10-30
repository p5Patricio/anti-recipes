import 'package:flutter/material.dart';

import '../../../recipes/presentation/recipe_kind_label.dart';
import '../../../recipes/presentation/recipes_providers.dart';

/// Searchable bottom sheet; pops with the chosen [RecipeSummary].
class RecipePickerSheet extends StatefulWidget {
  const RecipePickerSheet({super.key, required this.recipes});

  final List<RecipeSummary> recipes;

  @override
  State<RecipePickerSheet> createState() => _RecipePickerSheetState();
}

class _RecipePickerSheetState extends State<RecipePickerSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final query = _query.trim().toLowerCase();
    final matches = [
      for (final r in widget.recipes)
        if (r.recipe.name.toLowerCase().contains(query)) r,
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
                key: const Key('recipe-search'),
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Search recipes',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (v) => setState(() => _query = v),
              ),
            ),
            Expanded(
              child: matches.isEmpty
                  ? const Center(child: Text('No matching recipes'))
                  : ListView.builder(
                      itemCount: matches.length,
                      itemBuilder: (context, i) {
                        final s = matches[i];
                        return ListTile(
                          key: Key('pick-recipe-${s.recipe.id}'),
                          title: Text(s.recipe.name),
                          subtitle: Text(s.recipe.kind.label),
                          onTap: () => Navigator.pop(context, s),
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
