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

    test('Should return correct encoded data when value is 255', () {
      const value = 255;
      const expectedResult = '0xff';

      expect(CodecU8().encodeToHex(value), expectedResult);
    });

    test('Should throw InvalidSizeException when value is smaller than zero',
        () {
      const value = -1;

      expect(
        () => CodecU8().encodeToHex(value),
        throwsA(isA<InvalidSizeException>()),
      );
    });

    test('Should throw InvalidSizeException when value is greater than 256',
        () {
      const value = 256;

      expect(
        () => CodecU8().encodeToHex(value),
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