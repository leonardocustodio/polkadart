import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('U128 Decode Test:', () {
    test('Lowest value decoding', () {
      final input = Input.fromHex('0x00000000000000000000000000000000');
      final decoded = U128Codec.codec.decode(input);
      expect(decoded, BigInt.zero);
      expect(input.remainingLength, 0);
    });

    test('Highest value decoding', () {
      final input = Input.fromHex('0xffffffffffffffffffffffffffffffff');
      final decoded = U128Codec.codec.decode(input);
      expect(decoded, BigInt.parse('340282366920938463463374607431768211455'));
      expect(input.remainingLength, 0);
    });
  });

  group('U128 Encode Test:', () {
    test('Lowest value encoding', () {
      final output = HexOutput();
      U128Codec.codec.encodeTo(BigInt.zero, output);
      expect(output.toString(), '0x00000000000000000000000000000000');
    });

    test('Highest value encoding', () {
      final output = HexOutput();
      U128Codec.codec.encodeTo(
          BigInt.parse('340282366920938463463374607431768211455'), output);
      expect(output.toString(), '0xffffffffffffffffffffffffffffffff');
    });
  });
}
