import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('encode signed 64-bit to hex', () {
    test('Should return correct encoded data when value is zero', () {
      final value = 0.toBigInt;
      const expectedResult = '0x0000000000000000';

      expect(CodecI64().encodeToHex(value), expectedResult);
    });

    test(
        'Should return correct encoded data when value fits 64 bits and is positive',
        () {
      final largestSupportedValue = 9223372036854775807.toBigInt;
      const expectedResult = '0xffffffffffffff7f';

      expect(CodecI64().encodeToHex(largestSupportedValue), expectedResult);
    });

    test(
        'Should return correct encoded data when value fits 64 bits and is negative',
        () {
      final smallestSupportedValue = (-9223372036854775808).toBigInt;
      const expectedResult = '0x0000000000000080';

      expect(CodecI64().encodeToHex(smallestSupportedValue), expectedResult);
    });

    test(
        "Given an 64 bit decoder when value is negative and can't be represented it should throw",
        () {
      final value = BigInt.parse('-9223372036854775809');

      expect(
        () => CodecI64().encodeToHex(value),
        throwsA(isA<InvalidSizeException>()),
      );
    });

    test(
        "Given an 64 bit decoder when value is positive and can't be represented it should throw",
        () {
      final value = BigInt.parse('9223372036854775808');

      expect(
        () => CodecI64().encodeToHex(value),
        throwsA(isA<InvalidSizeException>()),
      );
    });
  });

  group('decode signed 64-bit from hex', () {
    test('Given an encoded string when it represents zero it should be decoded',
        () {
      const value = '0x0000000000000000';
      final expectedResult = 0.toBigInt;

      expect(CodecI64().decodeFromHex(value), expectedResult);
    });

    test(
        'Given an encoded string when it represents the largest supported value it should be decoded',
        () {
      const largestSupportedValue = '0xffffffffffffff7f';
      final expectedResult = 9223372036854775807.toBigInt;

      expect(CodecI64().decodeFromHex(largestSupportedValue), expectedResult);
    });

    test(
        'Given an encoded string when it represents the smallest supported value it should be decoded',
        () {
      const smallestSupportedValue = '0x0000000000000080';
      final expectedResult = (-9223372036854775808).toBigInt;

      expect(CodecI64().decodeFromHex(smallestSupportedValue), expectedResult);
    });

    test(
        "Given an encoded string when it represents a integer that don't fit 64 bits it should throw",
        () {
      const value = '0xffffff00000000000000000000000000';

      expect(
        () => CodecI64().decodeFromHex(value),
        throwsA(isA<Exception>()),
      );
    });
  });
}
