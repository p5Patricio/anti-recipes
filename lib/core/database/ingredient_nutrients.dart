import '../nutrition/nutrients.dart';
import 'app_database.dart';

extension IngredientNutrients on Ingredient {
  /// Raw nutrients per 100 g.
  Nutrients get per100g => Nutrients(
    kcal: kcal100,
    proteinG: protein100,
    fatG: fat100,
    carbsG: carbs100,
    fiberG: fiber100,
  );
}
