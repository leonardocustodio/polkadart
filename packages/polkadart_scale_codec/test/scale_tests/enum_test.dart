import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  // Test with Registry
  group('Option Encode Test:', () {
    final registry = Registry()
      ..registerCustomCodec(<String, dynamic>{
        'OrangeStruct': {
          'value1': 'bool',
          'value2': 'JuiceEnumComplex',
        },
        'JuiceEnum': {
          '_enum': ['Apple', 'Orange'],
        },
        'JuiceEnumComplex': {
          '_enum': {
            'Apple': 'U8',
            'Orange': 'OrangeStruct',
          },
        }
      });
    test('When value "Apple" is encoded then it returns 0x00', () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('JuiceEnum', 'Apple', output);
      expect(output.toString(), '0x00');
    });
    test('When value "Orange" is encoded then it returns 0x01', () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('JuiceEnum', 'Orange', output);
      expect(output.toString(), '0x01');
    });
    test('When value MapEntry("Apple", 1) is encoded then it returns 0x00', () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo(
          'JuiceEnumComplex',
          MapEntry(
            'Orange',
            {
              'value1': true,
              'value2': MapEntry(
                'Orange',
                {
                  'value1': true,
                  'value2': MapEntry('Apple', 1),
                },
              ),
            },
          ),
          output);
      expect(output.toString(), '0x010101010001');
    });

    test('When value MapEntry("Orange", true) is encoded then it returns 0x01',
        () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo(
          'JuiceEnumComplex',
          MapEntry(
            'Orange',
            {
              'value1': true,
              'value2': MapEntry('Apple', 1),
            },
          ),
          output);
      expect(output.toString(), '0x01010001');
    });
  });

  // Decode tests
  group('Option Decode Test:', () {
    final registry = Registry()
      ..registerCustomCodec(<String, dynamic>{
        'JuiceEnum': {
          '_enum': ['Apple', 'Orange'],
        },
        'JuiceEnumComplex': {
          '_enum': {
            'Apple': 'U8',
            'Orange': 'bool',
          },
        }
      });
    test('When value 0x00 is decoded then it returns "Apple"', () {
      final input = Input.fromHex('0x00');
      final codec = ScaleCodec(registry);
      final decoded = codec.decode('JuiceEnum', input);
      expect(decoded, 'Apple');
    });
    test('When value 0x01 is decoded then it returns "Orange"', () {
      final input = Input.fromHex('0x01');
      final codec = ScaleCodec(registry);
      final decoded = codec.decode('JuiceEnum', input);
      expect(decoded, 'Orange');
    });
    test('When value 0x0001 is decoded then it returns MapEntry("Apple", 1)',
        () {
      final input = Input.fromHex('0x0001');
      final codec = ScaleCodec(registry);
      final decoded = codec.decode('JuiceEnumComplex', input);
      expect(decoded.toString(), MapEntry('Apple', 1).toString());
    });
    test(
        'When value 0x0101 is decoded then it returns MapEntry("Orange", true)',
        () {
      final input = Input.fromHex('0x0101');
      final codec = ScaleCodec(registry);
      final decoded = codec.decode('JuiceEnumComplex', input);
      expect(decoded.toString(), MapEntry('Orange', true).toString());
    });
  });
}
