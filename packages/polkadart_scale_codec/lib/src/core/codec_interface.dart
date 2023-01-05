part of core;

///
/// An interface for the codec
mixin CodecInterface<T> {
  ///
  /// decodes the value form the source
  dynamic decode();

  ///
  /// encodes the passed parameter and returns the encoded value
  dynamic encode(T value);
}
