import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('I8 Decode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When lowest value 0x80 is decoded then it returns -128', () {
      final codec = Codec(registry: registry).fetchTypeCodec('i8');
      final i8Value = codec.decode(Input('0x80'));
      expect(i8Value, equals(-128));
    });

    test('When highest value 0x7f is decoded then it returns 127', () {
      final codec = Codec(registry: registry).fetchTypeCodec('i8');
      final i8Value = codec.decode(Input('0x7f'));
      expect(i8Value, equals(127));
    });
  });

  group('I8 Encode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When lowest value -128 is encoded then it returns 0x80', () {
      final codec = Codec<int>(registry: registry).fetchTypeCodec('i8');
      final encoder = HexEncoder();
      codec.encode(encoder, -128);
      expect(encoder.toHex(), equals('0x80'));
    });

    test('When highest value 127 is encoded then it returns 0x7f', () {
      final codec = Codec<int>(registry: registry).fetchTypeCodec('i8');
      final encoder = HexEncoder();
      codec.encode(encoder, 127);
      expect(encoder.toHex(), equals('0x7f'));
    });
  });

  group('Exception Test', () {
    final registry = TypeRegistry.createRegistry();

    test('When value -129 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).fetchTypeCodec('i8');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, -129),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test('When value 128 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).fetchTypeCodec('i8');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, 128),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  group('Custom Json Test', () {
    final registry = TypeRegistry.createRegistry();
    TypeRegistry.addCustomCodec(
      registry,
      <String, dynamic>{
        'i8_key': 'i8',
      },
    );

    test('When lowest value 0x80 is decoded then it returns -128', () {
      final codec = Codec(registry: registry).fetchTypeCodec('i8_key');
      final i8Value = codec.decode(Input('0x80'));
      expect(i8Value, equals(-128));
    });

    test('When highest value 0x7f is decoded then it returns 127', () {
      final codec = Codec(registry: registry).fetchTypeCodec('i8_key');
      final i8Value = codec.decode(Input('0x7f'));
      expect(i8Value, equals(127));
    });

    test('When lowest value -128 is encoded then it returns 0x80', () {
      final codec = Codec<int>(registry: registry).fetchTypeCodec('i8_key');
      final encoder = HexEncoder();
      codec.encode(encoder, -128);
      expect(encoder.toHex(), equals('0x80'));
    });

    test('When highest value 127 is encoded then it returns 0x7f', () {
      final codec = Codec<int>(registry: registry).fetchTypeCodec('i8_key');
      final encoder = HexEncoder();
      codec.encode(encoder, 127);
      expect(encoder.toHex(), equals('0x7f'));
    });

    test('When value -129 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).fetchTypeCodec('i8_key');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, -129),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test('When value 128 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).fetchTypeCodec('i8_key');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, 128),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  // I8() Direct Test Cases without type registry
  group('I8 Direct Test', () {
    test('When lowest value 0x80 is decoded then it returns -128', () {
      final i8Value = I8.decodeFromInput(Input('0x80'));
      expect(i8Value, equals(-128));
    });

    test('When highest value 0x7f is decoded then it returns 127', () {
      final i8Value = I8.decodeFromInput(Input('0x7f'));
      expect(i8Value, equals(127));
    });

    test('When lowest value -128 is encoded then it returns 0x80', () {
      final encoder = HexEncoder();
      I8.encodeToEncoder(encoder, -128);
      expect(encoder.toHex(), equals('0x80'));
    });

    test('When highest value 127 is encoded then it returns 0x7f', () {
      final encoder = HexEncoder();
      I8.encodeToEncoder(encoder, 127);
      expect(encoder.toHex(), equals('0x7f'));
    });

    test('When value -129 is encoded then it throws an exception', () {
      expect(() => I8.encodeToEncoder(HexEncoder(), -129),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test('When value 128 is encoded then it throws an exception', () {
      expect(() => I8.encodeToEncoder(HexEncoder(), 128),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });
}
