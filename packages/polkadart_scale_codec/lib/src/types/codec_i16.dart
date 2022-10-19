part of '../core/core.dart';

/// [ScaleCodecType] class to encode `signed 16-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecI16 implements ScaleCodecType<int> {
  /// Returns an encoded hex-decimal `string` from `int` [value]
  /// using [HexEncoder] methods.
  ///
  /// Example:
  /// ```
  /// final encoded = CodecI16.encodeToHex(-32768) // "0x0080";
  /// ```
  @override
  String encodeToHex(value) {
    var sink = HexEncoder();
    sink.i16(value);
    return sink.toHex();
  }

  /// Returns an `int` value which the hex-decimal `string`
  /// [encodedData] represents, using [Source] methods.
  ///
  /// Example:
  /// ```
  /// final decoded = CodecI16.decodeFromHex("0x0080") // -32768;
  /// ```
  @override
  int decodeFromHex(String encodedData) {
    Source source = Source(encodedData);
    final result = source.i16();
    source.assertEOF();

    return result;
  }
}
