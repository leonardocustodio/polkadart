part of codec_types;

///
/// BoolCodec to encode/decode bool
class BoolCodec extends Codec<bool> {
  ///
  /// constructor
  BoolCodec(super.registry);

  ///
  /// Decode a bool from the source
  ///
  /// Example:
  /// ```dart
  /// final boolCodec = BoolCodec(data: Source('0x01'));
  /// final boolValue = boolCodec.decode();
  /// print(boolValue); // true
  /// ```
  @override
  bool decode() {
    final bytes = data.bytes(1).toList();

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
  /// final boolCodec = BoolCodec(data: Source('0x00'));
  /// final boolValue = boolCodec.encode(true);
  /// print(boolValue); // 01
  /// ```
  @override
  String encode(bool value) {
    return value ? '01' : '00';
  }
}
