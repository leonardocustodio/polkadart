import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('I8 Decode Test:', () {
    test('Lowest value decoding', () {
      final input = Input.fromHex('0x80');
      final decoded = I8Codec.codec.decode(input);
      expect(decoded, -128);
      expect(input.remainingLength, 0);
    });

    test('Highest value decoding', () {
      final input = Input.fromHex('0x7f');
      final decoded = I8Codec.codec.decode(input);
      expect(decoded, 127);
      expect(input.remainingLength, 0);
    });
  });

  group('I8 Encode Test:', () {
    test('Lowest value encoding', () {
      final output = HexOutput();
      I8Codec.codec.encodeTo(-128, output);
      expect(output.toString(), '0x80');
    });

    test('Highest value encoding', () {
      final output = HexOutput();
      I8Codec.codec.encodeTo(127, output);
      expect(output.toString(), '0x7f');
    });
  });
}
