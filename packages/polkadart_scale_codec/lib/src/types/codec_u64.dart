part of '../core/core.dart';

/// [CodecType] class to encode `unsigned 64-bit` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// Example:
/// ```
/// final encoded = CodecU32.encode(16777215);
/// final decoded = CodecU32.decode("0xffffff00");
/// ```
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecU64 implements NewCodecType {
  @override
  String encodeToHex(value) {
    if (value is! BigInt) {
      throw UnexpectedTypeException(
        expectedType: 'BigInt',
        receivedType: value.runtimeType.toString(),
      );
    }

    var sink = HexSink();
    sink.u64(value);
    return sink.toHex();
  }

  @override
  BigInt decodeFromHex(String encodedData) {
    final Uint8List data = decodeHex(encodedData);

    if (data.length < 8) {
      throw EOFException();
    }

    final low = data[0] +
        data[1] * (pow(2, 8) as int) +
        data[2] * (pow(2, 16) as int) +
        data[3] * (pow(2, 24) as int);

    final high = data[4] +
        data[5] * (pow(2, 8) as int) +
        data[6] * (pow(2, 16) as int) +
        data[7] * (pow(2, 24) as int);

    final result = BigInt.from(low) + (BigInt.from(high) << 32);
    return result;
  }
}
