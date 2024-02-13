part of metadata_types;

class EraExtrinsic with Codec<Map<String, int>> {
  const EraExtrinsic._();

  static const EraExtrinsic codec = EraExtrinsic._();

  @override
  Map<String, int> decode(Input input) {
    final mortalLen = input.read();

    if (mortalLen == 0) {
      //
      // Immortal
      return <String, int>{};
    }

    //
    // Mortal
    final int encoded = mortalLen + (input.read() << 8);

    final int period = 2 << (encoded % (1 << 4));
    final int phase = ((encoded >> 4) * max(period >> 12, 1)) as int;

    return <String, int>{
      'period': period,
      'phase': phase,
    };
  }

  @override
  void encodeTo(Map<String, int> value, Output output) {
    if (value.isEmpty ||
        (value['phase'] == null && value['period'] == null) ||
        (value['phase'] == 0 && value['period'] == 0)) {
      //
      // Immortal
      output.pushByte(0);
      return;
    }

    final calPeriod = pow(2, (log(value['period']!) / log(2)).ceil());
    final phase = value['phase']! % min(max(calPeriod, 4), 1 << 16);
    final quantizeFactor = max(1, value['period']! >> 12);
    final quantizedPhase = phase / quantizeFactor * quantizeFactor;

    return output.write(_encode(quantizedPhase.toInt(), calPeriod as int));
  }

  _encode(int phase, int period) {
    if (phase == 0 && period == 0) {
      return '00';
    }

    final quantizeFactor = max(period >> 12, 1);
    final encoded = min(15, max(1, _trailingZeros(period) - 1)) |
        (phase ~/ quantizeFactor << 4);

    return _littleIntToUint8List(encoded, 2);
  }

  int _trailingZeros(int value) {
    var zero = 0;
    while ((value & 1) == 0) {
      zero += 1;
      value = value >> 1;
    }
    return zero;
  }

  /// Converts little endian integer to hex
  /// [value] - little endian integer
  /// [length] - length of the integer
  /// Returns: `Uint8List`
  ///
  /// Example:
  /// ```dart
  /// int value = 51;
  /// int length = 2;
  /// Uint8List hex = littleIntToHex(value, length);
  /// // hex = [51, 0]
  /// ```
  List<int> _littleIntToUint8List(int value, int length) {
    final String val = value.toRadixString(2).padLeft(length * 8, '0');
    final String flippedBits = _flipBits(val);
    final gmp = BigInt.parse(flippedBits, radix: 2)
        .toRadixString(16)
        .padLeft(length * 2, '0');
    return decodeHex(gmp).toList(growable: false);
  }

  ///
  /// Flips bits
  /// [bitString] - bit string
  /// Returns: `String`
  ///
  /// Example:
  /// ```dart
  /// String bitString = '000000000000000000001010';
  /// String flippedBits = flipBits(bitString);
  /// // flippedBits = '101010000000000000000000'
  /// ```
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
}
