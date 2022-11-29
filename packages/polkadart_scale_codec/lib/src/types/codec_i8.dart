part of '../core/core.dart';

/// [ScaleCodecType] class to encode `signed 8-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecI8 implements ScaleCodecType<int> {
  /// Returns an encoded hex-decimal `string` from `int` [value]
  /// using [HexEncoder] methods.
  ///
  /// Example:
  /// ```
  /// final encoded = CodecI8.encodeToHex(69); //"0x45"
  /// ```
  @override
  String encodeToHex(value) {
    var sink = HexEncoder();
    sink.i8(value);
    return sink.toHex();
  }

  /// Returns an `int` value which the hex-decimal `string`
  /// [encodedData] reprents, using [Source] methods.
  ///
  /// Example:
  /// ```
  /// final decoded = CodecI8.decodeFromHex("0x45"); //69
  /// ```
  @override
  int decodeFromHex(String encodedData) {
    Source source = Source(encodedData);
    final result = source.i8();
    source.assertEOF();

    return result;
  }
}
