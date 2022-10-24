import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('encode unsigned 64-bit to hex', () {
    test(
        'Given a positive integer when it is within range it should be encoded',
        () {
      final value = BigInt.from(16777215);
      const expectedResult = '0xffffff0000000000';

      expect(CodecU64().encodeToHex(value), expectedResult);
    });

    test('Should return correct encoded data when value is zero', () {
      final value = BigInt.zero;
      const expectedResult = '0x0000000000000000';

      expect(CodecU64().encodeToHex(value), expectedResult);
    });

    test(
        'Should return correct encoded data when value fits 64 bits and is positive',
        () {
      final largestSupportedValue = '18446744073709551615'.toBigInt;
      const expectedResult = '0xffffffffffffffff';

      expect(CodecU64().encodeToHex(largestSupportedValue), expectedResult);
    });

    test('Should throw InvalidSizeException when value is negative', () {
      final value = (-1).toBigInt;

      expect(
        () => CodecU64().encodeToHex(value),
        throwsA(isA<InvalidSizeException>()),
      );
    });

    test(
        "Given an 64 bit decoder when value is positive and can't be represented it should throw",
        () {
      final value = '18446744073709551616'.toBigInt;

      expect(
        () => CodecU64().encodeToHex(value),
        throwsA(isA<InvalidSizeException>()),
      );
    });
  });

  group('decode unsigned 64-bit integers', () {
    test('Given an encoded string when it represents zero it should be decoded',
        () {
      const value = '0x0000000000000000';
      final expectedResult = BigInt.zero;

      expect(CodecU64().decodeFromHex(value), expectedResult);
    });

    test(
        'Given an encoded string when it represents the largest supported value it should be decoded',
        () {
      const largestSupportedValue = '0xffffffffffffffff';
      final expectedResult = '18446744073709551615'.toBigInt;

      expect(CodecU64().decodeFromHex(largestSupportedValue), expectedResult);
    });

    test(
        "Given an encoded string when it represents a integer larger than 64 bits it should throw",
        () {
      const value = '0xffffffffffffffffffffffffffffffff';

      expect(
        () => CodecU64().decodeFromHex(value),
        throwsA(isA<UnprocessedDataLeftException>()),
      );
    });

    test(
        "Given an encoded string when it represents a integer smaller than 64 bits it should throw",
        () {
      const value = '0xffff';

      expect(
        () => CodecU64().decodeFromHex(value),
        throwsA(isA<EOFException>()),
      );
    });
  });
}
