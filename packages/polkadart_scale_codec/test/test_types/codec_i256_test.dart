import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('encode signed 256-bit to hex', () {
    test('Should return correct encoded data when value is zero', () {
      final value = 0.toBigInt;
      const expectedResult =
          '0x0000000000000000000000000000000000000000000000000000000000000000';

      expect(CodecI256().encodeToHex(value), expectedResult);
    });

    test(
        'Should return correct encoded data when value fits 256 bits and is positive',
        () {
      final largestSupportedValue = BigInt.parse(
          '57896044618658097711785492504343953926634992332820282019728792003956564819967');
      const expectedResult =
          '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f';

      expect(CodecI256().encodeToHex(largestSupportedValue), expectedResult);
    });

    test(
        'Should return correct encoded data when value fits 256 bits and is negative',
        () {
      final smallestSupportedValue = BigInt.parse(
          '-57896044618658097711785492504343953926634992332820282019728792003956564819968');
      const expectedResult =
          '0x0000000000000000000000000000000000000000000000000000000000000080';

      expect(CodecI256().encodeToHex(smallestSupportedValue), expectedResult);
    });

    test(
        "Given an 256 bit decoder when value is negative and can't be represented it should throw",
        () {
      final value = BigInt.parse(
          '-57896044618658097711785492504343953926634992332820282019728792003956564819969');

      expect(
        () => CodecI256().encodeToHex(value),
        throwsA(isA<InvalidSizeException>()),
      );
    });

    test(
        "Given an 256 bit decoder when value is positive and can't be represented it should throw",
        () {
      final value = BigInt.parse(
          '57896044618658097711785492504343953926634992332820282019728792003956564819968');

      expect(
        () => CodecI256().encodeToHex(value),
        throwsA(isA<InvalidSizeException>()),
      );
    });
  });

  group('decode signed 256-bit from hex', () {
    test('Given an encoded string when it represents zero it should be decoded',
        () {
      const value =
          '0x0000000000000000000000000000000000000000000000000000000000000000';
      final expectedResult = 0.toBigInt;

      expect(CodecI256().decodeFromHex(value), expectedResult);
    });

    test(
        'Given an encoded string when it represents the largest supported value it should be decoded',
        () {
      const largestSupportedValue =
          '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f';
      final expectedResult = BigInt.parse(
          '57896044618658097711785492504343953926634992332820282019728792003956564819967');

      expect(CodecI256().decodeFromHex(largestSupportedValue), expectedResult);
    });

    test(
        'Given an encoded string when it represents the smallest supported value it should be decoded',
        () {
      const smallestSupportedValue =
          '0x0000000000000000000000000000000000000000000000000000000000000080';
      final expectedResult = BigInt.parse(
          '-57896044618658097711785492504343953926634992332820282019728792003956564819968');

      expect(CodecI256().decodeFromHex(smallestSupportedValue), expectedResult);
    });

    test(
        "Given an encoded string when it represents a integer that don't fit 256 bits it should throw",
        () {
      const value = '0xffffff';

      expect(
        () => CodecI256().decodeFromHex(value),
        throwsA(isA<Exception>()),
      );
    });
  });
}
