import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('encode signed 16-bit to hex', () {
    test(
        'Given a positive integer when it is within range it should be encoded',
        () {
      const value = 42;
      const expectedResult = '0x2a00';

      expect(CodecI16().encodeToHex(value), expectedResult);
    });

    test(
        'Given a negative integer when it is within range it should be encoded',
        () {
      const value = -32768;
      const expectedResult = '0x0080';

      expect(CodecI16().encodeToHex(value), expectedResult);
    });

    test('Should return correct encoded data when value is zero', () {
      const value = 0;
      const expectedResult = '0x0000';

      expect(CodecI16().encodeToHex(value), expectedResult);
    });

    test(
        'Should return correct encoded data when value fits 16 bits and is positive',
        () {
      const largestSupportedValue = 32767;
      const expectedResult = '0xff7f';

      expect(CodecI16().encodeToHex(largestSupportedValue), expectedResult);
    });

    test(
        'Should return correct encoded data when value fits 16 bits and is negative',
        () {
      const smallestSupportedValue = -32768;
      const expectedResult = '0x0080';

      expect(CodecI16().encodeToHex(smallestSupportedValue), expectedResult);
    });

    test(
        "Given an 16 bit decoder when value is negative and can't be represented it should throw",
        () {
      const value = -32769;

      expect(
        () => CodecI16().encodeToHex(value),
        throwsA(isA<InvalidSizeException>()),
      );
    });

    test(
        "Given an 16 bit decoder when value is positive and can't be represented it should throw",
        () {
      const value = 32768;

      expect(
        () => CodecI16().encodeToHex(value),
        throwsA(isA<InvalidSizeException>()),
      );
    });
  });

  group('decode signed 16-bit from hex', () {
    test('Given an encoded string when it represents zero it should be decoded',
        () {
      const value = '0x0000';
      const expectedResult = 0;

      expect(CodecI16().decodeFromHex(value), expectedResult);
    });

    test(
        'Given an encoded string when it represents the largest supported value it should be decoded',
        () {
      const largestSupportedValue = '0xff7f';
      const expectedResult = 32767;

      expect(CodecI16().decodeFromHex(largestSupportedValue), expectedResult);
    });

    test(
        'Given an encoded string when it represents the smallest supported value it should be decoded',
        () {
      const smallestSupportedValue = '0x0080';
      const expectedResult = -32768;

      expect(CodecI16().decodeFromHex(smallestSupportedValue), expectedResult);
    });

    test(
        "Given an encoded string when it represents a integer that don't fit 16 bits it should throw",
        () {
      const value = '0xffff7fff';

      expect(
        () => CodecI16().decodeFromHex(value),
        throwsA(isA<Exception>()),
      );
    });
  });
}
