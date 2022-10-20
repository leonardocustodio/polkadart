import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('encode unsigned 256-bit to hex', () {
    test(
        'Given a positive integer when it is within range it should be encoded',
        () {
      final value = BigInt.from(16777215);
      const expectedResult =
          '0xffffff0000000000000000000000000000000000000000000000000000000000';

      expect(CodecU256().encodeToHex(value), expectedResult);
    });

    test('Should return correct encoded data when value is zero', () {
      final value = BigInt.from(0);
      const expectedResult =
          '0x0000000000000000000000000000000000000000000000000000000000000000';

      expect(CodecU256().encodeToHex(value), expectedResult);
    });

    test(
        'Should return correct encoded data when value fits 256 bits and is positive',
        () {
      final largestSupportedValue = BigInt.parse(
          '115792089237316195423570985008687907853269984665640564039457584007913129639935');
      const expectedResult =
          '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff';

      expect(CodecU256().encodeToHex(largestSupportedValue), expectedResult);
    });

    test('Should throw InvalidSizeException when value is negative', () {
      final value = BigInt.from(-1);

      expect(
        () => CodecU256().encodeToHex(value),
        throwsA(isA<InvalidSizeException>()),
      );
    });

    test(
        "Given an 256 bit decoder when value is positive and can't be represented it should throw",
        () {
      final value = BigInt.parse(
          '115792089237316195423570985008687907853269984665640564039457584007913129639936');

      expect(
        () => CodecU256().encodeToHex(value),
        throwsA(isA<InvalidSizeException>()),
      );
    });
  });

  group('decode unsigned 256-bit integers', () {
    test('Given an encoded string when it represents zero it should be decoded',
        () {
      const value =
          '0x0000000000000000000000000000000000000000000000000000000000000000';
      final expectedResult = 0.toBigInt;

      expect(CodecU256().decodeFromHex(value), expectedResult);
    });

    test(
        'Given an encoded string when it represents the largest supported value it should be decoded',
        () {
      const largestSupportedValue =
          '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f';
      final expectedResult =
          '57896044618658097711785492504343953926634992332820282019728792003956564819967'
              .toBigInt;

      expect(CodecU256().decodeFromHex(largestSupportedValue), expectedResult);
    });

    test(
        "Given an encoded string when it represents a integer larger than 256 bits it should throw",
        () {
      const value =
          '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7fff';

      expect(
        () => CodecU256().decodeFromHex(value),
        throwsA(isA<Exception>()),
      );
    });

    test(
        "Given an encoded string when it represents a integer smaller than 256 bits it should throw",
        () {
      const value = '0xffff';

      expect(
        () => CodecU256().decodeFromHex(value),
        throwsA(isA<Exception>()),
      );
    });
  });
}
