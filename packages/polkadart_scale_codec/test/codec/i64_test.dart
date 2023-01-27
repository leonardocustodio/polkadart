import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('I64 Decode Test', () {
    final registry = TypeRegistry.createRegistry();
    test(
        'When lowest value 0x0000000000000080 is decoded then it returns -9223372036854775808',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('i64');
      final i64Value = codec.decode(DefaultInput.fromHex('0x0000000000000080'));
      expect(i64Value, equals(BigInt.from(-9223372036854775808)));
    });

    test(
        'When highest value 0xffffffffffffff7f is decoded then it returns 9223372036854775807',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('i64');
      final i64Value = codec.decode(DefaultInput.fromHex('0xffffffffffffff7f'));
      expect(i64Value, equals(BigInt.from(9223372036854775807)));
    });
  });

  group('I64 Encode Test', () {
    final registry = TypeRegistry.createRegistry();
    test(
        'When lowest value -9223372036854775808 is encoded then it returns 0x0000000000000080',
        () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('i64');
      final encoder = HexEncoder();
      codec.encode(encoder, BigInt.from(-9223372036854775808));
      expect(encoder.toHex(), equals('0x0000000000000080'));
    });

    test(
        'When highest value 9223372036854775807 is encoded then it returns 0xffffffffffffff7f',
        () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('i64');
      final encoder = HexEncoder();
      codec.encode(encoder, BigInt.from(9223372036854775807));
      expect(encoder.toHex(), equals('0xffffffffffffff7f'));
    });
  });

  group('Exception Test', () {
    final registry = TypeRegistry.createRegistry();

    test(
        'When value -9223372036854775809 is encoded then it throws an exception',
        () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('i64');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, BigInt.parse('-9223372036854775809')),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test(
        'When value 9223372036854775808 is encoded then it throws an exception',
        () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('i64');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, BigInt.parse('9223372036854775808')),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  group('Custom Json Test', () {
    final registry = TypeRegistry.createRegistry();
    registry.registerCustomCodec(
      {'i64_key': 'i64'},
    );
    test(
        'When lowest value -9223372036854775808 is encoded then it returns 0x0000000000000080',
        () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('i64');
      final encoder = HexEncoder();
      codec.encode(encoder, BigInt.from(-9223372036854775808));
      expect(encoder.toHex(), equals('0x0000000000000080'));
    });

    test(
        'When highest value 9223372036854775807 is encoded then it returns 0xffffffffffffff7f',
        () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('i64');
      final encoder = HexEncoder();
      codec.encode(encoder, BigInt.from(9223372036854775807));
      expect(encoder.toHex(), equals('0xffffffffffffff7f'));
    });

    test(
        'When lowest value 0x0000000000000080 is decoded then it returns -9223372036854775808',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('i64');
      final i64Value = codec.decode(DefaultInput.fromHex('0x0000000000000080'));
      expect(i64Value, equals(BigInt.from(-9223372036854775808)));
    });

    test(
        'When highest value 0xffffffffffffff7f is decoded then it returns 9223372036854775807',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('i64');
      final i64Value = codec.decode(DefaultInput.fromHex('0xffffffffffffff7f'));
      expect(i64Value, equals(BigInt.from(9223372036854775807)));
    });
  });

  group('Custom Json Exception Test', () {
    final registry = TypeRegistry.createRegistry();
    registry.registerCustomCodec(
      {'i64_key': 'i64'},
    );

    test(
        'When value -9223372036854775809 is encoded then it throws an exception',
        () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('i64');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, BigInt.parse('-9223372036854775809')),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test(
        'When value 9223372036854775808 is encoded then it throws an exception',
        () {
      final codec = Codec<BigInt>(registry: registry).fetchTypeCodec('i64');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, BigInt.parse('9223372036854775808')),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  // I64() Direct test-cases without type registry

  group('I64 Direct Decode Test', () {
    test(
        'When lowest value 0x0000000000000080 is decoded then it returns -9223372036854775808',
        () {
      final i64Value =
          I64.decodeFromInput(DefaultInput.fromHex('0x0000000000000080'));
      expect(i64Value, equals(BigInt.from(-9223372036854775808)));
    });

    test(
        'When highest value 0xffffffffffffff7f is decoded then it returns 9223372036854775807',
        () {
      final i64Value =
          I64.decodeFromInput(DefaultInput.fromHex('0xffffffffffffff7f'));
      expect(i64Value, equals(BigInt.from(9223372036854775807)));
    });
  });

  group('I64 Direct Encode Test', () {
    test(
        'When lowest value -9223372036854775808 is encoded then it returns 0x0000000000000080',
        () {
      final encoder = HexEncoder();

      I64.encodeToEncoder(encoder, BigInt.from(-9223372036854775808));
      expect(encoder.toHex(), equals('0x0000000000000080'));
    });

    test(
        'When highest value 9223372036854775807 is encoded then it returns 0xffffffffffffff7f',
        () {
      final encoder = HexEncoder();

      I64.encodeToEncoder(encoder, BigInt.from(9223372036854775807));
      expect(encoder.toHex(), equals('0xffffffffffffff7f'));
    });
  });

  group('I64 Direct Exception Test', () {
    test(
        'When value -9223372036854775809 is encoded then it throws an exception',
        () {
      final encoder = HexEncoder();
      expect(
          () => I64.encodeToEncoder(
              encoder, BigInt.parse('-9223372036854775809')),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test(
        'When value 9223372036854775808 is encoded then it throws an exception',
        () {
      final encoder = HexEncoder();
      expect(
          () =>
              I64.encodeToEncoder(encoder, BigInt.parse('9223372036854775808')),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });
}
