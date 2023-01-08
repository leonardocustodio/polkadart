import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('U64 Decode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When lowest value 0x0000000000000000 is decoded then it returns 0',
        () {
      final codec = Codec<BigInt>(registry: registry)
          .createTypeCodec('u64', data: Source('0x0000000000000000'));
      final BigInt u64Value = codec.decode();
      expect(u64Value.toString(), equals('0'));
    });

    test(
        'When highest value 0xffffffffffffffff is decoded then it returns 18446744073709551615',
        () {
      final codec = Codec<BigInt>(registry: registry)
          .createTypeCodec('u64', data: Source('0xffffffffffffffff'));
      final BigInt u64Value = codec.decode();
      expect(u64Value.toString(), equals('18446744073709551615'));
    });
  });

  group('U64 Encode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When lowest value 0 is encoded then it returns 0x0000000000000000',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('u64');
      final String u64Value = codec.encode(BigInt.from(0));
      expect(u64Value, equals('0000000000000000'));
    });

    test(
        'When highest value 18446744073709551615 is encoded then it returns 0xffffffffffffffff',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('u64');
      final String u64Value =
          codec.encode(BigInt.parse('18446744073709551615'));
      expect(u64Value, equals('ffffffffffffffff'));
    });
  });

  group('Exception Test', () {
    final registry = TypeRegistry.createRegistry();

    test('When value -1 is encoded then it throws an exception', () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('u64');
      expect(() => codec.encode(BigInt.from(-1)),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test(
        'When value 18446744073709551616 is encoded then it throws an exception',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('u64');
      expect(() => codec.encode(BigInt.parse('18446744073709551616')),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  group('Custom Json Test', () {
    final registry = TypeRegistry.createRegistry();
    TypeRegistry.addCustomCodec(
      registry,
      <String, dynamic>{
        'u64_key': 'u64',
      },
    );

    test('When 0x0000000000000000 is decoded then it returns 0', () {
      final codec = Codec<BigInt>(registry: registry)
          .createTypeCodec('u64_key', data: Source('0x0000000000000000'));
      final BigInt u64Value = codec.decode();
      expect(u64Value.toString(), equals('0'));
    });

    test('When BigInt 0 is encoded then it returns 0x0000000000000000', () {
      final codec =
          Codec<BigInt>(registry: registry).createTypeCodec('u64_key');
      final String u64Value = codec.encode(BigInt.from(0));
      expect(u64Value, equals('0000000000000000'));
    });

    test(
        'When 0xffffffffffffffff is decoded then it returns 18446744073709551615',
        () {
      final codec = Codec<BigInt>(registry: registry)
          .createTypeCodec('u64_key', data: Source('0xffffffffffffffff'));
      final BigInt u64Value = codec.decode();
      expect(u64Value.toString(), equals('18446744073709551615'));
    });

    test(
        'When BigInt 18446744073709551615 is encoded then it returns 0xffffffffffffffff',
        () {
      final codec =
          Codec<BigInt>(registry: registry).createTypeCodec('u64_key');
      final String u64Value =
          codec.encode(BigInt.parse('18446744073709551615'));
      expect(u64Value, equals('ffffffffffffffff'));
    });
  });

  group('Custom Json Exception Test', () {
    final registry = TypeRegistry.createRegistry();
    TypeRegistry.addCustomCodec(
      registry,
      <String, dynamic>{
        'u64_key': 'u64',
      },
    );

    test('When value -1 is encoded then it throws an exception', () {
      final codec =
          Codec<BigInt>(registry: registry).createTypeCodec('u64_key');
      expect(() => codec.encode(BigInt.from(-1)),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test(
        'When value 18446744073709551616 is encoded then it throws an exception',
        () {
      final codec =
          Codec<BigInt>(registry: registry).createTypeCodec('u64_key');
      expect(() => codec.encode(BigInt.parse('18446744073709551616')),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  // Direct test-cases for U64(source: Source())
  group('U64 Direct Test', () {
    test('When lowest value 0x0000000000000000 is decoded then it returns 0',
        () {
      final u64Codec = U64(source: Source('0x0000000000000000'));
      final BigInt u64Value = u64Codec.decode();
      expect(u64Value.toString(), equals('0'));
    });

    test(
        'When highest value 0xffffffffffffffff is decoded then it returns 18446744073709551615',
        () {
      final u64Codec = U64(source: Source('0xffffffffffffffff'));
      final BigInt u64Value = u64Codec.decode();
      expect(u64Value.toString(), equals('18446744073709551615'));
    });
    test('When lowest value 0 is encoded then it returns 0x0000000000000000',
        () {
      final u64Codec = U64();
      final String u64Value = u64Codec.encode(BigInt.from(0));
      expect(u64Value, equals('0000000000000000'));
    });
    test(
        'When highest value 18446744073709551615 is encoded then it returns 0xffffffffffffffff',
        () {
      final u64Codec = U64();
      final String u64Value =
          u64Codec.encode(BigInt.parse('18446744073709551615'));
      expect(u64Value, equals('ffffffffffffffff'));
    });
    test('When value -1 is encoded then it throws an exception', () {
      final u64Codec = U64();
      expect(() => u64Codec.encode(BigInt.from(-1)),
          throwsA(isA<UnexpectedCaseException>()));
    });
    test(
        'When value 18446744073709551616 is encoded then it throws an exception',
        () {
      final u64Codec = U64();
      expect(() => u64Codec.encode(BigInt.parse('18446744073709551616')),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });
}
