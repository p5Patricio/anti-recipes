import 'dart:convert';

import 'package:file_picker/file_picker.dart';

import '../domain/backup_exception.dart';
import '../domain/backup_file_gateway.dart';

/// [BackupFileGateway] backed by the system pickers (Storage Access
/// Framework on Android, so no storage permission is needed).
class FilePickerBackupFileGateway implements BackupFileGateway {
  const FilePickerBackupFileGateway();

  @override
  Future<String?> saveBackup({
    required String fileName,
    required String contents,
  }) async {
    final uri = await FilePicker.saveFile(
      dialogTitle: 'Save backup',
      fileName: fileName,
      bytes: utf8.encode(contents),
      mimeType: 'application/json',
    );
    return uri == null ? null : (uri.pathSegments.lastOrNull ?? fileName);
  }

  @override
  Future<String?> pickBackup() async {
    final file = await FilePicker.pickFile(dialogTitle: 'Choose a backup');
    if (file == null) return null;
    try {
      return utf8.decode(await file.readAsBytes());
    } on FormatException catch (e) {
      throw BackupException('This file is not a text file.', cause: e);
    } catch (e) {
      throw BackupException('The file could not be read.', cause: e);
    }
  }
}
