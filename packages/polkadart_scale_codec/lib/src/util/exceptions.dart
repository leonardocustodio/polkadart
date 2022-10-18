part of utils;

/// UnexpectedCaseException
class UnexpectedCaseException implements Exception {
  const UnexpectedCaseException([this.msg]);

  final String? msg;

  @override
  String toString() => msg ?? 'Unexpected Case.';
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
  const AssertionException([this.msg]);

  final String? msg;
  @override
  String toString() => msg ?? 'Assertion Exception';
}

///
/// AssertionException
class InvalidOptionByteException implements Exception {
  const InvalidOptionByteException(this.msg);

  final String msg;
  @override
  String toString() => msg;
}

/// InvalidSizeException
class InvalidSizeException implements Exception {
  const InvalidSizeException([this.msg]);

  // Custom exception message
  final String? msg;

  @override
  String toString() => msg ?? 'Invalid size.';
}

/// IncompatibleCompactException
class IncompatibleCompactException implements Exception {
  const IncompatibleCompactException(this.msg);

  // Custom exception message
  final String msg;

  @override
  String toString() => msg;
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
