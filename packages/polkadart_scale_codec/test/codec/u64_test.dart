import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('U64 Decode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When lowest value 0x0000000000000000 is decoded then it returns 0',
        () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('u64');
      final BigInt u64Value =
          codec.decode(DefaultInput.fromHex('0x0000000000000000'));
      expect(u64Value.toString(), equals('0'));
    });

    test(
        'When highest value 0xffffffffffffffff is decoded then it returns 18446744073709551615',
        () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('u64');
      final BigInt u64Value =
          codec.decode(DefaultInput.fromHex('0xffffffffffffffff'));
      expect(u64Value.toString(), equals('18446744073709551615'));
    });
  });

  group('U64 Encode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When lowest value 0 is encoded then it returns 0x0000000000000000',
        () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('u64');
      final encoder = HexEncoder();
      codec.encode(encoder, BigInt.from(0));
      expect(encoder.toHex(), equals('0x0000000000000000'));
    });

    test(
        'When highest value 18446744073709551615 is encoded then it returns 0xffffffffffffffff',
        () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('u64');
      final encoder = HexEncoder();
      codec.encode(encoder, BigInt.parse('18446744073709551615'));
      expect(encoder.toHex(), equals('0xffffffffffffffff'));
    });
  });

  group('Exception Test', () {
    final registry = TypeRegistry.createRegistry();

    test('When value -1 is encoded then it throws an exception', () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('u64');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, BigInt.from(-1)),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test(
        'When value 18446744073709551616 is encoded then it throws an exception',
        () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('u64');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, BigInt.parse('18446744073709551616')),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  group('Custom Json Test', () {
    final registry = TypeRegistry.createRegistry();
    registry.registerCustomCodec(
      <String, dynamic>{
        'u64_key': 'u64',
      },
    );

    test('When 0x0000000000000000 is decoded then it returns 0', () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('u64_key');
      final BigInt u64Value =
          codec.decode(DefaultInput.fromHex('0x0000000000000000'));
      expect(u64Value.toString(), equals('0'));
    });

    test('When BigInt 0 is encoded then it returns 0x0000000000000000', () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('u64_key');
      final encoder = HexEncoder();
      codec.encode(encoder, BigInt.from(0));
      expect(encoder.toHex(), equals('0x0000000000000000'));
    });

    test(
        'When 0xffffffffffffffff is decoded then it returns 18446744073709551615',
        () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('u64_key');
      final BigInt u64Value =
          codec.decode(DefaultInput.fromHex('0xffffffffffffffff'));
      expect(u64Value.toString(), equals('18446744073709551615'));
    });

    test(
        'When BigInt 18446744073709551615 is encoded then it returns 0xffffffffffffffff',
        () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('u64_key');
      final encoder = HexEncoder();
      codec.encode(encoder, BigInt.parse('18446744073709551615'));
      expect(encoder.toHex(), equals('0xffffffffffffffff'));
    });
  });

  group('Custom Json Exception Test', () {
    final registry = TypeRegistry.createRegistry();
    registry.registerCustomCodec(
      <String, dynamic>{
        'u64_key': 'u64',
      },
    );

    test('When value -1 is encoded then it throws an exception', () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('u64_key');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, BigInt.from(-1)),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test(
        'When value 18446744073709551616 is encoded then it throws an exception',
        () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('u64_key');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, BigInt.parse('18446744073709551616')),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  // Direct test-cases for U64.decodeFromInput(Input())
  group('U64 Direct Test', () {
    test('When lowest value 0x0000000000000000 is decoded then it returns 0',
        () {
      final u64Value =
          U64.decodeFromInput(DefaultInput.fromHex('0x0000000000000000'));
      expect(u64Value.toString(), equals('0'));
    });

    test(
        'When highest value 0xffffffffffffffff is decoded then it returns 18446744073709551615',
        () {
      final u64Value =
          U64.decodeFromInput(DefaultInput.fromHex('0xffffffffffffffff'));
      expect(u64Value.toString(), equals('18446744073709551615'));
    });
    test('When lowest value 0 is encoded then it returns 0x0000000000000000',
        () {
      final encoder = HexEncoder();
      U64.encodeToEncoder(encoder, BigInt.from(0));
      expect(encoder.toHex(), equals('0x0000000000000000'));
    });
    test(
        'When highest value 18446744073709551615 is encoded then it returns 0xffffffffffffffff',
        () {
      final encoder = HexEncoder();
      U64.encodeToEncoder(encoder, BigInt.parse('18446744073709551615'));
      expect(encoder.toHex(), equals('0xffffffffffffffff'));
    });
    test('When value -1 is encoded then it throws an exception', () {
      final encoder = HexEncoder();
      expect(() => U64.encodeToEncoder(encoder, BigInt.from(-1)),
          throwsA(isA<UnexpectedCaseException>()));
    });
    test(
        'When value 18446744073709551616 is encoded then it throws an exception',
        () {
      final encoder = HexEncoder();
      expect(
          () => U64.encodeToEncoder(
              encoder, BigInt.parse('18446744073709551616')),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });
}
