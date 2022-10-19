part of '../core/core.dart';

/// [ScaleCodecType] class to encode `signed 32-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecI32 implements ScaleCodecType<int> {
  /// Returns an encoded hex-decimal `string` from `int` [value]
  /// using [HexEncoder] methods.
  ///
  /// Example:
  /// ```
  /// final encoded = CodecI32.encode(16777215); // "0xffffff00"
  /// ```
  @override
  String encodeToHex(value) {
    var sink = HexEncoder();
    sink.i32(value);
    return sink.toHex();
  }

  /// Returns an `int` value which the hex-decimal `string`
  /// [encodedData] represents, using [Source] methods.
  ///
  /// Example:
  /// ```
  /// final decoded = CodecI32.decode("0xffffff00"); // 16777215
  /// ```
  @override
  int decodeFromHex(String encodedData) {
    Source source = Source(encodedData);
    final result = source.i32();
    source.assertEOF();

    return result;
  }
}
