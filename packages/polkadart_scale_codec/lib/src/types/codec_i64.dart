part of '../core/core.dart';

/// [ScaleCodecType] class to encode `signed 64-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// Example:
/// ```
/// final encoded = CodecI64.encode(-9223372036854775808);
/// final decoded = CodecI64.decode("0x0000000000000080");
/// ```
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecI64 implements ScaleCodecType<BigInt> {
  @override
  String encodeToHex(BigInt value) {
    var sink = HexEncoder();
    sink.i64(value);
    return sink.toHex();
  }

  @override
  BigInt decodeFromHex(String encodedData) {
    Source source = Source(encodedData);
    final result = source.i64();
    source.assertEOF();

    return result;
  }
}
