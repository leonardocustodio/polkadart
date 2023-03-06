part of primitives;

/// Empty codec to encode/decode nothing
class NullCodec with Codec<dynamic> {
  const NullCodec._();

  static const NullCodec codec = NullCodec._();

  @override
  dynamic decode(Input input) {}

  @override
  void encodeTo(dynamic value, Output output) {}

  @override
  int sizeHint(dynamic value) => 0;
}
