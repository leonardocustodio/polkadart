part of codec_types;

///
/// Vec to encode/decode vector of values
class Vec extends Codec<List> {
  ///
  /// constructor
  Vec._() : super(registry: Registry());

  ///
  /// [static] Create a properties-copied instance of Vec
  @override
  Vec copyWith(Codec codec) {
    return copyProperties(codec, Vec._()) as Vec;
  }

  ///
  /// Decodes the value from the Codec's input
  ///
  /// The input is expected to be a Compact<u32> followed by that many instances of the type T.
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec().fetchTypeCodec('Vec<u8>');
  /// final value = codec.decode(Input('0x0401020304'));
  /// final vecValue = codec.decode();
  /// print(vecValue); // [1, 2, 3, 4]
  /// ```
  @override
  List decode(Input input) {
    if (subType.trim().isEmpty) {
      throw SubtypeNotFoundException();
    }

    final vecLength = Compact.decodeFromInput(input);

    final result = [];
    final codec = fetchTypeCodec(subType);
    for (var i = 0; i < vecLength; i++) {
      final value = codec.decode(input);
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
    if (subType.trim().isEmpty) {
      throw SubtypeNotFoundException();
    }

    Compact.encodeToEncoder(encoder, values.length);

    final codec = fetchTypeCodec(subType);
    for (var value in values) {
      codec.encode(encoder, value);
    }
  }
}
