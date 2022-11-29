part of '../core/core.dart';

/// [ScaleCodecType] class to encode `unsigned 64-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// Example:
/// ```
/// final encoded = CodecU64.encode(16777215);
/// final decoded = CodecU64.decode("0xffffff00");
/// ```
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecU64 implements ScaleCodecType<BigInt> {
  @override
  String encodeToHex(value) {
    var sink = HexEncoder();
    sink.u64(value);
    return sink.toHex();
  }

  @override
  BigInt decodeFromHex(String encodedData) {
    Source source = Source(encodedData);
    return source.u64();
  }
}
