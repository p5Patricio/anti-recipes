import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/formatting/grams_format.dart';
import '../../../core/l10n/l10n.dart';
import '../domain/shopping_list.dart';
import 'shopping_list_text.dart';

Set<int> deserializeShoppingChecked(String? raw) {
  if (raw == null || raw.isEmpty) return {};
  try {
    final decoded = jsonDecode(raw);
    if (decoded is List) {
      return {
        for (final item in decoded)
          if (item is num) item.toInt(),
      };
    }
  } catch (_) {}
  return {};
}

String serializeShoppingChecked(Set<int> checked) {
  final list = checked.toList()..sort();
  return jsonEncode(list);
}

/// Ingredient ids ticked off while shopping. Persisted in AppSettings.
class ShoppingCheckedNotifier extends Notifier<Set<int>> {
  static const settingKey = 'shopping_checked_ids';

  @override
  Set<int> build() {
    _loadPersisted();
    return {};
  }

  Future<void> _loadPersisted() async {
    try {
      final dao = ref.read(settingsDaoProvider);
      final raw = await dao.getSetting(settingKey);
      if (raw != null) {
        state = deserializeShoppingChecked(raw);
      }
    } catch (_) {}
  }

  void _persist() {
    try {
      final dao = ref.read(settingsDaoProvider);
      final encoded = serializeShoppingChecked(state);
      dao.setSetting(settingKey, encoded).catchError((_) {});
    } catch (_) {}
  }

  void setChecked(int ingredientId, {required bool checked}) {
    final next = {...state};
    if (checked) {
      next.add(ingredientId);
    } else {
      next.remove(ingredientId);
    }
    state = next;
    _persist();
  }

  void clear() {
    state = {};
    _persist();
  }
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
    final l10n = context.l10n;
    await Clipboard.setData(
      ClipboardData(text: shoppingListText(l10n, list, title: title)),
    );
    messenger.showSnackBar(SnackBar(content: Text(l10n.plannerShoppingCopied)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final checked = ref.watch(shoppingCheckedProvider);
    final notifier = ref.read(shoppingCheckedProvider.notifier);
    final done = list.items.where((i) => checked.contains(i.ingredientId));
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.plannerShoppingListButton),
        actions: [
          IconButton(
            key: const Key('uncheck-all'),
            tooltip: l10n.plannerUncheckAll,
            icon: const Icon(Icons.remove_done_outlined),
            onPressed: notifier.clear,
          ),
        ],
      ),
      body: list.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  l10n.plannerShoppingEmpty,
                  key: const Key('shopping-empty'),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              children: [
                Text(title, style: text.bodyMedium),
                Text(
                  l10n.plannerShoppingProgress(done.length, list.items.length),
                  key: const Key('shopping-progress'),
                  style: text.bodySmall,
                ),
                for (final entry in list.byCategory.entries) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 4),
                    child: Text(
                      shoppingCategoryLabel(l10n, entry.key),
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
                  label: Text(l10n.plannerCopyAsText),
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
    final l10n = context.l10n;
    return CheckboxListTile(
      key: Key('shop-item-${item.ingredientId}'),
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      value: checked,
      onChanged: (v) => onChanged(v ?? false),
      title: Text(
        l10n.plannerIngredientLine(formatGrams(item.totalG), item.name),
        style: checked
            ? const TextStyle(decoration: TextDecoration.lineThrough)
            : null,
      ),
      subtitle: count == null
          ? null
          : Text(l10n.plannerAboutServings(count, formatGrams(item.servingG!))),
    );
  }
}
