import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:polkadart_scale_codec/src/types/codec_u8.dart';
import 'package:test/test.dart';

void main() {
  group('encode to hex unsigned int tests', () {
    final typesRegistry = <String, dynamic>{
      'Codec': {
        'a': 'u8',
        'b': 'u16',
        'c': 'u32',
        'd': 'u64',
        'e': 'u128',
        'f': 'u256',
      },
    };
    // Creates the registry for parsing the types and selecting particular schema.
    final registry = OldTypeRegistry(types: typesRegistry);

    // specifyng which schema type to use
    registry.select('Codec');

    // fetching the parsed types from `Json` to `Type`
    final types = registry.getTypes();

    // Initializing Scale-Codec object
    final codec = Codec(types);

    group('fixed-length 8bit', () {
      test(
          'Given a positive integer when it is within range it should be encoded',
          () {
        const value = 69;
        const expectedResult = '0x45';

        expect(CodecU8().encodeToHex(value), expectedResult);
      });

      test('Should return correct encoded data when value is zero', () {
        const value = 0;
        const expectedResult = '0x00';

        expect(CodecU8().encodeToHex(value), expectedResult);
      });

      test('Should return correct encoded data when value is 255', () {
        const value = 255;
        const expectedResult = '0xff';

        expect(CodecU8().encodeToHex(value), expectedResult);
      });

      test('Should throw InvalidSizeException when value is smaller than zero',
          () {
        const value = -1;

        expect(
          () => CodecU8().encodeToHex(value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test('Should throw InvalidSizeException when value is greater than 256',
          () {
        const value = 256;

        expect(
          () => CodecU8().encodeToHex(value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test('Should throw UnexpectedTypeException when value is null', () {
        int? value;

        expect(
          () => CodecU8().encodeToHex(value),
          throwsA(isA<UnexpectedTypeException>()),
        );
      });

      test('Should throw UnexpectedTypeException when value is a BigInt', () {
        final value = 5.toBigInt;

        expect(
          () => CodecU8().encodeToHex(value),
          throwsA(isA<UnexpectedTypeException>()),
        );
      });

      test('Should throw UnexpectedTypeException when value is not an Integer',
          () {
        const value = '5';

        expect(
          () => CodecU8().encodeToHex(value),
          throwsA(isA<UnexpectedTypeException>()),
        );
      });
    });

    group('fixed-length 16bit', () {
      test(
          'Given a positive integer when it is within range it should be encoded',
          () {
        int value = 42;
        String expectedResult = '0x2a00';

        int registryIndex = registry.getIndex('u16');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test('Should return correct encoded data when value is zero', () {
        int value = 0;
        String expectedResult = '0x0000';

        int registryIndex = registry.getIndex('u16');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test('Should return correct encoded data when value is 65535', () {
        int value = 65535;
        String expectedResult = '0xffff';

        int registryIndex = registry.getIndex('u16');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test('Should throw InvalidSizeException when value is smaller than zero',
          () {
        int value = -1;
        int registryIndex = registry.getIndex('u16');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test('Should throw InvalidSizeException when value is greater than 65535',
          () {
        int value = 65536;
        int registryIndex = registry.getIndex('u16');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test('Should throw AssertionException when value is null', () {
        int? value;
        int registryIndex = registry.getIndex('u16');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });

      test('Should throw AssertionException when value is a BigInt', () {
        BigInt value = 5.toBigInt;
        int registryIndex = registry.getIndex('u16');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });

      test('Should throw AssertionException when value is not an Integer', () {
        String value = '5';
        int registryIndex = registry.getIndex('u16');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });
    });

    group('fixed-length 32bit', () {
      test(
          'Given a positive integer when it is within range it should be encoded',
          () {
        int value = 16777215;
        String expectedResult = '0xffffff00';

        int registryIndex = registry.getIndex('u32');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test('Should return correct encoded data when value is zero', () {
        int value = 0;
        String expectedResult = '0x00000000';

        int registryIndex = registry.getIndex('u32');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test('Should return correct encoded data when value is 4294967295', () {
        int value = 4294967295;
        String expectedResult = '0xffffffff';

        int registryIndex = registry.getIndex('u32');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test('Should throw InvalidSizeException when value is smaller than zero',
          () {
        int value = -1;
        int registryIndex = registry.getIndex('u32');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test(
          'Should throw InvalidSizeException when value is greater than 4294967295',
          () {
        int value = 4294967296;
        int registryIndex = registry.getIndex('u32');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test('Should throw AssertionException when value is null', () {
        int? value;
        int registryIndex = registry.getIndex('u32');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });

      test('Should throw AssertionException when value is a BigInt', () {
        BigInt value = 5.toBigInt;
        int registryIndex = registry.getIndex('u32');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });

      test('Should throw AssertionException when value is not an Integer', () {
        String value = '5';
        int registryIndex = registry.getIndex('u32');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });
    });

    group('fixed-length 64bit', () {
      test(
          'Given a positive integer when it is within range it should be encoded',
          () {
        BigInt value = BigInt.from(16777215);
        String expectedResult = '0xffffff0000000000';

        int registryIndex = registry.getIndex('u64');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test('Should return correct encoded data when value is zero', () {
        BigInt value = BigInt.from(0);
        String expectedResult = '0x0000000000000000';

        int registryIndex = registry.getIndex('u64');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test(
          'Should return correct encoded data when value is 18446744073709551615',
          () {
        BigInt value = BigInt.parse('18446744073709551615');
        String expectedResult = '0xffffffffffffffff';

        int registryIndex = registry.getIndex('u64');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test('Should throw InvalidSizeException when value is smaller than zero',
          () {
        BigInt value = BigInt.from(-1);
        int registryIndex = registry.getIndex('u64');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test(
          'Should throw InvalidSizeException when value is greater than 18446744073709551615',
          () {
        BigInt value = BigInt.parse('18446744073709551616');
        int registryIndex = registry.getIndex('u64');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test('Should throw AssertionException when value is null', () {
        BigInt? value;
        int registryIndex = registry.getIndex('u64');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });

      test('Should throw AssertionException when value is an Integer', () {
        int value = 5;
        int registryIndex = registry.getIndex('u64');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });

      test('Should throw AssertionException when value is not an BigInt', () {
        String value = '5';
        int registryIndex = registry.getIndex('u64');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });
    });

    group('fixed-length 128bit', () {
      test(
          'Given a positive integer when it is within range it should be encoded',
          () {
        BigInt value = BigInt.from(16777215);
        String expectedResult = '0xffffff00000000000000000000000000';

        int registryIndex = registry.getIndex('u128');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test('Should return correct encoded data when value is zero', () {
        BigInt value = BigInt.from(0);
        String expectedResult = '0x00000000000000000000000000000000';

        int registryIndex = registry.getIndex('u128');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test(
          'Should return correct encoded data when value is 340282366920938463463374607431768211455',
          () {
        BigInt value = BigInt.parse('340282366920938463463374607431768211455');
        String expectedResult = '0xffffffffffffffffffffffffffffffff';

        int registryIndex = registry.getIndex('u128');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test('Should throw InvalidSizeException when value is smaller than zero',
          () {
        BigInt value = BigInt.from(-1);
        int registryIndex = registry.getIndex('u128');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test(
          'Should throw InvalidSizeException when value is greater than 340282366920938463463374607431768211455',
          () {
        BigInt value = BigInt.parse('340282366920938463463374607431768211456');
        int registryIndex = registry.getIndex('u128');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test('Should throw AssertionException when value is null', () {
        int? value;
        int registryIndex = registry.getIndex('u128');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });

      test('Should throw AssertionException when value is an Integer', () {
        int value = 5;
        int registryIndex = registry.getIndex('u128');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });

      test('Should throw AssertionException when value is not a BigInt', () {
        String value = '5';
        int registryIndex = registry.getIndex('u128');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });
    });

    group('fixed-length 256bit', () {
      test(
          'Given a positive integer when it is within range it should be encoded',
          () {
        BigInt value = BigInt.from(16777215);
        String expectedResult =
            '0xffffff0000000000000000000000000000000000000000000000000000000000';

        int registryIndex = registry.getIndex('u256');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test('Should return correct encoded data when value is zero', () {
        BigInt value = BigInt.from(0);
        String expectedResult =
            '0x0000000000000000000000000000000000000000000000000000000000000000';

        int registryIndex = registry.getIndex('u256');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test(
          'Should return correct encoded data when value is 115792089237316195423570985008687907853269984665640564039457584007913129639935',
          () {
        BigInt value = BigInt.parse(
            '115792089237316195423570985008687907853269984665640564039457584007913129639935');
        String expectedResult =
            '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff';

        int registryIndex = registry.getIndex('u256');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test('Should throw InvalidSizeException when value is smaller than zero',
          () {
        BigInt value = BigInt.from(-1);
        int registryIndex = registry.getIndex('u256');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test(
          'Should throw InvalidSizeException when value is greater than 115792089237316195423570985008687907853269984665640564039457584007913129639935',
          () {
        BigInt value = BigInt.parse(
            '115792089237316195423570985008687907853269984665640564039457584007913129639936');
        int registryIndex = registry.getIndex('u256');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test('Should throw AssertionException when value is null', () {
        BigInt? value;
        int registryIndex = registry.getIndex('u256');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });

      test('Should throw AssertionException when value is a Integer', () {
        int value = 5;
        int registryIndex = registry.getIndex('u256');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });

      test('Should throw AssertionException when value is not a BigInt', () {
        String value = '5';
        int registryIndex = registry.getIndex('u256');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });
    });
  });
}
