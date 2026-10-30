import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/database/ingredient_nutrients.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/number_fields.dart';
import '../data/recipes_dao.dart';
import '../domain/recipe_kind.dart';
import '../domain/recipe_nutrition.dart';
import '../domain/yield_calculator.dart';
import 'recipe_kind_label.dart';
import 'recipes_providers.dart';
import 'widgets/confirm_delete.dart';
import 'widgets/ingredient_picker_sheet.dart';
import 'widgets/recipe_summary_card.dart';
import 'widgets/step_editor_card.dart';

const double _maxYieldFactor = 3;

String? _yieldValidator(String? value) {
  final n = parseNumber(value ?? '');
  if (n == null) return 'Enter a number';
  if (n <= 0 || n > _maxYieldFactor) return 'Must be above 0 and at most 3';
  return null;
}

class _LineState {
  _LineState(this.ingredient, double? grams)
    : grams = TextEditingController(
        text: grams == null ? '' : formatNumber(grams),
      );
  final Ingredient ingredient;
  final TextEditingController grams;
}

class _StepState {
  _StepState({String technique = '', int? tempC, int? minutes, this.toolId})
    : technique = TextEditingController(text: technique),
      tempC = TextEditingController(text: tempC?.toString() ?? ''),
      minutes = TextEditingController(text: minutes?.toString() ?? '');
  final TextEditingController technique;
  final TextEditingController tempC;
  final TextEditingController minutes;
  int? toolId;

  List<TextEditingController> get controllers => [technique, tempC, minutes];
}

/// Container: owns the form state and persistence of one recipe.
class RecipeEditorForm extends ConsumerStatefulWidget {
  const RecipeEditorForm({super.key, this.initial});

  /// The recipe being edited; null creates a new one.
  final RecipeDetail? initial;

  @override
  ConsumerState<RecipeEditorForm> createState() => _RecipeEditorFormState();
}

class _RecipeEditorFormState extends ConsumerState<RecipeEditorForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _yield = TextEditingController(text: '1');
  final _notes = TextEditingController();
  RecipeKind _kind = RecipeKind.proteinBase;
  final _lines = <_LineState>[];
  final _steps = <_StepState>[];
  final _toolIds = <int>{};
  bool _linesError = false;

  /// Removed rows keep their controllers alive until the form is disposed,
  /// because the widgets using them are still mounted for one more frame.
  final _retired = <TextEditingController>[];

  @override
  void initState() {
    super.initState();
    final d = widget.initial;
    if (d == null) return;
    _name.text = d.recipe.name;
    _yield.text = formatNumber(d.recipe.expectedYieldFactor);
    _notes.text = d.recipe.notes ?? '';
    _kind = d.recipe.kind;
    for (final l in d.ingredients) {
      _lines.add(_LineState(l.ingredient, l.rawG));
    }
    for (final s in d.steps) {
      _steps.add(
        _StepState(
          technique: s.technique,
          tempC: s.tempC,
          minutes: s.minutes,
          toolId: s.toolId,
        ),
      );
    }
    _toolIds.addAll(d.tools.map((t) => t.id));
  }

  @override
  void dispose() {
    for (final c in [_name, _yield, _notes, ..._retired]) {
      c.dispose();
    }
    for (final l in _lines) {
      l.grams.dispose();
    }
    for (final s in _steps) {
      for (final c in s.controllers) {
        c.dispose();
      }
    }
    super.dispose();
  }

  void _refresh() => setState(() {});

  RecipeNutrition _nutrition() {
    final factor = parseNumber(_yield.text);
    return RecipeNutrition([
      for (final l in _lines)
        if ((parseNumber(l.grams.text) ?? 0) > 0)
          RawIngredient(l.ingredient.per100g, parseNumber(l.grams.text)!),
    ], factor != null && factor > 0 && factor <= _maxYieldFactor ? factor : 0);
  }

  Future<void> _addLine() async {
    final picked = await showModalBottomSheet<Ingredient>(
      context: context,
      isScrollControlled: true,
      builder: (_) => IngredientPickerSheet(
        ingredients: ref.read(ingredientsProvider).value ?? const [],
        excludeIds: {for (final l in _lines) l.ingredient.id},
      ),
    );
    if (picked == null) return;
    setState(() {
      _lines.add(_LineState(picked, null));
      _linesError = false;
    });
  }

  void _removeLine(int index) => setState(() {
    _retired.add(_lines.removeAt(index).grams);
  });

  void _moveStep(int index, int delta) => setState(() {
    _steps.insert(index + delta, _steps.removeAt(index));
  });

  void _removeStep(int index) => setState(() {
    _retired.addAll(_steps.removeAt(index).controllers);
  });

  Future<void> _addTool(List<Tool> existing) async {
    final name = await showDialog<String>(
      context: context,
      builder: (_) => const _AddToolDialog(),
    );
    if (name == null || !mounted) return;
    final match = existing
        .where((t) => t.name.toLowerCase() == name.toLowerCase())
        .firstOrNull;
    final id = match?.id ?? await ref.read(recipesDaoProvider).addTool(name);
    if (!mounted) return;
    setState(() => _toolIds.add(id));
  }

  Future<void> _save() async {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final valid = _formKey.currentState!.validate();
    setState(() => _linesError = _lines.isEmpty);
    if (!valid || _lines.isEmpty) return;
    final notes = _notes.text.trim();
    final draft = RecipeDraft(
      id: widget.initial?.recipe.id,
      name: _name.text.trim(),
      kind: _kind,
      expectedYieldFactor: parseNumber(_yield.text)!,
      notes: notes.isEmpty ? null : notes,
      ingredients: [
        for (final l in _lines)
          RecipeIngredientDraft(
            ingredientId: l.ingredient.id,
            rawG: parseNumber(l.grams.text)!,
          ),
      ],
      steps: [
        for (final s in _steps)
          RecipeStepDraft(
            technique: s.technique.text.trim(),
            tempC: int.tryParse(s.tempC.text.trim()),
            minutes: int.tryParse(s.minutes.text.trim()),
            toolId: s.toolId,
          ),
      ],
      toolIds: _toolIds.toList(),
    );
    try {
      await ref.read(recipesDaoProvider).saveRecipe(draft);
      navigator.pop();
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('Could not save recipe: $e')),
      );
    }
  }

  Future<void> _delete() async {
    final navigator = Navigator.of(context);
    final dao = ref.read(recipesDaoProvider);
    final id = widget.initial!.recipe.id;
    final done = await confirmAndDelete(
      context,
      title: 'Delete "${widget.initial!.recipe.name}"?',
      message:
          'The recipe and its steps will be removed. This cannot be undone.',
      blockedMessage:
          'This recipe is used by a cooked batch, so it cannot be deleted.',
      inUse: () => dao.isRecipeInUse(id),
      delete: () => dao.deleteRecipe(id),
    );
    if (done) navigator.pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final tools = ref.watch(toolsProvider).value ?? const <Tool>[];
    // Keeps the stream loaded so the picker sheet can read it synchronously.
    ref.watch(ingredientsProvider);
    return Form(
      key: _formKey,
      onChanged: _refresh,
      // Not a lazy ListView: validation must reach every field.
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              key: const Key('recipe-name'),
              controller: _name,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (v) =>
                  (v ?? '').trim().isEmpty ? 'Enter a name' : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<RecipeKind>(
              key: const Key('recipe-kind'),
              initialValue: _kind,
              decoration: const InputDecoration(labelText: 'Kind'),
              items: [
                for (final k in RecipeKind.values)
                  DropdownMenuItem(value: k, child: Text(k.label)),
              ],
              onChanged: (k) => setState(() => _kind = k ?? _kind),
            ),
            const SizedBox(height: 12),
            TextFormField(
              key: const Key('recipe-yield'),
              controller: _yield,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Expected yield factor (cooked / raw)',
                helperText:
                    'Cooked weight divided by raw weight. Meat shrinks '
                    '(about 0.75); rice and pasta absorb water (about 2.5).',
                helperMaxLines: 3,
              ),
              validator: _yieldValidator,
            ),
            const SizedBox(height: 20),
            Text('Ingredients', style: text.titleMedium),
            const SizedBox(height: 8),
            for (final (i, l) in _lines.indexed)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(l.ingredient.name),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 2,
                      child: NumberField(
                        key: Key('line-grams-${l.ingredient.id}'),
                        controller: l.grams,
                        label: 'Raw',
                        suffix: 'g',
                        validator: numberValidator(positive: true),
                      ),
                    ),
                    IconButton(
                      key: Key('remove-line-${l.ingredient.id}'),
                      tooltip: 'Remove ingredient',
                      icon: const Icon(Icons.close),
                      onPressed: () => _removeLine(i),
                    ),
                  ],
                ),
              ),
            if (_linesError)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Add at least one ingredient',
                  key: const Key('lines-error'),
                  style: text.bodySmall?.copyWith(color: AppColors.error),
                ),
              ),
            Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton.icon(
                key: const Key('add-ingredient-line'),
                onPressed: _addLine,
                icon: const Icon(Icons.add),
                label: const Text('Add ingredient'),
              ),
            ),
            const SizedBox(height: 16),
            RecipeSummaryCard(_nutrition()),
            const SizedBox(height: 20),
            Text('Tools', style: text.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                for (final t in tools)
                  FilterChip(
                    key: Key('tool-chip-${t.id}'),
                    label: Text(t.name),
                    selected: _toolIds.contains(t.id),
                    onSelected: (on) => setState(
                      () => on ? _toolIds.add(t.id) : _toolIds.remove(t.id),
                    ),
                  ),
                ActionChip(
                  key: const Key('add-tool'),
                  avatar: const Icon(Icons.add, size: 18),
                  label: const Text('Add tool'),
                  onPressed: () => _addTool(tools),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text('Steps', style: text.titleMedium),
            const SizedBox(height: 8),
            for (final (i, s) in _steps.indexed)
              StepEditorCard(
                key: ObjectKey(s),
                index: i,
                technique: s.technique,
                tempC: s.tempC,
                minutes: s.minutes,
                tools: tools,
                toolId: s.toolId,
                onToolChanged: (id) => setState(() => s.toolId = id),
                onMoveUp: i == 0 ? null : () => _moveStep(i, -1),
                onMoveDown: i == _steps.length - 1
                    ? null
                    : () => _moveStep(i, 1),
                onRemove: () => _removeStep(i),
              ),
            Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton.icon(
                key: const Key('add-step'),
                onPressed: () => setState(() => _steps.add(_StepState())),
                icon: const Icon(Icons.add),
                label: const Text('Add step'),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              key: const Key('recipe-notes'),
              controller: _notes,
              minLines: 2,
              maxLines: 5,
              decoration: const InputDecoration(labelText: 'Notes (optional)'),
            ),
            const SizedBox(height: 20),
            FilledButton(
              key: const Key('save-recipe'),
              onPressed: _save,
              child: const Text('Save recipe'),
            ),
            if (widget.initial != null) ...[
              const SizedBox(height: 8),
              TextButton(
                key: const Key('delete-recipe-editor'),
                onPressed: _delete,
                style: TextButton.styleFrom(foregroundColor: AppColors.error),
                child: const Text('Delete recipe'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _AddToolDialog extends StatefulWidget {
  const _AddToolDialog();

  @override
  State<_AddToolDialog> createState() => _AddToolDialogState();
}

class _AddToolDialogState extends State<_AddToolDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _controller.text.trim();
    if (name.isNotEmpty) Navigator.pop(context, name);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add tool'),
      content: TextField(
        key: const Key('new-tool-name'),
        controller: _controller,
        autofocus: true,
        textCapitalization: TextCapitalization.sentences,
        decoration: const InputDecoration(labelText: 'Tool name'),
        onSubmitted: (_) => _submit(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          key: const Key('confirm-add-tool'),
          onPressed: _submit,
          child: const Text('Add'),
        ),
      ],
    );
  }
}
