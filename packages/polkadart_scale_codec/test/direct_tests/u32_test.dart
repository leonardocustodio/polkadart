import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('U32 Decode Test:', () {
    test('Lowest value decoding', () {
      final input = Input.fromHex('0x00000000');
      final decoded = U32Codec.codec.decode(input);
      expect(decoded, 0);
      expect(input.remainingLength, 0);
    });

    test('Highest value decoding', () {
      final input = Input.fromHex('0xffffffff');
      final decoded = U32Codec.codec.decode(input);
      expect(decoded, 4294967295);
      expect(input.remainingLength, 0);
    });
  });

  group('U32 Encode Test:', () {
    test('Lowest value encoding', () {
      final output = HexOutput();
      U32Codec.codec.encodeTo(0, output);
      expect(output.toString(), '0x00000000');
    });

    test('Highest value encoding', () {
      final output = HexOutput();
      U32Codec.codec.encodeTo(4294967295, output);
      expect(output.toString(), '0xffffffff');
    });
  });
}
