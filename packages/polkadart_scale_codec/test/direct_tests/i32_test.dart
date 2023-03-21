import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('I32 Decode Test:', () {
    test('Lowest value decoding', () {
      final input = Input.fromHex('0x00000080');
      final decoded = I32Codec.codec.decode(input);
      expect(decoded, -2147483648);
      expect(input.remainingLength, 0);
    });

    test('Highest value decoding', () {
      final input = Input.fromHex('0xffffff7f');
      final decoded = I32Codec.codec.decode(input);
      expect(decoded, 2147483647);
      expect(input.remainingLength, 0);
    });
  });

  group('I32 Encode Test:', () {
    test('Lowest value encoding', () {
      final output = HexOutput();
      I32Codec.codec.encodeTo(-2147483648, output);
      expect(output.toString(), '0x00000080');
    });

    test('Highest value encoding', () {
      final output = HexOutput();
      I32Codec.codec.encodeTo(2147483647, output);
      expect(output.toString(), '0xffffff7f');
    });
  });
}
