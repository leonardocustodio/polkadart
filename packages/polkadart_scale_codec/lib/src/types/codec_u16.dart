part of '../core/core.dart';

/// [ScaleCodecType] class to encode `unsigned 16-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecU16 implements ScaleCodecType<int> {
  /// Returns an encoded hex-decimal `string` from `int` [value]
  /// using [HexEncoder] methods.
  ///
  /// Example:
  /// ```
  /// final encoded = CodecU16().encodeToHex(42) // "0x2a00";
  /// ```
  @override
  String encodeToHex(value) {
    var sink = HexEncoder();
    sink.u16(value);
    return sink.toHex();
  }

  /// Returns an `int` value which the hex-decimal `string`
  /// [encodedData] represents, using [Source] methods.
  ///
  /// Example:
  /// ```
  /// final decoded = CodecU16().decodeFromHex("0x2a00") // 42;
  /// ```
  @override
  int decodeFromHex(String encodedData) {
    Source source = Source(encodedData);
    final result = source.u16();
    source.assertEOF();

    return result;
  }
}
