import 'package:flutter/material.dart';

import '../../../../core/l10n/l10n.dart';
import '../../../../core/widgets/number_fields.dart';

/// Largest single hydration entry accepted, in ml.
const maxCustomMl = 5000;

/// Asks for a custom amount in ml; null when cancelled.
Future<int?> showCustomMlDialog(BuildContext context) =>
    showDialog<int>(context: context, builder: (_) => const _CustomMlDialog());

class _CustomMlDialog extends StatefulWidget {
  const _CustomMlDialog();

  @override
  State<_CustomMlDialog> createState() => _CustomMlDialogState();
}

class _CustomMlDialogState extends State<_CustomMlDialog> {
  final _form = GlobalKey<FormState>();
  final _ml = TextEditingController();

  @override
  void dispose() {
    _ml.dispose();
    super.dispose();
  }

  String? _validate(String? value) {
    final l10n = context.l10n;
    final base = numberValidator(positive: true)(value);
    if (base != null) return base;
    return parseNumber(value!)! > maxCustomMl
        ? l10n.mealLogAtMostMl(maxCustomMl)
        : null;
  }

  void _submit() {
    if (!_form.currentState!.validate()) return;
    Navigator.pop(context, parseNumber(_ml.text)!.round());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.mealLogAddWaterTitle),
      content: Form(
        key: _form,
        child: NumberField(
          key: const Key('custom-ml-field'),
          controller: _ml,
          label: context.l10n.mealLogAmount,
          suffix: 'ml',
          integerOnly: true,
          validator: _validate,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(context.l10n.mealLogCancel),
        ),
        FilledButton(
          key: const Key('custom-ml-confirm'),
          onPressed: _submit,
          child: Text(context.l10n.mealLogAdd),
        ),
      ],
    );
  }
}
