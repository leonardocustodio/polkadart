part of primitives;

/// Empty codec to encode/decode nothing
class NullCodec with Codec {
  const NullCodec._();

  static const NullCodec instance = NullCodec._();

  @override
  void decode(Input input) {}

  @override
  void encodeTo(dynamic value, Output output) {}
}
