part of codec_types;

///
/// Str to encode/decode String
class Str extends Codec<String> {
  ///
  /// constructor
  Str._() : super(registry: Registry());

  ///
  /// [static] Create a properties-copied instance of Str
  @override
  Str copyWith(Codec codec) {
    return copyProperties(codec, Str._()) as Str;
  }

  ///
  /// Decodes the value from the Codec's input
  ///
  /// Example:
  /// ```dart
  /// final stringValue = Str.decodeFromInput(Input('0x1054657374'));
  /// print(stringValue); // Test
  /// ```
  @override
  String decode(Input input) {
    return decodeFromInput(input);
  }

  ///
  /// Decode a string from the input
  ///
  /// Example:
  /// ```dart
  /// final stringValue = Str.decodeFromInput(Input('0x1054657374'));
  /// print(stringValue); // Test
  /// ```
  static String decodeFromInput(Input input) {
    final compactLength = Compact.decodeFromInput(input);
    final bytes = input.bytes(compactLength).toList();
    return utf8.decode(bytes);
  }

  ///
  /// Encodes a String
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// Str.encodeToEncoder(encoder, 'Test');
  /// print(encoder.toHex()); // 0x1054657374
  /// ```
  @override
  void encode(Encoder encoder, String value) {
    encodeToEncoder(encoder, value);
  }

  ///
  /// [static] Encodes a String
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// Str.encodeToEncoder(encoder, 'Test');
  /// print(encoder.toHex()); // 0x1054657374
  /// ```
  static void encodeToEncoder(Encoder encoder, String value) {
    final bytes = utf8.encode(value);
    Compact.encodeToEncoder(encoder, bytes.length);
    encoder.writeBytes(bytes);
  }
}
