import 'package:polkadart_scale_codec/src/codec_types/codec_types.dart';
import 'package:polkadart_scale_codec/src/core/core.dart';
import 'package:test/test.dart';

void main() {
  group('Str Decode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When value "0x1054657374" is decoded then it returns "Test"', () {
      final codec = Codec(registry: registry).fetchTypeCodec('str');
      final strValue = codec.decode(DefaultInput.fromHex('0x1054657374'));
      expect(strValue, equals('Test'));
    });
    test('When value "0x00" is decoded then it returns empty string', () {
      final codec = Codec(registry: registry).fetchTypeCodec('str');
      final strValue = codec.decode(DefaultInput.fromHex('0x00'));
      expect(strValue, equals(''));
    });
  });

  group('Str Encode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When value "Test" is encoded then it returns 0x1054657374', () {
      final codec = Codec<String>(registry: registry).fetchTypeCodec('str');
      final encoder = HexEncoder();
      codec.encode(encoder, 'Test');
      expect(encoder.toHex(), equals('0x1054657374'));
    });
    test('When empty string is encoded then it returns 0x', () {
      final codec = Codec<String>(registry: registry).fetchTypeCodec('str');
      final encoder = HexEncoder();
      codec.encode(encoder, '');
      expect(encoder.toHex(), equals('0x00'));
    });
  });

  group('Custom Json Test', () {
    final registry = TypeRegistry.createRegistry();
    registry.addCustomCodec(
      <String, dynamic>{
        'str_key': 'str',
      },
    );
    test('When value "Test" is encoded then it returns 0x1054657374', () {
      final codec = Codec<String>(registry: registry).fetchTypeCodec('str_key');
      final encoder = HexEncoder();
      codec.encode(encoder, 'Test');
      expect(encoder.toHex(), equals('0x1054657374'));
    });
    test('When empty string is encoded then it returns 0x', () {
      final codec = Codec<String>(registry: registry).fetchTypeCodec('str_key');
      final encoder = HexEncoder();
      codec.encode(encoder, '');
      expect(encoder.toHex(), equals('0x00'));
    });

    test('When value "0x1054657374" is decoded then it returns "Test"', () {
      final codec = Codec(registry: registry).fetchTypeCodec('str_key');
      final strValue = codec.decode(DefaultInput.fromHex('0x1054657374'));
      expect(strValue, equals('Test'));
    });
    test('When value "0x00" is decoded then it returns empty string', () {
      final codec = Codec(registry: registry).fetchTypeCodec('str');
      final strValue = codec.decode(DefaultInput.fromHex('0x00'));
      expect(strValue, equals(''));
    });
  });

  /// Str static tests
  group('Str Static Decode Test', () {
    test('When value "0x1054657374" is decoded then it returns "Test"', () {
      final strValue =
          Str.decodeFromInput(DefaultInput.fromHex('0x1054657374'));
      expect(strValue, equals('Test'));
    });
    test('When value "0x00" is decoded then it returns empty string', () {
      final strValue = Str.decodeFromInput(DefaultInput.fromHex('0x00'));
      expect(strValue, equals(''));
    });

    test('When value "Test" is encoded then it returns 0x1054657374', () {
      final encoder = HexEncoder();
      Str.encodeToEncoder(encoder, 'Test');
      expect(encoder.toHex(), equals('0x1054657374'));
    });

    test('When empty string is encoded then it returns 0x', () {
      final encoder = HexEncoder();
      Str.encodeToEncoder(encoder, '');
      expect(encoder.toHex(), equals('0x00'));
    });
  });
}
