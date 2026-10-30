/// Whole grams with thousands separators: 1200 -> "1,200".
String formatGrams(double grams) {
  final rounded = grams.round();
  final digits = rounded.abs().toString();
  final out = StringBuffer(rounded < 0 ? '-' : '');
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) out.write(',');
    out.write(digits[i]);
  }
  return out.toString();
}
