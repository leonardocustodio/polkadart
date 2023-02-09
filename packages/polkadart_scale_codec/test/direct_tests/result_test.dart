import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Result Encode Test', () {
    test('When value {"Ok": 42} is encoded then it returns 0x002a', () {
      final output = HexOutput();
      Result(okCodec: U8Codec.instance, errCodec: U8Codec.instance)
          .encodeTo({'Ok': 42}, output);
      expect(output.toString(), '0x002a');
    });
    test('When value {"Err": false} is encoded then it returns 0x0100', () {
      final output = HexOutput();
      Result(okCodec: U8Codec.instance, errCodec: BoolCodec.instance)
          .encodeTo({'Err': false}, output);
      expect(output.toString(), '0x0100');
    });

    test(
        'When value {"Ok": {"Err": false}} is encoded then it returns 0x000100',
        () {
      final output = HexOutput();
      Result(
        okCodec: Result(
          okCodec: U8Codec.instance,
          errCodec: BoolCodec.instance,
        ),
        errCodec: BoolCodec.instance,
      ).encodeTo(
        {
          'Ok': {'Err': false},
        },
        output,
      );
      expect(output.toString(), '0x000100');
    });
    test('When value {"Ok": {"Err": true}} is encoded then it returns 0x000101',
        () {
      final output = HexOutput();
      Result(
        okCodec: Result(
          okCodec: U8Codec.instance,
          errCodec: BoolCodec.instance,
        ),
        errCodec: BoolCodec.instance,
      ).encodeTo(
        {
          'Ok': {'Err': true},
        },
        output,
      );
      expect(output.toString(), '0x000101');
    });

    test('When value {"Ok": [42, true]} is encoded then it returns 0x002a01',
        () {
      final output = HexOutput();
      Result(
        okCodec: TupleCodec([U8Codec.instance, BoolCodec.instance]),
        errCodec: BoolCodec.instance,
      ).encodeTo(
        {
          'Ok': [42, true],
        },
        output,
      );
      expect(output.toString(), '0x002a01');
    });
  });

  group('Result Decode Test', () {
    test('When value 0x002a is decoded then it returns {"Ok": 42}', () {
      final input = HexInput('0x002a');
      final result =
          Result(okCodec: U8Codec.instance, errCodec: U8Codec.instance)
              .decode(input);
      expect(result, {'Ok': 42});
    });
    test('When value 0x0100 is decoded then it returns {"Err": false}', () {
      final input = HexInput('0x0100');
      final result =
          Result(okCodec: U8Codec.instance, errCodec: BoolCodec.instance)
              .decode(input);
      expect(result, {'Err': false});
    });

    test(
        'When value 0x000100 is decoded then it returns {"Ok": {"Err": false}}',
        () {
      final input = HexInput('0x000100');
      final result = Result(
        okCodec: Result(
          okCodec: U8Codec.instance,
          errCodec: BoolCodec.instance,
        ),
        errCodec: BoolCodec.instance,
      ).decode(input);
      expect(result, {
        'Ok': {'Err': false}
      });
    });
    test('When value 0x000101 is decoded then it returns {"Ok": {"Err": true}}',
        () {
      final input = HexInput('0x000101');
      final result = Result(
        okCodec: Result(
          okCodec: U8Codec.instance,
          errCodec: BoolCodec.instance,
        ),
        errCodec: BoolCodec.instance,
      ).decode(input);
      expect(result, {
        'Ok': {'Err': true}
      });
    });

    test('When value 0x002a01 is decoded then it returns {"Ok": [42, true]}',
        () {
      final input = HexInput('0x002a01');
      final result = Result(
        okCodec: TupleCodec([U8Codec.instance, BoolCodec.instance]),
        errCodec: BoolCodec.instance,
      ).decode(input);
      expect(result, {
        'Ok': [42, true]
      });
    });
  });
}
