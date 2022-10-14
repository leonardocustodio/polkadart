import 'dart:typed_data';

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

/// [CodecType] class to encode `fixed-width` integers.
///
/// Basic integers are encoded using a fixed-width little-endian (LE) format.
///
/// Example:
/// ```
/// final encodedU8Int = CodecU8.encode(69);
/// final decodedU8Int = CodecU8.decode("0x45");
/// ```
///
/// See also: https://docs.substrate.io/reference/scale-codec/
class CodecU8 implements NewCodecType {
  @override
  String encodeToHex(value) {
    if (value is! int) {
      throw UnexpectedTypeException(
        expectedType: 'int',
        receivedType: value.runtimeType.toString(),
      );
    }

    var sink = HexSink();
    sink.u8(value);
    return sink.toHex();
  }

  @override
  int decodeFromHex(String encodedData) {
    final Uint8List data = decodeHex(encodedData);
    return data[0];
  }
}
