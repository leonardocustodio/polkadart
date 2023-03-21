import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('U8 Decode Test:', () {
    test('Lowest value decoding', () {
      final input = Input.fromHex('0x00');
      final decoded = U8Codec.codec.decode(input);
      expect(decoded, 0);
      expect(input.remainingLength, 0);
    });

    test('Highest value decoding', () {
      final input = Input.fromHex('0xff');
      final decoded = U8Codec.codec.decode(input);
      expect(decoded, 255);
      expect(input.remainingLength, 0);
    });
  });

  group('U8 Encode Test:', () {
    test('Lowest value encoding', () {
      final output = HexOutput();
      U8Codec.codec.encodeTo(0, output);
      expect(output.toString(), '0x00');
    });

    test('Highest value encoding', () {
      final output = HexOutput();
      U8Codec.codec.encodeTo(255, output);
      expect(output.toString(), '0xff');
    });
  });
}
