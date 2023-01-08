import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('I8 Decode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When lowest value 0x80 is decoded then it returns -128', () {
      final codec =
          Codec(registry: registry).createTypeCodec('i8', data: Source('0x80'));
      final i8Value = codec.decode();
      expect(i8Value, equals(-128));
    });

    test('When highest value 0x7f is decoded then it returns 127', () {
      final codec =
          Codec(registry: registry).createTypeCodec('i8', data: Source('0x7f'));
      final i8Value = codec.decode();
      expect(i8Value, equals(127));
    });
  });

  group('I8 Encode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When lowest value -128 is encoded then it returns 0x80', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i8');
      final i8Value = codec.encode(-128);
      expect(i8Value, equals('80'));
    });

    test('When highest value 127 is encoded then it returns 0x7f', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i8');
      final i8Value = codec.encode(127);
      expect(i8Value, equals('7f'));
    });
  });

  group('Exception Test', () {
    final registry = TypeRegistry.createRegistry();

    test('When value -129 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i8');
      expect(() => codec.encode(-129), throwsA(isA<UnexpectedCaseException>()));
    });

    test('When value 128 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i8');
      expect(() => codec.encode(128), throwsA(isA<UnexpectedCaseException>()));
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
      final codec = Codec(registry: registry)
          .createTypeCodec('i8_key', data: Source('0x80'));
      final i8Value = codec.decode();
      expect(i8Value, equals(-128));
    });

    test('When highest value 0x7f is decoded then it returns 127', () {
      final codec = Codec(registry: registry)
          .createTypeCodec('i8_key', data: Source('0x7f'));
      final i8Value = codec.decode();
      expect(i8Value, equals(127));
    });

    test('When lowest value -128 is encoded then it returns 0x80', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i8_key');
      final i8Value = codec.encode(-128);
      expect(i8Value, equals('80'));
    });

    test('When highest value 127 is encoded then it returns 0x7f', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i8_key');
      final i8Value = codec.encode(127);
      expect(i8Value, equals('7f'));
    });

    test('When value -129 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i8_key');
      expect(() => codec.encode(-129), throwsA(isA<UnexpectedCaseException>()));
    });

    test('When value 128 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i8_key');
      expect(() => codec.encode(128), throwsA(isA<UnexpectedCaseException>()));
    });
  });

  // I8() Direct Test Cases without type registry
  group('I8 Direct Test', () {
    test('When lowest value 0x80 is decoded then it returns -128', () {
      final codec = I8(source: Source('0x80'));
      final i8Value = codec.decode();
      expect(i8Value, equals(-128));
    });

    test('When highest value 0x7f is decoded then it returns 127', () {
      final codec = I8(source: Source('0x7f'));
      final i8Value = codec.decode();
      expect(i8Value, equals(127));
    });

    test('When lowest value -128 is encoded then it returns 0x80', () {
      final codec = I8();
      final i8Value = codec.encode(-128);
      expect(i8Value, equals('80'));
    });

    test('When highest value 127 is encoded then it returns 0x7f', () {
      final codec = I8();
      final i8Value = codec.encode(127);
      expect(i8Value, equals('7f'));
    });

    test('When value -129 is encoded then it throws an exception', () {
      final codec = I8();
      expect(() => codec.encode(-129), throwsA(isA<UnexpectedCaseException>()));
    });

    test('When value 128 is encoded then it throws an exception', () {
      final codec = I8();
      expect(() => codec.encode(128), throwsA(isA<UnexpectedCaseException>()));
    });
  });
}
