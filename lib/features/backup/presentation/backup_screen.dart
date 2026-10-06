import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/formatting/date_format.dart';
import '../../batch_planner/presentation/plan_providers.dart';
import '../data/backup_schema.dart';
import '../domain/backup_document.dart';
import '../domain/backup_exception.dart';
import 'backup_providers.dart';

/// Export the whole database to a JSON file, or replace it from one.
class BackupScreen extends ConsumerStatefulWidget {
  const BackupScreen({super.key});

  @override
  ConsumerState<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends ConsumerState<BackupScreen> {
  bool _busy = false;

  void _snack(String message) =>
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));

  Future<void> _export() async {
    setState(() => _busy = true);
    try {
      final document = await ref.read(backupServiceProvider).exportDocument();
      final saved = await ref
          .read(backupFileGatewayProvider)
          .saveBackup(
            fileName: backupFileName(document.exportedAt.toLocal()),
            contents: document.encode(),
          );
      if (!mounted) return;
      _snack(
        saved == null
            ? 'Export cancelled. No file was saved.'
            : 'Backup saved (${document.totalRows} rows). '
                  '${describeRowCounts(document.rowCounts)}',
      );
    } on BackupException catch (e) {
      if (mounted) _snack(e.message);
    } catch (_) {
      if (mounted) _snack('The backup could not be saved.');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _import() async {
    setState(() => _busy = true);
    try {
      final contents = await ref.read(backupFileGatewayProvider).pickBackup();
      if (contents == null || !mounted) return;
      final service = ref.read(backupServiceProvider);
      final document = service.inspect(contents);
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (_) => _ConfirmImportDialog(document: document),
      );
      if (confirmed != true || !mounted) return;

      final result = await service.importJson(contents);
      // Streams re-emit by themselves; the in-memory plan selection may point
      // at rows that no longer exist.
      ref.invalidate(planSelectionProvider);
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          key: const Key('import-success'),
          title: const Text('Backup restored'),
          content: Text(
            '${result.totalRows} rows loaded. '
            '${describeRowCounts(result.rowCounts)}',
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } on BackupException catch (e) {
      await _showImportError(e.message);
    } catch (_) {
      await _showImportError('The backup could not be imported.');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _showImportError(String message) async {
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        key: const Key('import-error'),
        title: const Text('Import failed'),
        content: Text('$message\n\nYour current data was not changed.'),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Backup')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            key: const Key('backup-privacy-note'),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.lock_open_outlined, color: scheme.secondary),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'A backup is a plain, unencrypted JSON file with all '
                      'your data, including your body weight and daily '
                      'targets, recipes, meals and hydration. Only share it '
                      'with people and services you trust.',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            key: const Key('export-backup'),
            onPressed: _busy ? null : _export,
            icon: const Icon(Icons.file_upload_outlined),
            label: const Text('Export backup'),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            key: const Key('import-backup'),
            onPressed: _busy ? null : _import,
            icon: const Icon(Icons.file_download_outlined),
            label: const Text('Import backup'),
          ),
          const SizedBox(height: 8),
          Text(
            'Importing erases everything currently in the app and replaces '
            'it with the contents of the backup.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _ConfirmImportDialog extends StatelessWidget {
  const _ConfirmImportDialog({required this.document});

  final BackupDocument document;

  @override
  Widget build(BuildContext context) {
    final exported = document.exportedAt.toLocal();
    String two(int v) => v.toString().padLeft(2, '0');
    final stamp =
        '${shortDate(exported)}, ${exported.year} '
        '${two(exported.hour)}:${two(exported.minute)}';
    return AlertDialog(
      key: const Key('confirm-import-dialog'),
      title: const Text('Replace all data?'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Backup exported on $stamp.'),
            const SizedBox(height: 12),
            const Text(
              'Everything currently stored in the app will be erased and '
              'replaced by:',
            ),
            const SizedBox(height: 8),
            if (document.totalRows == 0)
              const Text('Nothing: this backup is empty.')
            else
              for (final spec in backupTables)
                if ((document.rowCounts[spec.name] ?? 0) > 0)
                  Text(
                    '${spec.label}: ${document.rowCounts[spec.name]}',
                    key: Key('import-count-${spec.name}'),
                  ),
            const SizedBox(height: 12),
            const Text('This cannot be undone.'),
          ],
        ),
      ),
      actions: [
        TextButton(
          key: const Key('cancel-import'),
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          key: const Key('confirm-import'),
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Erase and import'),
        ),
      ],
    );
  }
}
