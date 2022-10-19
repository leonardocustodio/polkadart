import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('encode unsigned 128-bit to hex', () {
    test(
        'Given a positive integer when it is within range it should be encoded',
        () {
      final value = BigInt.from(16777215);
      const expectedResult = '0xffffff00000000000000000000000000';

      expect(CodecU128().encodeToHex(value), expectedResult);
    });

    test('Should return correct encoded data when value is zero', () {
      final value = BigInt.from(0);
      const expectedResult = '0x00000000000000000000000000000000';

      expect(CodecU128().encodeToHex(value), expectedResult);
    });

    test(
        'Should return correct encoded data when value fits 128 bits and is positive',
        () {
      final largestSupportedValue =
          BigInt.parse('340282366920938463463374607431768211455');
      const expectedResult = '0xffffffffffffffffffffffffffffffff';

      expect(CodecU128().encodeToHex(largestSupportedValue), expectedResult);
    });

    test('Should throw InvalidSizeException when value is negative', () {
      final value = BigInt.from(-1);

      expect(
        () => CodecU128().encodeToHex(value),
        throwsA(isA<InvalidSizeException>()),
      );
    });

    test(
        "Given an 128 bit decoder when value is positive and can't be represented it should throw",
        () {
      final value = BigInt.parse('340282366920938463463374607431768211456');

      expect(
        () => CodecU128().encodeToHex(value),
        throwsA(isA<InvalidSizeException>()),
      );
    });
  });

  group('decode unsigned 128-bit integers', () {
    test('Given an encoded string when it represents zero it should be decoded',
        () {
      const value = '0x00000000000000000000000000000000';
      final expectedResult = 0.toBigInt;

      expect(CodecU128().decodeFromHex(value), expectedResult);
    });

    test(
        'Given an encoded string when it represents the largest supported value it should be decoded',
        () {
      const largestSupportedValue = '0xffffffffffffffffffffffffffffff7f';
      final expectedResult = '170141183460469231731687303715884105727'.toBigInt;

      expect(CodecU128().decodeFromHex(largestSupportedValue), expectedResult);
    });

    test(
        "Given an encoded string when it represents a integer that don't fit 128 bits it should throw",
        () {
      const value = '0xffff';

      expect(
        () => CodecU128().decodeFromHex(value),
        throwsA(isA<Exception>()),
      );
    });
  });
}
