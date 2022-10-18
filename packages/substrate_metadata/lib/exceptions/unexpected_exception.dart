part of exceptions;

/// UnexpectedTypeException
class UnexpectedTypeException implements Exception {
  const UnexpectedTypeException(this.message);

  // Unexpected type
  final String message;

  @override
  String toString() {
    return message;
  }
}

/// UnexpectedKindException
class UnexpectedKindException implements Exception {
  const UnexpectedKindException(this.message);

  // Unexpected type
  final String message;

  @override
  String toString() {
    return message;
  }
}

/// UnexpectedCaseException
class UnexpectedCaseException implements Exception {
  const UnexpectedCaseException(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}
