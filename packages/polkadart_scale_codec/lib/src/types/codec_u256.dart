part of '../core/core.dart';

/// [ScaleCodecType] class to encode `unsigned 256-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// Example:
/// ```
/// final encoded = CodecU264.encode(16777215);
/// final decoded = CodecU264.decode("0xffffff0000000000000000000000000000000000000000000000000000000000");
/// ```
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecU256 implements ScaleCodecType<BigInt> {
  @override
  String encodeToHex(value) {
    var sink = HexEncoder();
    sink.u256(value);
    return sink.toHex();
  }

  @override
  BigInt decodeFromHex(String encodedData) {
    Source source = Source(encodedData);
    return source.u256();
  }
}
