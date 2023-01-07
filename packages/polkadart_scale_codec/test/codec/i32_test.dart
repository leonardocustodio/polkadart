import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('I32 Decode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When lowest value 0x80000000 is decoded then it returns -2147483648',
        () {
      final codec = Codec(registry: registry)
          .createTypeCodec('i32', data: Source('0x00000080'));
      final i32Value = codec.decode();
      expect(i32Value, equals(-2147483648));
    });

    test('When highest value 0xffffff7f is decoded then it returns 2147483647',
        () {
      final codec = Codec(registry: registry)
          .createTypeCodec('i32', data: Source('0xffffff7f'));
      final i32Value = codec.decode();
      expect(i32Value, equals(2147483647));
    });
  });

  group('I32 Encode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When lowest value -2147483648 is encoded then it returns 0x80000000',
        () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i32');
      final i32Value = codec.encode(-2147483648);
      expect(i32Value, equals('00000080'));
    });

    test('When highest value 2147483647 is encoded then it returns 0xffffff7f',
        () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i32');
      final i32Value = codec.encode(2147483647);
      expect(i32Value, equals('ffffff7f'));
    });
  });

  group('Exception Test', () {
    final registry = TypeRegistry.createRegistry();

    test('When value -2147483649 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i32');
      expect(() => codec.encode(-2147483649),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test('When value 2147483648 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i32');
      expect(() => codec.encode(2147483648),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  group('Custom Json Test', () {
    final registry = TypeRegistry.createRegistry();
    TypeRegistry.addCustomCodec(
      registry,
      <String, dynamic>{
        'i32_key': 'i32',
      },
    );

    test('When i32 is encoded then it returns the correct json', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i32_key');
      final i32Value = codec.encode(2147483647);
      expect(i32Value, equals('ffffff7f'));
    });

    test('When i32 is decoded then it returns the correct json', () {
      final codec = Codec(registry: registry)
          .createTypeCodec('i32_key', data: Source('0xffffff7f'));
      final i32Value = codec.decode();
      expect(i32Value, equals(2147483647));
    });

    test('When i32 is encoded then it returns the correct json', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i32_key');
      final i32Value = codec.encode(-2147483648);
      expect(i32Value, equals('00000080'));
    });

    test('When i32 is decoded then it returns the correct json', () {
      final codec = Codec(registry: registry)
          .createTypeCodec('i32_key', data: Source('0x00000080'));
      final i32Value = codec.decode();
      expect(i32Value, equals(-2147483648));
    });
  });

  group('Exception Test', () {
    final registry = TypeRegistry.createRegistry();

    test('When value -2147483649 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i32');
      expect(() => codec.encode(-2147483649),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test('When value 2147483648 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).createTypeCodec('i32');
      expect(() => codec.encode(2147483648),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });
}
