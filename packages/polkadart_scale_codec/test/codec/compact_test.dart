import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Compact Decode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When lowest value 0x00 is decoded then it returns 0', () {
      final codec = Codec(registry: registry).fetchTypeCodec('Compact');
      final compactValue = codec.decode(Input('0x00'));
      expect(compactValue, equals(0));
    });

    test(
        'When highest value 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff is decoded then it returns ((BigInt.from(64) << 530) - BigInt.from(1))',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('Compact');
      final compactValue = codec.decode(Input(
          '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'));
      expect(compactValue, equals(((BigInt.from(64) << 530) - BigInt.from(1))));
    });
  });

  group('Compact Encode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When lowest value 0 is encoded then it returns 0x00', () {
      final codec = Codec(registry: registry).fetchTypeCodec('Compact');
      final encoder = HexEncoder();
      codec.encode(encoder, 0);
      expect(encoder.toHex(), equals('0x00'));
    });

    test(
        'When highest value ((BigInt.from(64) << 530) - BigInt.from(1)) is encoded then it returns 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('Compact');
      final encoder = HexEncoder();
      codec.encode(encoder, (BigInt.from(64) << 530) - BigInt.from(1));
      expect(
          encoder.toHex(),
          equals(
              '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'));
    });
  });

  group('Exception Test', () {
    final registry = TypeRegistry.createRegistry();

    test('When value -1 is encoded then it throws an exception', () {
      final codec = Codec(registry: registry).fetchTypeCodec('Compact');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, -1),
          throwsA(isA<IncompatibleCompactValueException>()));
    });

    test(
        'When value (BigInt.from(64) << 530) is encoded then it throws an exception',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('Compact');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, (BigInt.from(64) << 530)),
          throwsA(isA<IncompatibleCompactValueException>()));
    });
  });

  group('Custom Json Test', () {
    final registry = TypeRegistry.createRegistry();
    registry.addCustomCodec(
      <String, dynamic>{
        'Compact_key': 'Compact',
      },
    );

    test('When lowest value 0x00 is decoded then it returns 0', () {
      final codec = Codec(registry: registry).fetchTypeCodec('Compact_key');
      final compactValue = codec.decode(Input('0x00'));
      expect(compactValue, equals(0));
    });

    test(
        'When highest value 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff is decoded then it returns ((BigInt.from(64) << 530) - BigInt.from(1))',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec(
        'Compact_key',
      );
      final compactValue = codec.decode(Input(
          '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'));
      expect(compactValue, equals(((BigInt.from(64) << 530) - BigInt.from(1))));
    });

    test('When lowest value 0 is encoded then it returns 0x00', () {
      final codec = Codec(registry: registry).fetchTypeCodec('Compact_key');
      final encoder = HexEncoder();
      codec.encode(encoder, 0);
      expect(encoder.toHex(), equals('0x00'));
    });

    test(
        'When highest value ((BigInt.from(64) << 530) - BigInt.from(1)) is encoded then it returns 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('Compact_key');
      final encoder = HexEncoder();
      codec.encode(encoder, ((BigInt.from(64) << 530) - BigInt.from(1)));
      expect(
          encoder.toHex(),
          equals(
              '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'));
    });

    test('When value -1 is encoded then it throws an exception', () {
      final codec = Codec(registry: registry).fetchTypeCodec('Compact_key');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, -1),
          throwsA(isA<IncompatibleCompactValueException>()));
    });

    test(
        'When value (BigInt.from(64) << 530) is encoded then it throws an exception',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('Compact_key');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, (BigInt.from(64) << 530)),
          throwsA(isA<IncompatibleCompactValueException>()));
    });
  });

  // Compact() Direct Test Cases without type registry
  group('Compact Direct Test', () {
    test('When lowest value 0x00 is decoded then it returns 0', () {
      final compactValue = Compact.decodeFromInput(Input('0x00'));
      expect(compactValue, equals(0));
    });

    test(
        'When highest value 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff is decoded then it returns ((BigInt.from(64) << 530) - BigInt.from(1))',
        () {
      final compactValue = Compact.decodeFromInput(Input(
          '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'));
      expect(compactValue, equals(((BigInt.from(64) << 530) - BigInt.from(1))));
    });

    test('When lowest value 0 is encoded then it returns 0x00', () {
      final encoder = HexEncoder();
      Compact.encodeToEncoder(encoder, 0);
      expect(encoder.toHex(), equals('0x00'));
    });

    test(
        'When highest value ((BigInt.from(64) << 530) - BigInt.from(1)) is encoded then it returns 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
        () {
      final encoder = HexEncoder();
      Compact.encodeToEncoder(
          encoder, ((BigInt.from(64) << 530) - BigInt.from(1)));
      expect(
          encoder.toHex(),
          equals(
              '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'));
    });

    test('When value -1 is encoded then it throws an exception', () {
      expect(() => Compact.encodeToEncoder(HexEncoder(), -1),
          throwsA(isA<IncompatibleCompactValueException>()));
    });

    test(
        'When value (BigInt.from(64) << 530) is encoded then it throws an exception',
        () {
      expect(
          () => Compact.encodeToEncoder(HexEncoder(), (BigInt.from(64) << 530)),
          throwsA(isA<IncompatibleCompactValueException>()));
    });
  });
}
