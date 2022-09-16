import 'package:analyzer/dart/element/type.dart';

/// Error thrown when code generation fails due to [type] being unsupported for
/// [reason].
class UnsupportedTypeError extends Error {
  final DartType type;
  final String? reason;

  UnsupportedTypeError(this.type, [this.reason]);
}
