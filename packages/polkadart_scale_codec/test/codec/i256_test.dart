import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('I256 Decode Test', () {
    final registry = TypeRegistry.createRegistry();
    test(
        'When lowest value 0x0000000000000000000000000000000000000000000000000000000000000080 is decoded then it returns -57896044618658097711785492504343953926634992332820282019728792003956564819968',
        () {
      final codec = Codec(registry: registry).createTypeCodec('i256');
      final i256Value = codec.decode(Input(
          '0x0000000000000000000000000000000000000000000000000000000000000080'));
      expect(
          i256Value,
          equals(BigInt.parse(
              '-57896044618658097711785492504343953926634992332820282019728792003956564819968')));
    });

    test(
        'When highest value 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f is decoded then it returns 57896044618658097711785492504343953926634992332820282019728792003956564819967',
        () {
      final codec = Codec(registry: registry).createTypeCodec('i256');
      final i256Value = codec.decode(Input(
          '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f'));
      expect(
          i256Value,
          equals(BigInt.parse(
              '57896044618658097711785492504343953926634992332820282019728792003956564819967')));
    });
  });

  group('I256 Encode Test', () {
    final registry = TypeRegistry.createRegistry();
    test(
        'When lowest value -57896044618658097711785492504343953926634992332820282019728792003956564819968 is encoded then it returns 0x0000000000000000000000000000000000000000000000000000000000000080',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('i256');
      final encoder = HexEncoder();
      codec.encode(
          encoder,
          BigInt.parse(
              '-57896044618658097711785492504343953926634992332820282019728792003956564819968'));
      expect(
          encoder.toHex(),
          equals(
              '0x0000000000000000000000000000000000000000000000000000000000000080'));
    });

    test(
        'When highest value 57896044618658097711785492504343953926634992332820282019728792003956564819967 is encoded then it returns 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('i256');
      final encoder = HexEncoder();
      codec.encode(
          encoder,
          BigInt.parse(
              '57896044618658097711785492504343953926634992332820282019728792003956564819967'));
      expect(
          encoder.toHex(),
          equals(
              '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f'));
    });
  });

  group('Exception Test', () {
    final registry = TypeRegistry.createRegistry();
    test(
        'When value 57896044618658097711785492504343953926634992332820282019728792003956564819968 is encoded then it throws an exception',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('i256');
      final encoder = HexEncoder();
      expect(
          () => codec.encode(
              encoder,
              BigInt.parse(
                  '57896044618658097711785492504343953926634992332820282019728792003956564819968')),
          throwsA(isA<Exception>()));
    });

    test(
        'When value -57896044618658097711785492504343953926634992332820282019728792003956564819969 is encoded then it throws an exception',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('i256');
      final encoder = HexEncoder();
      expect(
          () => codec.encode(
              encoder,
              BigInt.parse(
                  '-57896044618658097711785492504343953926634992332820282019728792003956564819969')),
          throwsA(isA<Exception>()));
    });
  });

  group('Custom Json Test', () {
    final registry = TypeRegistry.createRegistry();
    TypeRegistry.addCustomCodec(
      registry,
      {'i256_key': 'i256'},
    );

    test(
        'When lowest value -57896044618658097711785492504343953926634992332820282019728792003956564819968 is encoded then it returns 0x0000000000000000000000000000000000000000000000000000000000000080',
        () {
      final codec =
          Codec<BigInt>(registry: registry).createTypeCodec('i256_key');
      final encoder = HexEncoder();
      codec.encode(
          encoder,
          BigInt.parse(
              '-57896044618658097711785492504343953926634992332820282019728792003956564819968'));
      expect(
          encoder.toHex(),
          equals(
              '0x0000000000000000000000000000000000000000000000000000000000000080'));
    });

    test(
        'When highest value 57896044618658097711785492504343953926634992332820282019728792003956564819967 is encoded then it returns 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f',
        () {
      final codec =
          Codec<BigInt>(registry: registry).createTypeCodec('i256_key');
      final encoder = HexEncoder();
      codec.encode(
          encoder,
          BigInt.parse(
              '57896044618658097711785492504343953926634992332820282019728792003956564819967'));
      expect(
          encoder.toHex(),
          equals(
              '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f'));
    });

    test(
        'When lowest value 0x0000000000000000000000000000000000000000000000000000000000000080 is decoded then it returns -57896044618658097711785492504343953926634992332820282019728792003956564819968',
        () {
      final codec = Codec(registry: registry).createTypeCodec(
        'i256_key',
      );
      final i256Value = codec.decode(Input(
          '0x0000000000000000000000000000000000000000000000000000000000000080'));
      expect(
          i256Value,
          equals(BigInt.parse(
              '-57896044618658097711785492504343953926634992332820282019728792003956564819968')));
    });

    test(
        'When highest value 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f is decoded then it returns 57896044618658097711785492504343953926634992332820282019728792003956564819967',
        () {
      final codec = Codec(registry: registry).createTypeCodec(
        'i256_key',
      );
      final i256Value = codec.decode(Input(
          '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f'));
      expect(
          i256Value,
          equals(BigInt.parse(
              '57896044618658097711785492504343953926634992332820282019728792003956564819967')));
    });
  });

  group('Custom Json Exception Test', () {
    final registry = TypeRegistry.createRegistry();
    TypeRegistry.addCustomCodec(
      registry,
      {'i256_key': 'i256'},
    );

    test(
        'When value 57896044618658097711785492504343953926634992332820282019728792003956564819968 is encoded then it throws an exception',
        () {
      final codec =
          Codec<BigInt>(registry: registry).createTypeCodec('i256_key');
      final encoder = HexEncoder();
      expect(
          () => codec.encode(
              encoder,
              BigInt.parse(
                  '57896044618658097711785492504343953926634992332820282019728792003956564819968')),
          throwsA(isA<Exception>()));
    });

    test(
        'When value -57896044618658097711785492504343953926634992332820282019728792003956564819969 is encoded then it throws an exception',
        () {
      final codec =
          Codec<BigInt>(registry: registry).createTypeCodec('i256_key');
      final encoder = HexEncoder();
      expect(
          () => codec.encode(
              encoder,
              BigInt.parse(
                  '-57896044618658097711785492504343953926634992332820282019728792003956564819969')),
          throwsA(isA<Exception>()));
    });
  });

  // I256() Direct Test Case without type registry

  group('Direct Test', () {
    test(
        'When lowest value -57896044618658097711785492504343953926634992332820282019728792003956564819968 is encoded then it returns 0x0000000000000000000000000000000000000000000000000000000000000080',
        () {
      final encoder = HexEncoder();
      I256.encodeToEncoder(
          encoder,
          BigInt.parse(
              '-57896044618658097711785492504343953926634992332820282019728792003956564819968'));
      expect(
          encoder.toHex(),
          equals(
              '0x0000000000000000000000000000000000000000000000000000000000000080'));
    });

    test(
        'When highest value 57896044618658097711785492504343953926634992332820282019728792003956564819967 is encoded then it returns 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f',
        () {
      final encoder = HexEncoder();
      I256.encodeToEncoder(
          encoder,
          BigInt.parse(
              '57896044618658097711785492504343953926634992332820282019728792003956564819967'));
      expect(
          encoder.toHex(),
          equals(
              '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f'));
    });

    test(
        'When lowest value 0x0000000000000000000000000000000000000000000000000000000000000080 is decoded then it returns -57896044618658097711785492504343953926634992332820282019728792003956564819968',
        () {
      final i256Value = I256.decodeFromInput(Input(
          '0x0000000000000000000000000000000000000000000000000000000000000080'));

      expect(
          i256Value,
          equals(BigInt.parse(
              '-57896044618658097711785492504343953926634992332820282019728792003956564819968')));
    });

    test(
        'When highest value 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f is decoded then it returns 57896044618658097711785492504343953926634992332820282019728792003956564819967',
        () {
      final i256Value = I256.decodeFromInput(Input(
          '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f'));

      expect(
          i256Value,
          equals(BigInt.parse(
              '57896044618658097711785492504343953926634992332820282019728792003956564819967')));
    });
  });

  group('Direct Exception Test', () {
    test(
        'When value 57896044618658097711785492504343953926634992332820282019728792003956564819968 is encoded then it throws an exception',
        () {
      final encoder = HexEncoder();
      expect(
          () => I256.encodeToEncoder(
              encoder,
              BigInt.parse(
                  '57896044618658097711785492504343953926634992332820282019728792003956564819968')),
          throwsA(isA<Exception>()));
    });

    test(
        'When value -57896044618658097711785492504343953926634992332820282019728792003956564819969 is encoded then it throws an exception',
        () {
      final encoder = HexEncoder();
      expect(
          () => I256.encodeToEncoder(
              encoder,
              BigInt.parse(
                  '-57896044618658097711785492504343953926634992332820282019728792003956564819969')),
          throwsA(isA<Exception>()));
    });
  });
}
