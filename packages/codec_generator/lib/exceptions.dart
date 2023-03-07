///
/// UnknownPrimitiveException is thrown when a primitive is not recognized.
class UnknownPrimitiveException implements Exception {
  final String primitive;

  const UnknownPrimitiveException(this.primitive);

  @override
  String toString() => 'Unknown Primitive Exception: $primitive';
}
