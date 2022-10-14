part of '../core/core.dart';

/// [CodecType] class to encode `unsigned 256-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// Example:
/// ```
/// final encoded = CodecU264.encode(16777215);
/// final decoded = CodecU264.decode("0xffffff0000000000000000000000000000000000000000000000000000000000");
/// ```
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecU256 implements NewCodecType {
  @override
  String encodeToHex(value) {
    if (value is! BigInt) {
      throw UnexpectedTypeException(
        expectedType: 'BigInt',
        receivedType: value.runtimeType.toString(),
      );
    }

    var sink = HexSink();
    sink.u256(value);
    return sink.toHex();
  }

  @override
  BigInt decodeFromHex(String encodedData) {
    Source source = Source(encodedData);
    return source.u256();
  }
}
