import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('U16 Decode Test:', () {
    test('Lowest value decoding', () {
      final input = Input.fromHex('0x0000');
      final decoded = U16Codec.codec.decode(input);
      expect(decoded, 0);
      expect(input.remainingLength, 0);
    });

    test('Highest value decoding', () {
      final input = Input.fromHex('0xffff');
      final decoded = U16Codec.codec.decode(input);
      expect(decoded, 65535);
      expect(input.remainingLength, 0);
    });
  });

  group('U16 Encode Test:', () {
    test('Lowest value encoding', () {
      final output = HexOutput();
      U16Codec.codec.encodeTo(0, output);
      expect(output.toString(), '0x0000');
    });

    test('Highest value encoding', () {
      final output = HexOutput();
      U16Codec.codec.encodeTo(65535, output);
      expect(output.toString(), '0xffff');
    });
  });
}
