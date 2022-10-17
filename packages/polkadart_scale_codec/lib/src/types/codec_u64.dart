part of '../core/core.dart';

/// [CodecType] class to encode `unsigned 64-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// Example:
/// ```
/// final encoded = CodecU64.encode(16777215);
/// final decoded = CodecU64.decode("0xffffff00");
/// ```
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecU64 implements ScaleCodecType {
  @override
  String encodeToHex(value) {
    if (value is! BigInt) {
      throw UnexpectedTypeException(
        expectedType: 'BigInt',
        receivedType: value.runtimeType.toString(),
      );
    }

    var sink = HexEncoder();
    sink.u64(value);
    return sink.toHex();
  }

  @override
  BigInt decodeFromHex(String encodedData) {
    Source source = Source(encodedData);
    return source.u64();
  }
}
