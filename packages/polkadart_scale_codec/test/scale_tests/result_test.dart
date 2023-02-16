import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  // Test with Registry
  group('ResultCodec Encode Test:', () {
    final registry = Registry()
      ..registerCustomCodec(<String, dynamic>{
        'A': 'Result<u8, u8>',
        'C': 'Result<u8, bool>',
        'B': 'Result<C, bool>',
        'D': 'Result<(u8, bool), bool>'
      });

    test('When value {"Ok": 42} is encoded then it returns 0x002a', () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('A', {'Ok': 42}, output);
      expect(output.toString(), '0x002a');
    });
    test('When value {"Err": false} is encoded then it returns 0x0100', () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo('C', {'Err': false}, output);
      expect(output.toString(), '0x0100');
    });
    test(
        'When value {"Ok": {"Err": false}} is encoded then it returns 0x000100',
        () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo(
          'B',
          {
            'Ok': {'Err': false}
          },
          output);
      expect(output.toString(), '0x000100');
    });
    test('When value {"Ok": {"Err": true}} is encoded then it returns 0x000101',
        () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo(
          'B',
          {
            'Ok': {'Err': true}
          },
          output);
      expect(output.toString(), '0x000101');
    });
    test('When value {"Ok": [42, true]} is encoded then it returns 0x002a01',
        () {
      final output = HexOutput();
      final codec = ScaleCodec(registry);
      codec.encodeTo(
          'D',
          {
            'Ok': [42, true]
          },
          output);
      expect(output.toString(), '0x002a01');
    });
  });

  // Decode Tests
  group('ResultCodec Decode Test:', () {
    final registry = Registry()
      ..registerCustomCodec(<String, dynamic>{
        'A': 'Result<u8, u8>',
        'C': 'Result<u8, bool>',
        'B': 'Result<C, bool>',
        'D': 'Result<(u8, bool), bool>'
      });

    test('When value 0x002a is decoded then it returns {"Ok": 42}', () {
      final input = HexInput('0x002a');
      final codec = ScaleCodec(registry);
      final result = codec.decode('A', input);
      expect(result, {'Ok': 42});
    });
    test('When value 0x0100 is decoded then it returns {"Err": false}', () {
      final input = HexInput('0x0100');
      final codec = ScaleCodec(registry);
      final result = codec.decode('C', input);
      expect(result, {'Err': false});
    });
    test(
        'When value 0x000100 is decoded then it returns {"Ok": {"Err": false}}',
        () {
      final input = HexInput('0x000100');
      final codec = ScaleCodec(registry);
      final result = codec.decode('B', input);
      expect(result, {
        'Ok': {'Err': false}
      });
    });
    test('When value 0x000101 is decoded then it returns {"Ok": {"Err": true}}',
        () {
      final input = HexInput('0x000101');
      final codec = ScaleCodec(registry);
      final result = codec.decode('B', input);
      expect(result, {
        'Ok': {'Err': true}
      });
    });
    test('When value 0x002a01 is decoded then it returns {"Ok": [42, true]}',
        () {
      final input = HexInput('0x002a01');
      final codec = ScaleCodec(registry);
      final result = codec.decode('D', input);
      expect(result, {
        'Ok': [42, true]
      });
    });
  });
}
