import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('U256 Decode Test:', () {
    test('Lowest value decoding', () {
      final input = Input.fromHex(
          '0x0000000000000000000000000000000000000000000000000000000000000000');
      final decoded = U256Codec.codec.decode(input);
      expect(decoded, BigInt.zero);
      expect(input.remainingLength, 0);
    });

    test('Highest value decoding', () {
      final input = Input.fromHex(
          '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff');
      final decoded = U256Codec.codec.decode(input);
      expect(
          decoded,
          BigInt.parse(
              '115792089237316195423570985008687907853269984665640564039457584007913129639935'));
      expect(input.remainingLength, 0);
    });
  });

  group('U256 Encode Test:', () {
    test('Lowest value encoding', () {
      final output = HexOutput();
      U256Codec.codec.encodeTo(BigInt.zero, output);
      expect(output.toString(),
          '0x0000000000000000000000000000000000000000000000000000000000000000');
    });

    test('Highest value encoding', () {
      final output = HexOutput();
      U256Codec.codec.encodeTo(
          BigInt.parse(
              '115792089237316195423570985008687907853269984665640564039457584007913129639935'),
          output);
      expect(output.toString(),
          '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff');
    });
  });
}
