import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('encode signed 8-bit to hex', () {
    test(
        'Given a positive integer when it is within range it should be encoded',
        () {
      const value = 69;
      const expectedResult = '0x45';

      expect(CodecI8().encodeToHex(value), expectedResult);
    });

    test('Should return correct encoded data when value is zero', () {
      const value = 0;
      const expectedResult = '0x00';

      expect(CodecI8().encodeToHex(value), expectedResult);
    });

    test(
        'Should return correct encoded data when value fits 8 bits and is negative',
        () {
      const smallestSupportedValue = -128;
      const expectedResult = '0x80';

      expect(CodecI8().encodeToHex(smallestSupportedValue), expectedResult);
    });

    test(
        'Should return correct encoded data when value fits 8 bits and is positive',
        () {
      const largestSupportedValue = 127;
      const expectedResult = '0x7f';

      expect(CodecI8().encodeToHex(largestSupportedValue), expectedResult);
    });

    test(
        "Given an 8 bit decoder when value is negative and can't be represented it should throw",
        () {
      const value = -129;

      expect(
        () => CodecI8().encodeToHex(value),
        throwsA(isA<InvalidSizeException>()),
      );
    });

    test(
        "Given an 8 bit decoder when value is positive and can't be represented it should throw",
        () {
      const value = 128;

      expect(
        () => CodecI8().encodeToHex(value),
        throwsA(isA<InvalidSizeException>()),
      );
    });
  });

  group('decode signed 8-bit integers', () {
    test(
        'Given an encoded string when it represents a positive integer it should be decoded',
        () {
      const value = '0x45';
      const expectedResult = 69;

      expect(CodecI8().decodeFromHex(value), expectedResult);
    });

    test('Given an encoded string when it represents zero it should be decoded',
        () {
      const value = '0x00';
      const expectedResult = 0;

      expect(CodecI8().decodeFromHex(value), expectedResult);
    });

    test(
        'Given an encoded string when it represents the smallest supported value it should be decoded',
        () {
      const smallestSupportedValue = '0x80';
      const expectedResult = -128;

      expect(CodecI8().decodeFromHex(smallestSupportedValue), expectedResult);
    });

    test(
        'Given an encoded string when it represents the biggest supported value it should be decoded',
        () {
      const biggestSupportedValue = '0x7f';
      const expectedResult = 127;

      expect(CodecI8().decodeFromHex(biggestSupportedValue), expectedResult);
    });

    test(
        "Given an encoded string when it represents a integer that don't fit 8 bits it should throw",
        () {
      const value = '0xff7f';

      expect(
        () => CodecI8().decodeFromHex(value),
        throwsA(isA<Exception>()),
      );
    });
  });
}
