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
      test('Should encode and return correct value ', () {
        int value = 69;
        String expectedResult = '0x45';

        int registryIndex = registry.getIndex('i8');

        expect(codec.encodeToHex(registryIndex, value), expectedResult);
      });

      test('Should return correct encoded data when value is -128', () {
        int value = -128;
        String expectedResult = '0x80';

        int registryIndex = registry.getIndex('i8');

        expect(codec.encodeToHex(registryIndex, value), expectedResult);
      });

      test('Should return correct encoded data when value is 127', () {
        int value = 127;
        String expectedResult = '0x7f';

        int registryIndex = registry.getIndex('i8');

        expect(codec.encodeToHex(registryIndex, value), expectedResult);
      });

      test('Should throw InvalidSizeException when value is smaller than -128',
          () {
        int value = -129;
        int registryIndex = registry.getIndex('i8');

        expect(
          () => codec.encodeToHex(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test('Should throw InvalidSizeException when value is greater than 127',
          () {
        int value = 128;
        int registryIndex = registry.getIndex('i8');

        expect(
          () => codec.encodeToHex(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });
    });

    group('fixed-length 16bit', () {
      test('Should encode and return correct value ', () {
        int value = 42;
        String expectedResult = '0x2a00';

        int registryIndex = registry.getIndex('i16');

        expect(codec.encodeToHex(registryIndex, value), expectedResult);
      });

      test('Should return correct encoded data when value is -32768', () {
        int value = -32768;
        String expectedResult = '0x0080';

        int registryIndex = registry.getIndex('i16');

        expect(codec.encodeToHex(registryIndex, value), expectedResult);
      });

      test('Should return correct encoded data when value is 32767', () {
        int value = 32767;
        String expectedResult = '0xff7f';

        int registryIndex = registry.getIndex('i16');

        expect(codec.encodeToHex(registryIndex, value), expectedResult);
      });

      test(
          'Should throw InvalidSizeException when value is smaller than -32768',
          () {
        int value = -32769;
        int registryIndex = registry.getIndex('i16');

        expect(
          () => codec.encodeToHex(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test('Should throw InvalidSizeException when value is greater than 32767',
          () {
        int value = 32768;
        int registryIndex = registry.getIndex('i16');

        expect(
          () => codec.encodeToHex(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });
    });

    group('fixed-length 32bit', () {
      test('Should encode and return correct value ', () {
        int value = 16777215;
        String expectedResult = '0xffffff00';

        int registryIndex = registry.getIndex('i32');

        expect(codec.encodeToHex(registryIndex, value), expectedResult);
      });

      test('Should return correct encoded data when value is -2147483648', () {
        int value = -2147483648;
        String expectedResult = '0x00000080';

        int registryIndex = registry.getIndex('i32');

        expect(codec.encodeToHex(registryIndex, value), expectedResult);
      });

      test('Should return correct encoded data when value is 2147483647', () {
        int value = 2147483647;
        String expectedResult = '0xffffff7f';

        int registryIndex = registry.getIndex('i32');

        expect(codec.encodeToHex(registryIndex, value), expectedResult);
      });

      test(
          'Should throw InvalidSizeException when value is smaller than -2147483648',
          () {
        int value = -2147483649;
        int registryIndex = registry.getIndex('i32');

        expect(
          () => codec.encodeToHex(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });

      test(
          'Should throw InvalidSizeException when value is greater than 2147483647',
          () {
        int value = 2147483648;
        int registryIndex = registry.getIndex('i32');

        expect(
          () => codec.encodeToHex(registryIndex, value),
          throwsA(isA<InvalidSizeException>()),
        );
      });
    });
  });
}
