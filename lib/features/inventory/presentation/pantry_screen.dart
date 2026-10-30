import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../meal_log/presentation/compose_meal_screen.dart';
import 'batch_item_detail_screen.dart';
import 'inventory_providers.dart';
import 'log_batch_screen.dart';
import 'widgets/stock_card.dart';

/// Container: lists cooked batch items with live remaining stock.
class PantryScreen extends ConsumerWidget {
  const PantryScreen({super.key});

  void _push(BuildContext context, Widget screen) =>
      Navigator.of(context)
          .push(MaterialPageRoute<void>(builder: (_) => screen));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stock = ref.watch(stockProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantry'),
        actions: [
          IconButton(
            key: const Key('compose-meal'),
            tooltip: 'Compose a meal',
            icon: const Icon(Icons.restaurant_outlined),
            onPressed: () => openComposeMeal(context, ref),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('log-batch'),
        onPressed: () => _push(context, const LogBatchScreen()),
        icon: const Icon(Icons.add),
        label: const Text('Log batch cooked'),
      ),
      body: stock.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Could not load pantry: $e')),
        data: (items) {
          if (items.isEmpty) return const _EmptyState();
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, i) {
              final s = items[i];
              return StockCard(
                key: Key('stock-card-${s.batchItemId}'),
                name: s.recipeName,
                cookedOn: s.cookedOn,
                remainingG: s.remainingG,
                cookedTotalG: s.cookedTotalG,
                remainingFraction: s.remainingFraction,
                isLow: s.isLow,
                isEmpty: s.isEmpty,
                per100Cooked: s.nutrientsPerCookedGram.scale(100),
                onTap: () =>
                    _push(context, BatchItemDetailScreen(s.batchItemId)),
              );
            },
          );
        },
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.kitchen_outlined, size: 48, color: AppColors.sage),
            const SizedBox(height: 12),
            Text('Your pantry is empty', style: text.titleMedium),
            const SizedBox(height: 8),
            Text(
              'Log a cooked batch to track what is left and build meals from it.',
              textAlign: TextAlign.center,
              style: text.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
