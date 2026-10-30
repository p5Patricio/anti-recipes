import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Clean placeholder for tabs whose feature is not built yet.
class ComingSoonView extends StatelessWidget {
  const ComingSoonView({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.header,
  });

  final IconData icon;
  final String title;
  final String description;

  /// Optional widget shown above the icon (for example the logo).
  final Widget? header;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final header = this.header;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (header != null) ...[header, const SizedBox(height: 24)],
              Icon(icon, size: 48, color: AppColors.sage),
              const SizedBox(height: 12),
              Text(title, style: text.headlineSmall),
              const SizedBox(height: 8),
              Text(
                'Coming soon',
                style: text.labelLarge?.copyWith(color: AppColors.terracotta),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
                style: text.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
