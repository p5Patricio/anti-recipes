import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/formatting/date_format.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/number_fields.dart';
import '../../recipes/presentation/recipes_providers.dart';
import '../data/inventory_dao.dart';
import '../domain/yield_deviation.dart';
import 'widgets/recipe_picker_sheet.dart';

/// Highest yield factor the recipe editor accepts; mirrors its validation.
const double _maxYieldFactor = 3;

class _ItemState {
  _ItemState(this.summary)
    : raw = TextEditingController(
        text: formatNumber(summary.nutrition.rawTotalG),
      ),
      cooked = TextEditingController();

  final RecipeSummary summary;
  final TextEditingController raw;
  final TextEditingController cooked;
  bool updateYield = false;

  double? get measuredYield => measuredYieldFactor(
    rawG: parseNumber(raw.text) ?? 0,
    cookedG: parseNumber(cooked.text) ?? 0,
  );

  double get expectedYield => summary.recipe.expectedYieldFactor;

  bool get deviates {
    final measured = measuredYield;
    return measured != null &&
        yieldDeviates(measured: measured, expected: expectedYield);
  }

  /// A measured yield outside the editor's valid range is never written back.
  bool get canUpdateRecipe => deviates && measuredYield! <= _maxYieldFactor;
}

/// Records a cooking session: dates covered and the batch items produced.
class LogBatchScreen extends ConsumerStatefulWidget {
  const LogBatchScreen({super.key});

  @override
  ConsumerState<LogBatchScreen> createState() => _LogBatchScreenState();
}

class _LogBatchScreenState extends ConsumerState<LogBatchScreen> {
  final _formKey = GlobalKey<FormState>();
  final _items = <_ItemState>[];

  /// Removed rows keep their controllers until dispose: their widgets are
  /// still mounted for one more frame.
  final _retired = <TextEditingController>[];

  late DateTime _cookedOn;
  late DateTime _coversFrom;
  late DateTime _coversTo;
  bool _itemsError = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    _cookedOn = today;
    _coversFrom = today;
    _coversTo = today.add(const Duration(days: 3));
  }

  @override
  void dispose() {
    for (final i in _items) {
      i.raw.dispose();
      i.cooked.dispose();
    }
    for (final c in _retired) {
      c.dispose();
    }
    super.dispose();
  }

  Future<DateTime?> _pickDate(DateTime initial) => showDatePicker(
    context: context,
    initialDate: initial,
    firstDate: DateTime(2020),
    lastDate: DateTime(2100),
  );

  Future<void> _addItem() async {
    final picked = await showModalBottomSheet<RecipeSummary>(
      context: context,
      isScrollControlled: true,
      builder: (_) => RecipePickerSheet(
        recipes: ref.read(recipeSummariesProvider).value ?? const [],
      ),
    );
    if (picked == null) return;
    setState(() {
      _items.add(_ItemState(picked));
      _itemsError = false;
    });
  }

  void _removeItem(int index) => setState(() {
    final removed = _items.removeAt(index);
    _retired.addAll([removed.raw, removed.cooked]);
  });

  bool get _datesValid => !_coversTo.isBefore(_coversFrom);

  Future<void> _save() async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final valid = _formKey.currentState!.validate();
    setState(() => _itemsError = _items.isEmpty);
    if (!valid || _items.isEmpty || !_datesValid) return;
    final db = ref.read(appDatabaseProvider);
    try {
      await db.transaction(() async {
        await db.inventoryDao.createBatch(
          cookedOn: _cookedOn,
          coversFrom: _coversFrom,
          coversTo: _coversTo,
          items: [
            for (final i in _items)
              BatchItemDraft(
                recipeId: i.summary.recipe.id,
                rawTotalG: parseNumber(i.raw.text)!,
                cookedTotalG: parseNumber(i.cooked.text)!,
              ),
          ],
        );
        for (final i in _items) {
          if (i.updateYield && i.canUpdateRecipe) {
            await db.recipesDao.updateExpectedYield(
              i.summary.recipe.id,
              i.measuredYield!,
            );
          }
        }
      });
      navigator.pop(true);
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('Could not save batch: $e')),
      );
    }
  }

  Widget _dateTile(
    String key,
    String label,
    DateTime value,
    ValueChanged<DateTime> onPicked,
  ) => ListTile(
    key: Key(key),
    contentPadding: EdgeInsets.zero,
    leading: const Icon(Icons.event_outlined),
    title: Text(label),
    trailing: Text(weekdayDate(value)),
    onTap: () async {
      final picked = await _pickDate(value);
      if (picked != null) setState(() => onPicked(picked));
    },
  );

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    // Keeps the stream loaded so the picker sheet can read it synchronously.
    ref.watch(recipeSummariesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Log batch cooked')),
      body: Form(
        key: _formKey,
        onChanged: () => setState(() {}),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _dateTile(
                'pick-cooked-on',
                'Cooked on',
                _cookedOn,
                (d) => _cookedOn = d,
              ),
              _dateTile(
                'pick-covers-from',
                'Covers from',
                _coversFrom,
                (d) => _coversFrom = d,
              ),
              _dateTile(
                'pick-covers-to',
                'Covers to',
                _coversTo,
                (d) => _coversTo = d,
              ),
              if (!_datesValid)
                Text(
                  'The end date must not be before the start date.',
                  key: const Key('dates-error'),
                  style: text.bodySmall?.copyWith(color: AppColors.error),
                ),
              const SizedBox(height: 16),
              Text('Batch items', style: text.titleMedium),
              const SizedBox(height: 8),
              for (final (i, item) in _items.indexed)
                _ItemCard(
                  key: ObjectKey(item),
                  index: i,
                  item: item,
                  onRemove: () => _removeItem(i),
                  onUpdateYield: (v) => setState(() => item.updateYield = v),
                ),
              if (_itemsError)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Add at least one batch item',
                    key: const Key('items-error'),
                    style: text.bodySmall?.copyWith(color: AppColors.error),
                  ),
                ),
              Align(
                alignment: Alignment.centerLeft,
                child: OutlinedButton.icon(
                  key: const Key('add-batch-item'),
                  onPressed: _addItem,
                  icon: const Icon(Icons.add),
                  label: const Text('Add recipe'),
                ),
              ),
              const SizedBox(height: 24),
              FilledButton(
                key: const Key('save-batch'),
                onPressed: _save,
                child: const Text('Save batch'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({
    super.key,
    required this.index,
    required this.item,
    required this.onRemove,
    required this.onUpdateYield,
  });

  final int index;
  final _ItemState item;
  final VoidCallback onRemove;
  final ValueChanged<bool> onUpdateYield;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final measured = item.measuredYield;
    final expected = item.expectedYield;
    final expectedCooked =
        (parseNumber(item.raw.text) ?? item.summary.nutrition.rawTotalG) *
        expected;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.summary.recipe.name,
                    style: text.titleMedium,
                  ),
                ),
                IconButton(
                  key: Key('remove-batch-item-$index'),
                  tooltip: 'Remove',
                  icon: const Icon(Icons.close),
                  onPressed: onRemove,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: NumberField(
                    key: Key('batch-raw-$index'),
                    controller: item.raw,
                    label: 'Raw total',
                    suffix: 'g',
                    validator: numberValidator(positive: true),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: NumberField(
                    key: Key('batch-cooked-$index'),
                    controller: item.cooked,
                    label: 'Cooked total',
                    suffix: 'g',
                    validator: numberValidator(positive: true),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              measured == null
                  ? 'Recipe expects yield ${expected.toStringAsFixed(2)} '
                        '(about ${expectedCooked.round()} g cooked)'
                  : 'Yield ${measured.toStringAsFixed(2)} '
                        '(recipe expects ${expected.toStringAsFixed(2)})',
              key: Key('yield-info-$index'),
              style: text.bodySmall,
            ),
            if (item.deviates) ...[
              const SizedBox(height: 4),
              Text(
                'Measured yield is ${_deviationPercent(measured!, expected)}% '
                'away from the recipe. Weigh again if that looks wrong.',
                key: Key('yield-note-$index'),
                style: text.bodySmall?.copyWith(color: AppColors.warning),
              ),
              if (item.canUpdateRecipe)
                SwitchListTile(
                  key: Key('update-yield-$index'),
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Update recipe yield to this value'),
                  value: item.updateYield,
                  onChanged: onUpdateYield,
                ),
            ],
          ],
        ),
      ),
    );
  }
}

int _deviationPercent(double measured, double expected) =>
    (yieldDeviation(measured: measured, expected: expected) * 100).round();
