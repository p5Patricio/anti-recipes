import 'package:anti_recipes/features/meal_log/domain/protein_suggestion.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fills the protein gap left by the other components', () {
    // 0.3 g protein per cooked gram, 12 g already in the meal, target 52.5 g.
    final grams = suggestGramsForProtein(
      targetProteinG: 52.5,
      otherProteinG: 12,
      proteinPerGram: 0.3,
      maxGrams: 300,
    );
    expect(grams, 135);
    expect(12 + grams! * 0.3, closeTo(52.5, 0.2));
  });

  test('rounds to a whole gram', () {
    final grams = suggestGramsForProtein(
      targetProteinG: 52.5,
      otherProteinG: 0,
      proteinPerGram: 0.29,
      maxGrams: 500,
    );
    expect(grams, 181);
  });

  test('is clamped to what is left in the pantry', () {
    final grams = suggestGramsForProtein(
      targetProteinG: 52.5,
      otherProteinG: 0,
      proteinPerGram: 0.3,
      maxGrams: 120.4,
    );
    expect(grams, 120.4);
  });

  test('is zero when the other components already reach the target', () {
    expect(
      suggestGramsForProtein(
        targetProteinG: 52.5,
        otherProteinG: 60,
        proteinPerGram: 0.3,
        maxGrams: 300,
      ),
      0,
    );
  });

  test('is zero when nothing is left', () {
    expect(
      suggestGramsForProtein(
        targetProteinG: 52.5,
        otherProteinG: 0,
        proteinPerGram: 0.3,
        maxGrams: 0,
      ),
      0,
    );
  });

  test('is null for an item without protein', () {
    expect(
      suggestGramsForProtein(
        targetProteinG: 52.5,
        otherProteinG: 0,
        proteinPerGram: 0,
        maxGrams: 300,
      ),
      isNull,
    );
  });
}
