import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  // Creates the registry for parsing the types
  final registry = TypeRegistry(
    types: {
      'OrderJuiceEnum': {
        '_enum': ['Orange', 'Apple', 'Kiwi']
      },
      'OuncesEnum': {
        '_struct': {'ounces': 'u8', 'Remarks': 'Option<Text>'}
      },
      'OrderStruct': {
        '_struct': {
          'index': 'u8',
          'note': 'Text',
          'Juice': 'OrderJuiceEnum',
          'Ounces': 'OuncesEnum'
        }
      },
    },
  );

  final typeIndex = registry.getIndex('OrderStruct');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);

  {
    group('Encode OrderStruct:', () {
      test('When given valid value is encoded then it encodes easily.', () {
        final value = {
          'index': 8,
          'note': 'This is a note',
          'Juice': 'Kiwi',
          'Ounces': {
            'ounces': 1,
            'Remarks': Some('First order.'),
          }
        };
        final expectedResult =
            '0x0838546869732069732061206e6f7465020101304669727374206f726465722e';

        final encoded = codec.encode(typeIndex, value);

        expect(encoded, expectedResult);
      });
      test('When given valid changed value is encoded then it encodes easily.',
          () {
        final value = {
          'index': 8,
          'note': 'This is a note',
          'Juice': 'Kiwi',
          'Ounces': {
            'ounces': 1,
            'Remarks': None,
          }
        };
        final expectedResult = '0x0838546869732069732061206e6f7465020100';

        final encoded = codec.encode(typeIndex, value);

        expect(encoded, expectedResult);
      });
    });
  }

  {
    group('Decode OrderStruct:', () {
      test('When given valid hex is decoded then it decodes without exception.',
          () {
        final expectedResult = {
          'index': 8,
          'note': 'This is a note',
          'Juice': 'Kiwi',
          'Ounces': {
            'ounces': 1,
            'Remarks': Some('First order.'),
          }
        };
        final value =
            '0x0838546869732069732061206e6f7465020101304669727374206f726465722e';

        final decoded = codec.decode(typeIndex, value);

        expect(decoded, expectedResult);
      });
      test(
          'When given valid hex is decoded then it decodes without exception .',
          () {
        final expectedResult = {
          'index': 8,
          'note': 'This is a note',
          'Juice': 'Kiwi',
          'Ounces': {
            'ounces': 1,
            'Remarks': None,
          }
        };
        final value = '0x0838546869732069732061206e6f7465020100';

        final decoded = codec.decode(typeIndex, value);

        expect(decoded, expectedResult);
      });
    });
  }

  {
    group('Exception on encoding.', () {
      test(
          'When invalid value is encoded then it throws \'AssertionException\'.',
          () {
        final value = {
          'index': 8,
          'note': 'This is a note',
          'Juice': null,
          'Ounces': {
            'ounces': 1,
            'Remarks': null,
          }
        };

        expect(() => codec.encode(typeIndex, value),
            throwsA(isA<AssertionException>()));
      });
      test('When invalid key is encoded then it throws \'AssertionException\'.',
          () {
        final value = {'unknown': 0, 'randomKey': 'randomValue'};

        expect(() => codec.encode(typeIndex, value),
            throwsA(isA<AssertionException>()));
      });
    });
  }

  //
  // Exception on encoding
  group('Exception on encoding struct.', () {
    test(
        'When invalid value is encoded then it throws \'UnknownVariantException\'.',
        () {
      final value = 'scale-codec';

      expect(() => codec.encode(typeIndex, value),
          throwsA(isA<UnknownVariantException>()));
    });
    test(
        'When invalid type is encoded then it throws \'UnknownVariantException\'.',
        () {
      final value = 0;

      expect(() => codec.encode(typeIndex, value),
          throwsA(isA<UnknownVariantException>()));
    });

    test('When null is encoded then it throws \'UnknownVariantException\'.',
        () {
      final value = null;

      expect(() => codec.encode(typeIndex, value),
          throwsA(isA<UnknownVariantException>()));
    });
  });

  //
  // Exception on decoding
  group('Exception on decoding struct.', () {
    test('When invalid \'hex\' is decoded then it throws \'EOFException\'.',
        () {
      final value = '0x02';

      expect(
          () => codec.decode(typeIndex, value), throwsA(isA<EOFException>()));
    });
  });
}
