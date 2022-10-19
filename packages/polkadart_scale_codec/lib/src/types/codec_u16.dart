part of '../core/core.dart';

/// [ScaleCodecType] class to encode `unsigned 16-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// Example:
/// ```
/// final encoded = CodecU16.encode(42);
/// final decoded = CodecU16.decode("0x2a00");
/// ```
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecU16 implements ScaleCodecType<int> {
  @override
  String encodeToHex(value) {
    var sink = HexEncoder();
    sink.u16(value);
    return sink.toHex();
  }

  @override
  int decodeFromHex(String encodedData) {
    Source source = Source(encodedData);
    return source.u16();
  }
}
