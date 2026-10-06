import 'package:flutter/material.dart';

import '../../../../core/nutrition/nutrients.dart';

/// Compact one-line macro summary: "160 kcal · P 30 · F 3 · C 0 · Fiber 1".
String macroText(Nutrients n) =>
    '${n.kcal.round()} kcal · P ${n.proteinG.round()} · F ${n.fatG.round()} '
    '· C ${n.carbsG.round()} · Fiber ${n.fiberG.round()}';

class MacroLine extends StatelessWidget {
  const MacroLine(this.nutrients, {super.key, this.style});

  final Nutrients nutrients;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) => Text(
    macroText(nutrients),
    style: style ?? Theme.of(context).textTheme.bodyMedium,
  );
}
