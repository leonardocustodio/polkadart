import 'dart:collection';

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Composite Encode Test', () {
    test('When value {"a": 42, "b": true} is encoded then it returns 0x2a01',
        () {
      final output = HexOutput();
      CompositeCodec(
        LinkedHashMap.from({
          'a': U8Codec.instance,
          'b': BoolCodec.instance,
        }),
      ).encodeTo(
        LinkedHashMap.from(
          {
            'a': 42,
            'b': true,
          },
        ),
        output,
      );
      expect(output.toString(), '0x2a01');
    });

    test(
        'When Composite is encoded then it returns correct hex 0x0838546869732069732061206e6f7465104b69776901014448657920466f6f642077617320676f6f64',
        () {
      final output = HexOutput();
      CompositeCodec(
        LinkedHashMap.from({
          'index': U8Codec.instance,
          'note': StrCodec.instance,
          'Juice': CompositeCodec(
            LinkedHashMap.from({
              'name': StrCodec.instance,
              'ounces': U8Codec.instance,
            }),
          ),
          'Remarks': OptionCodec(StrCodec.instance),
        }),
      ).encodeTo(
        LinkedHashMap.from({
          'index': 8,
          'note': 'This is a note',
          'Juice': {
            'name': 'Kiwi',
            'ounces': 1,
          },
          'Remarks': Some('Hey Food was good'),
        }),
        output,
      );
      expect(output.toString(),
          '0x0838546869732069732061206e6f7465104b69776901014448657920466f6f642077617320676f6f64');
    });
  });

  group('Composite Decode Test', () {
    test('When value 0x2a01 is decoded then it returns {"a": 42, "b": true}',
        () {
      final input = HexInput('0x2a01');
      final decoded = CompositeCodec(
        LinkedHashMap.from({
          'a': U8Codec.instance,
          'b': BoolCodec.instance,
        }),
      ).decode(input);
      expect(decoded, {
        'a': 42,
        'b': true,
      });
    });

    test(
        'When Composite is decoded then it returns correct value {"index": 8, "note": "This is a note", "Juice": {"name": "Kiwi", "ounces": 1}, "Remarks": "Hey Food was good"}',
        () {
      final input = HexInput(
          '0x0838546869732069732061206e6f7465104b69776901014448657920466f6f642077617320676f6f64');
      final decoded = CompositeCodec(
        LinkedHashMap.from({
          'index': U8Codec.instance,
          'note': StrCodec.instance,
          'Juice': CompositeCodec(
            LinkedHashMap.from({
              'name': StrCodec.instance,
              'ounces': U8Codec.instance,
            }),
          ),
          'Remarks': OptionCodec(StrCodec.instance),
        }),
      ).decode(input);
      expect(decoded, {
        'index': 8,
        'note': 'This is a note',
        'Juice': {
          'name': 'Kiwi',
          'ounces': 1,
        },
        'Remarks': Some('Hey Food was good'),
      });
    });
  });
}
