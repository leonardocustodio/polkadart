part of '../core/core.dart';

/// [ScaleCodecType] class to encode and decode `bool` values.
///
/// Boolean values are encoded using the least significant bit of a single byte.
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecBoolean implements ScaleCodecType<bool> {
  /// Returns an encoded hex-decimal `String` from `bool` [value]
  /// using [HexEncoder] methods.
  ///
  /// Example:
  /// ```
  /// final encoded = CodecBoolean().encodeToHex(false); //"0x00"
  /// ```
  @override
  String encodeToHex(value) {
    var sink = HexEncoder();
    sink.boolean(value);
    return sink.toHex();
  }

  /// Returns a `bool` value which represents the [encodedData] hex-decimal
  /// `string` using [Source] methods.
  ///
  /// Example:
  /// ```
  /// final decoded = CodecBoolean().decodeFromHex("0x01"); //true
  /// ```
  @override
  bool decodeFromHex(String encodedData) {
    Source source = Source(encodedData);
    final result = source.boolean();
    source.assertEOF();

    return result;
  }
}
