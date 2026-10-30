/// Everything the backup feature needs from the platform's file system.
///
/// Kept behind an interface so domain and widget tests never touch a plugin.
abstract interface class BackupFileGateway {
  /// Lets the user choose where to store [contents] as [fileName].
  ///
  /// Returns a human-readable location, or null when the user cancelled.
  Future<String?> saveBackup({
    required String fileName,
    required String contents,
  });

  /// Lets the user choose a backup file and returns its text, or null when
  /// the user cancelled. Throws a `BackupException` when it cannot be read.
  Future<String?> pickBackup();
}
