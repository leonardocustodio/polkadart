import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('U128 Decode Test', () {
    final registry = TypeRegistry.createRegistry();
    test(
        'When lowest value 0x00000000000000000000000000000000 is decoded then it returns 0',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('u128',
          data: Source('0x00000000000000000000000000000000'));
      final BigInt u128Value = codec.decode();
      expect(u128Value.toString(), equals('0'));
    });

    test(
        'When highest value 0xffffffffffffffffffffffffffffffff is decoded then it returns 340282366920938463463374607431768211455',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('u128',
          data: Source('0xffffffffffffffffffffffffffffffff'));
      final BigInt u128Value = codec.decode();
      expect(u128Value.toString(),
          equals('340282366920938463463374607431768211455'));
    });
  });

  group('U128 Encode Test', () {
    final registry = TypeRegistry.createRegistry();
    test(
        'When lowest value 0 is encoded then it returns 0x00000000000000000000000000000000',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('u128');
      final String u128Value = codec.encode(BigInt.from(0));
      expect(u128Value, equals('00000000000000000000000000000000'));
    });

    test(
        'When highest value 340282366920938463463374607431768211455 is encoded then it returns 0xffffffffffffffffffffffffffffffff',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('u128');
      final String u128Value =
          codec.encode(BigInt.parse('340282366920938463463374607431768211455'));
      expect(u128Value, equals('ffffffffffffffffffffffffffffffff'));
    });
  });

  group('Exception Test', () {
    final registry = TypeRegistry.createRegistry();

    test('When value -1 is encoded then it throws an exception', () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('u128');
      expect(() => codec.encode(BigInt.from(-1)),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test(
        'When value 340282366920938463463374607431768211456 is encoded then it throws an exception',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('u128');
      expect(
          () => codec
              .encode(BigInt.parse('340282366920938463463374607431768211456')),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  group('Custom Type Test', () {
    final registry = TypeRegistry.createRegistry();
    TypeRegistry.addCustomCodec(
      registry,
      <String, dynamic>{
        'u128_key': 'u128',
      },
    );

    test('When 0x00000000000000000000000000000000 is decoded then it returns 0',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec(
          'u128_key',
          data: Source('0x00000000000000000000000000000000'));
      final BigInt u128Value = codec.decode();
      expect(u128Value.toString(), equals('0'));
    });

    test(
        'When BigInt 0 is encoded then it returns 0x00000000000000000000000000000000',
        () {
      final codec =
          Codec<BigInt>(registry: registry).createTypeCodec('u128_key');
      final String u128Value = codec.encode(BigInt.from(0));
      expect(u128Value, equals('00000000000000000000000000000000'));
    });

    test(
        'When 0xffffffffffffffffffffffffffffffff is decoded then it returns 340282366920938463463374607431768211455',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec(
          'u128_key',
          data: Source('0xffffffffffffffffffffffffffffffff'));
      final BigInt u128Value = codec.decode();
      expect(u128Value.toString(),
          equals('340282366920938463463374607431768211455'));
    });

    test(
        'When BigInt 340282366920938463463374607431768211455 is encoded then it returns 0xffffffffffffffffffffffffffffffff',
        () {
      final codec =
          Codec<BigInt>(registry: registry).createTypeCodec('u128_key');
      final String u128Value =
          codec.encode(BigInt.parse('340282366920938463463374607431768211455'));
      expect(u128Value, equals('ffffffffffffffffffffffffffffffff'));
    });
  });

  group('Custom Type Exception Test', () {
    final registry = TypeRegistry.createRegistry();
    TypeRegistry.addCustomCodec(
      registry,
      <String, dynamic>{
        'u128_key': 'u128',
      },
    );

    test('When value -1 is encoded then it throws an exception', () {
      final codec =
          Codec<BigInt>(registry: registry).createTypeCodec('u128_key');
      expect(() => codec.encode(BigInt.from(-1)),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test(
        'When value 340282366920938463463374607431768211456 is encoded then it throws an exception',
        () {
      final codec =
          Codec<BigInt>(registry: registry).createTypeCodec('u128_key');
      expect(
          () => codec
              .encode(BigInt.parse('340282366920938463463374607431768211456')),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });
}
