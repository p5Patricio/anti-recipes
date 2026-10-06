import 'package:anti_recipes/features/inventory/domain/yield_deviation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('measuredYieldFactor', () {
    test('is cooked over raw', () {
      expect(measuredYieldFactor(rawG: 400, cookedG: 300), 0.75);
    });

    test('is null while a weight is missing or not positive', () {
      expect(measuredYieldFactor(rawG: 0, cookedG: 300), isNull);
      expect(measuredYieldFactor(rawG: 400, cookedG: 0), isNull);
      expect(measuredYieldFactor(rawG: 400, cookedG: -5), isNull);
    });
  });

  group('yieldDeviates', () {
    test('is false at exactly the 10% threshold', () {
      expect(yieldDeviates(measured: 1.1, expected: 1.0), isFalse);
    });

    test('is true beyond 10% in either direction', () {
      expect(yieldDeviates(measured: 0.9, expected: 1.0), isFalse);
      expect(yieldDeviates(measured: 1.2, expected: 1.0), isTrue);
      expect(yieldDeviates(measured: 0.6, expected: 0.75), isTrue);
    });

    test('is false for a measured value close to the expected one', () {
      expect(yieldDeviates(measured: 0.775, expected: 0.75), isFalse);
    });

    test('ignores an invalid expected yield', () {
      expect(yieldDeviates(measured: 0.5, expected: 0), isFalse);
    });
  });

  test('yieldDeviation is relative to the expected yield', () {
    expect(yieldDeviation(measured: 0.9, expected: 0.75), closeTo(0.2, 1e-12));
  });
}
