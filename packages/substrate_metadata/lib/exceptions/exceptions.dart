///
/// SpecFileException
class SpecFileException implements Exception {
  final String message;

  SpecFileException(this.message);

  @override
  String toString() => message;
}
