part of codec_types;

///
/// encode/decode signed 128 bit integer
class I128 extends Codec<BigInt> {
  final Source? source;

  ///
  /// constructor
  I128({this.source}) : super(registry: Registry());

  ///
  /// Decode a signed 128 bit integer from the source
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('I32', data: Source('0x00000000000000000000000000000080'));
  /// final value = codec.decode();
  /// print(value); // -170141183460469231731687303715884105728
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('I32', data: Source('0xffffffffffffffffffffffffffffff7f'));
  /// final value = codec.decode();
  /// print(value); // 170141183460469231731687303715884105727
  /// ```
  @override
  BigInt decode() {
    final low = U64(source: source ?? data).decode();
    final high = I64(source: source ?? data).decode();
    return low + (high << 64);
  }

  ///
  /// Encodes a signed 128 bit integer
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('I32');
  /// final value = codec.encode(BigInt.parse('-170141183460469231731687303715884105728'));
  /// print(value); // 00000000000000000000000000000080
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('I32');
  /// final value = codec.encode(BigInt.parse('170141183460469231731687303715884105727'));
  /// print(value); // ffffffffffffffffffffffffffffff7f
  /// ```
  @override
  String encode(BigInt value) {
    if (value < BigInt.parse('-170141183460469231731687303715884105728') ||
        value > BigInt.parse('170141183460469231731687303715884105727')) {
      throw UnexpectedCaseException(
          'Expected value between BigInt.parse(-170141183460469231731687303715884105728) and BigInt.parse(170141183460469231731687303715884105727), but found: $value');
    }

    final base = BigInt.parse('340282366920938463463374607431768211456');
    return U128().encode((value + base) % base);
  }
}
