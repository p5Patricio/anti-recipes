import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Formats a number without a trailing ".0" for whole values.
String formatNumber(double v) =>
    v == v.roundToDouble() ? v.toInt().toString() : v.toString();

/// Parses user input accepting either "." or "," as decimal separator.
double? parseNumber(String text) =>
    double.tryParse(text.trim().replaceAll(',', '.'));

/// Validator for required numeric input; [positive] forbids zero.
FormFieldValidator<String> numberValidator({bool positive = false}) {
  return (value) {
    final n = parseNumber(value ?? '');
    if (n == null) return 'Enter a number';
    if (positive ? n <= 0 : n < 0) {
      return positive ? 'Must be above 0' : 'Must be 0 or more';
    }
    return null;
  };
}

class NumberField extends StatelessWidget {
  const NumberField({
    super.key,
    required this.controller,
    required this.label,
    this.suffix,
    this.validator,
    this.integerOnly = false,
  });

  final TextEditingController controller;
  final String label;
  final String? suffix;
  final FormFieldValidator<String>? validator;
  final bool integerOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: !integerOnly),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          integerOnly ? RegExp(r'\d') : RegExp(r'[\d.,]'),
        ),
      ],
      decoration: InputDecoration(labelText: label, suffixText: suffix),
      validator: validator,
    );
  }
}
