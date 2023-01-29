part of codec_types;

///
/// H256 to encode/decode H256
class H256 extends Codec<Uint8List> {
  ///
  /// conH256or
  H256._() : super(registry: Registry());

  ///
  /// [static] returns a new instance of H256
  @override
  H256 freshInstance() => H256._();

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
