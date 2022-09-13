import 'package:analyzer/dart/element/type.dart';

/// Error thrown when code generation fails due to [type] being unsupported for
/// [reason].
class UnsupportedTypeError extends Error {
  final DartType type;
  final String? reason;

  /// Not currently accesses. Will likely be removed in a future release.
  final String expression;

  UnsupportedTypeError(this.type, this.expression, [this.reason]);
}
