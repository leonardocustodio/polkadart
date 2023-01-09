part of codec_types;

///
/// encode/decode signed 64 bit integer
class I64 extends Codec<BigInt> {
  final Source? source;

  ///
  /// constructor
  I64({this.source}) : super(registry: Registry());

  ///
  /// Decode a signed 64 bit integer from the source
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('I64', data: Source('0x0000000000000080'));
  /// final value = codec.decode();
  /// print(value); // -9223372036854775808
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('I64', data: Source('0xffffffffffffff7f'));
  /// final value = codec.decode();
  /// print(value); // 9223372036854775807
  /// ```
  @override
  BigInt decode() {
    final low = U32(source: source ?? data).decode();
    final high = I32(source: source ?? data).decode();
    return BigInt.from(low) + (BigInt.from(high) << 32);
  }

  ///
  /// Encodes a signed 64 bit integer
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('I64');
  /// final value = codec.encode(BigInt.from(-9223372036854775808));
  /// print(value); // 0000000000000080
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('I64');
  /// final value = codec.encode(BigInt.from(9223372036854775807));
  /// print(value); // ffffffffffffff7f
  /// ```
  @override
  String encode(BigInt value) {
    if (value < BigInt.from(-9223372036854775808) ||
        value > BigInt.from(9223372036854775807)) {
      throw UnexpectedCaseException(
          'Expected value between BigInt.from(-9223372036854775808) and BigInt.from(9223372036854775807), but found: $value');
    }

    final base = BigInt.parse('18446744073709551616');
    return U64().encode((value + base) % base);
  }
}
