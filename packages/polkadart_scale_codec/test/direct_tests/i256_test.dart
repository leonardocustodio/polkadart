import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('I256 Decode Test:', () {
    test('Lowest value decoding', () {
      final input = Input.fromHex(
          '0x0000000000000000000000000000000000000000000000000000000000000080');
      final decoded = I256Codec.codec.decode(input);
      expect(
          decoded,
          BigInt.parse(
              '-57896044618658097711785492504343953926634992332820282019728792003956564819968'));
      expect(input.remainingLength, 0);
    });

    test('Highest value decoding', () {
      final input = Input.fromHex(
          '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f');
      final decoded = I256Codec.codec.decode(input);
      expect(
          decoded,
          BigInt.parse(
              '57896044618658097711785492504343953926634992332820282019728792003956564819967'));
      expect(input.remainingLength, 0);
    });
  });

  group('I256 Encode Test:', () {
    test('Lowest value encoding', () {
      final output = HexOutput();
      I256Codec.codec.encodeTo(
          BigInt.parse(
              '-57896044618658097711785492504343953926634992332820282019728792003956564819968'),
          output);
      expect(output.toString(),
          '0x0000000000000000000000000000000000000000000000000000000000000080');
    });

    test('Highest value encoding', () {
      final output = HexOutput();
      I256Codec.codec.encodeTo(
          BigInt.parse(
              '57896044618658097711785492504343953926634992332820282019728792003956564819967'),
          output);
      expect(output.toString(),
          '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f');
    });
  });
}
