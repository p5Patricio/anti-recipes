/// A backup could not be created, read or restored.
///
/// [message] is written for the user and is safe to show as-is.
class BackupException implements Exception {
  const BackupException(this.message, {this.cause});

  final String message;

  /// The underlying error, kept for diagnostics only.
  final Object? cause;

  @override
  String toString() => 'BackupException: $message';
}
