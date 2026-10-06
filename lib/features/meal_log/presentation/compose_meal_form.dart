import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/ingredient_nutrients.dart';
import '../../../core/nutrition/nutrients.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/number_fields.dart';
import '../../inventory/data/inventory_dao.dart';
import '../../nutrition_targets/domain/nutrition_engine.dart';
import '../../recipes/domain/recipe_kind.dart';
import '../../recipes/presentation/widgets/ingredient_picker_sheet.dart';
import '../data/meal_log_dao.dart';
import '../domain/meal_totals.dart';
import '../domain/protein_suggestion.dart';
import 'widgets/meal_line_card.dart';
import 'widgets/meal_totals_card.dart';
import 'widgets/pantry_picker_sheet.dart';

/// Floors to one decimal so a filled amount never exceeds the stock.
double _floor1(double v) => (v * 10).floorToDouble() / 10;

class _Line {
  _Line.stock(StockItem item, double grams, this.heldG)
    : stock = item,
      ingredient = null,
      grams = TextEditingController(text: grams > 0 ? formatNumber(grams) : '');

  _Line.fresh(Ingredient food, double grams)
    : stock = null,
      ingredient = food,
      heldG = 0,
      grams = TextEditingController(text: grams > 0 ? formatNumber(grams) : '');

  final StockItem? stock;
  final Ingredient? ingredient;

  /// Grams of this item already counted by the saved version of the meal;
  /// they are given back to the stock when the meal is replaced.
  final double heldG;
  final TextEditingController grams;

  String get id =>
      stock != null ? 'b${stock!.batchItemId}' : 'i${ingredient!.id}';

  String get label => stock?.recipeName ?? ingredient!.name;

  Nutrients get per100 => stock != null
      ? stock!.nutrientsPerCookedGram.scale(100)
      : ingredient!.per100g;

  double get gramsValue => math.max(0, parseNumber(grams.text) ?? 0);

  MealLineInput get input => MealLineInput(per100g: per100, grams: gramsValue);
}

/// Container: owns the lines under composition and saves the meal.
class ComposeMealForm extends ConsumerStatefulWidget {
  const ComposeMealForm({
    super.key,
    required this.date,
    required this.slot,
    required this.dayMeals,
    required this.stock,
    required this.ingredients,
    required this.engine,
  });

  final DateTime date;
  final int slot;

  /// Every meal already logged on [date], including the one being edited.
  final List<MealView> dayMeals;
  final List<StockItem> stock;
  final List<Ingredient> ingredients;
  final NutritionEngine engine;

  @override
  ConsumerState<ComposeMealForm> createState() => _ComposeMealFormState();
}

class _ComposeMealFormState extends ConsumerState<ComposeMealForm> {
  final _formKey = GlobalKey<FormState>();
  final _lines = <_Line>[];
  final _retired = <TextEditingController>[];
  bool _linesError = false;

  @override
  void initState() {
    super.initState();
    final existing = widget.dayMeals
        .where((m) => m.slot == widget.slot)
        .firstOrNull;
    for (final c in existing?.components ?? const <MealComponentView>[]) {
      if (c.batchItemId != null) {
        final item = widget.stock
            .where((s) => s.batchItemId == c.batchItemId)
            .firstOrNull;
        if (item != null) _lines.add(_Line.stock(item, c.grams, c.grams));
      } else {
        final food = widget.ingredients
            .where((i) => i.id == c.ingredientId)
            .firstOrNull;
        if (food != null) _lines.add(_Line.fresh(food, c.grams));
      }
    }
  }

  @override
  void dispose() {
    for (final l in _lines) {
      l.grams.dispose();
    }
    for (final c in _retired) {
      c.dispose();
    }
    super.dispose();
  }

  void _refresh() => setState(() {});

  /// Grams the meal may use of a pantry line: what is left plus what the saved
  /// meal already holds.
  double _availableG(_Line line) {
    final live = widget.stock
        .where((s) => s.batchItemId == line.stock!.batchItemId)
        .firstOrNull;
    return math.max(0, (live ?? line.stock!).remainingG + line.heldG);
  }

  bool _isOver(_Line line) =>
      line.stock != null && line.gramsValue > _availableG(line) + 1e-9;

  void _setGrams(_Line line, double grams) {
    line.grams.text = grams > 0 ? formatNumber(grams) : '';
    _refresh();
  }

  void _bump(_Line line, double delta) => _setGrams(
    line,
    _floor1(math.min(line.gramsValue + delta, _availableG(line))),
  );

  void _remove(_Line line) => setState(() {
    _lines.remove(line);
    _retired.add(line.grams);
  });

  Future<void> _addFromPantry() async {
    final used = {for (final l in _lines) l.stock?.batchItemId};
    final picked = await showModalBottomSheet<StockItem>(
      context: context,
      builder: (_) => PantryPickerSheet(
        items: [
          for (final s in widget.stock)
            if (s.remainingG > 0 && !used.contains(s.batchItemId)) s,
        ],
      ),
    );
    if (picked == null) return;
    setState(() {
      _lines.add(_Line.stock(picked, 0, 0));
      _linesError = false;
    });
  }

  Future<void> _addFresh() async {
    final picked = await showModalBottomSheet<Ingredient>(
      context: context,
      isScrollControlled: true,
      builder: (_) => IngredientPickerSheet(
        ingredients: widget.ingredients,
        excludeIds: {for (final l in _lines) ?l.ingredient?.id},
      ),
    );
    if (picked == null) return;
    setState(() {
      _lines.add(_Line.fresh(picked, 0));
      _linesError = false;
    });
  }

  Nutrients get _totals => mealTotals(_lines.map((l) => l.input));

  _Line? get _proteinBaseLine => _lines
      .where((l) => l.stock?.recipeKind == RecipeKind.proteinBase)
      .firstOrNull;

  void _suggest() {
    final line = _proteinBaseLine;
    if (line == null) return;
    final range = widget.engine.plan.proteinPerMeal;
    final otherProtein = mealTotals(
      _lines.where((l) => l != line).map((l) => l.input),
    ).proteinG;
    final available = _availableG(line);
    final grams = suggestGramsForProtein(
      targetProteinG: range.midpoint,
      otherProteinG: otherProtein,
      proteinPerGram: line.stock!.nutrientsPerCookedGram.proteinG,
      maxGrams: _floor1(available),
    );
    final messenger = ScaffoldMessenger.of(context);
    if (grams == null) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('This item has no protein to suggest from.'),
        ),
      );
      return;
    }
    _setGrams(line, grams);
    if (mealTotals(_lines.map((l) => l.input)).proteinG < range.min) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Only ${available.round()} g left, so protein stays below the target.',
          ),
        ),
      );
    }
  }

  Future<bool> _confirmOverride(List<_Line> over) async {
    final names = over.map((l) => l.label).join(', ');
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Not enough in the pantry'),
        content: Text(
          'You entered more than what is left of $names. '
          'Saving will leave the stock below zero.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            key: const Key('confirm-override'),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Save anyway'),
          ),
        ],
      ),
    );
    return confirmed == true;
  }

  Future<void> _save() async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final valid = _formKey.currentState!.validate();
    setState(() => _linesError = _lines.isEmpty);
    if (!valid || _lines.isEmpty) return;
    final over = _lines.where(_isOver).toList();
    if (over.isNotEmpty && !await _confirmOverride(over)) return;
    try {
      await ref
          .read(mealLogDaoProvider)
          .upsertMeal(
            date: widget.date,
            slot: widget.slot,
            dayType: widget.engine.targetsFor(widget.date).dayType,
            components: [
              for (final l in _lines)
                MealComponentDraft(
                  batchItemId: l.stock?.batchItemId,
                  ingredientId: l.ingredient?.id,
                  grams: l.gramsValue,
                ),
            ],
          );
      navigator.pop(true);
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('Could not save meal: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final engine = widget.engine;
    final totals = _totals;
    final range = engine.plan.proteinPerMeal;
    final targets = engine.targetsFor(widget.date);
    final others = dayTotalsExcludingSlot([
      for (final m in widget.dayMeals) (slot: m.slot, nutrients: m.nutrients),
    ], widget.slot);
    final progress = engine.progress(
      widget.date,
      consumed: others + totals,
      waterMl: 0,
      fruitPortions: 0,
      vegPortions: 0,
    );
    final hasProteinBase = _proteinBaseLine != null;
    return Column(
      children: [
        Expanded(
          child: Form(
            key: _formKey,
            onChanged: _refresh,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              children: [
                for (final line in _lines)
                  MealLineCard(
                    key: ObjectKey(line),
                    idKey: line.id,
                    label: line.label,
                    subtitle: line.stock != null
                        ? 'From pantry · ${_availableG(line).round()} g available'
                        : 'Fresh ingredient',
                    grams: line.grams,
                    nutrients: line.input.nutrients,
                    warning: _isOver(line)
                        ? 'Only ${_availableG(line).round()} g left in the pantry.'
                        : null,
                    onAdd: line.stock == null ? null : (d) => _bump(line, d),
                    onAll: line.stock == null
                        ? null
                        : () => _setGrams(line, _floor1(_availableG(line))),
                    onRemove: () => _remove(line),
                  ),
                if (_linesError)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      'Add at least one component',
                      key: const Key('lines-error'),
                      style: text.bodySmall?.copyWith(color: AppColors.error),
                    ),
                  ),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    OutlinedButton.icon(
                      key: const Key('add-from-pantry'),
                      onPressed: _addFromPantry,
                      icon: const Icon(Icons.kitchen_outlined),
                      label: const Text('Add from pantry'),
                    ),
                    OutlinedButton.icon(
                      key: const Key('add-fresh'),
                      onPressed: _addFresh,
                      icon: const Icon(Icons.egg_alt_outlined),
                      label: const Text('Add fresh ingredient'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  key: const Key('suggest-protein'),
                  onPressed: hasProteinBase ? _suggest : null,
                  icon: const Icon(Icons.auto_fix_high),
                  label: const Text('Suggest to reach protein target'),
                ),
                if (!hasProteinBase)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'Add a protein-base item from the pantry to get a suggestion.',
                      key: const Key('suggest-hint'),
                      style: text.bodySmall,
                    ),
                  ),
              ],
            ),
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MealTotalsCard(
                  totals: totals,
                  proteinRange: range,
                  proteinStatus: engine.checkMeal(totals).protein,
                  proteinOutsideG: proteinOutsideRangeG(range, totals.proteinG),
                  dayTypeLabel: targets.dayType.name,
                  remainingKcal: progress.remainingKcal,
                  remainingCarbsG: progress.remainingCarbsG,
                ),
                const SizedBox(height: 4),
                FilledButton(
                  key: const Key('save-meal'),
                  onPressed: _save,
                  child: const Text('Save meal'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
