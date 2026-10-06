import 'package:flutter/material.dart';

import '../../../core/widgets/coming_soon_view.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComingSoonView(
      icon: Icons.event_note_outlined,
      title: 'Plan',
      description: 'Plan your next batch cook and get one shopping list.',
    );
  }
}
