import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('encode signed 32-bit to hex', () {
    test(
        'Given a positive integer when it is within range it should be encoded',
        () {
      const value = 16777215;
      const expectedResult = '0xffffff00';

      expect(CodecI32().encodeToHex(value), expectedResult);
    });

    test(
        'Given a negative integer when it is within range it should be encoded',
        () {
      const value = -2147483648;
      const expectedResult = '0x00000080';

      expect(CodecI32().encodeToHex(value), expectedResult);
    });

    test('Should return correct encoded data when value is zero', () {
      const value = 0;
      const expectedResult = '0x00000000';

      expect(CodecI32().encodeToHex(value), expectedResult);
    });

    test(
        'Should return correct encoded data when value fits 32 bits and is positive',
        () {
      const largestSupportedValue = 2147483647;
      const expectedResult = '0xffffff7f';

      expect(CodecI32().encodeToHex(largestSupportedValue), expectedResult);
    });

    test(
        'Should return correct encoded data when value fits 32 bits and is negative',
        () {
      const smallestSupportedValue = -2147483648;
      const expectedResult = '0x00000080';

      expect(CodecI32().encodeToHex(smallestSupportedValue), expectedResult);
    });

    test(
        "Given an 32 bit decoder when value is negative and can't be represented it should throw",
        () {
      const value = -2147483649;

      expect(
        () => CodecI32().encodeToHex(value),
        throwsA(isA<InvalidSizeException>()),
      );
    });

    test(
        "Given an 32 bit decoder when value is positive and can't be represented it should throw",
        () {
      const value = 2147483648;

      expect(
        () => CodecI32().encodeToHex(value),
        throwsA(isA<InvalidSizeException>()),
      );
    });
  });

  group('decode signed 32-bit from hex', () {
    test('Given an encoded string when it represents zero it should be decoded',
        () {
      const value = '0x00000000';
      const expectedResult = 0;

      expect(CodecI32().decodeFromHex(value), expectedResult);
    });

    test(
        'Given an encoded string when it represents the largest supported value it should be decoded',
        () {
      const largestSupportedValue = '0xffffff7f';
      const expectedResult = 2147483647;

      expect(CodecI32().decodeFromHex(largestSupportedValue), expectedResult);
    });

    test(
        'Given an encoded string when it represents the smallest supported value it should be decoded',
        () {
      const smallestSupportedValue = '0x00000080';
      const expectedResult = -2147483648;

      expect(CodecI32().decodeFromHex(smallestSupportedValue), expectedResult);
    });

    test(
        "Given an encoded string when it represents a integer that don't fit 32 bits it should throw",
        () {
      const value = '0xffffff0000000000';

      expect(
        () => CodecI32().decodeFromHex(value),
        throwsA(isA<Exception>()),
      );
    });
  });
}
