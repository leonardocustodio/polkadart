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

class UnexpectedTypeException implements Exception {
  const UnexpectedTypeException([this.type]);

  // Unexpected type
  final dynamic type;

  @override
  String toString() {
    return 'Unexpected type${type == null ? '' : ': ${type.runtimeType}'}.';
  }
}
