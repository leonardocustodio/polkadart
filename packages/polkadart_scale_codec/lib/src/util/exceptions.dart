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

/// UnexpectedTypeException
class UnexpectedTypeException implements Exception {
  const UnexpectedTypeException([this.msg]);

  // Unexpected type
  final dynamic msg;

  @override
  String toString() => msg ?? 'Unexpected type.';
}

class UnprocessedDataLeftException implements Exception {
  const UnprocessedDataLeftException();

  @override
  String toString() => 'Unprocessed data left';
}
