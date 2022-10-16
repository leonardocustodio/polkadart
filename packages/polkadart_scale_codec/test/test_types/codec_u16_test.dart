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

    test('Should throw InvalidSizeException when value is smaller than zero',
        () {
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

    test('Should throw UnexpectedTypeException when value is null', () {
      int? value;

      expect(
        () => CodecU8().encodeToHex(value),
        throwsA(isA<UnexpectedTypeException>()),
      );
    });

    test('Should throw UnexpectedTypeException when value is a BigInt', () {
      final value = 5.toBigInt;

      expect(
        () => CodecU8().encodeToHex(value),
        throwsA(isA<UnexpectedTypeException>()),
      );
    });

    test('Should throw UnexpectedTypeException when value is not an Integer',
        () {
      const value = '5';

      expect(
        () => CodecU8().encodeToHex(value),
        throwsA(isA<UnexpectedTypeException>()),
      );
    });
  });
}
