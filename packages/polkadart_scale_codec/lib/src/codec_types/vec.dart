part of codec_types;

///
/// Vec to encode/decode vector of values
class Vec<T extends Codec> extends Codec<List> {
  ///
  /// constructor
  Vec._() : super(registry: Registry());

  ///
  /// Decodes the value from the Codec's input
  ///
  @override
  List decode() {
    final vecLength = super.createTypeCodec('Compact<u32>').decode();

    final result = [];
    for (var i = 0; i < vecLength; i++) {
      result.add(createTypeCodec(subType).decode());
    }

    return result;
  }

  ///
  /// Encodes a Vector of values.
  @override
  void encode(Encoder encoder, List value) {}

  ///
  /// [static] Encodes a Vector of lists to the encoder.
  static void encodeToEncoder(Encoder encoder, List value) {}
}
