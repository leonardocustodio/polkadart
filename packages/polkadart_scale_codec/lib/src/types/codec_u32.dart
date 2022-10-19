part of '../core/core.dart';

/// [ScaleCodecType] class to encode `unsigned 32-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// Example:
/// ```
/// final encoded = CodecU32.encode(16777215);
/// final decoded = CodecU32.decode("0xffffff00");
/// ```
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecU32 implements ScaleCodecType<int> {
  @override
  String encodeToHex(value) {
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
