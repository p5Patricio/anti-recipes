import '../../../core/formatting/grams_format.dart';
import 'batch_plan.dart';

/// One ingredient to buy, summed over every planned recipe and fresh addition.
class ShoppingItem {
  const ShoppingItem({
    required this.ingredientId,
    required this.name,
    required this.category,
    required this.totalG,
    this.servingG,
  });

  final int ingredientId;
  final String name;
  final String category;
  final double totalG;

  /// Typical weight of one unit (an egg), when known.
  final double? servingG;

  /// Whole units to buy; null while [servingG] is unknown.
  int? get servingCount {
    final s = servingG;
    if (s == null || !(s > 0)) return null;
    return (totalG / s - 1e-9).ceil();
  }

  /// "- [ ] 1,200 g Chicken breast", with the unit count when known.
  String get checklistLine {
    final count = servingCount;
    final units = count == null
        ? ''
        : ' (about $count x ${formatGrams(servingG!)} g)';
    return '- [ ] ${formatGrams(totalG)} g $name$units';
  }
}

/// All ingredients of a plan, grouped by category.
///
/// Raw ingredients have no pantry stock, so nothing is subtracted: leftovers
/// are cooked food and were already deducted from what gets cooked.
class ShoppingList {
  const ShoppingList._(this.items);

  /// Aggregates the scaled recipe lines and fresh additions of [plan].
  factory ShoppingList.fromPlan(BatchPlan plan) {
    final totals = <int, ShoppingItem>{};
    void add(
      int id,
      String name,
      String category,
      double grams,
      double? servingG,
    ) {
      if (!(grams > 0)) return;
      final existing = totals[id];
      totals[id] = ShoppingItem(
        ingredientId: id,
        name: name,
        category: category,
        totalG: (existing?.totalG ?? 0) + grams,
        servingG: servingG ?? existing?.servingG,
      );
    }

    for (final r in plan.recipes) {
      for (final l in r.lines) {
        add(l.ingredientId, l.name, l.category, l.rawG, l.servingG);
      }
    }
    for (final f in plan.fresh) {
      final a = f.addition;
      add(a.ingredientId, a.name, a.category, f.totalG, a.servingG);
    }
    final items = totals.values.toList()
      ..sort((a, b) {
        final byCategory = a.category.toLowerCase().compareTo(
          b.category.toLowerCase(),
        );
        return byCategory != 0
            ? byCategory
            : a.name.toLowerCase().compareTo(b.name.toLowerCase());
      });
    return ShoppingList._(List.unmodifiable(items));
  }

  /// Sorted by category, then name.
  final List<ShoppingItem> items;

  bool get isEmpty => items.isEmpty;

  /// Items per category, categories in sorted order.
  Map<String, List<ShoppingItem>> get byCategory {
    final groups = <String, List<ShoppingItem>>{};
    for (final i in items) {
      groups.putIfAbsent(i.category, () => []).add(i);
    }
    return groups;
  }

  /// Markdown-style checklist, one heading per category.
  String toText({String? title}) {
    final out = <String>[?title];
    for (final entry in byCategory.entries) {
      if (out.isNotEmpty) out.add('');
      out.add(categoryLabel(entry.key));
      out.addAll(entry.value.map((i) => i.checklistLine));
    }
    return out.join('\n');
  }
}

/// "protein" -> "Protein".
String categoryLabel(String category) => category.isEmpty
    ? 'Other'
    : category[0].toUpperCase() + category.substring(1);
