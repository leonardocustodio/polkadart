import 'dart:math';

import 'package:convert/convert.dart';
import 'package:polkadart_scale_codec/utils/utils.dart';

class Era {
  const Era._();

  static const Era codec = Era._();

  int _getTrailingZeros(int number) {
    final binary = number.toRadixString(2);
    int index = 0;

    while (binary[binary.length - 1 - index] == '0') {
      index++;
    }

    return index;
  }

  String _flipBits(String bitString) {
    final length = bitString.length;

    if (length % 8 != 0) {
      throw Exception('Bit string length must be a multiple of 8');
    }

    var newString = '';
    for (var i = length; i >= 0; i -= 8) {
      newString += bitString.substring(i, (i + 8).clamp(0, length));
    }

    return newString;
  }

  List<int> _littleIntToUint8List(int value, int length) {
    final String val = value.toRadixString(2).padLeft(length * 8, '0');
    final String flippedBits = _flipBits(val);
    final gmp = BigInt.parse(flippedBits, radix: 2)
        .toRadixString(16)
        .padLeft(length * 2, '0');
    return decodeHex(gmp).toList(growable: false);
  }

  (int, int) decode(String value) {
    final bytes = hex.decode(value);

    if (bytes.first == 0) {
      return (0, 0);
    }

    final firstByte = bytes[0];
    final secondByte = bytes[1] << 8;
    final encoded = firstByte + secondByte;
    final period = 2 << (encoded % (1 << 4));
    final quantizeFactor = max(period >> 12, 1);
    final phase = (encoded >> 4) * quantizeFactor;

    return (phase, period);
  }

  encode(int phase, int period) {
    if (phase == 0 && period == 0) {
      return '00';
    }

    final quantizeFactor = max(period >> 12, 1);
    final encoded = min(15, max(1, _getTrailingZeros(period) - 1)) |
        (phase ~/ quantizeFactor << 4);

    return hex.encode(_littleIntToUint8List(encoded, 2));
  }

  encodeMortal(int current, int period) {
    final calPeriod = pow(2, (log(period) / log(2)).ceil());
    final phase = current % min(max(calPeriod, 4), 1 << 16);
    final quantizeFactor = max(1, period >> 12);
    final quantizedPhase = phase / quantizeFactor * quantizeFactor;

    return encode(quantizedPhase.toInt(), period);
  }
}
