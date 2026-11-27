import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/l10n.dart';

/// Formats a number without a trailing ".0" for whole values.
String formatNumber(double v) =>
    v == v.roundToDouble() ? v.toInt().toString() : v.toString();

/// Parses user input accepting either "." or "," as decimal separator.
double? parseNumber(String text) =>
    double.tryParse(text.trim().replaceAll(',', '.'));

/// Stable error codes returned by [numberValidator]; [NumberField] turns them
/// into localized text. Any other message passes through unchanged.
const numberErrorEnter = 'number.enter';
const numberErrorPositive = 'number.positive';
const numberErrorNonNegative = 'number.nonNegative';

/// Validator for required numeric input; [positive] forbids zero.
///
/// Returns one of the `numberError*` codes, which [NumberField] localizes.
FormFieldValidator<String> numberValidator({bool positive = false}) {
  return (value) {
    final n = parseNumber(value ?? '');
    if (n == null) return numberErrorEnter;
    if (positive ? n <= 0 : n < 0) {
      return positive ? numberErrorPositive : numberErrorNonNegative;
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
      validator: validator == null
          ? null
          : (value) {
              final error = validator!(value);
              if (error == null) return null;
              final l10n = context.l10n;
              return switch (error) {
                numberErrorEnter => l10n.coreWidgetsEnterNumber,
                numberErrorPositive => l10n.coreWidgetsMustBeAboveZero,
                numberErrorNonNegative => l10n.coreWidgetsMustBeZeroOrMore,
                _ => error,
              };
            },
    );
  }
}
