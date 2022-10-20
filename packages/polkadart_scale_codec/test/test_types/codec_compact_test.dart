import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('encode compact integers to hex', () {
    test('Should return correct encoded data when value is zero', () {
      const value = 0;
      const expectedResult = '0x00';

      expect(CodecCompact<int>().encodeToHex(value), expectedResult);
    });

    test(
        'Given a positive integer when value is between 0-63 it should be encoded',
        () {
      const value = 42;
      const expectedResult = '0xa8';

      expect(CodecCompact<int>().encodeToHex(value), expectedResult);
    });

    test(
        'Given a positive integer when value is between 64-16383 it should be encoded',
        () {
      const value = 69;
      const expectedResult = '0x1501';

      expect(CodecCompact<int>().encodeToHex(value), expectedResult);
    });

    test(
        'Given a positive integer when value is between 16384-1073741823 it should be encoded',
        () {
      const value = 16384;
      const expectedResult = '0x02000100';

      expect(CodecCompact<int>().encodeToHex(value), expectedResult);
    });

    test(
        'Given a positive integer when value is between 1073741824-(2**536 - 1) it should be encoded',
        () {
      const value = 1073741824;
      const expectedResult = '0x0300000040';

      expect(CodecCompact<int>().encodeToHex(value), expectedResult);
    });

    test('Given a positive big integer it should be encoded', () {
      final value = 1073741824.toBigInt;
      const expectedResult = '0x0300000040';

      expect(CodecCompact<BigInt>().encodeToHex(value), expectedResult);
    });

    test('Given a negative value it should throw', () {
      final value = -1;

      expect(() => CodecCompact<int>().encodeToHex(value),
          throwsA(isA<IncompatibleCompactException>()));
    });

    test(
        "Given a compact encoder when value is positive and can't be represented it should throw",
        () {
      final value =
          '224945689727159819140526925384299092943484855915095831655037778630591879033574393515952034305194542857496045531676044756160413302774714984450425759043258192756735'
              .toBigInt;

      expect(() => CodecCompact<BigInt>().encodeToHex(value),
          throwsA(isA<IncompatibleCompactException>()));
    });

    test(
        "Should throw when CodecCompact<T> type is different than int and BigInt",
        () {
      final value = 'test';

      expect(() => CodecCompact<String>().encodeToHex(value),
          throwsA(isA<UnexpectedTypeException>()));
    });
  });

  group('decode compact integers from hex', () {
    test('Given an encoded string when it represents zero it should be decoded',
        () {
      const value = '0x00';
      const expectedResult = 0;

      expect(CodecCompact<int>().decodeFromHex(value), expectedResult);
    });

    test(
        'Given an encoded string when it represents a positive integer it should be decoded',
        () {
      const value = '0xfeff0300';
      const expectedResult = 65535;

      expect(CodecCompact<int>().decodeFromHex(value), expectedResult);
    });

    test(
        'Given an encoded string when it represents a positive big integer it should be decoded',
        () {
      const value = '0x0b00407a10f35a';
      final expectedResult = 100000000000000.toBigInt;

      expect(CodecCompact<BigInt>().decodeFromHex(value), expectedResult);
    });

    test(
        "Given an invalid encoded when it don't fit valid bytes it should throw",
        () {
      final value = '0xff';

      expect(() => CodecCompact<int>().decodeFromHex(value),
          throwsA(isA<EOFException>()));
    });
  });
}
