import 'package:flutter/material.dart';

/// Placeholder home screen until the daily dashboard is implemented.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/branding/logo.webp', width: 160),
            const SizedBox(height: 16),
            Text(
              'anti-recipes',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
