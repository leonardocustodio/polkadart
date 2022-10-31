import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  final typesRegistry = <String, dynamic>{
    'Codec': {
      'a': '(Compact<u8>, bool)',
      'b': '(String, u8)',
      'c': '(BitVec, Bytes, Option<bool>)',
      'd': '(i256, Result<u8, bool>)',
      'e': '(Vec<String>, Vec<u8>)',
    },
  };

  // Creates the registry for parsing the types
  final registry = TypeRegistry(types: typesRegistry);

  // specifying which type to use
  registry.select('Codec');

  // fetching the parsed types from `Json` to `Type``
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);
  group('encode tuple to hex ', () {
    test(
        'Given a list with compact unsigned integer and boolean it should be encoded to correct value',
        () {
      const value = [3, true];
      const expectedResult = '0x0c01';

      final registryIndex = registry.getIndex('(Compact<u8>, bool)');

      expect(codec.encode(registryIndex, value), expectedResult);
    });

    test(
        'Given a list of one String and one unsigned 8bit integer it should be encoded to correct value',
        () {
      const value = ['Tuple', 133];
      const expectedResult = '0x145475706c6585';

      final registryIndex = registry.getIndex('(String, u8)');

      expect(codec.encode(registryIndex, value), expectedResult);
    });

    test(
        'Given a list of one BitVec, one Bytes and one Option<bool> it should be encoded to correct value',
        () {
      const value = [
        [0],
        [255, 255],
        Some(true)
      ];
      const expectedResult = '0x200008ffff0101';

      final registryIndex = registry.getIndex('(BitVec, Bytes, Option<bool>)');

      expect(codec.encode(registryIndex, value), expectedResult);
    });

    test(
        'Given a list of one signed 256 bits integer and one Result<u8> it should be encoded to correct value',
        () {
      final value = [
        (-313113131423413).toBigInt,
        {'Ok': 42}
      ];
      const expectedResult =
          '0x4be906ab39e3feffffffffffffffffffffffffffffffffffffffffffffffffff002a';

      final registryIndex = registry.getIndex('(i256, Result<u8, bool>)');

      expect(codec.encode(registryIndex, value), expectedResult);
    });

    test(
        'Given a list of one Vec<String> it should be encoded to correct value',
        () {
      final value = [
        ['tuple', 'test'],
        [100, 10]
      ];
      const expectedResult = '0x08147475706c65107465737408640a';

      final registryIndex = registry.getIndex('(Vec<String>, Vec<u8>)');

      expect(codec.encode(registryIndex, value), expectedResult);
    });

    test('Given an empty list it should throw AssertionException', () {
      const value = [];

      final registryIndex = registry.getIndex('(Compact<u8>, bool)');

      expect(
        () => codec.encode(registryIndex, value),
        throwsA(isA<AssertionException>()),
      );
    });

    test('Given a null list it should throw AssertionException', () {
      const value = null;

      final registryIndex = registry.getIndex('(Compact<u8>, bool)');

      expect(
        () => codec.encode(registryIndex, value),
        throwsA(isA<AssertionException>()),
      );
    });

    test(
        'Given a list bigger than tuple length it should throw AssertionException',
        () {
      const value = [3, false, 3];

      final registryIndex = registry.getIndex('(Compact<u8>, bool)');

      expect(
        () => codec.encode(registryIndex, value),
        throwsA(isA<AssertionException>()),
      );
    });

    test(
        'Given a list smaller than tuple length it should throw AssertionException',
        () {
      const value = [3, false];

      final registryIndex = registry.getIndex('(Compact<u8>, bool, String)');

      expect(
        () => codec.encode(registryIndex, value),
        throwsA(isA<RangeError>()),
      );
    });
  });

  group('decode tuple tests ', () {
    test(
        'Given an encoded string when it represents a list of [Compact<u8>, bool] it should be decoded',
        () {
      const expectedResult = [3, true];
      const value = '0x0c01';

      final registryIndex = registry.getIndex('(Compact<u8>, bool)');

      expect(codec.decode(registryIndex, value), expectedResult);
    });

    test(
        'Given an encoded string when it represents a list of [String, u8] it should decoded',
        () {
      const expectedResult = ['Tuple', 133];
      const value = '0x145475706c6585';

      final registryIndex = registry.getIndex('(String, u8)');

      expect(codec.decode(registryIndex, value), expectedResult);
    });

    test(
        'Given an encoded string when it represents a list of [BitVec, Bytes, Option<bool>] it should decoded',
        () {
      const expectedResult = [
        [0],
        [255, 255],
        Some(true)
      ];
      const value = '0x200008ffff0101';

      final registryIndex = registry.getIndex('(BitVec, Bytes, Option<bool>)');

      expect(codec.decode(registryIndex, value), expectedResult);
    });

    test(
        'Given an encoded string when it represents a list of [i256, Result<u8, bool>] it should decoded',
        () {
      final expectedResult = [
        (-313113131423413).toBigInt,
        {'Ok': 42}
      ];
      const value =
          '0x4be906ab39e3feffffffffffffffffffffffffffffffffffffffffffffffffff002a';

      final registryIndex = registry.getIndex('(i256, Result<u8, bool>)');

      expect(codec.decode(registryIndex, value), expectedResult);
    });

    test(
        'Given an encoded string when it represents a list of [Vec<String>, Vec<u8>] it should decoded',
        () {
      final expectedResult = [
        ['tuple', 'test'],
        [100, 10]
      ];

      const value = '0x08147475706c65107465737408640a';

      final registryIndex = registry.getIndex('(Vec<String>, Vec<u8>)');

      expect(codec.decode(registryIndex, value), expectedResult);
    });

    test('Given an empty encoded string it should throw AssertionException',
        () {
      const value = '';

      final registryIndex = registry.getIndex('(Compact<u8>, bool)');

      expect(
        () => codec.decode(registryIndex, value),
        throwsA(isA<EOFException>()),
      );
    });
  });
}
