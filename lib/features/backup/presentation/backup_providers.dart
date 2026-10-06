import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/database_provider.dart';
import '../data/backup_service.dart';
import '../data/file_picker_backup_file_gateway.dart';
import '../domain/backup_file_gateway.dart';

final backupFileGatewayProvider = Provider<BackupFileGateway>(
  (ref) => const FilePickerBackupFileGateway(),
);

final backupServiceProvider = Provider<BackupService>(
  (ref) => BackupService(ref.watch(appDatabaseProvider)),
);
