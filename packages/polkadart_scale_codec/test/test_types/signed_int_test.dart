import 'package:polkadart_scale_codec/src/core/core.dart';
import 'package:polkadart_scale_codec/src/util/utils.dart';
import 'package:test/test.dart';

void main() {
  group('encode to hex signed int tests', () {
    final typesRegistry = <String, dynamic>{
      'Codec': {
        'a': 'i8',
        'b': 'i16',
        'c': 'i32',
        'd': 'i64',
        'e': 'i128',
        'f': 'i256',
      },
    };
    // Creates the registry for parsing the types and selecting particular schema.
    final registry = TypeRegistry(types: typesRegistry);

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

        int registryIndex = registry.getIndex('i8');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test('Should return correct encoded data when value is zero', () {
        int value = 0;
        String expectedResult = '0x00';

        int registryIndex = registry.getIndex('i8');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test('Should return correct encoded data when value is -128', () {
        int value = -128;
        String expectedResult = '0x80';

        int registryIndex = registry.getIndex('i8');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test('Should return correct encoded data when value is 127', () {
        int value = 127;
        String expectedResult = '0x7f';

        int registryIndex = registry.getIndex('i8');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test('Should throw InvalidSizeException when value is smaller than -128',
          () {
        int value = -129;
        int registryIndex = registry.getIndex('i8');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test('Should throw InvalidSizeException when value is greater than 127',
          () {
        int value = 128;
        int registryIndex = registry.getIndex('i8');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test('Should throw AssertionException when value is null', () {
        int? value;
        int registryIndex = registry.getIndex('i8');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });

      test('Should throw AssertionException when value is a BigInt', () {
        BigInt value = 5.toBigInt;
        int registryIndex = registry.getIndex('i8');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });

      test('Should throw AssertionException when value is not an Integer', () {
        String value = '5';
        int registryIndex = registry.getIndex('i8');

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

        int registryIndex = registry.getIndex('i16');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test('Should return correct encoded data when value is -32768', () {
        int value = -32768;
        String expectedResult = '0x0080';

        int registryIndex = registry.getIndex('i16');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test('Should return correct encoded data when value is zero', () {
        int value = 0;
        String expectedResult = '0x0000';

        int registryIndex = registry.getIndex('i16');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test('Should return correct encoded data when value is 32767', () {
        int value = 32767;
        String expectedResult = '0xff7f';

        int registryIndex = registry.getIndex('i16');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test(
          'Should throw InvalidSizeException when value is smaller than -32768',
          () {
        int value = -32769;
        int registryIndex = registry.getIndex('i16');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test('Should throw InvalidSizeException when value is greater than 32767',
          () {
        int value = 32768;
        int registryIndex = registry.getIndex('i16');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test('Should throw AssertionException when value is null', () {
        int? value;
        int registryIndex = registry.getIndex('i16');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });

      test('Should throw AssertionException when value is a BigInt', () {
        BigInt value = 5.toBigInt;
        int registryIndex = registry.getIndex('i16');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });

      test('Should throw AssertionException when value is not an Integer', () {
        String value = '5';
        int registryIndex = registry.getIndex('i16');

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

        int registryIndex = registry.getIndex('i32');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test('Should return correct encoded data when value is -2147483648', () {
        int value = -2147483648;
        String expectedResult = '0x00000080';

        int registryIndex = registry.getIndex('i32');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test('Should return correct encoded data when value is 0', () {
        int value = 0;
        String expectedResult = '0x00000000';

        int registryIndex = registry.getIndex('i32');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test('Should return correct encoded data when value is 2147483647', () {
        int value = 2147483647;
        String expectedResult = '0xffffff7f';

        int registryIndex = registry.getIndex('i32');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test(
          'Should throw InvalidSizeException when value is smaller than -2147483648',
          () {
        int value = -2147483649;
        int registryIndex = registry.getIndex('i32');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test(
          'Should throw InvalidSizeException when value is greater than 2147483647',
          () {
        int value = 2147483648;
        int registryIndex = registry.getIndex('i32');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test('Should throw AssertionException when value is null', () {
        int? value;
        int registryIndex = registry.getIndex('i32');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });

      test('Should throw AssertionException when value is a BigInt', () {
        BigInt value = 5.toBigInt;
        int registryIndex = registry.getIndex('i32');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });

      test('Should throw AssertionException when value is not an Integer', () {
        String value = '5';
        int registryIndex = registry.getIndex('i32');

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

        int registryIndex = registry.getIndex('i64');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test(
          'Should return correct encoded data when value is -9223372036854775808',
          () {
        BigInt value = BigInt.from(-9223372036854775808);
        String expectedResult = '0x0000000000000080';

        int registryIndex = registry.getIndex('i64');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test('Should return correct encoded data when value is zero', () {
        BigInt value = BigInt.from(0);
        String expectedResult = '0x0000000000000000';

        int registryIndex = registry.getIndex('i64');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test(
          'Should return correct encoded data when value is 9223372036854775807',
          () {
        BigInt value = BigInt.parse('9223372036854775807');
        String expectedResult = '0xffffffffffffff7f';

        int registryIndex = registry.getIndex('i64');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test(
          'Should throw InvalidSizeException when value is smaller than -9223372036854775808',
          () {
        BigInt value = BigInt.parse('-9223372036854775809');
        int registryIndex = registry.getIndex('i64');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test(
          'Should throw InvalidSizeException when value is greater than 9223372036854775807',
          () {
        BigInt value = BigInt.parse('9223372036854775808');
        int registryIndex = registry.getIndex('i64');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test('Should throw AssertionException when value is null', () {
        BigInt? value;
        int registryIndex = registry.getIndex('i64');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });

      test('Should throw AssertionException when value is an Integer', () {
        int value = 5;
        int registryIndex = registry.getIndex('i64');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });

      test('Should throw AssertionException when value is not an BigInt', () {
        String value = '5';
        int registryIndex = registry.getIndex('i64');

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

        int registryIndex = registry.getIndex('i128');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test(
          'Should return correct encoded data when value is -170141183460469231731687303715884105728',
          () {
        BigInt value = BigInt.parse('-170141183460469231731687303715884105728');
        String expectedResult = '0x00000000000000000000000000000080';

        int registryIndex = registry.getIndex('i128');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test('Should return correct encoded data when value is zero', () {
        BigInt value = BigInt.from(0);
        String expectedResult = '0x00000000000000000000000000000000';

        int registryIndex = registry.getIndex('i128');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test(
          'Should return correct encoded data when value is 170141183460469231731687303715884105727',
          () {
        BigInt value = BigInt.parse('170141183460469231731687303715884105727');
        String expectedResult = '0xffffffffffffffffffffffffffffff7f';

        int registryIndex = registry.getIndex('i128');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test(
          'Should throw InvalidSizeException when value is smaller than -170141183460469231731687303715884105728',
          () {
        BigInt value = BigInt.parse('-170141183460469231731687303715884105729');
        int registryIndex = registry.getIndex('i128');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test(
          'Should throw InvalidSizeException when value is greater than 170141183460469231731687303715884105727',
          () {
        BigInt value = BigInt.parse('170141183460469231731687303715884105728');
        int registryIndex = registry.getIndex('i128');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test('Should throw AssertionException when value is null', () {
        int? value;
        int registryIndex = registry.getIndex('i128');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });

      test('Should throw AssertionException when value is an Integer', () {
        int value = 5;
        int registryIndex = registry.getIndex('i128');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });

      test('Should throw AssertionException when value is not a BigInt', () {
        String value = '5';
        int registryIndex = registry.getIndex('i128');

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

        int registryIndex = registry.getIndex('i256');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test(
          'Should return correct encoded data when value is -57896044618658097711785492504343953926634992332820282019728792003956564819968',
          () {
        BigInt value = BigInt.parse(
            '-57896044618658097711785492504343953926634992332820282019728792003956564819968');
        String expectedResult =
            '0x0000000000000000000000000000000000000000000000000000000000000080';

        int registryIndex = registry.getIndex('i256');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test('Should return correct encoded data when value is zero', () {
        BigInt value = BigInt.from(0);
        String expectedResult =
            '0x0000000000000000000000000000000000000000000000000000000000000000';

        int registryIndex = registry.getIndex('i256');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test(
          'Should return correct encoded data when value is 57896044618658097711785492504343953926634992332820282019728792003956564819967',
          () {
        BigInt value = BigInt.parse(
            '57896044618658097711785492504343953926634992332820282019728792003956564819967');
        String expectedResult =
            '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f';

        int registryIndex = registry.getIndex('i256');

        expect(codec.encode(registryIndex, value), expectedResult);
      });

      test(
          'Should throw InvalidSizeException when value is smaller than -57896044618658097711785492504343953926634992332820282019728792003956564819968',
          () {
        BigInt value = BigInt.parse(
            '-57896044618658097711785492504343953926634992332820282019728792003956564819969');
        int registryIndex = registry.getIndex('i256');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test(
          'Should throw InvalidSizeException when value is greater than 57896044618658097711785492504343953926634992332820282019728792003956564819967',
          () {
        BigInt value = BigInt.parse(
            '57896044618658097711785492504343953926634992332820282019728792003956564819968');
        int registryIndex = registry.getIndex('i256');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test('Should throw AssertionException when value is null', () {
        BigInt? value;
        int registryIndex = registry.getIndex('i256');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });

      test('Should throw AssertionException when value is a Integer', () {
        int value = 5;
        int registryIndex = registry.getIndex('i256');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });

      test('Should throw AssertionException when value is not a BigInt', () {
        String value = '5';
        int registryIndex = registry.getIndex('i256');

        expect(
          () => codec.encode(registryIndex, value),
          throwsA(isA<AssertionException>()),
        );
      });
    });
  });
}
