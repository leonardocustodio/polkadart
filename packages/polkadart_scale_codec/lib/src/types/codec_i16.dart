part of '../core/core.dart';

/// [ScaleCodecType] class to encode `signed 16-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// Example:
/// ```
/// final encoded = CodecI16.encode(-32768);
/// final decoded = CodecI16.decode("0x0080");
/// ```
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecI16 implements ScaleCodecType<int> {
  @override
  String encodeToHex(value) {
    var sink = HexEncoder();
    sink.i16(value);
    return sink.toHex();
  }

  @override
  int decodeFromHex(String encodedData) {
    Source source = Source(encodedData);
    final result = source.i16();
    source.assertEOF();

    return result;
  }
}
