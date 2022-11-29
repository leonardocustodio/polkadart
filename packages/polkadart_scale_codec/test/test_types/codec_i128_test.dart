import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('encode signed 128-bit to hex', () {
    test('Should return correct encoded data when value is zero', () {
      final value = 0.toBigInt;
      const expectedResult = '0x00000000000000000000000000000000';

      expect(CodecI128().encodeToHex(value), expectedResult);
    });

    test(
        'Should return correct encoded data when value fits 128 bits and is positive',
        () {
      final largestSupportedValue =
          BigInt.parse('170141183460469231731687303715884105727');
      const expectedResult = '0xffffffffffffffffffffffffffffff7f';

      expect(CodecI128().encodeToHex(largestSupportedValue), expectedResult);
    });

    test(
        'Should return correct encoded data when value fits 128 bits and is negative',
        () {
      final smallestSupportedValue =
          BigInt.parse('-170141183460469231731687303715884105728');
      const expectedResult = '0x00000000000000000000000000000080';

      expect(CodecI128().encodeToHex(smallestSupportedValue), expectedResult);
    });

    test(
        "Given an 128 bit decoder when value is negative and can't be represented it should throw",
        () {
      final value = BigInt.parse('-170141183460469231731687303715884105729');

      expect(
        () => CodecI128().encodeToHex(value),
        throwsA(isA<InvalidSizeException>()),
      );
    });

    test(
        "Given an 128 bit decoder when value is positive and can't be represented it should throw",
        () {
      final value = BigInt.parse('170141183460469231731687303715884105728');

      expect(
        () => CodecI128().encodeToHex(value),
        throwsA(isA<InvalidSizeException>()),
      );
    });
  });

  group('decode signed 128-bit from hex', () {
    test('Given an encoded string when it represents zero it should be decoded',
        () {
      const value = '0x00000000000000000000000000000000';
      final expectedResult = 0.toBigInt;

      expect(CodecI128().decodeFromHex(value), expectedResult);
    });

    test(
        'Given an encoded string when it represents the largest supported value it should be decoded',
        () {
      const largestSupportedValue = '0xffffffffffffffffffffffffffffff7f';
      final expectedResult =
          BigInt.parse('170141183460469231731687303715884105727');

      expect(CodecI128().decodeFromHex(largestSupportedValue), expectedResult);
    });

    test(
        'Given an encoded string when it represents the smallest supported value it should be decoded',
        () {
      const smallestSupportedValue = '0x00000000000000000000000000000080';
      final expectedResult =
          BigInt.parse('-170141183460469231731687303715884105728');

      expect(CodecI128().decodeFromHex(smallestSupportedValue), expectedResult);
    });

    test(
        "Given an encoded string when it represents a integer that don't fit 128 bits it should throw",
        () {
      const value =
          '0xffffff0000000000000000000000000000000000000000000000000000000000';

      expect(
        () => CodecI128().decodeFromHex(value),
        throwsA(isA<Exception>()),
      );
    });
  });
}
