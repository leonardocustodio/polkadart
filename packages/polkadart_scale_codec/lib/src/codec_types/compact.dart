part of codec_types;

///
/// Compact to encode/decode bool
class Compact<T extends Uint> extends Codec<dynamic> {
  ///
  /// constructor
  Compact._() : super(registry: Registry());

  ///
  /// [static] Create a new instance of Compact
  @override
  Compact copyWith(Codec codec) {
    return copyProperties(codec, Compact._()) as Compact;
  }

  ///
  /// Decodes the value from the Codec's input
  ///
  /// Supported Compact values can range from  0 - ((2 ^ 536) - 1)
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec().createTypeCodec('Compact', input: Input('0x00'));
  /// final value = codec.decode();
  /// print(value); // 0
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec().createTypeCodec('Compact', input: Input('0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'));
  /// final value = codec.decode();
  /// print(value); // 115792089237316195423570985008687907853269984665640564039457584007913129639935
  /// ```
  @override
  dynamic decode(Input input) {
    return decodeFromInput(input);
  }

  ///
  /// [static] Decodes the value from the Codec's input
  ///
  /// Supported Compact values can range from  0 - ((2 ^ 536) - 1)
  ///
  /// Example:
  /// ```dart
  /// final value = Compact.decodeFromInput(input: Input('0x00'));
  /// print(value); // 0
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final value = Compact.decodeFromInput(input: Input('0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'));
  /// print(value); // 115792089237316195423570985008687907853269984665640564039457584007913129639935
  /// ```
  static dynamic decodeFromInput(Input input) {
    final int b = input.byte();
    final int mode = b & 3;
    switch (mode) {
      case 0:
        return b >> 2;
      case 1:
        return (b >> 2) + input.byte() * (2 << 5);
      case 2:
        return (b >> 2) +
            input.byte() * (2 << 5) +
            input.byte() * (2 << 13) +
            input.byte() * (2 << 21);
      case 3:
        return _decodeBigCompact(input, b >> 2);
      //
      // default: It will never hit `default case` because of the `mode` is always in the range of `0` to `3`.
    }
  }

  static dynamic _decodeBigCompact(Input input, int length) {
    final int i = U32.decodeFromInput(input);
    switch (length) {
      case 0:
        return i;
      case 1:
        return i + input.byte() * ((2 << 30) * 2);
      case 2:
        // pow(2, 32) = (2 << 30) * (2 << 0)
        // simplified = (2 << 30) * 2
        return i +
            input.byte() * ((2 << 30) * 2) +
            input.byte() * ((2 << 30) * (2 << 8));
    }

    BigInt n = BigInt.from(i);
    BigInt base = BigInt.from(32);
    while (length-- != 0) {
      n += BigInt.from(input.byte()) << base.toInt();
      base += BigInt.from(8);
    }
    //
    // returning [BigInt] here
    return n;
  }

  ///
  /// Compacts a value to the encoder
  ///
  /// Supported Compact values can range from  0 - ((2 ^ 536) - 1)
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// final codec = Codec().createTypeCodec('Compact');
  /// codec.encode(encoder, 0);
  /// print(encoder.toHex()); // 0x00
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// final codec = Codec().createTypeCodec('Compact');
  /// codec.encode(encoder, BigInt.parse('115792089237316195423570985008687907853269984665640564039457584007913129639935'));
  /// print(encoder.toHex()); // 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  /// ```
  @override
  void encode(Encoder encoder, dynamic value) {
    encodeToEncoder(encoder, value);
  }

  ///
  /// [static] Compacts a num
  ///
  /// Supported Compact values can range from  0 - ((2 ^ 536) - 1)
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// Compact.encodeToEncoder(encoder, 0);
  /// print(encoder.toHex()); // 0x00
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// Compact.encodeToEncoder(encoder, BigInt.parse('115792089237316195423570985008687907853269984665640564039457584007913129639935'));
  /// print(encoder.toHex()); // 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  /// ```
  static void encodeToEncoder(Encoder encoder, dynamic val) {
    if (!(val is BigInt || val is int)) {
      throw IncompatibleCompactTypeException(val.runtimeType);
    }

    final BigInt bigIntValue = val is BigInt ? val : BigInt.from(val);
    final int value = bigIntValue.toInt();
    if (value < 0) {
      throw IncompatibleCompactValueException(value);
    }

    if (value < 64) {
      encoder.write(value * 4);
    } else if (value < (2 << 8)) {
      encoder.writeBytes([
        (value & 63) * 4 + 1,
        value >>> 6,
      ]);
    } else if (value < (2 << 24)) {
      encoder.writeBytes([
        (value & 63) * 4 + 2,
        (value >>> 6) & 0xff,
      ]);
      U16.encodeToEncoder(encoder, value >>> 14);
    } else if (bigIntValue < (BigInt.from(64) << 530)) {
      BigInt copiedValue = bigIntValue;
      encoder.write(_unsignedIntByteLength(copiedValue) * 4 - 13);
      while (copiedValue.toInt() > 0) {
        encoder.write((copiedValue & BigInt.parse('0xff')).toInt());
        copiedValue >>= 8;
      }
    } else {
      throw IncompatibleCompactValueException(bigIntValue);
    }
  }

  ///
  /// Counts the shifts made to the the bits of [value] to the right by shiftAmount:`8` before becoming `0`.
  static int _unsignedIntByteLength(BigInt value) {
    int length = 0;
    final BigInt bigInt0 = BigInt.from(0);
    while (value > bigInt0) {
      value = value >> 8;
      length += 1;
    }
    return length;
  }
}
