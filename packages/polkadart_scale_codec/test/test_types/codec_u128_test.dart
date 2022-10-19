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
}
