import 'package:flutter/material.dart';

import '../../../../core/widgets/number_fields.dart';
import '../../domain/day_summary.dart';
import 'status_style.dart';

/// Presentational progress row: label, "consumed / target unit" and a bar
/// colored by the metric status.
class MetricBar extends StatelessWidget {
  const MetricBar({
    super.key,
    required this.label,
    required this.progress,
    required this.unit,
    this.detail,
  });

  final String label;
  final MetricProgress progress;
  final String unit;

  /// Optional second line, e.g. the configured range or what is left.
  final String? detail;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final color = statusColor(progress.status);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(label, style: text.titleSmall)),
            Text(
              '${progress.consumed.round()} / ${progress.target.round()} $unit',
              style: text.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: progress.fraction,
            minHeight: 10,
            color: color,
            backgroundColor: color.withValues(alpha: 0.2),
          ),
        ),
        if (detail != null) ...[
          const SizedBox(height: 2),
          Text(detail!, style: text.bodySmall),
        ],
      ],
    );
  }
}

/// "270-305 g" style range text.
String rangeText(MetricProgress p, String unit) {
  final r = p.range;
  return r == null ? '' : '${formatNumber(r.min)}-${formatNumber(r.max)} $unit';
}
