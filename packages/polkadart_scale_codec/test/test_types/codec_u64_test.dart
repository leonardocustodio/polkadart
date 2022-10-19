import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('encode unsigned 64-bit to hex', () {
    test(
        'Given a positive integer when it is within range it should be encoded',
        () {
      final value = BigInt.from(16777215);
      const expectedResult = '0xffffff0000000000';

      expect(CodecU64().encodeToHex(value), expectedResult);
    });

    test('Should return correct encoded data when value is zero', () {
      final value = BigInt.from(0);
      const expectedResult = '0x0000000000000000';

      expect(CodecU64().encodeToHex(value), expectedResult);
    });

    test(
        'Should return correct encoded data when value fits 64 bits and is positive',
        () {
      final largestSupportedValue = BigInt.parse('18446744073709551615');
      const expectedResult = '0xffffffffffffffff';

      expect(CodecU64().encodeToHex(largestSupportedValue), expectedResult);
    });

    test('Should throw InvalidSizeException when value is negative', () {
      final value = BigInt.from(-1);

      expect(
        () => CodecU64().encodeToHex(value),
        throwsA(isA<InvalidSizeException>()),
      );
    });

    test(
        "Given an 64 bit decoder when value is positive and can't be represented it should throw",
        () {
      final value = BigInt.parse('18446744073709551616');

      expect(
        () => CodecU64().encodeToHex(value),
        throwsA(isA<InvalidSizeException>()),
      );
    });
  });
}
