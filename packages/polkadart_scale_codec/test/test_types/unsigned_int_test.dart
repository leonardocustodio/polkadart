import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
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
        int value = 69;
        String expectedResult = '0x45';

        int registryIndex = registry.getIndex('u8');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test('Should return correct encoded data when value is zero', () {
        int value = 0;
        String expectedResult = '0x00';

        int registryIndex = registry.getIndex('u8');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test(
          'Should return correct encoded data when value fits 8 bits and is positive',
          () {
        final largestSupportedValue = 255;
        String expectedResult = '0xff';

        int registryIndex = registry.getIndex('u8');

        expect(
            codec.encode(registryIndex, largestSupportedValue), expectedResult);
      });

      test('Should throw InvalidSizeException when value is smaller than zero',
          () {
        int value = -1;
        int registryIndex = registry.getIndex('u8');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test('Should throw InvalidSizeException when value is greater than 255',
          () {
        int value = 256;
        int registryIndex = registry.getIndex('u8');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test('Should throw AssertionException when value is null', () {
        int? value;
        int registryIndex = registry.getIndex('u8');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });

      test('Should throw AssertionException when value is a BigInt', () {
        BigInt value = 5.toBigInt;
        int registryIndex = registry.getIndex('u8');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });

      test('Should throw AssertionException when value is not an Integer', () {
        String value = '5';
        int registryIndex = registry.getIndex('u8');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
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

      test(
          'Should return correct encoded data when value fits 16 bits and is positive',
          () {
        final largestSupportedValue = 65535;
        String expectedResult = '0xffff';

        int registryIndex = registry.getIndex('u16');

        expect(
            codec.encode(registryIndex, largestSupportedValue), expectedResult);
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

      test(
          'Should return correct encoded data when value fits 32 bits and is positive',
          () {
        final largestSupportedValue = 4294967295;
        String expectedResult = '0xffffffff';

        int registryIndex = registry.getIndex('u32');

        expect(
            codec.encode(registryIndex, largestSupportedValue), expectedResult);
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
          'Should return correct encoded data when value fits 64 bits and is positive',
          () {
        final largestSupportedValue = BigInt.parse('18446744073709551615');
        String expectedResult = '0xffffffffffffffff';

        int registryIndex = registry.getIndex('u64');

        expect(
            codec.encode(registryIndex, largestSupportedValue), expectedResult);
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
          'Should return correct encoded data when value fits 128 bits and is positive',
          () {
        final largestSupportedValue =
            BigInt.parse('340282366920938463463374607431768211455');
        String expectedResult = '0xffffffffffffffffffffffffffffffff';

        int registryIndex = registry.getIndex('u128');

        expect(
            codec.encode(registryIndex, largestSupportedValue), expectedResult);
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
          'Should return correct encoded data when value fits 256 bits and is positive',
          () {
        final largestSupportedValue = BigInt.parse(
            '115792089237316195423570985008687907853269984665640564039457584007913129639935');
        String expectedResult =
            '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff';

        int registryIndex = registry.getIndex('u256');

        expect(
            codec.encode(registryIndex, largestSupportedValue), expectedResult);
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

  group('decode from hex and return unsigned int tests', () {
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
      test('Given an encoded string 0x45 it should be decoded to 69', () {
        const expectedResult = 69;
        const value = '0x45';

        final registryIndex = registry.getIndex('u8');

        expect(codec.decode(registryIndex, value), expectedResult);
      });

      test('Given an encoded string 0x00 it should be decoded to zero', () {
        const expectedResult = 0;
        const value = '0x00';

        final registryIndex = registry.getIndex('u8');

        expect(codec.decode(registryIndex, value), expectedResult);
      });

      test('Given an encoded string 0xff it should be decoded to 255', () {
        const expectedResult = 255;
        const value = '0xff';

        final registryIndex = registry.getIndex('u8');

        expect(codec.decode(registryIndex, value), expectedResult);
      });

      test(
          'Should throw UnprocessedDataLeftException when encoded string represents a value out of u8 range',
          () {
        const value = '0x2a00';
        final registryIndex = registry.getIndex('u8');

        expect(
          () => codec.decode(registryIndex, value),
          throwsA(isA<UnprocessedDataLeftException>()),
        );
      });
    });

    group('fixed-length 16bit', () {
      test('Given an encoded string 0x2a00 it should be decoded to 42', () {
        const expectedResult = 42;
        const value = '0x2a00';

        final registryIndex = registry.getIndex('u16');

        expect(codec.decode(registryIndex, value), expectedResult);
      });

      test('Given an encoded string 0x0000 it should be decoded to zero', () {
        const expectedResult = 0;
        const value = '0x0000';

        final registryIndex = registry.getIndex('u16');

        expect(codec.decode(registryIndex, value), expectedResult);
      });

      test('Given an encoded string 0xffff it should be decoded to 65535', () {
        const expectedResult = 65535;
        const value = '0xffff';

        final registryIndex = registry.getIndex('u16');

        expect(codec.decode(registryIndex, value), expectedResult);
      });

      test(
          'Should throw UnprocessedDataLeftException when encoded string represents a value out of u16 range',
          () {
        const value = '0xffff00';
        final registryIndex = registry.getIndex('u16');

        expect(
          () => codec.decode(registryIndex, value),
          throwsA(isA<UnprocessedDataLeftException>()),
        );
      });
    });

    group('fixed-length 32bit', () {
      test(
          'Given an encoded string 0xffffff00 it should be decoded to 16777215',
          () {
        const expectedResult = 16777215;
        const value = '0xffffff00';

        final registryIndex = registry.getIndex('u32');

        expect(codec.decode(registryIndex, value), expectedResult);
      });

      test('Given an encoded string 0x00000000 it should be decoded to 0', () {
        const expectedResult = 0;
        const value = '0x00000000';

        final registryIndex = registry.getIndex('u32');

        expect(codec.decode(registryIndex, value), expectedResult);
      });

      test(
          'Given an encoded string 0xffffffff it should be decoded to 4294967295',
          () {
        const expectedResult = 4294967295;
        const value = '0xffffffff';

        final registryIndex = registry.getIndex('u32');

        expect(codec.decode(registryIndex, value), expectedResult);
      });

      test(
          'Should throw UnprocessedDataLeftException when encoded string represents a value out of u32 range',
          () {
        const value = '0xffffff0000000000';
        final registryIndex = registry.getIndex('u32');

        expect(
          () => codec.decode(registryIndex, value),
          throwsA(isA<UnprocessedDataLeftException>()),
        );
      });
    });

    group('fixed-length 64bit', () {
      test(
          'Given an encoded string 0xffffff0000000000 it should decoded to 16777215',
          () {
        final expectedResult = BigInt.from(16777215);
        const value = '0xffffff0000000000';

        final registryIndex = registry.getIndex('u64');

        expect(codec.decode(registryIndex, value), expectedResult);
      });

      test(
          'Given an encoded string 0x0000000000000000 it should be decoded to zero',
          () {
        final expectedResult = BigInt.from(0);
        const value = '0x0000000000000000';

        final registryIndex = registry.getIndex('u64');

        expect(codec.decode(registryIndex, value), expectedResult);
      });

      test(
          'Given an encoded string 0xffffffffffffff7f it should be decoded to 18446744073709551615',
          () {
        final expectedResult = BigInt.parse('18446744073709551615');
        const value = '0xffffffffffffffff';

        final registryIndex = registry.getIndex('u64');

        expect(codec.decode(registryIndex, value), expectedResult);
      });

      test(
          'Should throw UnprocessedDataLeftException when encoded string represents a value out of u64 range',
          () {
        const value = '0xffffff00000000000000000000000000';
        final registryIndex = registry.getIndex('u64');

        expect(
          () => codec.decode(registryIndex, value),
          throwsA(isA<UnprocessedDataLeftException>()),
        );
      });
    });

    group('fixed-length 128bit', () {
      test(
          'Given an encoded string 0xffffff00000000000000000000000000 it should be decoded to 16777215',
          () {
        final expectedResult = BigInt.from(16777215);
        const value = '0xffffff00000000000000000000000000';

        final registryIndex = registry.getIndex('u128');

        expect(codec.decode(registryIndex, value), expectedResult);
      });

      test(
          'Given an encoded string 0x00000000000000000000000000000000 it should be decoded to zero',
          () {
        final expectedResult = BigInt.from(0);
        const value = '0x00000000000000000000000000000000';

        final registryIndex = registry.getIndex('u128');

        expect(codec.decode(registryIndex, value), expectedResult);
      });

      test(
          'Given an encoded string 0xffffffffffffffffffffffffffffffff it should be decoded to 340282366920938463463374607431768211455',
          () {
        final expectedResult =
            BigInt.parse('340282366920938463463374607431768211455');
        const value = '0xffffffffffffffffffffffffffffffff';

        final registryIndex = registry.getIndex('u128');

        expect(codec.decode(registryIndex, value), expectedResult);
      });

      test(
          'Should throw UnprocessedDataLeftException when encoded string represents a value out of u128 range',
          () {
        const value =
            '0xffffff0000000000000000000000000000000000000000000000000000000000';
        final registryIndex = registry.getIndex('u128');

        expect(
          () => codec.decode(registryIndex, value),
          throwsA(isA<UnprocessedDataLeftException>()),
        );
      });
    });

    group('fixed-length 256bit', () {
      test('Given an encoded string it should be decoded to 16777215', () {
        final expectedResult = BigInt.from(16777215);
        const value =
            '0xffffff0000000000000000000000000000000000000000000000000000000000';

        final registryIndex = registry.getIndex('u256');

        expect(codec.decode(registryIndex, value), expectedResult);
      });

      test('Given an encoded string it should be decoded to zero', () {
        final expectedResult = BigInt.from(0);
        const value =
            '0x0000000000000000000000000000000000000000000000000000000000000000';

        final registryIndex = registry.getIndex('u256');

        expect(codec.decode(registryIndex, value), expectedResult);
      });

      test(
          'Given an encoded string it should be decoded to 115792089237316195423570985008687907853269984665640564039457584007913129639935',
          () {
        final expectedResult = BigInt.parse(
            '115792089237316195423570985008687907853269984665640564039457584007913129639935');
        const value =
            '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff';

        final registryIndex = registry.getIndex('u256');

        expect(codec.decode(registryIndex, value), expectedResult);
      });

      test(
          'Should throw UnprocessedDataLeftException when encoded string is invalid',
          () {
        const value =
            '0xffffff00000000000000000000000000000000000000000000000000000000';
        final registryIndex = registry.getIndex('u256');

        expect(
          () => codec.decode(registryIndex, value),
          throwsA(isA<EOFException>()),
        );
      });
    });
  });
}
