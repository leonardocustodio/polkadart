import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  // Tests using Registry
  group('Sequence Codec Encode Tests', () {
    final registry = Registry()
      ..registerCustomCodec(
        <String, dynamic>{
          '2DVector': 'Vec<1DVector>',
          '1DVector': 'Vec<B>',
          'B': 'C',
          'C': 'U8',
        },
      );

    test('Encode 2DVector', () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo(
          '2DVector',
          [
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9]
          ],
          output);

      expect(output.toString(), '0x0c0c0102030c0405060c070809');
    });

    test('Encode 1DVector', () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('1DVector', [1, 2, 3], output);

      expect(output.toString(), '0x0c010203');
    });

    test('Encode B which is C and which further resolves to u8.', () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('B', 1, output);

      expect(output.toString(), '0x01');
    });

    test('Encode C which is u8', () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('C', 1, output);

      expect(output.toString(), '0x01');
    });
  });

  group('Sequence Codec Decode Tests', () {
    final registry = Registry()
      ..registerCustomCodec(<String, dynamic>{
        '2DVector': 'Vec<1DVector>',
        '1DVector': 'Vec<B>',
        'B': 'C',
        'C': 'U8',
      });

    test('Decode 2DVector', () {
      final input = Input.fromHex('0x0c0c0102030c0405060c070809');
      final codec = ScaleCodec(registry);
      expect(codec.decode('2DVector', input), [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
      ]);
      expect(input.remainingLength, 0);
    });

    test('Decode 1DVector', () {
      final input = Input.fromHex('0x0c010203');
      final codec = ScaleCodec(registry);
      expect(codec.decode('1DVector', input), [1, 2, 3]);
      expect(input.remainingLength, 0);
    });

    test('Decode B which is C and which further resolves to u8.', () {
      final input = Input.fromHex('0x01');
      final codec = ScaleCodec(registry);
      expect(codec.decode('B', input), 1);
      expect(input.remainingLength, 0);
    });

    test('Decode C which is u8', () {
      final input = Input.fromHex('0x01');
      final codec = ScaleCodec(registry);
      expect(codec.decode('C', input), 1);
      expect(input.remainingLength, 0);
    });
  });
}
