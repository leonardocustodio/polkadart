import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  // Test with Registry
  group('ArrayCodec Encode Test:', () {
    final registry = Registry()
      ..registerCustomCodec(<String, dynamic>{
        'A': '[(U8, bool); 4]',
        'C': '[U8; 2]',
        'B': '[U8; 4]',
        'D': '[C; 2]'
      });

    test(
        'When value [[0, true], [1, false], [2, true], [3, false]] is encoded then it returns 0x0001010002010300',
        () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo(
          'A',
          [
            [0, true],
            [1, false],
            [2, true],
            [3, false]
          ],
          output);
      expect(output.toString(), '0x0001010002010300');
    });
    test('When value [1, 2, 3, 4] is encoded then it returns 0x01020304', () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('B', [1, 2, 3, 4], output);
      expect(output.toString(), '0x01020304');
    });
    test('When value [[1, 2], [3, 4]] is encoded then it returns 0x01020304',
        () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo(
          'D',
          [
            [1, 2],
            [3, 4]
          ],
          output);
      expect(output.toString(), '0x01020304');
    });
    test('When value [5, 6, 7, 8] is encoded then it returns 0x05060708', () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('B', [5, 6, 7, 8], output);
      expect(output.toString(), '0x05060708');
    });
  });

  group('ArrayCodec Decode Test:', () {
    final registry = Registry()
      ..registerCustomCodec(<String, dynamic>{
        'A': '[(U8, bool); 4]',
        'B': '[U8; 4]',
        'C': '[U8; 2]',
        'D': '[C; 2]'
      });

    test(
        'When value 0x0001010002010300 is decoded then it returns [[0, true], [1, false], [2, true], [3, false]]',
        () {
      final input = Input.fromHex('0x0001010002010300');
      final codec = ScaleCodec(registry);
      final decoded = codec.decode('A', input);
      expect(decoded, [
        [0, true],
        [1, false],
        [2, true],
        [3, false]
      ]);
    });
    test('When value 0x01020304 is decoded then it returns [1, 2, 3, 4]', () {
      final input = Input.fromHex('0x01020304');
      final codec = ScaleCodec(registry);
      final decoded = codec.decode('B', input);
      expect(decoded, [1, 2, 3, 4]);
    });
    test('When value 0x01020304 is decoded then it returns [[1, 2], [3, 4]]',
        () {
      final input = Input.fromHex('0x01020304');
      final codec = ScaleCodec(registry);
      final decoded = codec.decode('D', input);
      expect(decoded, [
        [1, 2],
        [3, 4]
      ]);
    });
    test('When value 0x05060708 is decoded then it returns [5, 6, 7, 8]', () {
      final input = Input.fromHex('0x05060708');
      final codec = ScaleCodec(registry);
      final decoded = codec.decode('B', input);
      expect(decoded, [5, 6, 7, 8]);
    });
  });
}
