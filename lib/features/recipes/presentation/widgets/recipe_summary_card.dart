import 'package:flutter/material.dart';

import '../../domain/recipe_nutrition.dart';
import 'macro_line.dart';

/// Presentational summary: weights, total macros and macros per 100 g cooked.
class RecipeSummaryCard extends StatelessWidget {
  const RecipeSummaryCard(this.nutrition, {super.key});

  final RecipeNutrition nutrition;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Card(
      key: const Key('recipe-summary'),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Summary', style: text.titleMedium),
            const SizedBox(height: 8),
            Text('Raw weight: ${nutrition.rawTotalG.round()} g'),
            Text('Expected cooked weight: ${nutrition.cookedTotalG.round()} g'),
            const SizedBox(height: 8),
            Text('Total', style: text.labelMedium),
            MacroLine(nutrition.total),
            const SizedBox(height: 8),
            Text('Per 100 g cooked', style: text.labelMedium),
            MacroLine(nutrition.per100Cooked),
          ],
        ),
      ),
    );
  }
}
