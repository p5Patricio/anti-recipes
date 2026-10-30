import 'package:flutter/material.dart';

import '../../../../core/widgets/number_fields.dart';
import '../targets_form_controllers.dart';

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
