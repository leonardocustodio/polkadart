part of '../core/core.dart';

/// [ScaleCodecType] class to encode `unsigned 64-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecU64 implements ScaleCodecType<BigInt> {
  /// Returns an encoded hex-decimal `string` from `BigInt` [value]
  /// using [HexEncoder] methods.
  ///
  /// Example:
  /// ```
  /// final encoded = CodecU64.encodeToHex(9223372036854775807.toBigInt); // "0xffffffffffffff7f"
  /// ```
  @override
  String encodeToHex(value) {
    var sink = HexEncoder();
    sink.u64(value);
    return sink.toHex();
  }

  /// Returns an `BigInt` value which the hex-decimal `string`
  /// [encodedData] represents, using [Source] methods.
  ///
  /// Example:
  /// ```
  /// final decoded = CodecU64.decodeFromHex("0xffffffffffffff7f"); // 9223372036854775807
  /// ```
  @override
  BigInt decodeFromHex(String encodedData) {
    Source source = Source(encodedData);
    final result = source.u64();
    source.assertEOF();

    return result;
  }
}
