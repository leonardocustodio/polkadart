import 'package:polkadart_scale_codec/io/io.dart' show HexOutput;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    show Input, ResultCodec;
import 'package:polkadart_scale_codec/primitives/primitives.dart'
    show BoolCodec, U8Codec, Result;
import 'package:test/test.dart';

void main() {
  test('Result Codec Encode Test Result.ok', () {
    final expectedHex = '0x002a';

    final codec = ResultCodec(U8Codec.codec, BoolCodec.codec);
    final output = HexOutput();

    codec.encodeTo(Result.ok(42), output);
    final actualHex = output.toString();

    expect(expectedHex, actualHex);
  });

  test('Result Codec Encode Test Result.error', () {
    final expectedHex = '0x0100';

    final codec = ResultCodec(U8Codec.codec, BoolCodec.codec);
    final output = HexOutput();

    codec.encodeTo(Result.err(false), output);
    final actualHex = output.toString();

    expect(expectedHex, actualHex);
  });

  test('Result Codec Decode Test Result.ok', () {
    final expectedResult = 42;

    final codec = ResultCodec(U8Codec.codec, BoolCodec.codec);
    final input = Input.fromHex('0x002a');

    final Result<int, bool> result = codec.decode(input);

    expect(expectedResult, result.okValue);
  });

  test('Result Codec Decode Test Result.error', () {
    final expectedResult = false;

    final codec = ResultCodec(U8Codec.codec, BoolCodec.codec);
    final input = Input.fromHex('0x0100');

    final Result<int, bool> result = codec.decode(input);

    expect(expectedResult, result.errValue);
  });
}
