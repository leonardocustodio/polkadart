import 'dart:typed_data';

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  test('U8 can decode', () {
    final input = Uint8ListInput.fromList([0xFF, 0xFF]);
    final decoded = U8Codec.instance.decode(input);
    expect(decoded, 255);
    expect(input.remainingLen(), 1);
  });

  test('U8 can encode', () {
    final output = ByteOutput(1);
    U8Codec.instance.encodeTo(123, output);
    expect(output.length, 1);
    expect(output.buffer.toBytes(), Uint16List.fromList([123]));
  });
}
