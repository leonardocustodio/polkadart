import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('I128 Decode Test:', () {
    test('Lowest value decoding', () {
      final input = Input.fromHex('0x00000000000000000000000000000080');
      final decoded = I128Codec.codec.decode(input);
      expect(decoded, BigInt.parse('-170141183460469231731687303715884105728'));
      expect(input.remainingLength, 0);
    });

    test('Highest value decoding', () {
      final input = Input.fromHex('0xffffffffffffffffffffffffffffff7f');
      final decoded = I128Codec.codec.decode(input);
      expect(decoded, BigInt.parse('170141183460469231731687303715884105727'));
      expect(input.remainingLength, 0);
    });
  });

  group('I128 Encode Test:', () {
    test('Lowest value encoding', () {
      final output = HexOutput();
      I128Codec.codec.encodeTo(
          BigInt.parse('-170141183460469231731687303715884105728'), output);
      expect(output.toString(), '0x00000000000000000000000000000080');
    });

    test('Highest value encoding', () {
      final output = HexOutput();
      I128Codec.codec.encodeTo(
          BigInt.parse('170141183460469231731687303715884105727'), output);
      expect(output.toString(), '0xffffffffffffffffffffffffffffff7f');
    });
  });
}
