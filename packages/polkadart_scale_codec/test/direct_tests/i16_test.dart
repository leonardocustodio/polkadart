import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('I16 Decode Test:', () {
    test('Lowest value decoding', () {
      final input = Input.fromHex('0x0080');
      final decoded = I16Codec.codec.decode(input);
      expect(decoded, -32768);
      expect(input.remainingLength, 0);
    });

    test('Highest value decoding', () {
      final input = Input.fromHex('0xff7f');
      final decoded = I16Codec.codec.decode(input);
      expect(decoded, 32767);
      expect(input.remainingLength, 0);
    });
  });

  group('I16 Encode Test:', () {
    test('Lowest value encoding', () {
      final output = HexOutput();
      I16Codec.codec.encodeTo(-32768, output);
      expect(output.toString(), '0x0080');
    });

    test('Highest value encoding', () {
      final output = HexOutput();
      I16Codec.codec.encodeTo(32767, output);
      expect(output.toString(), '0xff7f');
    });
  });
}
