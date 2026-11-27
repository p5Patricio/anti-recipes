import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n.dart';
import '../../batch_planner/presentation/plan_providers.dart';
import '../../batch_planner/presentation/shopping_list_screen.dart';
import '../../inventory/presentation/localized_dates.dart';
import '../data/backup_schema.dart';
import '../domain/backup_document.dart';
import '../domain/backup_exception.dart';
import 'backup_messages.dart';
import 'backup_providers.dart';

/// Export the whole database to a JSON file, or replace it from one.
class BackupScreen extends ConsumerStatefulWidget {
  const BackupScreen({super.key});

  @override
  ConsumerState<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends ConsumerState<BackupScreen> {
  bool _busy = false;

  List<String> get _tableOrder => [for (final s in backupTables) s.name];

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
      final l10n = context.l10n;
      _snack(
        saved == null
            ? l10n.backupExportCancelled
            : l10n.backupSaved(
                document.totalRows,
                describeRowCounts(l10n, document.rowCounts, _tableOrder),
              ),
      );
    } on BackupException catch (e) {
      if (mounted) _snack(backupErrorMessage(context.l10n, e));
    } catch (_) {
      if (mounted) _snack(context.l10n.backupSaveFailed);
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
      // Streams re-emit by themselves; the plan selection and shopping checklist
      // reload fresh state from the restored database.
      ref.invalidate(planSelectionProvider);
      ref.invalidate(shoppingCheckedProvider);
      if (!mounted) return;
      final l10n = context.l10n;
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          key: const Key('import-success'),
          title: Text(l10n.backupRestoredTitle),
          content: Text(
            l10n.backupRestoredBody(
              result.totalRows,
              describeRowCounts(l10n, result.rowCounts, _tableOrder),
            ),
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: Text(l10n.backupOk),
            ),
          ],
        ),
      );
    } on BackupException catch (e) {
      if (mounted) await _showImportError(backupErrorMessage(context.l10n, e));
    } catch (_) {
      if (mounted) {
        await _showImportError(context.l10n.backupImportFailedGeneric);
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _showImportError(String message) async {
    if (!mounted) return;
    final l10n = context.l10n;
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        key: const Key('import-error'),
        title: Text(l10n.backupImportFailedTitle),
        content: Text(l10n.backupImportFailedBody(message)),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.backupOk),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.backupTitle)),
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
                  Expanded(child: Text(l10n.backupPrivacyNote)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            key: const Key('export-backup'),
            onPressed: _busy ? null : _export,
            icon: const Icon(Icons.file_upload_outlined),
            label: Text(l10n.backupExport),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            key: const Key('import-backup'),
            onPressed: _busy ? null : _import,
            icon: const Icon(Icons.file_download_outlined),
            label: Text(l10n.backupImport),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.backupImportWarning,
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
    final l10n = context.l10n;
    final exported = document.exportedAt.toLocal();
    String two(int v) => v.toString().padLeft(2, '0');
    final stamp =
        '${localizedShortDate(context, exported)}, ${exported.year} '
        '${two(exported.hour)}:${two(exported.minute)}';
    return AlertDialog(
      key: const Key('confirm-import-dialog'),
      title: Text(l10n.backupConfirmTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.backupExportedOn(stamp)),
            const SizedBox(height: 12),
            Text(l10n.backupConfirmIntro),
            const SizedBox(height: 8),
            if (document.totalRows == 0)
              Text(l10n.backupEmptyBackup)
            else
              for (final spec in backupTables)
                if ((document.rowCounts[spec.name] ?? 0) > 0)
                  Text(
                    l10n.backupCountEntry(
                      backupTableLabel(l10n, spec.name),
                      document.rowCounts[spec.name]!,
                    ),
                    key: Key('import-count-${spec.name}'),
                  ),
            const SizedBox(height: 12),
            Text(l10n.backupCannotUndo),
          ],
        ),
      ),
      actions: [
        TextButton(
          key: const Key('cancel-import'),
          onPressed: () => Navigator.pop(context, false),
          child: Text(l10n.backupCancel),
        ),
        FilledButton(
          key: const Key('confirm-import'),
          onPressed: () => Navigator.pop(context, true),
          child: Text(l10n.backupEraseAndImport),
        ),
      ],
    );
  }
}
