import 'package:flutter/material.dart';

import 'core/l10n/l10n.dart';
import 'features/batch_planner/presentation/plan_screen.dart';
import 'features/inventory/presentation/pantry_screen.dart';
import 'features/meal_log/presentation/today_screen.dart';
import 'features/recipes/presentation/recipes_screen.dart';
import 'features/settings/presentation/settings_screen.dart';

/// Bottom-navigation shell; keeps every tab alive with an [IndexedStack].
class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  static const _screens = <Widget>[
    TodayScreen(),
    RecipesScreen(),
    PantryScreen(),
    PlanScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: NavigationBar(
        height: 68,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.today_outlined),
            selectedIcon: const Icon(Icons.today),
            label: l10n.shellTabToday,
          ),
          NavigationDestination(
            icon: const Icon(Icons.menu_book_outlined),
            selectedIcon: const Icon(Icons.menu_book),
            label: l10n.shellTabRecipes,
          ),
          NavigationDestination(
            icon: const Icon(Icons.kitchen_outlined),
            selectedIcon: const Icon(Icons.kitchen),
            label: l10n.shellTabPantry,
          ),
          NavigationDestination(
            icon: const Icon(Icons.event_note_outlined),
            selectedIcon: const Icon(Icons.event_note),
            label: l10n.shellTabPlan,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: l10n.shellTabSettings,
          ),
        ],
      ),
    );
  }
}
