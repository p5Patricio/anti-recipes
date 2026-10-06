enum RangeStatus { below, within, above }

/// Inclusive numeric range.
class Range {
  const Range(this.min, this.max) : assert(min <= max, 'min must be <= max');

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
