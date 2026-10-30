enum RangeStatus { below, within, above }

/// Inclusive numeric range.
class Range {
  /// Throws [ArgumentError] when a bound is NaN or [min] is greater than [max].
  Range(this.min, this.max) {
    if (min.isNaN || max.isNaN) {
      throw ArgumentError('Range bounds must not be NaN');
    }
    if (min > max) {
      throw ArgumentError('Range min ($min) must be <= max ($max)');
    }
  }

  final double min;
  final double max;

  bool contains(double value) => value >= min && value <= max;

  double get midpoint => (min + max) / 2;

  double clamp(double value) => value < min ? min : (value > max ? max : value);

  RangeStatus status(double value) {
    if (value < min) return RangeStatus.below;
    if (value > max) return RangeStatus.above;
    return RangeStatus.within;
  }

  @override
  bool operator ==(Object other) =>
      other is Range && other.min == min && other.max == max;

  @override
  int get hashCode => Object.hash(min, max);

  @override
  String toString() => 'Range($min, $max)';
}
