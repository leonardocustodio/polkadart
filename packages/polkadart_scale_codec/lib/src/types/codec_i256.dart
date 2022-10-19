part of '../core/core.dart';

/// [ScaleCodecType] class to encode `signed 256-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecI256 implements ScaleCodecType<BigInt> {
  /// Returns an encoded hex-decimal `string` from `BigInt` [value]
  /// using [HexEncoder] methods.
  ///
  /// Example:
  /// ```
  /// final encoded = CodecI256.encodeToHex(16777215.toBigInt);
  /// // "0xffffff0000000000000000000000000000000000000000000000000000000000"
  /// ```
  @override
  String encodeToHex(BigInt value) {
    var sink = HexEncoder();
    sink.i256(value);
    return sink.toHex();
  }

  /// Returns an `BigInt` value which the hex-decimal `string`
  /// [encodedData] represents, using [Source] methods.
  ///
  /// Example:
  /// ```
  /// final decoded = CodecI256.decodeFromHex("0xffffff0000000000000000000000000000000000000000000000000000000000");
  /// // 16777215
  /// ```
  @override
  BigInt decodeFromHex(String encodedData) {
    Source source = Source(encodedData);
    final result = source.i256();
    source.assertEOF();

    return result;
  }
}
