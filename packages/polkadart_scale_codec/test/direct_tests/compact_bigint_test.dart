import 'dart:typed_data';

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('CompactBigInt sizeHint:', () {
    final List<BigInt> values = [
      BigInt.zero,
      BigInt.from(63),
      BigInt.from(64),
      BigInt.from(16383),
      BigInt.from(16384),
      BigInt.from(1073741823),
      BigInt.from(1073741824),
      (BigInt.one << 32) - BigInt.one,
      BigInt.one << 32,
      BigInt.one << 40,
      BigInt.one << 48,
      (BigInt.one << 56) - BigInt.one,
      BigInt.one << 56,
      (BigInt.one << 64) - BigInt.one,
      BigInt.one << 64,
      BigInt.one << 72,
      BigInt.one << 80,
      BigInt.one << 88,
      BigInt.one << 96,
      BigInt.one << 104,
      BigInt.one << 112,
      (BigInt.one << 120) - BigInt.one,
      BigInt.one << 120,
      (BigInt.one << 128) - BigInt.one,
    ];
    final List<int> outputs = [
      1,
      1,
      2,
      2,
      4,
      4,
      5,
      5,
      6,
      7,
      8,
      8,
      9,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      16,
      17,
      17,
    ];

    test('Length of input and output should match', () {
      expect(values.length, outputs.length);
    });

    // Iterating over tests
    for (var i = 0; i < values.length; i++) {
      //
      // Test size hint
      test('Test for size hint at ${values[i]}', () {
        expect(outputs[i], CompactBigIntCodec.codec.sizeHint(values[i]));
      });
    }
  });

  group('CompactBigInt decoding:', () {
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
      [0x13, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff],
    ].map((e) => Uint8List.fromList(e)).toList(growable: false);
    final List<BigInt> outputs = [
      BigInt.zero,
      BigInt.from(63),
      BigInt.from(64),
      BigInt.from(16383),
      BigInt.from(16384),
      BigInt.from(1073741823),
      BigInt.from(1073741824),
      (BigInt.one << 32) - BigInt.one,
      BigInt.one << 32,
      BigInt.one << 40,
      BigInt.one << 48,
      (BigInt.one << 56) - BigInt.one,
      BigInt.one << 56,
      (BigInt.one << 64) - BigInt.one,
    ];

    test('Length of input and output should match', () {
      expect(inputs.length, outputs.length);
    });
    for (var i = 0; i < inputs.length; i++) {
      test('Testing decoding of ${inputs[i]} at index $i', () {
        final decoded = CompactBigIntCodec.codec.decode(ByteInput(inputs[i]));
        expect(outputs[i], decoded);
      });
    }
  });

  group('CompactBigInt encoding:', () {
    final List<BigInt> inputs = [
      BigInt.zero,
      BigInt.from(63),
      BigInt.from(64),
      BigInt.from(16383),
      BigInt.from(16384),
      BigInt.from(1073741823),
      BigInt.from(1073741824),
      (BigInt.one << 32) - BigInt.one,
      BigInt.one << 32,
      BigInt.one << 40,
      BigInt.one << 48,
      (BigInt.one << 56) - BigInt.one,
      BigInt.one << 56,
      (BigInt.one << 64) - BigInt.one,
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
      [0x13, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff],
    ].map((e) => Uint8List.fromList(e)).toList(growable: false);

    final List<int> sizes = [
      1,
      1,
      2,
      2,
      4,
      4,
      5,
      5,
      6,
      7,
      8,
      8,
      9,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      16,
      17,
      17,
    ];

    test('Length of input and output should match', () {
      expect(inputs.length, outputs.length);
    });

    for (var i = 0; i < inputs.length; i++) {
      test('Testing encoding of ${inputs[i]} at index $i', () {
        final encoded = CompactBigIntCodec.codec.encode(inputs[i]);
        expect(outputs[i], encoded);
        expect(sizes[i], encoded.lengthInBytes);
      });
    }
  });
}
