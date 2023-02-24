///
/// SpecFileException
class SpecFileException implements Exception {
  final String message;

  SpecFileException(this.message);

  @override
  String toString() => message;
}

///
/// UnexpectedTypeException
class UnexpectedTypeException implements Exception {
  final String message;

  UnexpectedTypeException(this.message);

  @override
  String toString() => message;
}

///
/// UnsupportedMetadataException
class UnsupportedMetadataException implements Exception {
  final String message;

  UnsupportedMetadataException(this.message);

  @override
  String toString() => message;
}
