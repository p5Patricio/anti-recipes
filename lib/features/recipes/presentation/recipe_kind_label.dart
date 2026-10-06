import '../domain/recipe_kind.dart';

extension RecipeKindLabel on RecipeKind {
  String get label => switch (this) {
    RecipeKind.proteinBase => 'Protein base',
    RecipeKind.carbBase => 'Carb base',
    RecipeKind.sauce => 'Sauce',
    RecipeKind.vegetable => 'Vegetable',
    RecipeKind.complete => 'Complete',
  };
}
