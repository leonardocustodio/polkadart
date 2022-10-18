part of exceptions;

/// UnexpectedTypeException
class UnexpectedTypeException implements Exception {
  const UnexpectedTypeException(this.msg);

  // Unexpected type
  final String msg;

  @override
  String toString() {
    return msg;
  }
}

/// UnexpectedKindException
class UnexpectedKindException implements Exception {
  const UnexpectedKindException(this.msg);

  // Unexpected type
  final String msg;

  @override
  String toString() {
    return msg;
  }
}

/// UnexpectedCaseException
class UnexpectedCaseException implements Exception {
  const UnexpectedCaseException(this.msg);

  final String msg;

  @override
  String toString() {
    return msg;
  }
}
