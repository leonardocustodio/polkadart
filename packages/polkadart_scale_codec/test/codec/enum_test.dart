import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Enum Registry Encode Test', () {
    final registry = TypeRegistry.createRegistry()
      ..registerCustomCodec({
        'JuiceEnum': {
          '_enum': ['Apple', 'Orange'],
        },
        'JuiceEnumComplex': {
          '_enum': {
            'Apple': 'u8',
            'Orange': 'bool',
          },
        }
      });
    test('When value "Apple" is encoded then it returns 0x00', () {
      final codec = Codec(registry: registry).fetchTypeCodec('JuiceEnum');
      final encoder = HexEncoder();
      codec.encode(encoder, 'Apple');
      expect(encoder.toHex(), equals('0x00'));
    });
    test('When value "Orange" is encoded then it returns 0x01', () {
      final codec = Codec(registry: registry).fetchTypeCodec('JuiceEnum');
      final encoder = HexEncoder();
      codec.encode(encoder, 'Orange');
      expect(encoder.toHex(), equals('0x01'));
    });

    test('When value {"Apple": 1} is encoded then it returns 0x00', () {
      final codec =
          Codec(registry: registry).fetchTypeCodec('JuiceEnumComplex');
      final encoder = HexEncoder();
      codec.encode(encoder, {'Apple': 1});
      expect(encoder.toHex(), equals('0x0001'));
    });

    test('When value {"Orange": true} is encoded then it returns 0x01', () {
      final codec =
          Codec(registry: registry).fetchTypeCodec('JuiceEnumComplex');
      final encoder = HexEncoder();
      codec.encode(encoder, {'Orange': true});
      expect(encoder.toHex(), equals('0x0101'));
    });
  });

  group('Enum Registry Decode Test', () {
    final registry = TypeRegistry.createRegistry()
      ..registerCustomCodec({
        'JuiceEnum': {
          '_enum': ['Apple', 'Orange'],
        },
        'JuiceEnumComplex': {
          '_enum': {
            'Apple': 'u8',
            'Orange': 'bool',
          },
        }
      });
    test('When value 0x00 is decoded then it returns "Apple"', () {
      final codec = Codec(registry: registry).fetchTypeCodec('JuiceEnum');
      final input = DefaultInput.fromHex('0x00');
      expect(codec.decode(input), equals('Apple'));
    });
    test('When value 0x01 is decoded then it returns "Orange"', () {
      final codec = Codec(registry: registry).fetchTypeCodec('JuiceEnum');
      final input = DefaultInput.fromHex('0x01');
      expect(codec.decode(input), equals('Orange'));
    });

    test('When value 0x0001 is decoded then it returns {"Apple": 1}', () {
      final codec =
          Codec(registry: registry).fetchTypeCodec('JuiceEnumComplex');
      final input = DefaultInput.fromHex('0x0001');
      expect(codec.decode(input), equals({'Apple': 1}));
    });

    test('When value 0x0101 is decoded then it returns {"Orange": true}', () {
      final codec =
          Codec(registry: registry).fetchTypeCodec('JuiceEnumComplex');
      final input = DefaultInput.fromHex('0x0101');
      expect(codec.decode(input), equals({'Orange': true}));
    });
  });

  group('Enum Exception Testing', () {
    final registry = TypeRegistry.createRegistry()
      ..registerCustomCodec({
        'JuiceEnum': {
          '_enum': ['Apple', 'Orange'],
        },
        'JuiceEnumComplex': {
          '_enum': {
            'Apple': 'u8',
            'Orange': 'bool',
          },
        }
      });
    test(
        'When value "Banana" is encoded then it throws an InvalidEnumException',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('JuiceEnum');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, 'Banana'),
          throwsA(isA<InvalidEnumException>()));
    });

    test(
        'When value {"Banana": true} is encoded then it throws an InvalidEnumException',
        () {
      final codec =
          Codec(registry: registry).fetchTypeCodec('JuiceEnumComplex');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, {'Banana': true}),
          throwsA(isA<InvalidEnumException>()));
    });

    test('When value 0x02 is decoded then it throws an AssertionException', () {
      final codec = Codec(registry: registry).fetchTypeCodec('JuiceEnum');
      final input = DefaultInput.fromHex('0x02');
      expect(() => codec.decode(input), throwsA(isA<AssertionException>()));
    });

    test('When value 0x0201 is decoded then it throws an AssertionException',
        () {
      final codec =
          Codec(registry: registry).fetchTypeCodec('JuiceEnumComplex');
      final input = DefaultInput.fromHex('0x0201');
      expect(() => codec.decode(input), throwsA(isA<AssertionException>()));
    });
  });
}
