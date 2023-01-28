import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Vec Encode Test', () {
    test('When value {"Ok": 42} is encoded then it returns 0x002a', () {
      final codec = Codec().fetchTypeCodec('Result<u8, bool>');
      final encoder = HexEncoder();
      codec.encode(encoder, {'Ok': 42});
      expect(encoder.toHex(), equals('0x002a'));
    });

    test('When value {"Err": false} is encoded then it returns 0x0100', () {
      final codec = Codec().fetchTypeCodec('Result<u8, bool>');
      final encoder = HexEncoder();
      codec.encode(encoder, {'Err': false});
      expect(encoder.toHex(), equals('0x0100'));
    });

    test(
        'When value {"Ok": {"Err": false}} is encoded then it returns 0x000100',
        () {
      final codec = Codec().fetchTypeCodec('Result<Result<u8, bool>, bool>');
      final encoder = HexEncoder();
      codec.encode(encoder, {
        'Ok': {'Err': false}
      });
      expect(encoder.toHex(), equals('0x000100'));
    });
    test('When value {"Ok": {"Err": true}} is encoded then it returns 0x000101',
        () {
      final codec = Codec().fetchTypeCodec('Result<Result<u8, bool>, bool>');
      final encoder = HexEncoder();
      codec.encode(encoder, {
        'Ok': {'Err': true}
      });
      expect(encoder.toHex(), equals('0x000101'));
    });

    test('When value {"Ok": [42, true]} is encoded then it returns 0x002a01',
        () {
      final codec = Codec().fetchTypeCodec('Result<(u8, bool), bool>');
      final encoder = HexEncoder();
      codec.encode(encoder, {
        'Ok': [42, true]
      });
      expect(encoder.toHex(), equals('0x002a01'));
    });
  });

  // Decode Test
  group('Vec Decode Test', () {
    test('When value 0x002a is decoded then it returns {"Ok": 42}', () {
      final codec = Codec().fetchTypeCodec('Result<u8, bool>');
      final input = DefaultInput.fromHex('0x002a');
      expect(codec.decode(input), equals({'Ok': 42}));
    });

    test('When value 0x0100 is decoded then it returns {"Err": false}', () {
      final codec = Codec().fetchTypeCodec('Result<u8, bool>');
      final input = DefaultInput.fromHex('0x0100');
      expect(codec.decode(input), equals({'Err': false}));
    });

    test(
        'When value 0x000100 is decoded then it returns {"Ok": {"Err": false}}',
        () {
      final codec = Codec().fetchTypeCodec('Result<Result<u8, bool>, bool>');
      final input = DefaultInput.fromHex('0x000100');
      expect(
          codec.decode(input),
          equals({
            'Ok': {'Err': false}
          }));
    });
    test('When value 0x000101 is decoded then it returns {"Ok": {"Err": true}}',
        () {
      final codec = Codec().fetchTypeCodec('Result<Result<u8, bool>, bool>');
      final input = DefaultInput.fromHex('0x000101');
      expect(
          codec.decode(input),
          equals({
            'Ok': {'Err': true}
          }));
    });

    test('When value 0x002a01 is decoded then it returns {"Ok": [42, true]}',
        () {
      final codec = Codec().fetchTypeCodec('Result<(u8, bool), bool>');
      final input = DefaultInput.fromHex('0x002a01');
      expect(
          codec.decode(input),
          equals({
            'Ok': [42, true]
          }));
    });
  });
  group('Vec Registry Encode Test', () {
    final registry = TypeRegistry.createRegistry()
      ..registerCustomCodec({
        'Res': 'Result<A, bool>',
        'A': 'Result<u8, bool>',
        'Result_With_Tuple': 'Result<(u8, bool), bool>',
      });
    test('When value {"Ok": 42} is encoded then it returns 0x002a', () {
      final codec = Codec(registry: registry).fetchTypeCodec('A');
      final encoder = HexEncoder();
      codec.encode(encoder, {'Ok': 42});
      expect(encoder.toHex(), equals('0x002a'));
    });

    test('When value {"Err": false} is encoded then it returns 0x0100', () {
      final codec = Codec(registry: registry).fetchTypeCodec('A');
      final encoder = HexEncoder();
      codec.encode(encoder, {'Err': false});
      expect(encoder.toHex(), equals('0x0100'));
    });

    test(
        'When value {"Ok": {"Err": false}} is encoded then it returns 0x000100',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('Res');
      final encoder = HexEncoder();
      codec.encode(encoder, {
        'Ok': {'Err': false}
      });
      expect(encoder.toHex(), equals('0x000100'));
    });
    test('When value {"Ok": {"Err": true}} is encoded then it returns 0x000101',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('Res');
      final encoder = HexEncoder();
      codec.encode(encoder, {
        'Ok': {'Err': true}
      });
      expect(encoder.toHex(), equals('0x000101'));
    });

    test('When value {"Ok": [42, true]} is encoded then it returns 0x002a01',
        () {
      final codec =
          Codec(registry: registry).fetchTypeCodec('Result_With_Tuple');
      final encoder = HexEncoder();
      codec.encode(encoder, {
        'Ok': [42, true]
      });
      expect(encoder.toHex(), equals('0x002a01'));
    });
  });

  group('Vec Registry Decode Test', () {
    final registry = TypeRegistry.createRegistry()
      ..registerCustomCodec({
        'Res': 'Result<A, bool>',
        'A': 'Result<u8, bool>',
        'Result_With_Tuple': 'Result<(u8, bool), bool>',
      });
    test('When value 0x002a is decoded then it returns {"Ok": 42}', () {
      final codec = Codec(registry: registry).fetchTypeCodec('A');
      final input = DefaultInput.fromHex('0x002a');
      expect(codec.decode(input), equals({'Ok': 42}));
    });

    test('When value 0x0100 is decoded then it returns {"Err": false}', () {
      final codec = Codec(registry: registry).fetchTypeCodec('A');
      final input = DefaultInput.fromHex('0x0100');
      expect(codec.decode(input), equals({'Err': false}));
    });

    test(
        'When value 0x000100 is decoded then it returns {"Ok": {"Err": false}}',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('Res');
      final input = DefaultInput.fromHex('0x000100');
      expect(
          codec.decode(input),
          equals({
            'Ok': {'Err': false}
          }));
    });

    test('When value 0x000101 is decoded then it returns {"Ok": {"Err": true}}',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('Res');
      final input = DefaultInput.fromHex('0x000101');
      expect(
          codec.decode(input),
          equals({
            'Ok': {'Err': true}
          }));
    });

    test('When value 0x002a01 is decoded then it returns {"Ok": [42, true]}',
        () {
      final codec =
          Codec(registry: registry).fetchTypeCodec('Result_With_Tuple');
      final input = DefaultInput.fromHex('0x002a01');
      expect(
          codec.decode(input),
          equals({
            'Ok': [42, true]
          }));
    });
  });
}
