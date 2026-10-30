import 'package:flutter/material.dart';

import '../../../core/widgets/coming_soon_view.dart';

class PantryScreen extends StatelessWidget {
  const PantryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComingSoonView(
      icon: Icons.kitchen_outlined,
      title: 'Pantry',
      description: 'Track cooked batches and compose meals from stock.',
    );
  }
}
