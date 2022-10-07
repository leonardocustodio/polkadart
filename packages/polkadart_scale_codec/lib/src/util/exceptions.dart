part of utils;

/// InvalidAddressException
class InvalidAddressException implements Exception {
  const InvalidAddressException(this.msg);

  final String msg;

  @override
  String toString() => msg;
}

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
  const IncompatibleCompactException(this.size);

  // Custom exception message
  final String size;

  @override
  String toString() => '$size is too large for a compact.';
}

/// InvalidCompactException
class InvalidCompactException implements Exception {
  const InvalidCompactException([this.msg]);

  // Custom exception message
  final String? msg;

  @override
  String toString() => msg ?? 'Invalid compact.';
}

/// UnexpectedTypeException
class UnexpectedTypeException implements Exception {
  const UnexpectedTypeException([this.msg]);

  // Unexpected type
  final dynamic msg;

  @override
  String toString() => msg ?? 'Unexpected type.';
}
