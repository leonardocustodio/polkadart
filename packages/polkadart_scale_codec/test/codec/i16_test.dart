import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('I16 Decode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When lowest value 0x8000 is decoded then it returns -32768', () {
      final codec = Codec(registry: registry).createTypeCodec('i16');
      final i16Value = codec.decode(Input('0x0080'));
      expect(i16Value, equals(-32768));
    });

    test('When highest value 0xff7f is decoded then it returns 32767', () {
      final codec = Codec(registry: registry).createTypeCodec('i16');
      final i16Value = codec.decode(Input('0xff7f'));
      expect(i16Value, equals(32767));
    });
  });

  group('I16 Encode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When lowest value -32768 is encoded then it returns 0x8000', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i16');
      final encoder = HexEncoder();
      codec.encode(encoder, -32768);
      expect(encoder.toHex(), equals('0x0080'));
    });

    test('When highest value 32767 is encoded then it returns 0xff7f', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i16');
      final encoder = HexEncoder();
      codec.encode(encoder, 32767);
      expect(encoder.toHex(), equals('0xff7f'));
    });
  });

  group('Exception Test', () {
    final registry = TypeRegistry.createRegistry();

    test('When value -32769 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i16');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, -32769),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test('When value 32768 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i16');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, 32768),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  group('Custom Json Test', () {
    final registry = TypeRegistry.createRegistry();
    TypeRegistry.addCustomCodec(
      registry,
      <String, dynamic>{
        'i16_key': 'i16',
      },
    );

    test('When lowest value 0x8000 is decoded then it returns -32768', () {
      final codec = Codec(registry: registry).createTypeCodec('i16');
      final i16Value = codec.decode(Input('0x0080'));
      expect(i16Value, equals(-32768));
    });

    test('When highest value 0xff7f is decoded then it returns 32767', () {
      final codec = Codec(registry: registry).createTypeCodec('i16');
      final i16Value = codec.decode(Input('0xff7f'));
      expect(i16Value, equals(32767));
    });

    test('When lowest value -32768 is encoded then it returns 0x8000', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i16');
      final encoder = HexEncoder();
      codec.encode(encoder, -32768);
      expect(encoder.toHex(), equals('0x0080'));
    });

    test('When highest value 32767 is encoded then it returns 0xff7f', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i16');
      final encoder = HexEncoder();
      codec.encode(encoder, 32767);
      expect(encoder.toHex(), equals('0xff7f'));
    });

    test('When value -32769 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i16');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, -32769),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test('When value 32768 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i16');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, 32768),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  // I16() direct test cases without type registry
  group('I16 Direct Test', () {
    test('When lowest value 0x8000 is decoded then it returns -32768', () {
      final i16Value = I16.decodeFromInput(Input('0x0080'));
      expect(i16Value, equals(-32768));
    });

    test('When highest value 0xff7f is decoded then it returns 32767', () {
      final i16Value = I16.decodeFromInput(Input('0xff7f'));
      expect(i16Value, equals(32767));
    });

    test('When lowest value -32768 is encoded then it returns 0x8000', () {
      final encoder = HexEncoder();
      I16.encodeToEncoder(encoder, -32768);
      expect(encoder.toHex(), equals('0x0080'));
    });

    test('When highest value 32767 is encoded then it returns 0xff7f', () {
      final encoder = HexEncoder();
      I16.encodeToEncoder(encoder, 32767);
      expect(encoder.toHex(), equals('0xff7f'));
    });

    test('When value -32769 is encoded then it throws an exception', () {
      final encoder = HexEncoder();
      expect(() => I16.encodeToEncoder(encoder, -32769),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test('When value 32768 is encoded then it throws an exception', () {
      final encoder = HexEncoder();
      expect(() => I16.encodeToEncoder(encoder, 32768),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });
}
