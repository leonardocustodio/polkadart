import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('I64 Decode Test:', () {
    test('Lowest value decoding', () {
      final input = Input.fromHex('0x0000000000000080');
      final decoded = I64Codec.codec.decode(input);
      expect(decoded, BigInt.parse('-9223372036854775808'));
      expect(input.remainingLength, 0);
    });

    test('Highest value decoding', () {
      final input = Input.fromHex('0xffffffffffffff7f');
      final decoded = I64Codec.codec.decode(input);
      expect(decoded, BigInt.parse('9223372036854775807'));
      expect(input.remainingLength, 0);
    });
  });

  group('I64 Encode Test:', () {
    test('Lowest value encoding', () {
      final output = HexOutput();
      I64Codec.codec.encodeTo(BigInt.parse('-9223372036854775808'), output);
      expect(output.toString(), '0x0000000000000080');
    });

    test('Highest value encoding', () {
      final output = HexOutput();
      I64Codec.codec.encodeTo(BigInt.parse('9223372036854775807'), output);
      expect(output.toString(), '0xffffffffffffff7f');
    });
  });
}
