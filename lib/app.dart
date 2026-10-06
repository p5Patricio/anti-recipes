import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/meal_log/presentation/home_screen.dart';

class AntiRecipesApp extends StatelessWidget {
  const AntiRecipesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'anti-recipes',
      theme: AppTheme.light(),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
