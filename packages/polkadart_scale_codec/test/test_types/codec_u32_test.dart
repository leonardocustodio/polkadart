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

    test('Should throw InvalidSizeException when value is smaller than zero',
        () {
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

    test('Should throw UnexpectedTypeException when value is null', () {
      int? value;

      expect(
        () => CodecU32().encodeToHex(value),
        throwsA(isA<UnexpectedTypeException>()),
      );
    });

    test('Should throw UnexpectedTypeException when value is a BigInt', () {
      final value = 5.toBigInt;

      expect(
        () => CodecU32().encodeToHex(value),
        throwsA(isA<UnexpectedTypeException>()),
      );
    });

    test('Should throw UnexpectedTypeException when value is not an Integer',
        () {
      const value = '5';

      expect(
        () => CodecU32().encodeToHex(value),
        throwsA(isA<UnexpectedTypeException>()),
      );
    });
  });
}
