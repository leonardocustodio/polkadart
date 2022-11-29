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
}
