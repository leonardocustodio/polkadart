part of codec_types;

///
/// H256 to encode/decode H256
class H256 extends Codec<Uint8List> {
  ///
  /// conH256or
  H256._() : super(registry: Registry());

  ///
  /// Decodes the value from the Codec's input
  @override
  Uint8List decode(Input input) {
    return input.bytes(32);
  }

  ///
  /// Encodes H256 of value
  @override
  void encode(Encoder encoder, Uint8List value) {
    encoder.writeBytes(value.toList());
  }
}
