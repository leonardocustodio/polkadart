part of exceptions;

class AssertionException implements Exception {
  const AssertionException(this.message);

  final dynamic message;

  @override
  String toString() {
    return message;
  }
}
