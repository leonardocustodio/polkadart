import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Composite Encode Test', () {
    test('When value {"a": 42, "b": true} is encoded then it returns 0x2a01',
        () {
      final output = HexOutput();
      CompositeCodec(
        {
          'a': U8Codec.codec,
          'b': BoolCodec.codec,
        },
      ).encodeTo(
        {
          'a': 42,
          'b': true,
        },
        output,
      );
      expect(output.toString(), '0x2a01');
    });

    test(
        'When Composite is encoded then it returns correct hex 0x0838546869732069732061206e6f7465104b69776901014448657920466f6f642077617320676f6f64',
        () {
      final output = HexOutput();
      CompositeCodec(
        {
          'index': U8Codec.codec,
          'note': StrCodec.codec,
          'Juice': CompositeCodec(
            {
              'name': StrCodec.codec,
              'ounces': U8Codec.codec,
            },
          ),
          'Remarks': OptionCodec(StrCodec.codec),
        },
      ).encodeTo(
        {
          'index': 8,
          'note': 'This is a note',
          'Juice': {
            'name': 'Kiwi',
            'ounces': 1,
          },
          'Remarks': 'Hey Food was good',
        },
        output,
      );
      expect(output.toString(),
          '0x0838546869732069732061206e6f7465104b69776901014448657920466f6f642077617320676f6f64');
    });
  });

  group('Composite Decode Test', () {
    test('When value 0x2a01 is decoded then it returns {"a": 42, "b": true}',
        () {
      final input = Input.fromHex('0x2a01');
      final decoded = CompositeCodec(
        {
          'a': U8Codec.codec,
          'b': BoolCodec.codec,
        },
      ).decode(input);
      expect(decoded, {
        'a': 42,
        'b': true,
      });
      expect(input.remainingLength, 0);
    });

    test(
        'When Composite is decoded then it returns correct value {"index": 8, "note": "This is a note", "Juice": {"name": "Kiwi", "ounces": 1}, "Remarks": "Hey Food was good"}',
        () {
      final input = Input.fromHex(
          '0x0838546869732069732061206e6f7465104b69776901014448657920466f6f642077617320676f6f64');
      final decoded = CompositeCodec(
        {
          'index': U8Codec.codec,
          'note': StrCodec.codec,
          'Juice': CompositeCodec(
            {
              'name': StrCodec.codec,
              'ounces': U8Codec.codec,
            },
          ),
          'Remarks': OptionCodec(StrCodec.codec),
        },
      ).decode(input);
      expect(
          decoded.toString(),
          {
            'index': 8,
            'note': 'This is a note',
            'Juice': {
              'name': 'Kiwi',
              'ounces': 1,
            },
            'Remarks': 'Hey Food was good',
          }.toString());
      expect(input.remainingLength, 0);
    });
  });
}
