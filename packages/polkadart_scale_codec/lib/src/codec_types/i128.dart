part of codec_types;

///
/// encode/decode signed 128 bit integer
class I128 extends Codec<BigInt> {
  ///
  /// constructor
  I128._() : super(registry: Registry());

  ///
  /// [static] returns a new instance of I128
  @override
  I128 freshInstance() => I128._();

  ///
  /// Decode a signed 128 bit integer from the input
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().fetchTypeCodec('I128');
  /// final value = codec.decode(DefaultInput.fromHex('0x00000000000000000000000000000080'));
  /// print(value); // -170141183460469231731687303715884105728
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().fetchTypeCodec('I128');
  /// final value = codec.decode(DefaultInput.fromHex('0xffffffffffffffffffffffffffffff7f'));
  /// print(value); // 170141183460469231731687303715884105727
  /// ```
  @override
  BigInt decode(Input input) {
    return decodeFromInput(input);
  }

  ///
  /// [static] Decode a signed 128 bit integer from the input
  ///
  /// Example:
  /// ```dart
  /// final value = I128.decodeFromInput(DefaultInput.fromHex('0x00000000000000000000000000000080'));
  /// print(value); // -170141183460469231731687303715884105728
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final value = I128.decodeFromInput(DefaultInput.fromHex('0xffffffffffffffffffffffffffffff7f'));
  /// print(value); // 170141183460469231731687303715884105727
  /// ```
  static BigInt decodeFromInput(Input input) {
    final low = U64.decodeFromInput(input);
    final high = I64.decodeFromInput(input);
    return low + (high << 64);
  }

  ///
  /// Encodes a signed 128 bit integer
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().fetchTypeCodec('I128');
  /// final encoder = HexEncoder();
  /// codec.encode(encoder, BigInt.parse('-170141183460469231731687303715884105728'));
  /// print(encoder.toHex()); // 00000000000000000000000000000080
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().fetchTypeCodec('I128');
  /// final encoder = HexEncoder();
  /// codec.encode(encoder, BigInt.parse('170141183460469231731687303715884105727'));
  /// print(encoder.toHex()); // ffffffffffffffffffffffffffffff7f
  /// ```
  @override
  void encode(Encoder encoder, BigInt value) {
    encodeToEncoder(encoder, value);
  }

  ///
  /// [static] Encodes a signed 128 bit integer
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// I128.encodeToEncoder(encoder, BigInt.parse('-170141183460469231731687303715884105728'));
  /// print(encoder.toHex()); // 00000000000000000000000000000080
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// I128.encodeToEncoder(encoder, BigInt.parse('170141183460469231731687303715884105727'));
  /// print(encoder.toHex()); // ffffffffffffffffffffffffffffff7f
  /// ```
  static void encodeToEncoder(Encoder encoder, BigInt value) {
    if (value < BigInt.parse('-170141183460469231731687303715884105728') ||
        value > BigInt.parse('170141183460469231731687303715884105727')) {
      throw UnexpectedCaseException(
          'Expected value between BigInt.parse(-170141183460469231731687303715884105728) and BigInt.parse(170141183460469231731687303715884105727), but found: $value');
    }

    final base = BigInt.parse('340282366920938463463374607431768211456');
    final val = (value + base) % base;
    U128.encodeToEncoder(encoder, val);
  }
}
