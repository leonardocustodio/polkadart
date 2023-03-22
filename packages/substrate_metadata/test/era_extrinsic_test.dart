import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:substrate_metadata/types/metadata_types.dart';
import 'package:test/test.dart';

void main() {
  group('EraExtrinsic', () {
    test('Decode Test', () {
      final input = Input.fromHex('0xd501');
      final codec = EraExtrinsic.codec;
      final result = codec.decode(input);

      expect(result, <String, int>{
        'period': 64,
        'phase': 29,
      });
    });

    test('Encode Test', () {
      final output = ByteOutput();
      final codec = EraExtrinsic.codec;
      codec.encodeTo(<String, int>{
        'period': 64,
        'phase': 29,
      }, output);

      expect(output.toBytes(), [213, 1]);
    });
  });
}
