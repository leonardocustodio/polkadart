part of codec_types;

///
/// encode/decode signed 256 bit integer
class I256 extends Codec<BigInt> {
  ///
  /// constructor
  I256._() : super(registry: Registry());

  ///
  /// [static] Create a properties-copied instance of I256
  @override
  I256 copyWith(Codec codec) {
    return copyProperties(codec, I256._()) as I256;
  }

  ///
  /// Decode a signed 256 bit integer from the input
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().fetchTypeCodec('I256');
  /// final value = codec.decode(Input('0x0000000000000000000000000000008000000000000000000000000000000000'));
  /// print(value); // -57896044618658097711785492504343953926634992332820282019728792003956564819968
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().fetchTypeCodec('I256');
  /// final value = codec.decode(Input('0xffffffffffffffffffffffffffffffff7fffffffffffffffffffffffffffffff'));
  /// print(value); // 57896044618658097711785492504343953926634992332820282019728792003956564819967
  /// ```
  @override
  BigInt decode(Input input) {
    return decodeFromInput(input);
  }

  ///
  /// [static] Decode a signed 256 bit integer from the input
  ///
  /// Example:
  /// ```dart
  /// final value = I256.decodeFromInput(Input('0x0000000000000000000000000000008000000000000000000000000000000000'));
  /// print(value); // -57896044618658097711785492504343953926634992332820282019728792003956564819968
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final value = I256.decodeFromInput(Input('0xffffffffffffffffffffffffffffffff7fffffffffffffffffffffffffffffff'));
  /// print(value); // 57896044618658097711785492504343953926634992332820282019728792003956564819967
  /// ```
  static BigInt decodeFromInput(Input input) {
    final low = U128.decodeFromInput(input);
    final high = I128.decodeFromInput(input);
    return low + (high << 128);
  }

  ///
  /// Encodes a signed 256 bit integer
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().fetchTypeCodec('I256');
  /// final encoder = HexEncoder();
  /// codec.encode(encoder, BigInt.parse('-57896044618658097711785492504343953926634992332820282019728792003956564819968'));
  /// print(encoder.toHex()); // 00000000000000000000000000000080
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().fetchTypeCodec('I256');
  /// final encoder = HexEncoder();
  /// codec.encode(encoder, BigInt.parse('57896044618658097711785492504343953926634992332820282019728792003956564819967'));
  /// print(encoder.toHex()); // ffffffffffffffffffffffffffffff7f
  /// ```
  @override
  void encode(Encoder encoder, BigInt value) {
    encodeToEncoder(encoder, value);
  }

  ///
  /// [static] Encodes a signed 256 bit integer
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// I256.encodeToEncoder(encoder, BigInt.parse('-57896044618658097711785492504343953926634992332820282019728792003956564819968'));
  /// print(encoder.toHex()); // 0000000000000000000000000000000000000000000000000000000000000080
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// I256.encodeToEncoder(encoder, BigInt.parse('57896044618658097711785492504343953926634992332820282019728792003956564819967'));
  /// print(encoder.toHex()); // 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f
  /// ```
  static void encodeToEncoder(Encoder encoder, BigInt value) {
    if (value <
            BigInt.parse(
                '-57896044618658097711785492504343953926634992332820282019728792003956564819968') ||
        value >
            BigInt.parse(
                '57896044618658097711785492504343953926634992332820282019728792003956564819967')) {
      throw UnexpectedCaseException(
          'Expected value between BigInt.parse(-57896044618658097711785492504343953926634992332820282019728792003956564819968) and BigInt.parse(57896044618658097711785492504343953926634992332820282019728792003956564819967), but found: $value');
    }

    final base = BigInt.parse(
        '115792089237316195423570985008687907853269984665640564039457584007913129639936');
    final val = (value + base) % base;
    U256.encodeToEncoder(encoder, val);
  }
}
