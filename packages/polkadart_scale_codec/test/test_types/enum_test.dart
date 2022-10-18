import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  {
    // Creates the registry for parsing the types
    final registry = TypeRegistry(
      types: {
        'FavouriteColorEnum': {
          '_enum': ['Red', 'Orange']
        },
      },
    );

    final typeIndex = registry.getIndex('FavouriteColorEnum');

    // fetching the parsed types from `Json` to `Type`
    final types = registry.getTypes();

    // Initializing Scale-Codec object
    final codec = Codec(types);

    group('Encode FavouriteColorEnum:', () {
      test(
          'When \'Red\' of \'FavouriteColorEnum\' is encoded then it produces desired results.',
          () {
        final value = 'Red';
        final expectedResult = '0x00';

        final encoded = codec.encode(typeIndex, value);

        expect(encoded, expectedResult);
      });
      test(
          'When \'Orange\' of \'FavouriteColorEnum\' is encoded then it produces desired results.',
          () {
        final value = 'Orange';
        final expectedResult = '0x01';

        final encoded = codec.encode(typeIndex, value);

        expect(encoded, expectedResult);
      });
    });

    group('Decode FavouriteColorEnum:', () {
      test(
          'When \'0x00\' is decoded then it will produce 0th index result of \'FavouriteColorEnum\': \'Red\'.',
          () {
        final value = '0x00';
        final expectedResult = 'Red';

        final encoded = codec.decode(typeIndex, value);

        expect(encoded, expectedResult);
      });
      test(
          'When \'0x01\' is decoded then it will produce 1st index result of \'FavouriteColorEnum\': \'Orange\'.',
          () {
        final value = '0x01';
        final expectedResult = 'Orange';

        final encoded = codec.decode(typeIndex, value);

        expect(encoded, expectedResult);
      });
    });

    group('Exception on encoding with wrong enum.', () {
      test(
          'When Unknown enum value: \'White\' is encoded then it throws \'UnknownVariantException\'.',
          () {
        final value = 'White';

        expect(() => codec.encode(typeIndex, value),
            throwsA(isA<UnknownVariantException>()));
      });
    });
  }

  {
    // Creates the registry for parsing the types
    final registry = TypeRegistry(
      types: {
        'FavouriteColorEnum': {
          '_enum': ['Red', 'Orange']
        },
        'ComplexEnum': {
          '_enum': {
            'Plain': 'Text',
            'ExtraData': {
              'index': 'u8',
              'name': 'Text',
              'customTuple': '(FavouriteColorEnum, bool)'
            }
          }
        },
      },
    );

    final typeIndex = registry.getIndex('ComplexEnum');

    // fetching the parsed types from `Json` to `Type`
    final types = registry.getTypes();

    // Initializing Scale-Codec object
    final codec = Codec(types);

    group('Encode ComplexEnum:', () {
      test(
          'When {\'Plain\': \'scale-codec\'} is encoded then it produces \'0x002c7363616c652d636f646563\'.',
          () {
        final value = {'Plain': 'scale-codec'};
        final expectedResult = '0x002c7363616c652d636f646563';

        final encoded = codec.encode(typeIndex, value);

        expect(encoded, expectedResult);
      });
      test(
          'When \'ExtraData\' is encoded then it produces \'0x010124706f6c6b61646172740001\'.',
          () {
        final value = {
          'ExtraData': {
            'index': 1,
            'name': 'polkadart',
            'customTuple': ['Red', true]
          },
        };
        final expectedResult = '0x010124706f6c6b61646172740001';

        final encoded = codec.encode(typeIndex, value);

        expect(encoded, expectedResult);
      });
    });

    group('Decode ComplexEnum:', () {
      test(
          'When \'0x002c7363616c652d636f646563\' is decoded then it results to value: \'{\'Plain\': \'scale-codec\'}\'.',
          () {
        final value = '0x002c7363616c652d636f646563';
        final expectedResult = {'Plain': 'scale-codec'};

        final encoded = codec.decode(typeIndex, value);

        expect(encoded, expectedResult);
      });
      test(
          'When \'0x010124706f6c6b61646172740001\' is decoded then it results to value: \'ExtraData\'\'.',
          () {
        final value = '0x010124706f6c6b61646172740001';
        final expectedResult = {
          'ExtraData': {
            'index': 1,
            'name': 'polkadart',
            'customTuple': ['Red', true]
          },
        };

        final decoded = codec.decode(typeIndex, value);

        expect(decoded, expectedResult);
      });
    });

    group('Exception on encoding with wrong type.', () {
      test(
          'When \'u8\' is used instead of \'Text\' is encoded then it throws \'AssertionException\'.',
          () {
        final value = {'Plain': 0};

        expect(() => codec.encode(typeIndex, value),
            throwsA(isA<AssertionException>()));
      });
    });
  }
}
