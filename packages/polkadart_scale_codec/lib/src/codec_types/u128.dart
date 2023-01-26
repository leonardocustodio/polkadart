part of codec_types;

///
/// encode/decode unsigned 128 bit integer
class U128 extends Uint<BigInt> {
  ///
  /// constructor
  U128._() : super._();

  ///
  /// [static] returns a new instance of U128
  @override
  U128 freshInstance() => U128._();

  ///
  /// Decode a unsigned 128 bit integer from the input
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().fetchTypeCodec('U128');
  /// final value = codec.decode(DefaultInput.fromHex('0x00000000000000000000000000000000'));
  /// print(value); // 0
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().fetchTypeCodec('U128');
  /// final value = codec.decode(DefaultInput.fromHex('0xffffffffffffffffffffffffffffffff'));
  /// print(value); // 340282366920938463463374607431768211455
  /// ```
  @override
  BigInt decode(Input input) {
    return decodeFromInput(input);
  }

  ///
  /// [static] Decode a unsigned 128 bit integer from the input
  ///
  /// Example:
  /// ```dart
  /// final value = U128.decodeFromInput(DefaultInput.fromHex('0x00000000000000000000000000000000'));
  /// print(value); // 0
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final value = U128.decodeFromInput(DefaultInput.fromHex('0xffffffffffffffffffffffffffffffff'));
  /// print(value); // 340282366920938463463374607431768211455
  /// ```
  static BigInt decodeFromInput(Input input) {
    final low = U64.decodeFromInput(input);
    final high = U64.decodeFromInput(input);
    return low + (high << 64);
  }

  ///
  /// Encodes a unsigned 128 bit integer
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().fetchTypeCodec('U128');
  /// final encoder = HexEncoder();
  /// codec.encode(encoder, BigInt.from(0));
  /// print(encoder.toHex()); // 00000000000000000000000000000000
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().fetchTypeCodec('U128');
  /// final encoder = HexEncoder();
  /// codec.encode(encoder, BigInt.parse('340282366920938463463374607431768211455'));
  /// print(encoder.toHex()); // ffffffffffffffffffffffffffffffff
  /// ```
  @override
  void encode(Encoder encoder, BigInt value) {
    encodeToEncoder(encoder, value);
  }

  ///
  /// [static] Encodes a unsigned 128 bit integer
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// U128.encodeToEncoder(encoder, BigInt.from(0));
  /// print(encoder.toHex()); // 00000000000000000000000000000000
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// U128.encodeToEncoder(encoder, BigInt.parse('340282366920938463463374607431768211455'));
  /// print(encoder.toHex()); // ffffffffffffffffffffffffffffffff
  /// ```
  static void encodeToEncoder(Encoder encoder, BigInt value) {
    if (value < BigInt.zero ||
        value > BigInt.parse('ffffffffffffffffffffffffffffffff', radix: 16)) {
      throw UnexpectedCaseException(
          'Expected value between 0 and BigInt.parse("ffffffffffffffffffffffffffffffff"), but found: $value');
    }

    U64.encodeToEncoder(
        encoder, value & BigInt.parse('ffffffffffffffff', radix: 16));
    U64.encodeToEncoder(encoder, value >> 64);
  }
}
