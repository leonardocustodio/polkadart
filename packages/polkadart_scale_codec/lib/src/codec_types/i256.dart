part of codec_types;

///
/// encode/decode signed 256 bit integer
class I256 extends Codec<BigInt> {
  final Source? source;

  ///
  /// constructor
  I256({this.source}) : super(registry: Registry());

  ///
  /// Decode a signed 256 bit integer from the source
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('I256', data: Source('0x0000000000000000000000000000008000000000000000000000000000000000'));
  /// final value = codec.decode();
  /// print(value); // -57896044618658097711785492504343953926634992332820282019728792003956564819968
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('I256', data: Source('0xffffffffffffffffffffffffffffffff7fffffffffffffffffffffffffffffff'));
  /// final value = codec.decode();
  /// print(value); // 57896044618658097711785492504343953926634992332820282019728792003956564819967
  /// ```
  @override
  BigInt decode() {
    final low = U128(source: source ?? data).decode();
    final high = I128(source: source ?? data).decode();
    return low + (high << 128);
  }

  ///
  /// Encodes a signed 256 bit integer
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('I256');
  /// final value = codec.encode(BigInt.parse('-57896044618658097711785492504343953926634992332820282019728792003956564819968'));
  /// print(value); // 00000000000000000000000000000080
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('I256');
  /// final value = codec.encode(BigInt.parse('57896044618658097711785492504343953926634992332820282019728792003956564819967'));
  /// print(value); // ffffffffffffffffffffffffffffff7f
  /// ```
  @override
  String encode(BigInt value) {
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
    return U256().encode((value + base) % base);
  }
}
