part of '../core/core.dart';

/// [ScaleCodecType] class to encode and decode `Strings`.
///
/// Strings are Vectors of bytes (Vec<u8>) containing a valid UTF8 sequence.
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecString implements ScaleCodecType<String> {
  /// Returns an encoded hex-decimal `String` from `String` [value]
  /// using [HexEncoder] methods.
  ///
  /// Example:
  /// ```
  /// final encoded = CodecString.encodeToHex("Test"); //"0x1054657374"
  /// ```
  @override
  String encodeToHex(value) {
    var sink = HexEncoder();
    sink.str(value);
    return sink.toHex();
  }

  /// Returns an `String` value which the hex-decimal `String`
  /// [encodedData] represents, using [Source] methods.
  ///
  /// Example:
  /// ```
  /// final decoded = CodecString.decodeFromHex("0x1054657374"); //Test
  /// ```
  @override
  String decodeFromHex(String encodedData) {
    Source source = Source(encodedData);
    final result = source.str();
    source.assertEOF();

    return result;
  }
}
