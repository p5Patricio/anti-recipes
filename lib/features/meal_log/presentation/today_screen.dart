import 'package:flutter/material.dart';

import '../../../core/widgets/coming_soon_view.dart';

/// Placeholder until the daily dashboard is implemented.
class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ComingSoonView(
      icon: Icons.today_outlined,
      title: 'Today',
      description: 'Your meals, hydration and daily targets in one place.',
      header: Image.asset('assets/branding/logo.webp', width: 160),
    );
  }
}
