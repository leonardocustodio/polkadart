part of '../core/core.dart';

/// [ScaleCodecType] class to encode `signed 8-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// Example:
/// ```
/// final encoded = CodecI8.encode(69);
/// final decoded = CodecI8.decode("0x45");
/// ```
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecI8 implements ScaleCodecType<int> {
  @override
  String encodeToHex(value) {
    var sink = HexEncoder();
    sink.i8(value);
    return sink.toHex();
  }

  @override
  int decodeFromHex(String encodedData) {
    Source source = Source(encodedData);
    final result = source.i8();
    source.assertEOF();

    return result;
  }
}
