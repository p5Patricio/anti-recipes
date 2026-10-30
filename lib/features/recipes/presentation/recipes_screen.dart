import 'package:flutter/material.dart';

import '../../../core/widgets/coming_soon_view.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComingSoonView(
      icon: Icons.menu_book_outlined,
      title: 'Recipes',
      description: 'Build modular recipes with raw and cooked yields.',
    );
  }
}
