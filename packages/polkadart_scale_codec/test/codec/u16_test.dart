import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('U16 Decode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When lowest value 0x0000 is decoded then it returns 0', () {
      final codec = Codec(registry: registry)
          .createTypeCodec('u16', data: Source('0x0000'));
      final u16Value = codec.decode();
      expect(u16Value, equals(0));
    });

    test('When highest value 0xffff is decoded then it returns 65535', () {
      final codec = Codec(registry: registry)
          .createTypeCodec('u16', data: Source('0xffff'));
      final u16Value = codec.decode();
      expect(u16Value, equals(65535));
    });
  });

  group('U16 Encode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When lowest value 0 is encoded then it returns 0x0000', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('u16');
      final u16Value = codec.encode(0);
      expect(u16Value, equals('0000'));
    });

    test('When highest value 65535 is encoded then it returns 0xffff', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('u16');
      final u16Value = codec.encode(65535);
      expect(u16Value, equals('ffff'));
    });
  });

  group('Exception Test', () {
    final registry = TypeRegistry.createRegistry();

    test('When value -1 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('u16');
      expect(() => codec.encode(-1), throwsA(isA<UnexpectedCaseException>()));
    });

    test('When value 65536 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('u16');
      expect(
          () => codec.encode(65536), throwsA(isA<UnexpectedCaseException>()));
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
      final codec = Codec(registry: registry)
          .createTypeCodec('u16_key', data: Source('0x0000'));
      final u16Value = codec.decode();
      expect(u16Value, equals(0));
    });

    test('When highest value 0xffff is decoded then it returns 65535', () {
      final codec = Codec(registry: registry)
          .createTypeCodec('u16_key', data: Source('0xffff'));
      final u16Value = codec.decode();
      expect(u16Value, equals(65535));
    });

    test('When lowest value 0 is encoded then it returns 0x0000', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('u16_key');
      final u16Value = codec.encode(0);
      expect(u16Value, equals('0000'));
    });

    test('When highest value 65535 is encoded then it returns 0xffff', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('u16_key');
      final u16Value = codec.encode(65535);
      expect(u16Value, equals('ffff'));
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
      final codec = Codec<int>(registry: registry).createTypeCodec('u16_key');
      expect(() => codec.encode(-1), throwsA(isA<UnexpectedCaseException>()));
    });

    test('When value 65536 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('u16_key');
      expect(
          () => codec.encode(65536), throwsA(isA<UnexpectedCaseException>()));
    });
  });
}
