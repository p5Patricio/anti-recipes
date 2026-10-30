/// Grams of one batch item that make the meal protein hit [targetProteinG].
///
/// [otherProteinG] is the protein already supplied by the other components and
/// [proteinPerGram] the protein of one gram of the chosen item. The result is
/// rounded to a whole gram and clamped to `0..maxGrams`; null when the item
/// has no protein to give.
double? suggestGramsForProtein({
  required double targetProteinG,
  required double otherProteinG,
  required double proteinPerGram,
  required double maxGrams,
}) {
  if (!(proteinPerGram > 0)) return null;
  final needed = ((targetProteinG - otherProteinG) / proteinPerGram)
      .roundToDouble();
  final upper = maxGrams < 0 ? 0.0 : maxGrams;
  return needed < 0 ? 0 : (needed > upper ? upper : needed);
}
