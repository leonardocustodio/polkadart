part of exceptions;

class SpecFileException implements Exception {
  const SpecFileException(this.message);

  final String message;

  @override
  String toString() {
    return message;
  }
}
