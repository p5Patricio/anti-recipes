import 'package:anti_recipes/core/nutrition/nutrients.dart';
import 'package:anti_recipes/core/nutrition/range.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Nutrients', () {
    const a = Nutrients(
      kcal: 100,
      proteinG: 10,
      fatG: 5,
      carbsG: 20,
      fiberG: 2,
    );
    const b = Nutrients(kcal: 50, proteinG: 5, fatG: 1, carbsG: 4, fiberG: 1);

    test('addition and scale', () {
      expect(
        a + b,
        const Nutrients(
          kcal: 150,
          proteinG: 15,
          fatG: 6,
          carbsG: 24,
          fiberG: 3,
        ),
      );
      expect(a.scale(2).kcal, 200);
      expect(a + Nutrients.zero, a);
    });

    test('fromPer100g scales by grams / 100', () {
      final n = Nutrients.fromPer100g(a, 250);
      expect(n.kcal, 250);
      expect(n.proteinG, 25);
      expect(n.fiberG, 5);
    });

    test('sum of empty is zero, of many adds up', () {
      expect(Nutrients.sum(const []), Nutrients.zero);
      expect(Nutrients.sum([a, b, b]).proteinG, 20);
    });

    test('equality and hashCode', () {
      expect(
        a,
        const Nutrients(
          kcal: 100,
          proteinG: 10,
          fatG: 5,
          carbsG: 20,
          fiberG: 2,
        ),
      );
      expect(a.hashCode, a.scale(1).hashCode);
      expect(a == b, isFalse);
    });

    test('kcalFromMacros uses 4/9/4', () {
      expect(kcalFromMacros(proteinG: 160, fatG: 70, carbsG: 295), 2450);
    });
  });

  group('Range', () {
    const r = Range(50, 55);

    test('contains, midpoint, clamp', () {
      expect(r.contains(50), isTrue);
      expect(r.contains(55), isTrue);
      expect(r.contains(55.1), isFalse);
      expect(r.midpoint, 52.5);
      expect(r.clamp(40), 50);
      expect(r.clamp(60), 55);
      expect(r.clamp(52), 52);
    });

    test('status', () {
      expect(r.status(49.9), RangeStatus.below);
      expect(r.status(50), RangeStatus.within);
      expect(r.status(55), RangeStatus.within);
      expect(r.status(55.1), RangeStatus.above);
    });
  });
}
