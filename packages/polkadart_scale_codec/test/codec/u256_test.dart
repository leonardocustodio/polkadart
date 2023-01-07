import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  // u256 test cases
  group('U256 Decode Test', () {
    final registry = TypeRegistry.createRegistry();
    test(
        'When lowest value 0x0000000000000000000000000000000000000000000000000000000000000000 is decoded then it returns 0',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('u256',
          data: Source(
              '0x0000000000000000000000000000000000000000000000000000000000000000'));
      final BigInt u256Value = codec.decode();
      expect(u256Value.toString(), equals('0'));
    });

    test(
        'When highest value 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff is decoded then it returns 115792089237316195423570985008687907853269984665640564039457584007913129639935',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('u256',
          data: Source(
              '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'));
      final BigInt u256Value = codec.decode();
      expect(
          u256Value.toString(),
          equals(
              '115792089237316195423570985008687907853269984665640564039457584007913129639935'));
    });
  });

  group('U256 Encode Test', () {
    final registry = TypeRegistry.createRegistry();
    test(
        'When lowest value 0 is encoded then it returns 0x0000000000000000000000000000000000000000000000000000000000000000',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('u256');
      final String u256Value = codec.encode(BigInt.from(0));
      expect(
          u256Value,
          equals(
              '0000000000000000000000000000000000000000000000000000000000000000'));
    });

    test(
        'When highest value 115792089237316195423570985008687907853269984665640564039457584007913129639935 is encoded then it returns 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('u256');
      final String u256Value = codec.encode(BigInt.parse(
          '115792089237316195423570985008687907853269984665640564039457584007913129639935'));
      expect(
          u256Value,
          equals(
              'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'));
    });
  });

  group('Exception Test', () {
    final registry = TypeRegistry.createRegistry();

    test('When value -1 is encoded then it throws an exception', () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('u256');
      expect(() => codec.encode(BigInt.from(-1)),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test(
        'When value 115792089237316195423570985008687907853269984665640564039457584007913129639936 is encoded then it throws an exception',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('u256');
      expect(
          () => codec.encode(BigInt.parse(
              '115792089237316195423570985008687907853269984665640564039457584007913129639936')),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  group('Exception Test', () {
    final registry = TypeRegistry.createRegistry();

    test('When value -1 is encoded then it throws an exception', () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('u256');
      expect(() => codec.encode(BigInt.from(-1)),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test(
        'When value 115792089237316195423570985008687907853269984665640564039457584007913129639936 is encoded then it throws an exception',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('u256');
      expect(
          () => codec.encode(BigInt.parse(
              '115792089237316195423570985008687907853269984665640564039457584007913129639936')),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  group('Custom Type Test', () {
    final registry = TypeRegistry.createRegistry();
    TypeRegistry.addCustomCodec(
      registry,
      <String, dynamic>{
        'u256_key': 'u256',
      },
    );

    test(
        'When 0x0000000000000000000000000000000000000000000000000000000000000000 is decoded then it returns 0',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('u256',
          data: Source(
              '0x0000000000000000000000000000000000000000000000000000000000000000'));
      final BigInt u256Value = codec.decode();
      expect(u256Value.toString(), equals('0'));
    });

    test(
        'When BigInt 0 is encoded then it returns 0x0000000000000000000000000000000000000000000000000000000000000000',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('u256');
      final String u256Value = codec.encode(BigInt.from(0));
      expect(
          u256Value,
          equals(
              '0000000000000000000000000000000000000000000000000000000000000000'));
    });

    test(
        'When 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff is decoded then it returns 115792089237316195423570985008687907853269984665640564039457584007913129639935',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('u256',
          data: Source(
              '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'));
      final BigInt u256Value = codec.decode();
      expect(
          u256Value.toString(),
          equals(
              '115792089237316195423570985008687907853269984665640564039457584007913129639935'));
    });

    test(
        'When BigInt 115792089237316195423570985008687907853269984665640564039457584007913129639935 is encoded then it returns 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('u256');
      final String u256Value = codec.encode(BigInt.parse(
          '115792089237316195423570985008687907853269984665640564039457584007913129639935'));
      expect(
          u256Value,
          equals(
              'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'));
    });
  });
  group('Custom Type Exception Test', () {
    final registry = TypeRegistry.createRegistry();
    TypeRegistry.addCustomCodec(
      registry,
      <String, dynamic>{
        'u256_key': 'u256',
      },
    );

    test(
        'When BigInt 115792089237316195423570985008687907853269984665640564039457584007913129639936 is encoded then it throws an exception',
        () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('u256');
      expect(
          () => codec.encode(BigInt.parse(
              '115792089237316195423570985008687907853269984665640564039457584007913129639936')),
          throwsA(isA<UnexpectedCaseException>()));
    });

    test('When BigInt -1 is encoded then it throws an exception', () {
      final codec = Codec<BigInt>(registry: registry).createTypeCodec('u256');
      expect(() => codec.encode(BigInt.from(-1)),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });
}
