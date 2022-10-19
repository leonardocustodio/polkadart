part of '../core/core.dart';

/// [ScaleCodecType] class to encode `unsigned 8-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecU8 implements ScaleCodecType<int> {
  /// Returns an encoded hex-decimal `string` from `int` [value]
  /// using [HexEncoder] methods.
  ///
  /// Example:
  /// ```
  /// final encoded = CodecU8.encodeToHex(69); //"0x45"
  /// ```
  @override
  String encodeToHex(value) {
    var sink = HexEncoder();
    sink.u8(value);
    return sink.toHex();
  }

  /// Returns an `int` value which represents
  /// the [encodedData] hex-decimal `string`
  /// using [Source] methods.
  ///
  /// Example:
  /// ```
  /// final decoded = CodecU8.decodeFromHex("0x45"); //69
  /// ```
  @override
  int decodeFromHex(String encodedData) {
    Source source = Source(encodedData);
    final result = source.u8();
    source.assertEOF();

    return result;
  }
}
