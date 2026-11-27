import 'dart:convert';

import 'package:file_picker/file_picker.dart';

import '../domain/backup_exception.dart';
import '../domain/backup_file_gateway.dart';

/// [BackupFileGateway] backed by the system pickers (Storage Access
/// Framework on Android, so no storage permission is needed).
class FilePickerBackupFileGateway implements BackupFileGateway {
  /// The dialog titles come from the caller because they are user-facing and
  /// must follow the app language; this class stays free of localization.
  const FilePickerBackupFileGateway({
    required this.saveDialogTitle,
    required this.pickDialogTitle,
  });

  final String saveDialogTitle;
  final String pickDialogTitle;

  @override
  Future<String?> saveBackup({
    required String fileName,
    required String contents,
  }) async {
    final uri = await FilePicker.saveFile(
      dialogTitle: saveDialogTitle,
      fileName: fileName,
      bytes: utf8.encode(contents),
      mimeType: 'application/json',
    );
    return uri == null ? null : (uri.pathSegments.lastOrNull ?? fileName);
  }

  @override
  Future<String?> pickBackup() async {
    final file = await FilePicker.pickFile(dialogTitle: pickDialogTitle);
    if (file == null) return null;
    try {
      return utf8.decode(await file.readAsBytes());
    } on FormatException catch (e) {
      throw BackupException(BackupFailure.notTextFile, cause: e);
    } catch (e) {
      throw BackupException(BackupFailure.unreadable, cause: e);
    }
  }
}
