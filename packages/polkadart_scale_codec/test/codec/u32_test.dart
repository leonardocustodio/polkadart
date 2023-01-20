import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('U32 Decode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When lowest value 0x00000000 is decoded then it returns 0', () {
      final codec = Codec(registry: registry)
          .createTypeCodec('u32', input: Input('0x00000000'));
      final u32Value = codec.decode();
      expect(u32Value, equals(0));
    });

    test('When highest value 0xffffffff is decoded then it returns 4294967295',
        () {
      final codec = Codec(registry: registry)
          .createTypeCodec('u32', input: Input('0xffffffff'));
      final u32Value = codec.decode();
      expect(u32Value, equals(4294967295));
    });
  });

  group('U32 Encode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When lowest value 0 is encoded then it returns 0x00000000', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('u32');
      final encoder = HexEncoder();
      codec.encode(encoder, 0);
      expect(encoder.toHex(), equals('00000000'));
    });

    test('When highest value 4294967295 is encoded then it returns 0xffffffff',
        () {
      final codec = Codec<int>(registry: registry).createTypeCodec('u32');
      final encoder = HexEncoder();
      codec.encode(encoder, 4294967295);
      expect(encoder.toHex(), equals('ffffffff'));
    });
  });

  group('Exception Test', () {
    final registry = TypeRegistry.createRegistry();

    test('When value -1 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('u32');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, -1),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test('When value 4294967296 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('u32');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, 4294967296),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  group('Custom Json Test', () {
    final registry = TypeRegistry.createRegistry();
    TypeRegistry.addCustomCodec(
      registry,
      <String, dynamic>{
        'u32_key': 'u32',
      },
    );

    test('When u32_key is decoded then it returns 0', () {
      final codec = Codec(registry: registry)
          .createTypeCodec('u32_key', input: Input('0x00000000'));
      final u32Value = codec.decode();
      expect(u32Value, equals(0));
    });

    test('When u32_key is encoded then it returns 0xffffffff', () {
      final codec = Codec<int>(registry: registry)
          .createTypeCodec('u32_key', input: Input('0xffffffff'));
      final u32Value = codec.decode();
      expect(u32Value, equals(4294967295));
    });

    test('When u32_key is encoded then it returns 0x00000000', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('u32_key');
      final encoder = HexEncoder();
      codec.encode(encoder, 0);
      expect(encoder.toHex(), equals('00000000'));
    });

    test('When u32_key is encoded then it returns 0xffffffff', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('u32_key');
      final encoder = HexEncoder();
      codec.encode(encoder, 4294967295);
      expect(encoder.toHex(), equals('ffffffff'));
    });

    test('When u32_key is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('u32_key');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, -1),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test('When u32_key is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('u32_key');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, 4294967296),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  // Direct Test cases for U32()
  group('U32 Direct Test', () {
    test('When lowest value 0x00000000 is decoded then it returns 0', () {
      final u32Value = U32.decodeFromInput(Input('0x00000000'));
      expect(u32Value, equals(0));
    });

    test('When highest value 0xffffffff is decoded then it returns 4294967295',
        () {
      final u32Value = U32.decodeFromInput(Input('0xffffffff'));
      expect(u32Value, equals(4294967295));
    });

    test('When lowest value 0 is encoded then it returns 0x00000000', () {
      final encoder = HexEncoder();
      U32.encodeToEncoder(encoder, 0);
      expect(encoder.toHex(), equals('00000000'));
    });

    test('When highest value 4294967295 is encoded then it returns 0xffffffff',
        () {
      final encoder = HexEncoder();
      U32.encodeToEncoder(encoder, 4294967295);
      expect(encoder.toHex(), equals('ffffffff'));
    });

    test('When value -1 is encoded then it throws an exception', () {
      final encoder = HexEncoder();
      expect(() => U32.encodeToEncoder(encoder, -1),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test('When value 4294967296 is encoded then it throws an exception', () {
      final encoder = HexEncoder();
      expect(() => U32.encodeToEncoder(encoder, 4294967296),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });
}
