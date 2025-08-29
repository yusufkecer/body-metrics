abstract class AppException implements Exception {
  const AppException(this.message, {this.code, this.stackTrace});
  final String message;
  final String? code;
  final StackTrace? stackTrace;

  @override
  String toString() => 'AppException: $message${code != null ? ' (code: $code)' : ''}';
}
