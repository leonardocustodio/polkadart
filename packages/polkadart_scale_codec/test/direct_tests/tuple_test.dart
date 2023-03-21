import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('encode tuple to hex ', () {
    test(
        'Given a list with compact unsigned integer and boolean it should be encoded to correct value',
        () {
      const value = [3, true];
      const expectedResult = '0x0c01';
      final output = HexOutput();
      TupleCodec([CompactCodec.codec, BoolCodec.codec]).encodeTo(value, output);
      expect(output.toString(), expectedResult);
    });

    test(
        'Given a list of one String and one unsigned 8bit integer it should be encoded to correct value',
        () {
      const value = ['Tuple', 133];
      const expectedResult = '0x145475706c6585';
      final output = HexOutput();
      TupleCodec([StrCodec.codec, U8Codec.codec]).encodeTo(value, output);
      expect(output.toString(), expectedResult);
    });

    test(
        'Given a list of one Vec<String> it should be encoded to correct value',
        () {
      final value = [
        ['tuple', 'test'],
        [100, 10]
      ];
      const expectedResult = '0x08147475706c65107465737408640a';
      final output = HexOutput();
      TupleCodec([SequenceCodec(StrCodec.codec), SequenceCodec(U8Codec.codec)])
          .encodeTo(value, output);
      expect(output.toString(), expectedResult);
    });

    test('Given a ((Str, Str), (U8, U8)) it should be encoded to correct value',
        () {
      final value = [
        ['tuple', 'test'],
        [100, 10]
      ];
      const expectedResult = '0x147475706c651074657374640a';
      final output = HexOutput();
      TupleCodec([
        TupleCodec([StrCodec.codec, StrCodec.codec]),
        TupleCodec([U8Codec.codec, U8Codec.codec]),
      ]).encodeTo(value, output);
      expect(output.toString(), expectedResult);
    });
  });

  group('decode tuple from hex ', () {
    test(
        'Given a hex with compact unsigned integer and boolean it should be decoded to correct value',
        () {
      const value = '0x0c01';
      const expectedResult = [3, true];
      final input = Input.fromHex(value);
      final result =
          TupleCodec([CompactCodec.codec, BoolCodec.codec]).decode(input);
      expect(result, expectedResult);
    });

    test(
        'Given a hex of one String and one unsigned 8bit integer it should be decoded to correct value',
        () {
      const value = '0x145475706c6585';
      const expectedResult = ['Tuple', 133];
      final input = Input.fromHex(value);
      final result = TupleCodec([StrCodec.codec, U8Codec.codec]).decode(input);
      expect(result, expectedResult);
      expect(input.remainingLength, 0);
    });

    test('Given a hex of one Vec<String> it should be decoded to correct value',
        () {
      const value = '0x08147475706c65107465737408640a';
      final expectedResult = [
        ['tuple', 'test'],
        [100, 10]
      ];
      final input = Input.fromHex(value);
      final result = TupleCodec(
              [SequenceCodec(StrCodec.codec), SequenceCodec(U8Codec.codec)])
          .decode(input);
      expect(result, expectedResult);
      expect(input.remainingLength, 0);
    });

    test(
        'Given a hex of ((Str, Str), (U8, U8)) it should be decoded to correct value',
        () {
      const value = '0x147475706c651074657374640a';
      final expectedResult = [
        ['tuple', 'test'],
        [100, 10]
      ];
      final input = Input.fromHex(value);
      final result = TupleCodec([
        TupleCodec([StrCodec.codec, StrCodec.codec]),
        TupleCodec([U8Codec.codec, U8Codec.codec]),
      ]).decode(input);
      expect(result, expectedResult);
      expect(input.remainingLength, 0);
    });
  });
}
