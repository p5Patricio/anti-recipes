import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n.dart';
import '../../domain/recipe_nutrition.dart';
import 'macro_line.dart';

/// Presentational summary: weights, total macros and macros per 100 g cooked.
class RecipeSummaryCard extends StatelessWidget {
  const RecipeSummaryCard(this.nutrition, {super.key});

  final RecipeNutrition nutrition;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final l10n = context.l10n;
    return Card(
      key: const Key('recipe-summary'),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.recipesSummaryTitle, style: text.titleMedium),
            const SizedBox(height: 8),
            Text(l10n.recipesSummaryRawWeight(nutrition.rawTotalG.round())),
            Text(
              l10n.recipesSummaryCookedWeight(nutrition.cookedTotalG.round()),
            ),
            const SizedBox(height: 8),
            Text(l10n.recipesSummaryTotal, style: text.labelMedium),
            MacroLine(nutrition.total),
            const SizedBox(height: 8),
            Text(l10n.recipesPer100Cooked, style: text.labelMedium),
            MacroLine(nutrition.per100Cooked),
          ],
        ),
      ),
    );
  }
}
