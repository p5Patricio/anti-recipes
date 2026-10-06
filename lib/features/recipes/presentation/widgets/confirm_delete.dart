import 'package:flutter/material.dart';

/// Asks for confirmation, then runs [delete] and reports the outcome.
///
/// Returns true only when the delete went through. [inUse] is checked first so
/// rows protected by a foreign key produce a friendly SnackBar instead of an
/// unhandled database error; any other failure is reported the same way.
Future<bool> confirmAndDelete(
  BuildContext context, {
  required String title,
  required String message,
  required String blockedMessage,
  required Future<bool> Function() inUse,
  required Future<void> Function() delete,
}) async {
  final messenger = ScaffoldMessenger.of(context);
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          key: const Key('confirm-delete'),
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Delete'),
        ),
      ],
    ),
  );
  if (confirmed != true) return false;
  try {
    if (await inUse()) {
      messenger.showSnackBar(SnackBar(content: Text(blockedMessage)));
      return false;
    }
    await delete();
    return true;
  } catch (_) {
    // A foreign key restriction can still trip between the check and delete.
    messenger.showSnackBar(SnackBar(content: Text(blockedMessage)));
    return false;
  }
}
