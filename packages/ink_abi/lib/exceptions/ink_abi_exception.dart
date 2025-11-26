/// Base exception for all ink! ABI-related errors
///
/// This is the parent exception class for all ink! ABI operations.
/// Specific error types extend this class to provide detailed error information.
class InkAbiException implements Exception {
  /// Human-readable error message
  final String message;

  /// Optional additional context about the error
  final Map<String, dynamic>? context;

  const InkAbiException(this.message, {this.context});

  @override
  String toString() {
    if (context != null && context!.isNotEmpty) {
      return 'InkAbiException: $message (context: $context)';
    }
    return 'InkAbiException: $message';
  }
}
