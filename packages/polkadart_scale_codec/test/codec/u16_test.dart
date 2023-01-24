import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('U16 Decode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When lowest value 0x0000 is decoded then it returns 0', () {
      final codec = Codec(registry: registry).fetchTypeCodec('u16');
      final u16Value = codec.decode(Input('0x0000'));
      expect(u16Value, equals(0));
    });

    test('When highest value 0xffff is decoded then it returns 65535', () {
      final codec = Codec(registry: registry).fetchTypeCodec('u16');
      final u16Value = codec.decode(Input('0xffff'));
      expect(u16Value, equals(65535));
    });
  });

  group('U16 Encode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When lowest value 0 is encoded then it returns 0x0000', () {
      final codec = Codec<int>(registry: registry).fetchTypeCodec('u16');
      final encoder = HexEncoder();
      codec.encode(encoder, 0);
      expect(encoder.toHex(), equals('0x0000'));
    });

    test('When highest value 65535 is encoded then it returns 0xffff', () {
      final codec = Codec<int>(registry: registry).fetchTypeCodec('u16');
      final encoder = HexEncoder();
      codec.encode(encoder, 65535);
      expect(encoder.toHex(), equals('0xffff'));
    });
  });

  group('Exception Test', () {
    final registry = TypeRegistry.createRegistry();

    test('When value -1 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).fetchTypeCodec('u16');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, -1),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test('When value 65536 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).fetchTypeCodec('u16');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, 65536),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  group('Custom Json Test', () {
    final registry = TypeRegistry.createRegistry();
    TypeRegistry.addCustomCodec(
      registry,
      <String, dynamic>{
        'u16_key': 'u16',
      },
    );

    test('When lowest value 0x0000 is decoded then it returns 0', () {
      final Codec codec = Codec(registry: registry).fetchTypeCodec('u16_key');
      final u16Value = codec.decode(Input('0x0000'));
      expect(u16Value, equals(0));
    });

    test('When highest value 0xffff is decoded then it returns 65535', () {
      final codec = Codec(registry: registry).fetchTypeCodec('u16_key');
      final u16Value = codec.decode(Input('0xffff'));
      expect(u16Value, equals(65535));
    });

    test('When lowest value 0 is encoded then it returns 0x0000', () {
      final codec = Codec<int>(registry: registry).fetchTypeCodec('u16_key');
      final encoder = HexEncoder();
      codec.encode(encoder, 0);
      expect(encoder.toHex(), equals('0x0000'));
    });

    test('When highest value 65535 is encoded then it returns 0xffff', () {
      final codec = Codec<int>(registry: registry).fetchTypeCodec('u16_key');
      final encoder = HexEncoder();
      codec.encode(encoder, 65535);
      expect(encoder.toHex(), equals('0xffff'));
    });
  });

  group('Exception Test for custom json', () {
    final registry = TypeRegistry.createRegistry();
    TypeRegistry.addCustomCodec(
      registry,
      <String, dynamic>{
        'u16_key': 'u16',
      },
    );

    test('When value -1 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).fetchTypeCodec('u16_key');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, -1),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test('When value 65536 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).fetchTypeCodec('u16_key');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, 65536),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  /// Test cases using U16() class
  group('U16 Class Test', () {
    test('When lowest value 0x0000 is decoded then it returns 0', () {
      final u16Value = U16.decodeFromInput(Input('0x0000'));
      expect(u16Value, equals(0));
    });

    test('When highest value 0xffff is decoded then it returns 65535', () {
      final u16Value = U16.decodeFromInput(Input('0xffff'));
      expect(u16Value, equals(65535));
    });

    test('When lowest value 0 is encoded then it returns 0x0000', () {
      final encoder = HexEncoder();
      U16.encodeToEncoder(encoder, 0);
      expect(encoder.toHex(), equals('0x0000'));
    });

    test('When highest value 65535 is encoded then it returns 0xffff', () {
      final encoder = HexEncoder();
      U16.encodeToEncoder(encoder, 65535);
      expect(encoder.toHex(), equals('0xffff'));
    });
  });
}
