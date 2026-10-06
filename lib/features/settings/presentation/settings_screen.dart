import 'package:flutter/material.dart';

import '../../nutrition_targets/presentation/nutrition_targets_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.track_changes_outlined),
              title: const Text('Nutrition targets'),
              subtitle: const Text('Protein, fat, day types and weekly plan'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const NutritionTargetsScreen(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
