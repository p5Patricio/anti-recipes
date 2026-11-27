import '../../../core/l10n/l10n.dart';

/// Localized, lowercase name of an ingredient category.
///
/// The built-in categories are translated; a custom category (for example
/// one restored from a backup) is shown as stored.
String categoryLabel(AppLocalizations l10n, String category) =>
    switch (category) {
      'protein' => l10n.recipesCategoryProtein,
      'carb' => l10n.recipesCategoryCarb,
      'vegetable' => l10n.recipesCategoryVegetable,
      'fruit' => l10n.recipesCategoryFruit,
      'fat' => l10n.recipesCategoryFat,
      'other' => l10n.recipesCategoryOther,
      _ => category,
    };
