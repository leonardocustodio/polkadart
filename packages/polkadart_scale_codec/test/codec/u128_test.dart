import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('U128 Decode Test', () {
    final registry = TypeRegistry.createRegistry();
    test(
        'When lowest value 0x00000000000000000000000000000000 is decoded then it returns 0',
        () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('u128');
      final BigInt u128Value =
          codec.decode(Input('0x00000000000000000000000000000000'));
      expect(u128Value.toString(), equals('0'));
    });

    test(
        'When highest value 0xffffffffffffffffffffffffffffffff is decoded then it returns 340282366920938463463374607431768211455',
        () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('u128');
      final BigInt u128Value =
          codec.decode(Input('0xffffffffffffffffffffffffffffffff'));
      expect(u128Value.toString(),
          equals('340282366920938463463374607431768211455'));
    });
  });

  group('U128 Encode Test', () {
    final registry = TypeRegistry.createRegistry();
    test(
        'When lowest value 0 is encoded then it returns 0x00000000000000000000000000000000',
        () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('u128');
      final encoder = HexEncoder();
      codec.encode(encoder, BigInt.from(0));

      expect(encoder.toHex(), equals('0x00000000000000000000000000000000'));
    });

    test(
        'When highest value 340282366920938463463374607431768211455 is encoded then it returns 0xffffffffffffffffffffffffffffffff',
        () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('u128');
      final encoder = HexEncoder();
      codec.encode(
          encoder, BigInt.parse('340282366920938463463374607431768211455'));
      expect(encoder.toHex(), equals('0xffffffffffffffffffffffffffffffff'));
    });
  });

  group('Exception Test', () {
    final registry = TypeRegistry.createRegistry();

    test('When value -1 is encoded then it throws an exception', () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('u128');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, BigInt.from(-1)),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test(
        'When value 340282366920938463463374607431768211456 is encoded then it throws an exception',
        () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('u128');
      final encoder = HexEncoder();
      expect(
          () => codec.encode(
              encoder, BigInt.parse('340282366920938463463374607431768211456')),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  group('Custom Type Test', () {
    final registry = TypeRegistry.createRegistry();
    registry.addCustomCodec(
      <String, dynamic>{'u128_key': 'u128'},
    );

    test('When 0x00000000000000000000000000000000 is decoded then it returns 0',
        () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec(
        'u128_key',
      );
      final BigInt u128Value =
          codec.decode(Input('0x00000000000000000000000000000000'));
      expect(u128Value.toString(), equals('0'));
    });

    test(
        'When BigInt 0 is encoded then it returns 0x00000000000000000000000000000000',
        () {
      final codec =
          Codec<BigInt>(registry: registry).fetchTypeCodec('u128_key');
      final encoder = HexEncoder();
      codec.encode(encoder, BigInt.from(0));
      expect(encoder.toHex(), equals('0x00000000000000000000000000000000'));
    });

    test(
        'When 0xffffffffffffffffffffffffffffffff is decoded then it returns 340282366920938463463374607431768211455',
        () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec(
        'u128_key',
      );
      final BigInt u128Value =
          codec.decode(Input('0xffffffffffffffffffffffffffffffff'));
      expect(u128Value.toString(),
          equals('340282366920938463463374607431768211455'));
    });

    test(
        'When BigInt 340282366920938463463374607431768211455 is encoded then it returns 0xffffffffffffffffffffffffffffffff',
        () {
      final codec =
          Codec<BigInt>(registry: registry).fetchTypeCodec('u128_key');
      final encoder = HexEncoder();
      codec.encode(
          encoder, BigInt.parse('340282366920938463463374607431768211455'));
      expect(encoder.toHex(), equals('0xffffffffffffffffffffffffffffffff'));
    });
  });

  group('Custom Type Exception Test', () {
    final registry = TypeRegistry.createRegistry();
    registry.addCustomCodec(
      <String, dynamic>{'u128_key': 'u128'},
    );

    test('When value -1 is encoded then it throws an exception', () {
      final codec =
          Codec<BigInt>(registry: registry).fetchTypeCodec('u128_key');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, BigInt.from(-1)),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test(
        'When value 340282366920938463463374607431768211456 is encoded then it throws an exception',
        () {
      final codec =
          Codec<BigInt>(registry: registry).fetchTypeCodec('u128_key');
      final encoder = HexEncoder();
      expect(
          () => codec.encode(
              encoder, BigInt.parse('340282366920938463463374607431768211456')),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  // U128() Direct-test cases without type registry
  group('U128 Direct Test', () {
    test(
        'When lowest value 0x00000000000000000000000000000000 is decoded then it returns 0',
        () {
      final u128Value =
          U128.decodeFromInput(Input('0x00000000000000000000000000000000'));
      expect(u128Value.toString(), equals('0'));
    });

    test(
        'When highest value 0xffffffffffffffffffffffffffffffff is decoded then it returns 340282366920938463463374607431768211455',
        () {
      final u128Value =
          U128.decodeFromInput(Input('0xffffffffffffffffffffffffffffffff'));
      expect(u128Value.toString(),
          equals('340282366920938463463374607431768211455'));
    });

    test('When 0 is encoded then it returns 0x00000000000000000000000000000000',
        () {
      final encoder = HexEncoder();
      U128.encodeToEncoder(encoder, BigInt.from(0));
      expect(encoder.toHex(), equals('0x00000000000000000000000000000000'));
    });

    test(
        'When BigInt 340282366920938463463374607431768211455 is encoded then it returns 0xffffffffffffffffffffffffffffffff',
        () {
      final encoder = HexEncoder();
      U128.encodeToEncoder(
          encoder, BigInt.parse('340282366920938463463374607431768211455'));
      expect(encoder.toHex(), equals('0xffffffffffffffffffffffffffffffff'));
    });

    test('When value -1 is encoded then it throws an exception', () {
      final encoder = HexEncoder();
      expect(() => U128.encodeToEncoder(encoder, BigInt.from(-1)),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test(
        'When value 340282366920938463463374607431768211456 is encoded then it throws an exception',
        () {
      final encoder = HexEncoder();
      expect(
          () => U128.encodeToEncoder(
              encoder, BigInt.parse('340282366920938463463374607431768211456')),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });
}
