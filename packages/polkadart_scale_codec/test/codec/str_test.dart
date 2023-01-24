import 'package:polkadart_scale_codec/src/core/core.dart';
import 'package:test/test.dart';

void main() {
  group('Str Decode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When value "0x1054657374" is decoded then it returns "Test"', () {
      final codec = Codec(registry: registry).createTypeCodec('str');
      final strValue = codec.decode(Input('0x1054657374'));
      expect(strValue, equals('Test'));
    });
    test('When value "0x00" is decoded then it returns empty string', () {
      final codec = Codec(registry: registry).createTypeCodec('str');
      final strValue = codec.decode(Input('0x00'));
      expect(strValue, equals(''));
    });
  });

  group('Str Encode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When value "Test" is encoded then it returns 0x1054657374', () {
      final codec = Codec<String>(registry: registry).createTypeCodec('str');
      final encoder = HexEncoder();
      codec.encode(encoder, 'Test');
      expect(encoder.toHex(), equals('0x1054657374'));
    });
    test('When empty string is encoded then it returns 0x', () {
      final codec = Codec<String>(registry: registry).createTypeCodec('str');
      final encoder = HexEncoder();
      codec.encode(encoder, '');
      expect(encoder.toHex(), equals('0x00'));
    });
  });

  group('Custom Json Test', () {
    final registry = TypeRegistry.createRegistry();
    TypeRegistry.addCustomCodec(
      registry,
      <String, dynamic>{
        'str_key': 'str',
      },
    );
    test('When value "Test" is encoded then it returns 0x1054657374', () {
      final codec =
          Codec<String>(registry: registry).createTypeCodec('str_key');
      final encoder = HexEncoder();
      codec.encode(encoder, 'Test');
      expect(encoder.toHex(), equals('0x1054657374'));
    });
    test('When empty string is encoded then it returns 0x', () {
      final codec =
          Codec<String>(registry: registry).createTypeCodec('str_key');
      final encoder = HexEncoder();
      codec.encode(encoder, '');
      expect(encoder.toHex(), equals('0x00'));
    });

    test('When value "0x1054657374" is decoded then it returns "Test"', () {
      final codec = Codec(registry: registry).createTypeCodec('str_key');
      final strValue = codec.decode(Input('0x1054657374'));
      expect(strValue, equals('Test'));
    });
    test('When value "0x00" is decoded then it returns empty string', () {
      final codec = Codec(registry: registry).createTypeCodec('str');
      final strValue = codec.decode(Input('0x00'));
      expect(strValue, equals(''));
    });
  });
}
