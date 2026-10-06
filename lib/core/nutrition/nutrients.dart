/// Kilocalories per gram of each macronutrient (Atwater factors).
const double kcalPerGramProtein = 4;
const double kcalPerGramFat = 9;
const double kcalPerGramCarbs = 4;

/// Energy implied by the given macros (4/9/4).
double kcalFromMacros({
  required double proteinG,
  required double fatG,
  required double carbsG,
}) =>
    proteinG * kcalPerGramProtein +
    fatG * kcalPerGramFat +
    carbsG * kcalPerGramCarbs;

/// Immutable nutrient amounts. Units: kcal and grams.
class Nutrients {
  const Nutrients({
    this.kcal = 0,
    this.proteinG = 0,
    this.fatG = 0,
    this.carbsG = 0,
    this.fiberG = 0,
  });

  static const Nutrients zero = Nutrients();

  final double kcal;
  final double proteinG;
  final double fatG;
  final double carbsG;
  final double fiberG;

  /// Sums every element; an empty iterable yields [zero].
  static Nutrients sum(Iterable<Nutrients> items) =>
      items.fold(zero, (acc, n) => acc + n);

  /// Nutrients for [grams] of a food described per 100 g.
  static Nutrients fromPer100g(Nutrients per100, double grams) =>
      per100.scale(grams / 100);

  Nutrients operator +(Nutrients other) => Nutrients(
        kcal: kcal + other.kcal,
        proteinG: proteinG + other.proteinG,
        fatG: fatG + other.fatG,
        carbsG: carbsG + other.carbsG,
        fiberG: fiberG + other.fiberG,
      );

  Nutrients scale(double factor) => Nutrients(
        kcal: kcal * factor,
        proteinG: proteinG * factor,
        fatG: fatG * factor,
        carbsG: carbsG * factor,
        fiberG: fiberG * factor,
      );

  @override
  bool operator ==(Object other) =>
      other is Nutrients &&
      other.kcal == kcal &&
      other.proteinG == proteinG &&
      other.fatG == fatG &&
      other.carbsG == carbsG &&
      other.fiberG == fiberG;

  @override
  int get hashCode => Object.hash(kcal, proteinG, fatG, carbsG, fiberG);

  @override
  String toString() =>
      'Nutrients(kcal: $kcal, protein: $proteinG, fat: $fatG, '
      'carbs: $carbsG, fiber: $fiberG)';
}
