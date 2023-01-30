part of codec_types;

///
/// Vec to encode/decode vector of values
class Vec extends Codec<List> {
  ///
  /// constructor
  Vec._() : super(registry: Registry());

  ///
  /// Decodes the value from the Codec's input
  ///
  /// The input is expected to be a Compact<u32> followed by that many instances of the type T.
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec().fetchTypeCodec('Vec<u8>');
  /// final value = codec.decode(DefaultInput.fromHex('0x0401020304'));
  /// final vecValue = codec.decode();
  /// print(vecValue); // [1, 2, 3, 4]
  /// ```
  @override
  List decode(Input input) {
    if (subType == null) {
      throw SubtypeNotFoundException();
    }

    final vecLength = Compact.decodeFromInput(input);

    final result = [];
    for (var i = 0; i < vecLength; i++) {
      final value = subType!.decode(input);
      result.add(value);
    }

    return result;
  }

  ///
  /// Encodes a Vector of values.
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec().fetchTypeCodec('Vec<u8>');');
  /// final encoder = HexEncoder();
  /// codec.encode(encoder, [1, 2, 3, 4]);
  /// print(encoder.toHex()); // 0x0401020304
  /// ```
  @override
  void encode(Encoder encoder, List values) {
    if (subType == null) {
      throw SubtypeNotFoundException();
    }

    Compact.encodeToEncoder(encoder, values.length);

    for (var value in values) {
      subType!.encode(encoder, value);
    }
  }
}
