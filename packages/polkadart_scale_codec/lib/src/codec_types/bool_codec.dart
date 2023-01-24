part of codec_types;

///
/// BoolCodec to encode/decode bool
class BoolCodec extends Codec<bool> {
  ///
  /// constructor
  BoolCodec._() : super(registry: Registry());

  ///
  /// [static] Create a properties-copied instance of BoolCodec
  @override
  BoolCodec copyWith(Codec codec) {
    return copyProperties(codec, BoolCodec._()) as BoolCodec;
  }

  ///
  /// Decodes the value from the Codec's input
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<bool>().createTypeCodec('Bool');
  /// final boolValue = codec.decode(Input('0x01'));
  /// print(boolValue); // true
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<bool>().createTypeCodec('Bool');
  /// final boolValue = codec.decode(Input('0x00'));
  /// print(boolValue); // false
  /// ```
  @override
  bool decode(Input input) {
    return decodeFromInput(input);
  }

  ///
  /// Decode a bool from the input
  /// Example:
  /// ```dart
  /// final boolValue = BoolCodec.decodeFromInput(Input('0x01'));
  /// print(boolValue); // true
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final boolValue = BoolCodec.decodeFromInput(Input('0x00'));
  /// print(boolValue); // false
  /// ```
  static bool decodeFromInput(Input input) {
    final bytes = input.bytes(1).toList();

    if (bytes[0] == 1) {
      return true;
    } else if (bytes[0] == 0) {
      return false;
    }

    throw UnexpectedCaseException(
        'Expected 0 or 1 but found byte: ${bytes[0]}');
  }

  ///
  /// Encodes a bool
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<bool>().createTypeCodec('Bool');
  /// final encoder = HexEncoder();
  /// codec.encode(encoder, true);
  /// print(encoder.toHex()); // 0x01
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<bool>().createTypeCodec('Bool');
  /// final encoder = HexEncoder();
  /// codec.encode(encoder, false);
  /// print(encoder.toHex()); // 0x00
  /// ```
  @override
  void encode(Encoder encoder, bool value) {
    encodeToEncoder(encoder, value);
  }

  ///
  /// [static] Encodes a bool
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// BoolCodec.encodeToEncoder(encoder, true);
  /// print(encoder.toHex()); // 0x01
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// BoolCodec.encodeToEncoder(encoder, false);
  /// print(encoder.toHex()); // 0x00
  /// ```
  static void encodeToEncoder(Encoder encoder, bool value) {
    encoder.write(value ? 1 : 0);
  }
}
