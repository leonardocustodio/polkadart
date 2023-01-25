import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  /// bool codec test cases
  group('Test bool Decode', () {
    final registry = TypeRegistry.createRegistry();
    test('When 0x01 is decoded then it returns true', () {
      final codec = Codec(registry: registry).fetchTypeCodec('bool');
      final boolValue = codec.decode(Input('0x01'));
      expect(boolValue, equals(true));
    });

    test('When 0x00 is decoded then it returns false', () {
      final codec = Codec(registry: registry).fetchTypeCodec('bool');
      final boolValue = codec.decode(Input('0x00'));
      expect(boolValue, equals(false));
    });
  });

  group('Test bool Encode', () {
    final registry = TypeRegistry.createRegistry();
    test('When true is encoded then it returns 0x01', () {
      final codec = Codec(registry: registry).fetchTypeCodec('bool');
      final encoder = HexEncoder();
      codec.encode(encoder, true);
      final boolValue = encoder.toHex();
      expect(boolValue, equals('0x01'));
    });

    test('When false is encoded then it returns 0x00', () {
      final codec = Codec(registry: registry).fetchTypeCodec('bool');
      final encoder = HexEncoder();
      codec.encode(encoder, false);
      final boolValue = encoder.toHex();
      expect(boolValue, equals('0x00'));
    });
  });

  group('Custom Json Test', () {
    final registry = TypeRegistry.createRegistry();
    registry.addCustomCodec(
      <String, dynamic>{
        'bool_key': 'bool',
      },
    );
    test('When 0x01 is decoded then it returns true', () {
      final codec = Codec(registry: registry).fetchTypeCodec('bool_key');
      final boolValue = codec.decode(Input('0x01'));
      expect(boolValue, equals(true));
    });

    test('When 0x00 is decoded then it returns false', () {
      final codec = Codec(registry: registry).fetchTypeCodec('bool_key');
      final boolValue = codec.decode(Input('0x00'));
      expect(boolValue, equals(false));
    });

    test('When true is encoded then it returns 0x01', () {
      final codec = Codec(registry: registry).fetchTypeCodec('bool_key');
      final encoder = HexEncoder();
      codec.encode(encoder, true);
      final boolValue = encoder.toHex();
      expect(boolValue, equals('0x01'));
    });

    test('When false is encoded then it returns 0x00', () {
      final codec = Codec(registry: registry).fetchTypeCodec('bool_key');
      final encoder = HexEncoder();
      codec.encode(encoder, false);
      final boolValue = encoder.toHex();
      expect(boolValue, equals('0x00'));
    });
  });

  group('Test bool exceptions cases', () {
    final registry = TypeRegistry.createRegistry();
    test('When 0x02 is decoded then it throws CodecException.', () {
      final codec = Codec(registry: registry).fetchTypeCodec('bool');
      expect(() => codec.decode(Input('0x02')),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test('When null is encoded then it throws CodecException.', () {
      final codec = Codec(registry: registry).fetchTypeCodec('bool');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, null), throwsA(isA<Error>()));
    });
  });

  /// BoolCodec direct test cases
  group('Test BoolCodec Decode', () {
    test('When 0x01 is decoded then it returns true', () {
      final boolValue = BoolCodec.decodeFromInput(Input('0x01'));
      expect(boolValue, equals(true));
    });

    test('When 0x00 is decoded then it returns false', () {
      final boolValue = BoolCodec.decodeFromInput(Input('0x00'));
      expect(boolValue, equals(false));
    });

    test('When 0x02 is decoded then it throws CodecException.', () {
      expect(() => BoolCodec.decodeFromInput(Input('0x02')),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  group('Test BoolCodec Encode', () {
    test('When true is encoded then it returns 0x01', () {
      final encoder = HexEncoder();
      BoolCodec.encodeToEncoder(encoder, true);
      final boolValue = encoder.toHex();
      expect(boolValue, equals('0x01'));
    });

    test('When false is encoded then it returns 0x00', () {
      final encoder = HexEncoder();
      BoolCodec.encodeToEncoder(encoder, false);
      final boolValue = encoder.toHex();
      expect(boolValue, equals('0x00'));
    });
  });
}
