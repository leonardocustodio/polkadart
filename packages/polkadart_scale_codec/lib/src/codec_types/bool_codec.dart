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
  /// final boolValue = codec.encode(true);
  /// print(boolValue); // 01
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<bool>().createTypeCodec('Bool');
  /// final boolValue = codec.encode(false);
  /// print(boolValue); // 00
  /// ```
  @override
  String encode(bool value) {
    return value ? '01' : '00';
  }
}
