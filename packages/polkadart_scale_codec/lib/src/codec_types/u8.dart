part of codec_types;

///
/// U8 to encode/decode unsigned 8 bit integer
class U8 extends Codec<int> {
  final Source? source;

  ///
  /// constructor
  U8({this.source}) : super(registry: Registry());

  ///
  /// Decode a unsigned 8 bit integer from the source
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('U8', data: Source('0x00'));
  /// final value = codec.decode();
  /// print(value); // 0
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('U8', data: Source('0xff'));
  /// final value = codec.decode();
  /// print(value); // 255
  /// ```
  @override
  int decode() {
    return bytesToLittleEndianInt((source ?? data).bytes(1).toList());
  }

  ///
  /// Encodes a unsigned 8 bit integer
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('U8');
  /// final encoder = HexEncoder();
  /// codec.encode(encoder, 0);
  /// print(encoder.toHex()); // 0x00
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('U8');
  /// final encoder = HexEncoder();
  /// codec.encode(encoder, 255);
  /// print(encoder.toHex()); // 0xff
  /// ```
  @override
  void encode(Encoder encoder, int value) {
    if (value < 0 || value > 255) {
      throw UnexpectedCaseException(
          'Expected value between 0 and 255, but found: $value');
    }
    encoder.write(value);
  }
}
