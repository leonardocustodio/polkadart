import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('U64 Decode Test:', () {
    test('Lowest value decoding', () {
      final input = Input.fromHex('0x0000000000000000');
      final decoded = U64Codec.codec.decode(input);
      expect(decoded, BigInt.parse('0'));
      expect(input.remainingLength, 0);
    });

    test('Highest value decoding', () {
      final input = Input.fromHex('0xffffffffffffffff');
      final decoded = U64Codec.codec.decode(input);
      expect(decoded, BigInt.parse('18446744073709551615'));
      expect(input.remainingLength, 0);
    });
  });

  group('U64 Encode Test:', () {
    test('Lowest value encoding', () {
      final output = HexOutput();
      U64Codec.codec.encodeTo(BigInt.parse('0'), output);
      expect(output.toString(), '0x0000000000000000');
    });

    test('Highest value encoding', () {
      final output = HexOutput();
      U64Codec.codec.encodeTo(BigInt.parse('18446744073709551615'), output);
      expect(output.toString(), '0xffffffffffffffff');
    });
  });
}
