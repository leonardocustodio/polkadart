import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('encode compact integers to hex', () {
    test('Should return correct encoded data when value is zero', () {
      final value = 0.toBigInt;
      const expectedResult = '0x00';

      expect(CodecCompact().encodeToHex(value), expectedResult);
    });

    test(
        'Given a positive integer when value is between 0-63 it should be encoded',
        () {
      final value = 42.toBigInt;
      const expectedResult = '0xa8';

      expect(CodecCompact().encodeToHex(value), expectedResult);
    });

    test(
        'Given a positive integer when value is between 64-16383 it should be encoded',
        () {
      final value = 69.toBigInt;
      const expectedResult = '0x1501';

      expect(CodecCompact().encodeToHex(value), expectedResult);
    });

    test(
        'Given a positive integer when value is between 16384-1073741823 it should be encoded',
        () {
      final value = 16384.toBigInt;
      const expectedResult = '0x02000100';

      expect(CodecCompact().encodeToHex(value), expectedResult);
    });

    test(
        'Given a positive integer when value is between 1073741824-(2**536 - 1) it should be encoded',
        () {
      final value = 1073741824.toBigInt;
      const expectedResult = '0x0300000040';

      expect(CodecCompact().encodeToHex(value), expectedResult);
    });

    test('Given a negative value it should throw', () {
      final value = (-1).toBigInt;

      expect(() => CodecCompact().encodeToHex(value),
          throwsA(isA<IncompatibleCompactException>()));
    });

    test(
        "Given a compact encoder when value is positive and can't be represented it should throw",
        () {
      final value =
          '224945689727159819140526925384299092943484855915095831655037778630591879033574393515952034305194542857496045531676044756160413302774714984450425759043258192756735'
              .toBigInt;

      expect(() => CodecCompact().encodeToHex(value),
          throwsA(isA<IncompatibleCompactException>()));
    });
  });

  group('decode compact integers from hex', () {
    test('Given an encoded string when it represents zero it should be decoded',
        () {
      const value = '0x00';
      final expectedResult = 0.toBigInt;

      expect(CodecCompact().decodeFromHex(value), expectedResult);
    });

    test(
        'Given an encoded string when it represents a positive integer it should be decoded',
        () {
      const value = '0xfeff0300';
      final expectedResult = 65535.toBigInt;

      expect(CodecCompact().decodeFromHex(value), expectedResult);
    });

    test(
        'Given an encoded string when it represents a positive big integer it should be decoded',
        () {
      const value = '0x0b00407a10f35a';
      final expectedResult = 100000000000000.toBigInt;

      expect(CodecCompact().decodeFromHex(value), expectedResult);
    });

    test(
        "Given an invalid encoded when it don't fit valid bytes it should throw",
        () {
      final value = '0xff';

      expect(() => CodecCompact().decodeFromHex(value),
          throwsA(isA<EOFException>()));
    });
  });
}
