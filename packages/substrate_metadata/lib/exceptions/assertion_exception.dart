part of exceptions;

class AssertionException implements Exception {
  const AssertionException(this.msg);

  final dynamic msg;

  @override
  String toString() {
    return msg;
  }
}
