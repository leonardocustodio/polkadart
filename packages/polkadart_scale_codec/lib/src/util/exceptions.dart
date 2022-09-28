part of utils;

///
/// UnexpectedCaseException
class UnexpectedCaseException implements Exception {
  const UnexpectedCaseException([this.value]);

  final dynamic value;

  @override
  String toString() {
    return 'Unexpected case${value == null ? '' : ': $value'}.';
  }
}

///
/// EOFException
class EOFException implements Exception {
  const EOFException();

  @override
  String toString() {
    return 'Unexpected EOF.';
  }
}

///
/// AssertionException
class AssertionException implements Exception {
  const AssertionException([this.msg]);

  final String? msg;
  @override
  String toString() {
    return msg ?? 'Assertion Exception';
  }
}

///
/// InvalidSizeException
class InvalidSizeException implements Exception {
  const InvalidSizeException([this.msg]);

  // Custom exception message
  final String? msg;

  @override
  String toString() {
    return msg ?? 'Invalid size.';
  }
}

///
/// IncompatibleCompactException
class IncompatibleCompactException implements Exception {
  const IncompatibleCompactException(this.size);

  // Custom exception message
  final String size;

  @override
  String toString() {
    return '$size is too large for a compact';
  }
}

///
/// InvalidCompactException
class InvalidCompactException implements Exception {
  const InvalidCompactException([this.msg]);

  // Custom exception message
  final String? msg;

  @override
  String toString() {
    return msg ?? 'Invalid compact.';
  }
}

class UnexpectedTypeException implements Exception {
  const UnexpectedTypeException([this.msg]);

  // Unexpected type
  final dynamic msg;

  @override
  String toString() {
    return msg ?? 'Unexpected type.';
  }
}
