import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('I16 Decode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When lowest value 0x8000 is decoded then it returns -32768', () {
      final codec = Codec(registry: registry)
          .createTypeCodec('i16', data: Source('0x0080'));
      final i16Value = codec.decode();
      expect(i16Value, equals(-32768));
    });

    test('When highest value 0xff7f is decoded then it returns 32767', () {
      final codec = Codec(registry: registry)
          .createTypeCodec('i16', data: Source('0xff7f'));
      final i16Value = codec.decode();
      expect(i16Value, equals(32767));
    });
  });

  group('I16 Encode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When lowest value -32768 is encoded then it returns 0x8000', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i16');
      final i16Value = codec.encode(-32768);
      expect(i16Value, equals('0080'));
    });

    test('When highest value 32767 is encoded then it returns 0xff7f', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i16');
      final i16Value = codec.encode(32767);
      expect(i16Value, equals('ff7f'));
    });
  });

  group('Exception Test', () {
    final registry = TypeRegistry.createRegistry();

    test('When value -32769 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i16');
      expect(
          () => codec.encode(-32769), throwsA(isA<UnexpectedCaseException>()));
    });

    test('When value 32768 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i16');
      expect(
          () => codec.encode(32768), throwsA(isA<UnexpectedCaseException>()));
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
      final codec = Codec(registry: registry)
          .createTypeCodec('i16', data: Source('0x0080'));
      final i16Value = codec.decode();
      expect(i16Value, equals(-32768));
    });

    test('When highest value 0xff7f is decoded then it returns 32767', () {
      final codec = Codec(registry: registry)
          .createTypeCodec('i16', data: Source('0xff7f'));
      final i16Value = codec.decode();
      expect(i16Value, equals(32767));
    });

    test('When lowest value -32768 is encoded then it returns 0x8000', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i16');
      final i16Value = codec.encode(-32768);
      expect(i16Value, equals('0080'));
    });

    test('When highest value 32767 is encoded then it returns 0xff7f', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i16');
      final i16Value = codec.encode(32767);
      expect(i16Value, equals('ff7f'));
    });

    test('When value -32769 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i16');
      expect(
          () => codec.encode(-32769), throwsA(isA<UnexpectedCaseException>()));
    });

    test('When value 32768 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i16');
      expect(
          () => codec.encode(32768), throwsA(isA<UnexpectedCaseException>()));
    });
  });

  // I16() direct test cases without type registry
  group('I16 Direct Test', () {
    test('When lowest value 0x8000 is decoded then it returns -32768', () {
      final codec = I16(source: Source('0x0080'));
      final i16Value = codec.decode();
      expect(i16Value, equals(-32768));
    });

    test('When highest value 0xff7f is decoded then it returns 32767', () {
      final codec = I16(source: Source('0xff7f'));
      final i16Value = codec.decode();
      expect(i16Value, equals(32767));
    });

    test('When lowest value -32768 is encoded then it returns 0x8000', () {
      final codec = I16();
      final i16Value = codec.encode(-32768);
      expect(i16Value, equals('0080'));
    });

    test('When highest value 32767 is encoded then it returns 0xff7f', () {
      final codec = I16();
      final i16Value = codec.encode(32767);
      expect(i16Value, equals('ff7f'));
    });

    test('When value -32769 is encoded then it throws an exception', () {
      final codec = I16();
      expect(
          () => codec.encode(-32769), throwsA(isA<UnexpectedCaseException>()));
    });

    test('When value 32768 is encoded then it throws an exception', () {
      final codec = I16();
      expect(
          () => codec.encode(32768), throwsA(isA<UnexpectedCaseException>()));
    });
  });
}
