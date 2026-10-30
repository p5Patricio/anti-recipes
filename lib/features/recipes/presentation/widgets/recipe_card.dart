import 'package:flutter/material.dart';

import '../../../../core/nutrition/nutrients.dart';
import '../../domain/recipe_kind.dart';
import '../recipe_kind_label.dart';
import 'macro_line.dart';

/// Presentational list card: name, kind, yield and macros per 100 g cooked.
class RecipeCard extends StatelessWidget {
  const RecipeCard({
    super.key,
    required this.name,
    required this.kind,
    required this.yieldFactor,
    required this.per100Cooked,
    required this.onTap,
  });

  final String name;
  final RecipeKind kind;
  final double yieldFactor;
  final Nutrients per100Cooked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: text.titleMedium),
              const SizedBox(height: 4),
              Text(
                '${kind.label} · yield ${yieldFactor.toStringAsFixed(2)}',
                style: text.bodySmall,
              ),
              const SizedBox(height: 8),
              Text('Per 100 g cooked', style: text.labelSmall),
              MacroLine(per100Cooked),
            ],
          ),
        ),
      ),
    );
  }
}
