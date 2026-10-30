/// Relative deviation above which a measured yield is worth flagging.
const double yieldDeviationThreshold = 0.10;

/// Cooked / raw weight ratio, or null while either weight is not positive.
double? measuredYieldFactor({required double rawG, required double cookedG}) =>
    rawG > 0 && cookedG > 0 ? cookedG / rawG : null;

/// Relative difference `|measured - expected| / expected` (0.1 means 10%).
double yieldDeviation({required double measured, required double expected}) =>
    (measured - expected).abs() / expected;

/// True when the measured yield differs from the recipe's expected yield by
/// strictly more than [threshold] (with a tolerance for floating point noise).
bool yieldDeviates({
  required double measured,
  required double expected,
  double threshold = yieldDeviationThreshold,
}) =>
    expected > 0 &&
    yieldDeviation(measured: measured, expected: expected) > threshold + 1e-9;
