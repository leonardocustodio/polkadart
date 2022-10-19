import 'package:polkadart_scale_codec/src/core/core.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('Given true should be encoded to 0x01', () {
    final value = true;
    final expectedResult = '0x01';

    expect(CodecBoolean().encodeToHex(value), expectedResult);
  });

  test('Given false should be encoded to 0x01', () {
    final value = false;
    final expectedResult = '0x00';

    expect(CodecBoolean().encodeToHex(value), expectedResult);
  });

  test('Given string when it represents true it should be decoded', () {
    final value = '0x01';
    final expectedResult = true;

    expect(CodecBoolean().decodeFromHex(value), expectedResult);
  });

  test('Given string when it represents false it should be decoded', () {
    final value = '0x00';
    final expectedResult = false;

    expect(CodecBoolean().decodeFromHex(value), expectedResult);
  });
}
