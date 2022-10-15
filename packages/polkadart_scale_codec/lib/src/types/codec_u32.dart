part of '../core/core.dart';

/// [CodecType] class to encode `unsigned 32-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// Example:
/// ```
/// final encodedU32Int = CodecU32.encode(16777215);
/// final decodedU32Int = CodecU32.decode("0xffffff00");
/// ```
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecU32 implements NewCodecType {
  @override
  String encodeToHex(value) {
    if (value is! int) {
      throw UnexpectedTypeException(
        expectedType: 'int',
        receivedType: value.runtimeType.toString(),
      );
    }

    var sink = HexEncoder();
    sink.u32(value);
    return sink.toHex();
  }

  @override
  int decodeFromHex(String encodedData) {
    Source source = Source(encodedData);
    return source.u32();
  }
}
