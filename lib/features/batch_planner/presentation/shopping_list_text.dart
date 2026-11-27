import '../../../core/formatting/grams_format.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/shopping_list.dart';

/// "protein" -> "Protein" (localized for the known categories), "" -> "Other".
String shoppingCategoryLabel(AppLocalizations l10n, String category) =>
    switch (category.toLowerCase()) {
      '' || 'other' => l10n.plannerCategoryOther,
      'protein' => l10n.plannerCategoryProtein,
      'carb' => l10n.plannerCategoryCarb,
      'vegetable' => l10n.plannerCategoryVegetable,
      'fruit' => l10n.plannerCategoryFruit,
      'fat' => l10n.plannerCategoryFat,
      _ => category[0].toUpperCase() + category.substring(1),
    };

/// "- [ ] 1,200 g Chicken breast", with the unit count when known.
String shoppingChecklistLine(AppLocalizations l10n, ShoppingItem item) {
  final count = item.servingCount;
  final grams = formatGrams(item.totalG);
  return count == null
      ? l10n.plannerChecklistLine(grams, item.name)
      : l10n.plannerChecklistLineWithUnits(
          grams,
          item.name,
          count,
          formatGrams(item.servingG!),
        );
}

/// Markdown-style checklist, one heading per category.
String shoppingListText(
  AppLocalizations l10n,
  ShoppingList list, {
  String? title,
}) {
  final out = <String>[?title];
  for (final entry in list.byCategory.entries) {
    if (out.isNotEmpty) out.add('');
    out.add(shoppingCategoryLabel(l10n, entry.key));
    out.addAll(entry.value.map((i) => shoppingChecklistLine(l10n, i)));
  }
  return out.join('\n');
}
