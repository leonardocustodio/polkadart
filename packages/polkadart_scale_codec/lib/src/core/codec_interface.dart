part of core;

///
/// An interface for the codec
mixin CodecInterface<T> {
  ///
  /// decodes the value
  T decode(Input input);

  ///
  /// encodes the passed parameter and returns the encoded value
  void encode(Encoder encoder, T value);
}
