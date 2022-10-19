part of '../core/core.dart';

/// [ScaleCodecType] class to encode `unsigned 256-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecU256 implements ScaleCodecType<BigInt> {
  /// Returns an encoded hex-decimal `string` from `BigInt` [value]
  /// using [HexEncoder] methods.
  ///
  /// Example:
  /// ```
  /// final encoded = CodecU256.encodeToHex(16777215.toBigInt);
  /// // "0xffffff0000000000000000000000000000000000000000000000000000000000"
  /// ```
  @override
  String encodeToHex(value) {
    var sink = HexEncoder();
    sink.u256(value);
    return sink.toHex();
  }

  /// Returns an `BigInt` value which the hex-decimal `string`
  /// [encodedData] represents, using [Source] methods.
  ///
  /// Example:
  /// ```
  /// final decoded = CodecU256.decodeFromHex("0xffffff0000000000000000000000000000000000000000000000000000000000");
  /// // 16777215
  /// ```
  @override
  BigInt decodeFromHex(String encodedData) {
    Source source = Source(encodedData);
    return source.u256();
  }
}
