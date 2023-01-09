part of codec_types;

///
/// BoolCodec to encode/decode bool
class BoolCodec extends Codec<bool> {
  final Source? source;

  ///
  /// constructor
  BoolCodec({this.source}) : super(registry: Registry());

  ///
  /// Decode a bool from the source
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<bool>().createTypeCodec('Bool', data: Source('0x01'));
  /// final boolValue = codec.decode();
  /// print(boolValue); // true
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<bool>().createTypeCodec('Bool', data: Source('0x00'));
  /// final boolValue = codec.decode();
  /// print(boolValue); // false
  /// ```
  @override
  bool decode() {
    final bytes = (source ?? data).bytes(1).toList();

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
    encoder.write(value ? 1 : 0);
  }
}
