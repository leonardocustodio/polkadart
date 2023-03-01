part of primitives;

/// Empty codec to encode/decode nothing
class NullCodec with Codec<void> {
  const NullCodec._();

  static const NullCodec instance = NullCodec._();

  @override
  void decode(Input input) {}

  @override
  void encodeTo(void value, Output output) {}

  @override
  int sizeHint(void value) => 0;
}
