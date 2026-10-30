import 'package:flutter/material.dart';

import '../../../../core/widgets/number_fields.dart';

/// Numeric "grams per meal" input that reports every valid, positive value.
class GramsPerMealField extends StatefulWidget {
  const GramsPerMealField({
    super.key,
    required this.initial,
    required this.onChanged,
    this.label = 'Grams per meal',
  });

  final double initial;
  final String label;
  final ValueChanged<double> onChanged;

  @override
  State<GramsPerMealField> createState() => _GramsPerMealFieldState();
}

class _GramsPerMealFieldState extends State<GramsPerMealField> {
  late final _controller = TextEditingController(
    text: formatNumber(widget.initial),
  )..addListener(_report);

  late double _last = widget.initial;

  /// Listeners also fire on cursor moves, so only report real changes.
  void _report() {
    final value = parseNumber(_controller.text);
    if (value == null || !(value > 0) || value == _last) return;
    _last = value;
    widget.onChanged(value);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      NumberField(controller: _controller, label: widget.label, suffix: 'g');
}
