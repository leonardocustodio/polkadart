import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('encode unsigned 32-bit to hex', () {
    test(
        'Given a positive integer when it is within range it should be encoded',
        () {
      const value = 16777215;
      const expectedResult = '0xffffff00';

      expect(CodecU32().encodeToHex(value), expectedResult);
    });

    test('Should return correct encoded data when value is zero', () {
      const value = 0;
      const expectedResult = '0x00000000';

      expect(CodecU32().encodeToHex(value), expectedResult);
    });

    test(
        'Should return correct encoded data when value fits 32 bits and is positive',
        () {
      const largestSupportedValue = 4294967295;
      const expectedResult = '0xffffffff';

      expect(CodecU32().encodeToHex(largestSupportedValue), expectedResult);
    });

    test('Should throw InvalidSizeException when value is negative', () {
      const value = -1;

      expect(
        () => CodecU32().encodeToHex(value),
        throwsA(isA<InvalidSizeException>()),
      );
    });

    test(
        "Given an 32 bit decoder when value is positive and can't be represented it should throw",
        () {
      const value = 4294967296;

      expect(
        () => CodecU32().encodeToHex(value),
        throwsA(isA<InvalidSizeException>()),
      );
    });
  });

  group('decode unsigned 32-bit integers', () {
    test('Given an encoded string when it represents zero it should be decoded',
        () {
      const value = '0x00000000';
      const expectedResult = 0;

      expect(CodecU32().decodeFromHex(value), expectedResult);
    });

    test(
        'Given an encoded string when it represents the largest supported value it should be decoded',
        () {
      const largestSupportedValue = '0xffffffff';
      const expectedResult = 4294967295;

      expect(CodecU32().decodeFromHex(largestSupportedValue), expectedResult);
    });

    test(
        "Given an encoded string when it represents a integer larger than 32 bits it should throw",
        () {
      const value = '0xffffffffffff';

      expect(
        () => CodecU32().decodeFromHex(value),
        throwsA(isA<UnprocessedDataLeftException>()),
      );
    });

    test(
        "Given an encoded string when it represents a integer smaller than 32 bits it should throw",
        () {
      const value = '0xffff';

      expect(
        () => CodecU32().decodeFromHex(value),
        throwsA(isA<EOFException>()),
      );
    });
  });
}
