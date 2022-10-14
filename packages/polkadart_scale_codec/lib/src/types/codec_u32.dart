part of '../core/core.dart';

/// [CodecType] class to encode `unsigned 32-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// Example:
/// ```
/// final encodedU32Int = CodecU32.encode(16777215);
/// final decodedU32Int = CodecU32.decode("0xffffff00");
/// ```
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecU32 implements NewCodecType {
  @override
  String encodeToHex(value) {
    if (value is! int) {
      throw UnexpectedTypeException(
        expectedType: 'int',
        receivedType: value.runtimeType.toString(),
      );
    }

    var sink = HexSink();
    sink.u32(value);
    return sink.toHex();
  }

  @override
  int decodeFromHex(String encodedData) {
    final Uint8List data = decodeHex(encodedData);

    if (data.length < 4) {
      throw EOFException();
    }

    final result = data[0] +
        data[1] * (pow(2, 8) as int) +
        data[2] * (pow(2, 16) as int) +
        data[3] * (pow(2, 24) as int);
    return result;
  }
}
