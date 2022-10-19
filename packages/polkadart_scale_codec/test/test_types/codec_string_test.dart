import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('Given a custom string it should be encoded', () {
    const value = 'Test';
    const expectedResult = '0x1054657374';

    expect(CodecString().encodeToHex(value), expectedResult);
  });

  test(
      'Given a custom string which represents a string value it should be decoded',
      () {
    const value = '0x2c5363616c6520436f646563';
    const expectedResult = 'Scale Codec';

    expect(CodecString().decodeFromHex(value), expectedResult);
  });
}
