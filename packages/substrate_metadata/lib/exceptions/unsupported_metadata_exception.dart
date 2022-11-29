part of exceptions;

class UnsupportedMetadataException implements Exception {
  const UnsupportedMetadataException(this.message);

  final String message;

  @override
  String toString() => message;
}
