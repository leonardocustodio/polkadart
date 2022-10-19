import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('encode unsigned 8-bit to hex', () {
    test(
        'Given a positive integer when it is within range it should be encoded',
        () {
      const value = 69;
      const expectedResult = '0x45';

      expect(CodecU8().encodeToHex(value), expectedResult);
    });

    test('Should return correct encoded data when value is zero', () {
      const value = 0;
      const expectedResult = '0x00';

      expect(CodecU8().encodeToHex(value), expectedResult);
    });

    test(
        'Should return correct encoded data when value fits 8 bits and is positive',
        () {
      const largestSupportedValue = 255;
      const expectedResult = '0xff';

      expect(CodecU8().encodeToHex(largestSupportedValue), expectedResult);
    });

    test('Should throw InvalidSizeException when value is negative', () {
      const value = -1;

      expect(
        () => CodecU8().encodeToHex(value),
        throwsA(isA<InvalidSizeException>()),
      );
    });

    test(
        "Given an 8 bit decoder when value is positive and can't be represented it should throw",
        () {
      const value = 256;

      expect(
        () => CodecU8().encodeToHex(value),
        throwsA(isA<InvalidSizeException>()),
      );
    });
  });

  group('decode unsigned 8-bit integers', () {
    test('Given an encoded string when it represents zero it should be decoded',
        () {
      const value = '0x00';
      const expectedResult = 0;

      expect(CodecU8().decodeFromHex(value), expectedResult);
    });

    test(
        'Given an encoded string when it represents the biggest supported value it should be decoded',
        () {
      const biggestSupportedValue = '0xff';
      const expectedResult = 255;

      expect(CodecU8().decodeFromHex(biggestSupportedValue), expectedResult);
    });

    test(
        "Given an encoded string when it represents a integer that don't fit 8 bits it should throw",
        () {
      const value = '0xff7f';

      expect(
        () => CodecU8().decodeFromHex(value),
        throwsA(isA<Exception>()),
      );
    });
  });
}
