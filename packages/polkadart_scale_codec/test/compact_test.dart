import 'dart:typed_data';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  test('Compact enconding works', () {
    final List<int> values = [
      0,
      63,
      64,
      16383,
      16384,
      1073741823,
      1073741824,
      (1 << 32) - 1,
      1 << 32,
      1 << 40,
      1 << 48,
      (1 << 56) - 1,
      1 << 56,
    ];
    final List<int> outputs = [1, 1, 2, 2, 4, 4, 5, 5, 6, 7, 8, 8, 9];

    expect(values.length, outputs.length);
    for (var i = 0; i < values.length; i++) {
      // Test size hint
      expect(outputs[i], CompactCodec.instance.sizeHint(values[i]));

      // Test encoding
      final encoded = CompactCodec.instance.encode(values[i]);
      expect(outputs[i], encoded.lengthInBytes);

      // Test decoding
      final input = Uint8ListInput(encoded);
      expect(values[i], CompactCodec.instance.decode(input));
    }
  });

  test('Compact decoding works', () {
    final List<Uint8List> inputs = [
      [0x00],
      [0xfc],
      [0x01, 0x01],
      [0xfd, 0xff],
      [0x02, 0x00, 0x01, 0x00],
      [0xfe, 0xff, 0xff, 0xff],
      [0x03, 0x00, 0x00, 0x00, 0x40],
      [0x03, 0xff, 0xff, 0xff, 0xff],
      [0x07, 0x00, 0x00, 0x00, 0x00, 0x01],
      [0x0b, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01],
      [0x0f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01],
      [0x0f, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff],
      [0x13, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01],
    ].map((e) => Uint8List.fromList(e)).toList();
    final List<int> outputs = [
      0,
      63,
      64,
      16383,
      16384,
      1073741823,
      1073741824,
      (1 << 32) - 1,
      1 << 32,
      1 << 40,
      1 << 48,
      (1 << 56) - 1,
      1 << 56,
    ];

    expect(inputs.length, outputs.length);
    for (var i = 0; i < inputs.length; i++) {
      final decoded = CompactCodec.instance.decode(Uint8ListInput(inputs[i]));
      expect(outputs[i], decoded);
    }
  });
}
