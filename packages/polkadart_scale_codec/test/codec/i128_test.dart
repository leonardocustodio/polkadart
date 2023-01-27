import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('I128 Decode Test', () {
    final registry = TypeRegistry.createRegistry();
    test(
        'When lowest value 0x00000000000000000000000000000080 is decoded then it returns -170141183460469231731687303715884105728',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('i128');
      final i128Value = codec
          .decode(DefaultInput.fromHex('0x00000000000000000000000000000080'));
      expect(i128Value,
          equals(BigInt.parse('-170141183460469231731687303715884105728')));
    });

    test(
        'When highest value 0xffffffffffffffffffffffffffffff7f is decoded then it returns 170141183460469231731687303715884105727',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('i128');
      final i128Value = codec
          .decode(DefaultInput.fromHex('0xffffffffffffffffffffffffffffff7f'));
      expect(i128Value,
          equals(BigInt.parse('170141183460469231731687303715884105727')));
    });
  });

  group('I128 Encode Test', () {
    final registry = TypeRegistry.createRegistry();
    test(
        'When lowest value -170141183460469231731687303715884105728 is encoded then it returns 0x00000000000000000000000000000080',
        () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('i128');
      final encoder = HexEncoder();
      codec.encode(
          encoder, BigInt.parse('-170141183460469231731687303715884105728'));
      expect(encoder.toHex(), equals('0x00000000000000000000000000000080'));
    });

    test(
        'When highest value 170141183460469231731687303715884105727 is encoded then it returns 0xffffffffffffffffffffffffffffff7f',
        () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('i128');
      final encoder = HexEncoder();
      codec.encode(
          encoder, BigInt.parse('170141183460469231731687303715884105727'));
      expect(encoder.toHex(), equals('0xffffffffffffffffffffffffffffff7f'));
    });
  });

  group('Exception Test', () {
    final registry = TypeRegistry.createRegistry();

    test(
        'When value -170141183460469231731687303715884105729 is encoded then it throws an exception',
        () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('i128');
      final encoder = HexEncoder();
      expect(
          () => codec.encode(encoder,
              BigInt.parse('-170141183460469231731687303715884105729')),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test(
        'When value 170141183460469231731687303715884105728 is encoded then it throws an exception',
        () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('i128');
      final encoder = HexEncoder();
      expect(
          () => codec.encode(
              encoder, BigInt.parse('170141183460469231731687303715884105728')),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  group('Custom Json Test', () {
    final registry = TypeRegistry.createRegistry();
    registry.registerCustomCodec(
      {'i128_key': 'i128'},
    );

    test(
        'When lowest value -170141183460469231731687303715884105728 is encoded then it returns 0x00000000000000000000000000000080',
        () {
      final codec =
          Codec<BigInt>(registry: registry).fetchTypeCodec('i128_key');
      final encoder = HexEncoder();
      codec.encode(
          encoder, BigInt.parse('-170141183460469231731687303715884105728'));
      expect(encoder.toHex(), equals('0x00000000000000000000000000000080'));
    });

    test(
        'When highest value 170141183460469231731687303715884105727 is encoded then it returns 0xffffffffffffffffffffffffffffff7f',
        () {
      final codec =
          Codec<BigInt>(registry: registry).fetchTypeCodec('i128_key');

      final encoder = HexEncoder();
      codec.encode(
          encoder, BigInt.parse('170141183460469231731687303715884105727'));
      expect(encoder.toHex(), equals('0xffffffffffffffffffffffffffffff7f'));
    });

    test(
        'When lowest value 0x00000000000000000000000000000080 is decoded then it returns -170141183460469231731687303715884105728',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('i128_key');
      final i128Value = codec
          .decode(DefaultInput.fromHex('0x00000000000000000000000000000080'));
      expect(i128Value,
          equals(BigInt.parse('-170141183460469231731687303715884105728')));
    });

    test(
        'When highest value 0xffffffffffffffffffffffffffffff7f is decoded then it returns 170141183460469231731687303715884105727',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('i128_key');
      final i128Value = codec
          .decode(DefaultInput.fromHex('0xffffffffffffffffffffffffffffff7f'));
      expect(i128Value,
          equals(BigInt.parse('170141183460469231731687303715884105727')));
    });
  });

  group('Custom Json Exception Test', () {
    final registry = TypeRegistry.createRegistry();
    registry.registerCustomCodec(
      {'i128_key': 'i128'},
    );

    test(
        'When value -170141183460469231731687303715884105729 is encoded then it throws an exception',
        () {
      final codec =
          Codec<BigInt>(registry: registry).fetchTypeCodec('i128_key');
      final encoder = HexEncoder();
      expect(
          () => codec.encode(encoder,
              BigInt.parse('-170141183460469231731687303715884105729')),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test(
        'When value 170141183460469231731687303715884105728 is encoded then it throws an exception',
        () {
      final codec =
          Codec<BigInt>(registry: registry).fetchTypeCodec('i128_key');
      final encoder = HexEncoder();
      expect(
          () => codec.encode(
              encoder, BigInt.parse('170141183460469231731687303715884105728')),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  // I128() Direct test-cases without type registry

  group('I128 Direct Decode Test', () {
    test(
        'When lowest value 0x00000000000000000000000000000080 is decoded then it returns -170141183460469231731687303715884105728',
        () {
      final i128Value = I128.decodeFromInput(
          DefaultInput.fromHex('0x00000000000000000000000000000080'));

      expect(i128Value,
          equals(BigInt.parse('-170141183460469231731687303715884105728')));
    });

    test(
        'When highest value 0xffffffffffffffffffffffffffffff7f is decoded then it returns 170141183460469231731687303715884105727',
        () {
      final i128Value = I128.decodeFromInput(
          DefaultInput.fromHex('0xffffffffffffffffffffffffffffff7f'));

      expect(i128Value,
          equals(BigInt.parse('170141183460469231731687303715884105727')));
    });
  });

  group('I128 Direct Encode Test', () {
    test(
        'When lowest value -170141183460469231731687303715884105728 is encoded then it returns 0x00000000000000000000000000000080',
        () {
      final encoder = HexEncoder();
      I128.encodeToEncoder(
          encoder, BigInt.parse('-170141183460469231731687303715884105728'));
      expect(encoder.toHex(), equals('0x00000000000000000000000000000080'));
    });

    test(
        'When highest value 170141183460469231731687303715884105727 is encoded then it returns 0xffffffffffffffffffffffffffffff7f',
        () {
      final encoder = HexEncoder();

      I128.encodeToEncoder(
          encoder, BigInt.parse('170141183460469231731687303715884105727'));
      expect(encoder.toHex(), equals('0xffffffffffffffffffffffffffffff7f'));
    });
  });

  group('I128 Direct Exception Test', () {
    test(
        'When value -170141183460469231731687303715884105729 is encoded then it throws an exception',
        () {
      final encoder = HexEncoder();
      expect(
          () => I128.encodeToEncoder(encoder,
              BigInt.parse('-170141183460469231731687303715884105729')),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test(
        'When value 170141183460469231731687303715884105728 is encoded then it throws an exception',
        () {
      final encoder = HexEncoder();
      expect(
          () => I128.encodeToEncoder(
              encoder, BigInt.parse('170141183460469231731687303715884105728')),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });
}
