part of '../core/core.dart';

/// [ScaleCodecType] class to encode `signed 32-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// Example:
/// ```
/// final encoded = CodecI32.encode(-32768);
/// final decoded = CodecI32.decode("0x0080");
/// ```
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecI32 implements ScaleCodecType<int> {
  @override
  String encodeToHex(value) {
    var sink = HexEncoder();
    sink.i32(value);
    return sink.toHex();
  }

  @override
  int decodeFromHex(String encodedData) {
    Source source = Source(encodedData);
    final result = source.i32();
    source.assertEOF();

    return result;
  }
}
