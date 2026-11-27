import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../core/nutrition/nutrients.dart';

/// Compact one-line macro summary: "160 kcal · P 30 · F 3 · C 0 · Fiber 1".
String macroText(AppLocalizations l10n, Nutrients n) => l10n.recipesMacroLine(
  n.kcal.round(),
  n.proteinG.round(),
  n.fatG.round(),
  n.carbsG.round(),
  n.fiberG.round(),
);

class MacroLine extends StatelessWidget {
  const MacroLine(this.nutrients, {super.key, this.style});

  final Nutrients nutrients;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) => Text(
    macroText(context.l10n, nutrients),
    style: style ?? Theme.of(context).textTheme.bodyMedium,
  );
}
