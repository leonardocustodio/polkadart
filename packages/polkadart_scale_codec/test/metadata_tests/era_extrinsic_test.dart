import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('EraExtrinsic Decode', () {
    test('should work', () {
      final input = HexInput('0xd501');
      final codec = EraExtrinsic.instance;
      final result = codec.decode(input);

      expect(result, <String, int>{
        'period': 64,
        'phase': 29,
      });
    });
  });
}
