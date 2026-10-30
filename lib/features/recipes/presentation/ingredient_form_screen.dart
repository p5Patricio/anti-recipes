import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/nutrition/nutrients.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/number_fields.dart';
import '../domain/energy_check.dart';
import 'recipes_providers.dart';
import 'widgets/confirm_delete.dart';

const _baseCategories = [
  'protein',
  'carb',
  'vegetable',
  'fruit',
  'fat',
  'other',
];

String _capitalize(String s) =>
    s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

/// Create ([ingredient] == null) or edit one ingredient (values per 100 g raw).
class IngredientFormScreen extends ConsumerStatefulWidget {
  const IngredientFormScreen({super.key, this.ingredient});

  final Ingredient? ingredient;

  @override
  ConsumerState<IngredientFormScreen> createState() =>
      _IngredientFormScreenState();
}

class _IngredientFormScreenState extends ConsumerState<IngredientFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _kcal = TextEditingController();
  final _protein = TextEditingController();
  final _fat = TextEditingController();
  final _carbs = TextEditingController();
  final _fiber = TextEditingController();
  final _serving = TextEditingController();
  String _category = 'other';
  bool _isFruit = false;
  bool _isVegetable = false;

  @override
  void initState() {
    super.initState();
    final i = widget.ingredient;
    if (i == null) return;
    _name.text = i.name;
    _category = i.category;
    _isFruit = i.isFruit;
    _isVegetable = i.isVegetable;
    _kcal.text = formatNumber(i.kcal100);
    _protein.text = formatNumber(i.protein100);
    _fat.text = formatNumber(i.fat100);
    _carbs.text = formatNumber(i.carbs100);
    _fiber.text = formatNumber(i.fiber100);
    _serving.text = i.servingG == null ? '' : formatNumber(i.servingG!);
  }

  @override
  void dispose() {
    for (final c in [_name, _kcal, _protein, _fat, _carbs, _fiber, _serving]) {
      c.dispose();
    }
    super.dispose();
  }

  /// Macro-implied kcal when every energy field parses; null otherwise.
  double? _impliedKcalIfMismatch() {
    final kcal = parseNumber(_kcal.text);
    final p = parseNumber(_protein.text);
    final f = parseNumber(_fat.text);
    final c = parseNumber(_carbs.text);
    if (kcal == null || p == null || f == null || c == null) return null;
    if (kcal < 0 || p < 0 || f < 0 || c < 0) return null;
    final mismatch = kcalDeviatesFromMacros(
      kcal: kcal,
      proteinG: p,
      fatG: f,
      carbsG: c,
    );
    return mismatch ? kcalFromMacros(proteinG: p, fatG: f, carbsG: c) : null;
  }

  String? _nameValidator(String? value) {
    final name = (value ?? '').trim();
    if (name.isEmpty) return 'Enter a name';
    final taken = (ref.read(ingredientsProvider).value ?? const []).any(
      (i) =>
          i.id != widget.ingredient?.id &&
          i.name.toLowerCase() == name.toLowerCase(),
    );
    return taken ? 'An ingredient with this name already exists' : null;
  }

  String? _servingValidator(String? value) => (value ?? '').trim().isEmpty
      ? null
      : numberValidator(positive: true)(value);

  Future<void> _save() async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    if (!_formKey.currentState!.validate()) return;
    final serving = parseNumber(_serving.text);
    final companion = IngredientsCompanion(
      id: Value.absentIfNull(widget.ingredient?.id),
      name: Value(_name.text.trim()),
      category: Value(_category),
      isFruit: Value(_isFruit),
      isVegetable: Value(_isVegetable),
      servingG: Value(serving),
      kcal100: Value(parseNumber(_kcal.text)!),
      protein100: Value(parseNumber(_protein.text)!),
      fat100: Value(parseNumber(_fat.text)!),
      carbs100: Value(parseNumber(_carbs.text)!),
      fiber100: Value(parseNumber(_fiber.text)!),
    );
    try {
      await ref.read(recipesDaoProvider).saveIngredient(companion);
      navigator.pop();
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('Could not save ingredient: $e')),
      );
    }
  }

  Future<void> _delete() async {
    final navigator = Navigator.of(context);
    final dao = ref.read(recipesDaoProvider);
    final ingredient = widget.ingredient!;
    final done = await confirmAndDelete(
      context,
      title: 'Delete "${ingredient.name}"?',
      message: 'The ingredient will be removed from your library.',
      blockedMessage:
          'This ingredient is used in a recipe or a logged meal, so it '
          'cannot be deleted.',
      inUse: () => dao.isIngredientInUse(ingredient.id),
      delete: () => dao.deleteIngredient(ingredient.id),
    );
    if (done) navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.ingredient != null;
    final implied = _impliedKcalIfMismatch();
    final categories = {
      ..._baseCategories,
      if (editing) widget.ingredient!.category,
    }.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(editing ? 'Edit ingredient' : 'New ingredient'),
        actions: [
          if (editing)
            IconButton(
              key: const Key('delete-ingredient'),
              tooltip: 'Delete',
              icon: const Icon(Icons.delete_outline),
              onPressed: _delete,
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        onChanged: () => setState(() {}),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                key: const Key('ingredient-name'),
                controller: _name,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: _nameValidator,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                key: const Key('ingredient-category'),
                initialValue: _category,
                decoration: const InputDecoration(labelText: 'Category'),
                items: [
                  for (final c in categories)
                    DropdownMenuItem(value: c, child: Text(_capitalize(c))),
                ],
                onChanged: (c) => setState(() => _category = c ?? _category),
              ),
              const SizedBox(height: 16),
              Text(
                'Per 100 g raw',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              _field('ingredient-kcal', _kcal, 'Calories', 'kcal'),
              _field('ingredient-protein', _protein, 'Protein', 'g'),
              _field('ingredient-fat', _fat, 'Fat', 'g'),
              _field('ingredient-carbs', _carbs, 'Carbs', 'g'),
              _field('ingredient-fiber', _fiber, 'Fiber', 'g'),
              if (implied != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Calories differ from protein, fat and carbs by more than '
                    '15% (they add up to about ${implied.round()} kcal). '
                    'You can still save.',
                    key: const Key('energy-warning'),
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: AppColors.warning),
                  ),
                ),
              SwitchListTile(
                key: const Key('ingredient-is-fruit'),
                contentPadding: EdgeInsets.zero,
                title: const Text('Counts as a fruit portion'),
                value: _isFruit,
                onChanged: (v) => setState(() => _isFruit = v),
              ),
              SwitchListTile(
                key: const Key('ingredient-is-vegetable'),
                contentPadding: EdgeInsets.zero,
                title: const Text('Counts as a vegetable portion'),
                value: _isVegetable,
                onChanged: (v) => setState(() => _isVegetable = v),
              ),
              const SizedBox(height: 8),
              NumberField(
                key: const Key('ingredient-serving'),
                controller: _serving,
                label: 'Serving size (optional)',
                suffix: 'g',
                validator: _servingValidator,
              ),
              const SizedBox(height: 20),
              FilledButton(
                key: const Key('save-ingredient'),
                onPressed: _save,
                child: const Text('Save ingredient'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(
    String key,
    TextEditingController controller,
    String label,
    String unit,
  ) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: NumberField(
      key: Key(key),
      controller: controller,
      label: label,
      suffix: unit,
      validator: numberValidator(),
    ),
  );
}
