import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('I64 Decode Test', () {
    final registry = TypeRegistry.createRegistry();
    test(
        'When lowest value 0x0000000000000080 is decoded then it returns -9223372036854775808',
        () {
      final codec = Codec(registry: registry)
          .createTypeCodec('i64', data: Source('0x0000000000000080'));
      final i64Value = codec.decode();
      expect(i64Value, equals(BigInt.from(-9223372036854775808)));
    });

    test(
        'When highest value 0xffffffffffffff7f is decoded then it returns 9223372036854775807',
        () {
      final codec = Codec(registry: registry)
          .createTypeCodec('i64', data: Source('0xffffffffffffff7f'));
      final i64Value = codec.decode();
      expect(i64Value, equals(BigInt.from(9223372036854775807)));
    });
  });

  group('I64 Encode Test', () {
    final registry = TypeRegistry.createRegistry();
    test(
        'When lowest value -9223372036854775808 is encoded then it returns 0x0000000000000080',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('i64');
      final i64Value = codec.encode(BigInt.from(-9223372036854775808));
      expect(i64Value, equals('0000000000000080'));
    });

    test(
        'When highest value 9223372036854775807 is encoded then it returns 0xffffffffffffff7f',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('i64');
      final i64Value = codec.encode(BigInt.from(9223372036854775807));
      expect(i64Value, equals('ffffffffffffff7f'));
    });
  });

  group('Exception Test', () {
    final registry = TypeRegistry.createRegistry();

    test(
        'When value -9223372036854775809 is encoded then it throws an exception',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('i64');
      expect(() => codec.encode(BigInt.parse('-9223372036854775809')),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test(
        'When value 9223372036854775808 is encoded then it throws an exception',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('i64');
      expect(() => codec.encode(BigInt.parse('9223372036854775808')),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  group('Custom Json Test', () {
    final registry = TypeRegistry.createRegistry();
    TypeRegistry.addCustomCodec(
      registry,
      {'i64_key': 'i64'},
    );
    test(
        'When lowest value -9223372036854775808 is encoded then it returns 0x0000000000000080',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('i64');
      final i64Value = codec.encode(BigInt.from(-9223372036854775808));
      expect(i64Value, equals('0000000000000080'));
    });

    test(
        'When highest value 9223372036854775807 is encoded then it returns 0xffffffffffffff7f',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('i64');
      final i64Value = codec.encode(BigInt.from(9223372036854775807));
      expect(i64Value, equals('ffffffffffffff7f'));
    });

    test(
        'When lowest value 0x0000000000000080 is decoded then it returns -9223372036854775808',
        () {
      final codec = Codec(registry: registry)
          .createTypeCodec('i64', data: Source('0x0000000000000080'));
      final i64Value = codec.decode();
      expect(i64Value, equals(BigInt.from(-9223372036854775808)));
    });

    test(
        'When highest value 0xffffffffffffff7f is decoded then it returns 9223372036854775807',
        () {
      final codec = Codec(registry: registry)
          .createTypeCodec('i64', data: Source('0xffffffffffffff7f'));
      final i64Value = codec.decode();
      expect(i64Value, equals(BigInt.from(9223372036854775807)));
    });
  });

  group('Custom Json Exception Test', () {
    final registry = TypeRegistry.createRegistry();
    TypeRegistry.addCustomCodec(
      registry,
      {'i64_key': 'i64'},
    );

    test(
        'When value -9223372036854775809 is encoded then it throws an exception',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('i64');
      expect(() => codec.encode(BigInt.parse('-9223372036854775809')),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test(
        'When value 9223372036854775808 is encoded then it throws an exception',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('i64');
      expect(() => codec.encode(BigInt.parse('9223372036854775808')),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  // I64() Direct test-cases without type registry

  group('I64 Direct Decode Test', () {
    test(
        'When lowest value 0x0000000000000080 is decoded then it returns -9223372036854775808',
        () {
      final codec = I64(source: Source('0x0000000000000080'));
      final i64Value = codec.decode();
      expect(i64Value, equals(BigInt.from(-9223372036854775808)));
    });

    test(
        'When highest value 0xffffffffffffff7f is decoded then it returns 9223372036854775807',
        () {
      final codec = I64(source: Source('0xffffffffffffff7f'));
      final i64Value = codec.decode();
      expect(i64Value, equals(BigInt.from(9223372036854775807)));
    });
  });

  group('I64 Direct Encode Test', () {
    test(
        'When lowest value -9223372036854775808 is encoded then it returns 0x0000000000000080',
        () {
      final codec = I64();
      final i64Value = codec.encode(BigInt.from(-9223372036854775808));
      expect(i64Value, equals('0000000000000080'));
    });

    test(
        'When highest value 9223372036854775807 is encoded then it returns 0xffffffffffffff7f',
        () {
      final codec = I64();
      final i64Value = codec.encode(BigInt.from(9223372036854775807));
      expect(i64Value, equals('ffffffffffffff7f'));
    });
  });

  group('I64 Direct Exception Test', () {
    test(
        'When value -9223372036854775809 is encoded then it throws an exception',
        () {
      final codec = I64();
      expect(() => codec.encode(BigInt.parse('-9223372036854775809')),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test(
        'When value 9223372036854775808 is encoded then it throws an exception',
        () {
      final codec = I64();
      expect(() => codec.encode(BigInt.parse('9223372036854775808')),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });
}
