part of core;

///
/// An interface for the codec
mixin CodecInterface<T> {
  ///
  /// decodes the value form the source
  T decode();

  ///
  /// encodes the passed parameter and returns the encoded value
  String encode(T value);
}
