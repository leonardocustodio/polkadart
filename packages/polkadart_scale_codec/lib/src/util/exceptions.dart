part of utils;

class UnknownVariantException implements Exception {
  const UnknownVariantException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// UnexpectedCaseException
class UnexpectedCaseException implements Exception {
  const UnexpectedCaseException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Unexpected Case.';
}

/// EOFException
class EOFException implements Exception {
  const EOFException();

  @override
  String toString() => 'Unexpected end of file/source exception.';
}

///
/// AssertionException
class AssertionException implements Exception {
  const AssertionException([this.message]);

  final String? message;
  @override
  String toString() => message ?? 'Assertion Exception';
}

///
/// AssertionException
class InvalidOptionByteException implements Exception {
  const InvalidOptionByteException(this.message);

  final String message;
  @override
  String toString() => message;
}

/// InvalidSizeException
class InvalidSizeException implements Exception {
  const InvalidSizeException([this.message]);

  // Custom exception message
  final String? message;

  @override
  String toString() => message ?? 'Invalid size.';
}

/// IncompatibleCompactException
class IncompatibleCompactException implements Exception {
  const IncompatibleCompactException(this.message);

  // Custom exception message
  final String message;

  @override
  String toString() => message;
}

/// Exception thrown when [receivedType] is different than
/// [expectedType].
///
/// Example:
/// ```
/// String encodeIntToHex (dynamic value) {
///   if (value is! int) {
///     throw UnexpectedTypeException(
///             expectedType: 'int',
///             receivedType: value.runtimeType.toString(),
///           );
///   }
/// }
/// ```
class UnexpectedTypeException implements Exception {
  const UnexpectedTypeException(
      {required this.expectedType, required this.receivedType});

  final String expectedType;
  final String receivedType;

  @override
  String toString() => 'Expecting `$expectedType`, but found `$receivedType`';
}
