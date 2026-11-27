import '../../../core/l10n/l10n.dart';
import '../domain/recipe_kind.dart';

extension RecipeKindLabel on RecipeKind {
  /// Localized label.
  String localizedLabel(AppLocalizations l10n) => switch (this) {
    RecipeKind.proteinBase => l10n.recipesKindProteinBase,
    RecipeKind.carbBase => l10n.recipesKindCarbBase,
    RecipeKind.sauce => l10n.recipesKindSauce,
    RecipeKind.vegetable => l10n.recipesKindVegetable,
    RecipeKind.complete => l10n.recipesKindComplete,
  };

  /// English label without a context, kept for callers outside this feature
  /// that have not moved to [localizedLabel] yet.
  String get label => switch (this) {
    RecipeKind.proteinBase => 'Protein base',
    RecipeKind.carbBase => 'Carb base',
    RecipeKind.sauce => 'Sauce',
    RecipeKind.vegetable => 'Vegetable',
    RecipeKind.complete => 'Complete',
  };
}
