part of '../core/core.dart';

/// [CodecType] class to encode `unsigned 16-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// Example:
/// ```
/// final encodedU8Int = CodecU16.encode(42);
/// final decodedU8Int = CodecU16.decode("0x2a00");
/// ```
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecU16 implements NewCodecType {
  @override
  String encodeToHex(value) {
    if (value is! int) {
      throw UnexpectedTypeException(
        expectedType: 'int',
        receivedType: value.runtimeType.toString(),
      );
    }

    var sink = HexSink();
    sink.u16(value);
    return sink.toHex();
  }

  @override
  int decodeFromHex(String encodedData) {
    final Uint8List data = decodeHex(encodedData);

    if (data.length < 2) {
      throw EOFException();
    }

    final result = data[0] + data[1] * (pow(2, 8) as int);
    return result;
  }
}
