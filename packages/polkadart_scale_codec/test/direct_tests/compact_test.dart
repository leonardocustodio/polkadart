import 'dart:typed_data';

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Compact sizeHint:', () {
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

    test('Length of input and output should match', () {
      expect(values.length, outputs.length);
    });

    // Iterating over tests
    for (var i = 0; i < values.length; i++) {
      //
      // Test size hint
      test('Test for size hint at ${values[i]}', () {
        expect(outputs[i], CompactCodec.codec.sizeHint(values[i]));
      });
    }
  });

  group('Compact decoding:', () {
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
    ].map((e) => Uint8List.fromList(e)).toList(growable: false);
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

    test('Length of input and output should match', () {
      expect(inputs.length, outputs.length);
    });
    for (var i = 0; i < inputs.length; i++) {
      test('Testing decoding of ${inputs[i]} at index $i', () {
        final decoded = CompactCodec.codec.decode(ByteInput(inputs[i]));
        expect(outputs[i], decoded);
      });
    }
  });

  group('Compact encoding:', () {
    final List<int> inputs = [
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
    final List<Uint8List> outputs = [
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
    ].map((e) => Uint8List.fromList(e)).toList(growable: false);

    final List<int> sizes = [1, 1, 2, 2, 4, 4, 5, 5, 6, 7, 8, 8, 9];

    test('Length of input and output should match', () {
      expect(inputs.length, outputs.length);
    });

    for (var i = 0; i < inputs.length; i++) {
      test('Testing encoding of ${inputs[i]} at index $i', () {
        final encoded = CompactCodec.codec.encode(inputs[i]);
        expect(outputs[i], encoded);
        expect(sizes[i], encoded.lengthInBytes);
      });
    }
  });
}
