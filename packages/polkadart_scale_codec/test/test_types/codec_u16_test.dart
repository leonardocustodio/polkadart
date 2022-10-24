import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('encode unsigned 16-bit to hex', () {
    test(
        'Given a positive integer when it is within range it should be encoded',
        () {
      const value = 42;
      const expectedResult = '0x2a00';

      expect(CodecU16().encodeToHex(value), expectedResult);
    });

    test('Should return correct encoded data when value is zero', () {
      const value = 0;
      const expectedResult = '0x0000';

      expect(CodecU16().encodeToHex(value), expectedResult);
    });

    test(
        'Should return correct encoded data when value fits 16 bits and is positive',
        () {
      const largestSupportedValue = 65535;
      const expectedResult = '0xffff';

      expect(CodecU16().encodeToHex(largestSupportedValue), expectedResult);
    });

    test('Should throw InvalidSizeException when value is negative', () {
      const value = -1;

      expect(
        () => CodecU16().encodeToHex(value),
        throwsA(isA<InvalidSizeException>()),
      );
    });

    test(
        "Given an 16 bit decoder when value is positive and can't be represented it should throw",
        () {
      const value = 65536;

      expect(
        () => CodecU16().encodeToHex(value),
        throwsA(isA<InvalidSizeException>()),
      );
    });
  });

  group('decode unsigned 16-bit integers', () {
    test('Given an encoded string when it represents zero it should be decoded',
        () {
      const value = '0x0000';
      const expectedResult = 0;

      expect(CodecU16().decodeFromHex(value), expectedResult);
    });

    test(
        'Given an encoded string when it represents the largest supported value it should be decoded',
        () {
      const largestSupportedValue = '0xffff';
      const expectedResult = 65535;

      expect(CodecU16().decodeFromHex(largestSupportedValue), expectedResult);
    });

    test(
        "Given an encoded string when it represents a integer larger than 16 bits it should throw",
        () {
      const value = '0xff7fff';

      expect(
        () => CodecU16().decodeFromHex(value),
        throwsA(isA<UnprocessedDataLeftException>()),
      );
    });

    test(
        "Given an encoded string when it represents a integer that don't fit 16 bits it should throw",
        () {
      const value = '0xff';

      expect(
        () => CodecU16().decodeFromHex(value),
        throwsA(isA<EOFException>()),
      );
    });
  });
}
