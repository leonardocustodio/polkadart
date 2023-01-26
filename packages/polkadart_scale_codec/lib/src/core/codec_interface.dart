part of core;

///
/// An interface for the codec
abstract class CodecInterface<T> {
  ///
  /// decodes the value
  T decode(Input input);

  ///
  /// encodes the passed parameter and returns the encoded value
  void encode(Encoder encoder, T value);

  ///
  /// returns the fresh instance of the codec
  CodecInterface<T> freshInstance();
}
