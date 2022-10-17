part of '../core/core.dart';

/// [ScaleCodecType] class to encode `signed 256-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// Example:
/// ```
/// final encoded = CodecI256.encode(16777215);
/// final decoded = CodecI256.decode("0xffffff0000000000000000000000000000000000000000000000000000000000");
/// ```
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecI256 implements ScaleCodecType<BigInt> {
  @override
  String encodeToHex(BigInt value) {
    var sink = HexEncoder();
    sink.i256(value);
    return sink.toHex();
  }

  @override
  BigInt decodeFromHex(String encodedData) {
    Source source = Source(encodedData);
    final result = source.i256();
    source.assertEOF();

    return result;
  }
}
