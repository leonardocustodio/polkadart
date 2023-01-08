import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  /// bool codec test cases
  group('Test bool Decode', () {
    final registry = TypeRegistry.createRegistry();
    test('When 0x01 is decoded then it returns true', () {
      final codec = Codec(registry: registry)
          .createTypeCodec('bool', data: Source('0x01'));
      final boolValue = codec.decode();
      expect(boolValue, equals(true));
    });

    test('When 0x00 is decoded then it returns false', () {
      final codec = Codec(registry: registry)
          .createTypeCodec('bool', data: Source('0x00'));
      final boolValue = codec.decode();
      expect(boolValue, equals(false));
    });
  });

  group('Test bool Encode', () {
    final registry = TypeRegistry.createRegistry();
    test('When true is encoded then it returns 0x01', () {
      final codec = Codec(registry: registry).createTypeCodec('bool');
      final boolValue = codec.encode(true);
      expect(boolValue, equals('01'));
    });

    test('When false is encoded then it returns 0x00', () {
      final codec = Codec(registry: registry).createTypeCodec('bool');
      final boolValue = codec.encode(false);
      expect(boolValue, equals('00'));
    });
  });

  group('Custom Json Test', () {
    final registry = TypeRegistry.createRegistry();
    TypeRegistry.addCustomCodec(
      registry,
      <String, dynamic>{
        'bool_key': 'bool',
      },
    );
    test('When 0x01 is decoded then it returns true', () {
      final codec = Codec(registry: registry)
          .createTypeCodec('bool_key', data: Source('0x01'));
      final boolValue = codec.decode();
      expect(boolValue, equals(true));
    });

    test('When 0x00 is decoded then it returns false', () {
      final codec = Codec(registry: registry)
          .createTypeCodec('bool_key', data: Source('0x00'));
      final boolValue = codec.decode();
      expect(boolValue, equals(false));
    });

    test('When true is encoded then it returns 0x01', () {
      final codec = Codec(registry: registry).createTypeCodec('bool_key');
      final boolValue = codec.encode(true);
      expect(boolValue, equals('01'));
    });

    test('When false is encoded then it returns 0x00', () {
      final codec = Codec(registry: registry).createTypeCodec('bool_key');
      final boolValue = codec.encode(false);
      expect(boolValue, equals('00'));
    });
  });

  group('Test bool exceptions cases', () {
    final registry = TypeRegistry.createRegistry();
    test('When 0x02 is decoded then it throws CodecException.', () {
      final codec = Codec(registry: registry)
          .createTypeCodec('bool', data: Source('0x02'));
      expect(() => codec.decode(), throwsA(isA<UnexpectedCaseException>()));
    });

    test('When null is encoded then it throws CodecException.', () {
      final codec = Codec(registry: registry).createTypeCodec('bool');
      expect(() => codec.encode(null), throwsA(isA<Error>()));
    });
  });

  /// Decode from source bool test-cases
  group('Test bool DecodeFromSource', () {
    test('When 0x01 is decoded then it returns true', () {
      final boolValue = BoolCodec.decodeFromSource(Source('0x01'));
      expect(boolValue, equals(true));
    });

    test('When 0x00 is decoded then it returns false', () {
      final boolValue = BoolCodec.decodeFromSource(Source('0x00'));
      expect(boolValue, equals(false));
    });
  });
}
