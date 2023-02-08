import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('U32 Decode Test:', () {
    test('Lowest value decoding', () {
      final input = HexInput('0x00000000');
      final decoded = U32Codec.instance.decode(input);
      expect(decoded, 0);
      expect(input.remainingLength, 0);
    });

    test('Highest value decoding', () {
      final input = HexInput('0xffffffff');
      final decoded = U32Codec.instance.decode(input);
      expect(decoded, 4294967295);
      expect(input.remainingLength, 0);
    });
  });

  group('U32 Encode Test:', () {
    test('Lowest value encoding', () {
      final output = HexOutput();
      U32Codec.instance.encodeTo(0, output);
      expect(output.toString(), '0x00000000');
    });

    test('Highest value encoding', () {
      final output = HexOutput();
      U32Codec.instance.encodeTo(4294967295, output);
      expect(output.toString(), '0xffffffff');
    });
  });
}
