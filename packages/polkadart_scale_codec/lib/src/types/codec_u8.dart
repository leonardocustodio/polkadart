part of '../core/core.dart';

/// [CodecType] class to encode `unsigned 8-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// Example:
/// ```
/// final encodedU8Int = CodecU8.encode(69);
/// final decodedU8Int = CodecU8.decode("0x45");
/// ```
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecU8 implements NewCodecType {
  @override
  String encodeToHex(value) {
    if (value is! int) {
      throw UnexpectedTypeException(
        expectedType: 'int',
        receivedType: value.runtimeType.toString(),
      );
    }

    var sink = HexEncoder();
    sink.u8(value);
    return sink.toHex();
  }

  @override
  int decodeFromHex(String encodedData) {
    Source source = Source(encodedData);
    return source.u8();
  }
}
