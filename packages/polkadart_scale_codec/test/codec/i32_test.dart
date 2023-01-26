import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('I32 Decode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When lowest value 0x80000000 is decoded then it returns -2147483648',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('i32');
      final i32Value = codec.decode(DefaultInput.fromHex('0x00000080'));
      expect(i32Value, equals(-2147483648));
    });

    test('When highest value 0xffffff7f is decoded then it returns 2147483647',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('i32');
      final i32Value = codec.decode(DefaultInput.fromHex('0xffffff7f'));
      expect(i32Value, equals(2147483647));
    });
  });

  group('I32 Encode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When lowest value -2147483648 is encoded then it returns 0x80000000',
        () {
      final codec = Codec<int>(registry: registry).fetchTypeCodec('i32');
      final encoder = HexEncoder();
      codec.encode(encoder, -2147483648);
      expect(encoder.toHex(), equals('0x00000080'));
    });

    test('When highest value 2147483647 is encoded then it returns 0xffffff7f',
        () {
      final codec = Codec<int>(registry: registry).fetchTypeCodec('i32');
      final encoder = HexEncoder();
      codec.encode(encoder, 2147483647);
      expect(encoder.toHex(), equals('0xffffff7f'));
    });
  });

  group('Exception Test', () {
    final registry = TypeRegistry.createRegistry();

    test('When value -2147483649 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).fetchTypeCodec('i32');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, -2147483649),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test('When value 2147483648 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).fetchTypeCodec('i32');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, 2147483648),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  group('Custom Json Test', () {
    final registry = TypeRegistry.createRegistry();
    registry.addCustomCodec(
      <String, dynamic>{
        'i32_key': 'i32',
      },
    );

    test('When i32 is encoded then it returns the correct json', () {
      final codec = Codec<int>(registry: registry).fetchTypeCodec('i32_key');
      final encoder = HexEncoder();
      codec.encode(encoder, 2147483647);
      expect(encoder.toHex(), equals('0xffffff7f'));
    });

    test('When i32 is decoded then it returns the correct json', () {
      final codec = Codec(registry: registry).fetchTypeCodec('i32_key');
      final i32Value = codec.decode(DefaultInput.fromHex('0xffffff7f'));
      expect(i32Value, equals(2147483647));
    });

    test('When i32 is encoded then it returns the correct json', () {
      final codec = Codec<int>(registry: registry).fetchTypeCodec('i32_key');
      final encoder = HexEncoder();
      codec.encode(encoder, -2147483648);
      expect(encoder.toHex(), equals('0x00000080'));
    });

    test('When i32 is decoded then it returns the correct json', () {
      final codec = Codec(registry: registry).fetchTypeCodec('i32_key');
      final i32Value = codec.decode(DefaultInput.fromHex('0x00000080'));
      expect(i32Value, equals(-2147483648));
    });
  });

  group('Exception Test', () {
    final registry = TypeRegistry.createRegistry();

    test('When value -2147483649 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).fetchTypeCodec('i32');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, -2147483649),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test('When value 2147483648 is encoded then it throws an exception', () {
      final codec = Codec<int>(registry: registry).fetchTypeCodec('i32');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, 2147483648),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  // I32() Direct Test Cases without type registry
  group('I32 Direct Test', () {
    test('When lowest value 0x80000000 is decoded then it returns -2147483648',
        () {
      final i32Value = I32.decodeFromInput(DefaultInput.fromHex('0x00000080'));
      expect(i32Value, equals(-2147483648));
    });

    test('When highest value 0xffffff7f is decoded then it returns 2147483647',
        () {
      final i32Value = I32.decodeFromInput(DefaultInput.fromHex('0xffffff7f'));
      expect(i32Value, equals(2147483647));
    });

    test('When lowest value -2147483648 is encoded then it returns 0x80000000',
        () {
      final encoder = HexEncoder();
      I32.encodeToEncoder(encoder, -2147483648);
      expect(encoder.toHex(), equals('0x00000080'));
    });

    test('When highest value 2147483647 is encoded then it returns 0xffffff7f',
        () {
      final encoder = HexEncoder();
      I32.encodeToEncoder(encoder, 2147483647);
      expect(encoder.toHex(), equals('0xffffff7f'));
    });
  });
}
