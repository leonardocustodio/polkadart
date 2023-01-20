import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('U8 Decode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When lowest value 0x00 is decoded then it returns 0', () {
      final codec =
          Codec(registry: registry).createTypeCodec('u8', input: Input('0x00'));
      final u8Value = codec.decode();
      expect(u8Value, equals(0));
    });

    test('When highest value 0xff is decoded then it returns 255', () {
      final codec =
          Codec(registry: registry).createTypeCodec('u8', input: Input('0xff'));
      final u8Value = codec.decode();
      expect(u8Value, equals(255));
    });
  });

  group('U8 Encode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When lowest value 0 is encoded then it returns 0x00', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('u8');
      final encoder = HexEncoder();
      codec.encode(encoder, 0);
      final u8Value = encoder.toHex();
      expect(u8Value, equals('0x00'));
    });

    test('When highest value 255 is encoded then it returns 0xff', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('u8');
      final encoder = HexEncoder();
      codec.encode(encoder, 255);
      final u8Value = encoder.toHex();
      expect(u8Value, equals('0xff'));
    });
  });

  group('Exception Test', () {
    final registry = TypeRegistry.createRegistry();

    test('When value -1 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('u8');

      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, -1),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test('When value 256 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('u8');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, 256),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  group('Custom Json Test', () {
    final registry = TypeRegistry.createRegistry();
    TypeRegistry.addCustomCodec(
      registry,
      <String, dynamic>{
        'u8_key': 'u8',
      },
    );

    test('When lowest value 0x00 is decoded then it returns 0', () {
      final codec = Codec<int>(registry: registry)
          .createTypeCodec('u8_key', input: Input('0x00'));
      final u8Value = codec.decode();
      expect(u8Value, equals(0));
    });

    test('When highest value 0xff is decoded then it returns 255', () {
      final codec = Codec<int>(registry: registry)
          .createTypeCodec('u8_key', input: Input('0xff'));
      final u8Value = codec.decode();
      expect(u8Value, equals(255));
    });

    test('When lowest value 0 is encoded then it returns 0x00', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('u8_key');
      final encoder = HexEncoder();
      codec.encode(encoder, 0);
      final u8Value = encoder.toHex();
      expect(u8Value, equals('0x00'));
    });

    test('When highest value 255 is encoded then it returns 0xff', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('u8_key');
      final encoder = HexEncoder();
      codec.encode(encoder, 255);
      final u8Value = encoder.toHex();
      expect(u8Value, equals('0xff'));
    });
  });

  group('Exception Test for custom json', () {
    final registry = TypeRegistry.createRegistry();
    TypeRegistry.addCustomCodec(
      registry,
      <String, dynamic>{
        'u8_key': 'u8',
      },
    );

    test('When value -1 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('u8_key');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, -1),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test('When value 256 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('u8_key');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, 256),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  /// Direct test for U8
  group('U8 Direct Test', () {
    test('When lowest value 0x00 is decoded then it returns 0', () {
      final u8Value = U8.decodeFromInput(Input('0x00'));
      expect(u8Value, equals(0));
    });

    test('When highest value 0xff is decoded then it returns 255', () {
      final u8Value = U8.decodeFromInput(Input('0xff'));
      expect(u8Value, equals(255));
    });

    test('When lowest value 0 is encoded then it returns 0x00', () {
      final u8 = U8();
      final encoder = HexEncoder();
      u8.encode(encoder, 0);
      final u8Value = encoder.toHex();
      expect(u8Value, equals('0x00'));
    });

    test('When highest value 255 is encoded then it returns 0xff', () {
      final u8 = U8();
      final encoder = HexEncoder();
      u8.encode(encoder, 255);
      final u8Value = encoder.toHex();
      expect(u8Value, equals('0xff'));
    });
  });
}
