part of '../core/core.dart';

/// [ScaleCodecType] class to encode `signed 128-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// Example:
/// ```
/// final encoded = CodecI128.encode(16777215);
/// final decoded = CodecI128.decode("0xffffff00000000000000000000000000");
/// ```
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecI128 implements ScaleCodecType<BigInt> {
  @override
  String encodeToHex(BigInt value) {
    var sink = HexEncoder();
    sink.i128(value);
    return sink.toHex();
  }

  @override
  BigInt decodeFromHex(String encodedData) {
    Source source = Source(encodedData);
    final result = source.i128();
    source.assertEOF();

    return result;
  }
}
