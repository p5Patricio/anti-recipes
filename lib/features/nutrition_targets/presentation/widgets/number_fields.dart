import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../targets_form_controllers.dart';

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

/// Min / max pair; the max field also validates `min <= max`.
class RangeFields extends StatelessWidget {
  const RangeFields({
    super.key,
    required this.keyPrefix,
    required this.label,
    required this.controllers,
    this.unit,
  });

  final String keyPrefix;
  final String label;
  final String? unit;
  final RangeControllers controllers;

  @override
  Widget build(BuildContext context) {
    final base = numberValidator();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: NumberField(
              key: Key('$keyPrefix-min'),
              controller: controllers.min,
              label: '$label min',
              suffix: unit,
              validator: base,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: NumberField(
              key: Key('$keyPrefix-max'),
              controller: controllers.max,
              label: '$label max',
              suffix: unit,
              validator: (value) {
                final error = base(value);
                if (error != null) return error;
                final min = parseNumber(controllers.min.text);
                if (min != null && parseNumber(value!)! < min) {
                  return 'Must be at least min';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
