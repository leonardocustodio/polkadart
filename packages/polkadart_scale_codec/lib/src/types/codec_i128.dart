part of '../core/core.dart';

/// [ScaleCodecType] class to encode `signed 128-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecI128 implements ScaleCodecType<BigInt> {
  /// Returns an encoded hex-decimal `string` from `BigInt` [value]
  /// using [HexEncoder] methods.
  ///
  /// Example:
  /// ```
  /// final encoded = CodecI128.encodeToHex(16777215.toBigInt); // "0xffffff00000000000000000000000000"
  /// ```
  @override
  String encodeToHex(BigInt value) {
    var sink = HexEncoder();
    sink.i128(value);
    return sink.toHex();
  }

  /// Returns an `BigInt` value which the hex-decimal `string`
  /// [encodedData] represents, using [Source] methods.
  ///
  /// Example:
  /// ```
  /// final decoded = CodecI128.decodeFromHex("0xffffff00000000000000000000000000"); // 16777215
  /// ```
  @override
  BigInt decodeFromHex(String encodedData) {
    Source source = Source(encodedData);
    final result = source.i128();
    source.assertEOF();

    return result;
  }
}
