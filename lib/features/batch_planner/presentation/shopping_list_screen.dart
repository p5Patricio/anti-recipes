import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/formatting/grams_format.dart';
import '../domain/shopping_list.dart';

/// Ingredient ids ticked off while shopping. Held in memory only.
class ShoppingCheckedNotifier extends Notifier<Set<int>> {
  @override
  Set<int> build() => {};

  void setChecked(int ingredientId, {required bool checked}) {
    final next = {...state};
    if (checked) {
      next.add(ingredientId);
    } else {
      next.remove(ingredientId);
    }
    state = next;
  }

  void clear() => state = {};
}

final shoppingCheckedProvider =
    NotifierProvider<ShoppingCheckedNotifier, Set<int>>(
      ShoppingCheckedNotifier.new,
    );

/// Grouped checklist of everything to buy for the plan.
class ShoppingListScreen extends ConsumerWidget {
  const ShoppingListScreen({
    super.key,
    required this.list,
    required this.title,
  });

  final ShoppingList list;

  /// First line of the exported text, e.g. the covered dates.
  final String title;

  Future<void> _copy(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    await Clipboard.setData(ClipboardData(text: list.toText(title: title)));
    messenger.showSnackBar(
      const SnackBar(content: Text('Shopping list copied')),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = Theme.of(context).textTheme;
    final checked = ref.watch(shoppingCheckedProvider);
    final notifier = ref.read(shoppingCheckedProvider.notifier);
    final done = list.items.where((i) => checked.contains(i.ingredientId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping list'),
        actions: [
          IconButton(
            key: const Key('uncheck-all'),
            tooltip: 'Uncheck all',
            icon: const Icon(Icons.remove_done_outlined),
            onPressed: notifier.clear,
          ),
        ],
      ),
      body: list.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Nothing to buy yet. Choose recipes in the plan first.',
                  key: Key('shopping-empty'),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              children: [
                Text(title, style: text.bodyMedium),
                Text(
                  '${done.length} of ${list.items.length} checked',
                  key: const Key('shopping-progress'),
                  style: text.bodySmall,
                ),
                for (final entry in list.byCategory.entries) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 4),
                    child: Text(
                      categoryLabel(entry.key),
                      key: Key('shopping-category-${entry.key}'),
                      style: text.titleMedium,
                    ),
                  ),
                  for (final item in entry.value)
                    _ItemTile(
                      item: item,
                      checked: checked.contains(item.ingredientId),
                      onChanged: (v) =>
                          notifier.setChecked(item.ingredientId, checked: v),
                    ),
                ],
                const SizedBox(height: 24),
                FilledButton.icon(
                  key: const Key('copy-shopping-list'),
                  onPressed: () => _copy(context),
                  icon: const Icon(Icons.copy_outlined),
                  label: const Text('Copy as text'),
                ),
              ],
            ),
    );
  }
}

class _ItemTile extends StatelessWidget {
  const _ItemTile({
    required this.item,
    required this.checked,
    required this.onChanged,
  });

  final ShoppingItem item;
  final bool checked;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final count = item.servingCount;
    return CheckboxListTile(
      key: Key('shop-item-${item.ingredientId}'),
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      value: checked,
      onChanged: (v) => onChanged(v ?? false),
      title: Text(
        '${formatGrams(item.totalG)} g ${item.name}',
        style: checked
            ? const TextStyle(decoration: TextDecoration.lineThrough)
            : null,
      ),
      subtitle: count == null
          ? null
          : Text('About $count x ${formatGrams(item.servingG!)} g'),
    );
  }
}
