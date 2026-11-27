import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/l10n/locale_provider.dart';
import '../../backup/presentation/backup_screen.dart';
import '../../nutrition_targets/presentation/nutrition_targets_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final locale = ref.watch(localeProvider);
    final languageLabel = switch (locale?.languageCode) {
      'en' => l10n.settingsLanguageEnglish,
      'es' => l10n.settingsLanguageSpanish,
      _ => l10n.settingsLanguageSystem,
    };
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.track_changes_outlined),
              title: Text(l10n.settingsNutritionTargetsTitle),
              subtitle: Text(l10n.settingsNutritionTargetsSubtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const NutritionTargetsScreen(),
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              key: const Key('backup-tile'),
              leading: const Icon(Icons.save_alt_outlined),
              title: Text(l10n.settingsBackupTitle),
              subtitle: Text(l10n.settingsBackupSubtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const BackupScreen()),
              ),
            ),
          ),
          Card(
            child: ListTile(
              key: const Key('language-tile'),
              leading: const Icon(Icons.language),
              title: Text(l10n.settingsLanguageTitle),
              subtitle: Text(languageLabel),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _pickLanguage(context, ref),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickLanguage(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final current = ref.read(localeProvider)?.languageCode;
    final options = <(String?, String)>[
      (null, l10n.settingsLanguageSystem),
      ('en', l10n.settingsLanguageEnglish),
      ('es', l10n.settingsLanguageSpanish),
    ];
    final picked = await showDialog<(String?,)>(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: Text(l10n.settingsLanguageTitle),
        children: [
          for (final (code, label) in options)
            SimpleDialogOption(
              key: Key('language-option-${code ?? 'system'}'),
              onPressed: () => Navigator.of(dialogContext).pop((code,)),
              child: Row(
                children: [
                  Expanded(child: Text(label)),
                  if (code == current) const Icon(Icons.check, size: 18),
                ],
              ),
            ),
        ],
      ),
    );
    if (picked == null) return;
    final code = picked.$1;
    await ref
        .read(localeProvider.notifier)
        .setLocale(code == null ? null : Locale(code));
  }
}
