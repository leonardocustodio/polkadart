import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('encode tuple tests ', () {
    final typesRegistry = <String, dynamic>{
      'Codec': {
        'a': '()',
        'b': '(Compact<u8>, bool)',
        'c': '(Compact<u8>, bool, String)',
      },
    };

    // Creates the registry for parsing the types
    final registry = OldTypeRegistry(types: typesRegistry);

    // specifying which type to use
    registry.select('Codec');

    // fetching the parsed types from `Json` to `Type``
    final types = registry.getTypes();

    // Initializing Scale-Codec object
    final codec = Codec(types);

    test(
        'Given a serie with compact unsigned integer and boolean it should be encoded to correct value',
        () {
      const value = [3, true];
      const expectedResult = '0x0c01';

      final registryIndex = registry.getIndex('(Compact<u8>, bool)');

      expect(codec.encodeToHex(registryIndex, value), expectedResult);
    });

    test(
        'Given a serie with compact unsigned integer, boolean and a String it should be encoded to correct value',
        () {
      const value = [42, false, 'Tuple'];
      const expectedResult = '0xa800145475706c65';

      final registryIndex = registry.getIndex('(Compact<u8>, bool, String)');

      expect(codec.encodeToHex(registryIndex, value), expectedResult);
    });

    test('Given an empty serie it should throw AssertionException', () {
      const value = [];

      final registryIndex = registry.getIndex('(Compact<u8>, bool)');

      expect(
        () => codec.encodeToHex(registryIndex, value),
        throwsA(isA<AssertionException>()),
      );
    });

    test('Given a null serie it should throw AssertionException', () {
      const value = null;

      final registryIndex = registry.getIndex('(Compact<u8>, bool)');

      expect(
        () => codec.encodeToHex(registryIndex, value),
        throwsA(isA<AssertionException>()),
      );
    });

    test(
        'Given an serie bigger than tuple length it should throw AssertionException',
        () {
      const value = [3, false, 3];

      final registryIndex = registry.getIndex('(Compact<u8>, bool)');

      expect(
        () => codec.encodeToHex(registryIndex, value),
        throwsA(isA<AssertionException>()),
      );
    });

    test(
        'Given an serie smaller than tuple length it should throw AssertionException',
        () {
      const value = [3, false];

      final registryIndex = registry.getIndex('(Compact<u8>, bool, String)');

      expect(
        () => codec.encodeToHex(registryIndex, value),
        throwsA(isA<AssertionException>()),
      );
    });

    test(
        'Should throw AssertionError when tuple is empty and value is not null',
        () {
      const value = [3, false];

      final registryIndex = registry.getIndex('()');

      expect(
        () => codec.encodeToHex(registryIndex, value),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  group('decode tuple tests ', () {
    final typesRegistry = <String, dynamic>{
      'Codec': {
        'b': '(Compact<u8>, bool)',
        'c': '(Compact<u8>, bool, String)',
      },
    };

    // Creates the registry for parsing the types
    final registry = OldTypeRegistry(types: typesRegistry);

    // specifying which type to use
    registry.select('Codec');

    // fetching the parsed types from `Json` to `Type``
    final types = registry.getTypes();

    // Initializing Scale-Codec object
    final codec = Codec(types);

    test('Given an encoded string it should decode to correct 2 values list',
        () {
      const expectedResult = [3, true];
      const value = '0x0c01';

      final registryIndex = registry.getIndex('(Compact<u8>, bool)');

      expect(codec.decodeBinary(registryIndex, value), expectedResult);
    });

    test('Given an encoded string it should decode to correct 3 values list',
        () {
      const expectedResult = [42, true, 'Test'];
      const value = '0xa8011054657374';

      final registryIndex = registry.getIndex('(Compact<u8>, bool, String)');

      expect(codec.decodeBinary(registryIndex, value), expectedResult);
    });

    test('Given an empty encoded string it should throw AssertionException',
        () {
      const value = '';

      final registryIndex = registry.getIndex('(Compact<u8>, bool)');

      expect(
        () => codec.decodeBinary(registryIndex, value),
        throwsA(isA<EOFException>()),
      );
    });
    test('Should throw EOFExpection when encoded string is invalid', () {
      const value = '0xa8';

      final registryIndex = registry.getIndex('(Compact<u8>, bool, String)');

      expect(
        () => codec.decodeBinary(registryIndex, value),
        throwsA(isA<EOFException>()),
      );
    });
  });
}
