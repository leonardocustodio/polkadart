import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  // Creates the registry for parsing the types
  final registry = TypeRegistry();

  // specifying which type to use.
  final usageIndex = registry.getIndex('BitVec<u8>');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  //
  // Encodes type: `BitVec<u8>`
  group('Encode BitVec<u8>:', () {
    test(
        'When \'[1, 1, 0, 1, 1]\' is encoded then result \'0x141b\' is produced',
        () {
      final encoded = Codec(types).encode(usageIndex, [1, 1, 0, 1, 1]);
      expect('0x141b', equals(encoded));
    });

    test(
        'When \'[1, 1, 0, 1, 1, 0]\' is encoded then result \'0x181b\' is produced',
        () {
      final encoded = Codec(types).encode(usageIndex, [1, 1, 0, 1, 1, 0]);
      expect('0x181b', equals(encoded));
    });

    test(
        'When \'[1, 1, 0, 1, 1, 0, 0]\' is encoded then result \'0x1c1b\' is produced',
        () {
      final encoded = Codec(types).encode(usageIndex, [1, 1, 0, 1, 1, 0, 0]);
      expect('0x1c1b', equals(encoded));
    });

    test(
        'When \'[1, 1, 1, 1, 1, 0, 1]\' is encoded then result \'0x1c5f\' is produced',
        () {
      final encoded = Codec(types).encode(usageIndex, [1, 1, 1, 1, 1, 0, 1]);
      expect('0x1c5f', equals(encoded));
    });

    test(
        'When \'[1, 1, 0, 1, 1, 0, 0, 0]\' is encoded then result \'0x201b\' is produced',
        () {
      final encoded = Codec(types).encode(usageIndex, [1, 1, 0, 1, 1, 0, 0, 0]);
      expect('0x201b', equals(encoded));
    });

    test(
        'When \'[1, 1, 1, 1, 1, 1, 1, 1]\' is encoded then result \'0x20ff\' is produced',
        () {
      final encoded = Codec(types).encode(usageIndex, [1, 1, 1, 1, 1, 1, 1, 1]);
      expect('0x20ff', equals(encoded));
    });
  });

  group('Decode BitVec<u8>: ', () {
    test(
        'When \'0x141b\' is decoded then result \'[1, 1, 0, 1, 1]\' is produced',
        () {
      final decoded = Codec(types).decode(usageIndex, '0x141b');
      expect([1, 1, 0, 1, 1], equals(decoded));
    });

    test(
        'When \'0x181b\' is decoded then result \'[1, 1, 0, 1, 1, 0]\' is produced',
        () {
      final decoded = Codec(types).decode(usageIndex, '0x181b');
      expect([1, 1, 0, 1, 1, 0], equals(decoded));
    });

    test(
        'When \'0x1c1b\' is decoded then result \'[1, 1, 0, 1, 1, 0, 0]\' is produced',
        () {
      final decoded = Codec(types).decode(usageIndex, '0x1c1b');
      expect([1, 1, 0, 1, 1, 0, 0], equals(decoded));
    });

    test(
        'When \'0x1c5f\' is decoded then result \'[1, 1, 1, 1, 1, 0, 1]\' is produced',
        () {
      final decoded = Codec(types).decode(usageIndex, '0x1c5f');
      expect([1, 1, 1, 1, 1, 0, 1], equals(decoded));
    });

    test(
        'When \'0x201b\' is decoded then result \'[1, 1, 0, 1, 1, 0, 0, 0]\' is produced',
        () {
      final decoded = Codec(types).decode(usageIndex, '0x201b');
      expect([1, 1, 0, 1, 1, 0, 0, 0], equals(decoded));
    });

    test(
        'When \'0x20ff\' is decoded then result \'[1, 1, 1, 1, 1, 1, 1, 1]\' is produced',
        () {
      final decoded = Codec(types).decode(usageIndex, '0x20ff');
      expect([1, 1, 1, 1, 1, 1, 1, 1], equals(decoded));
    });
  });

  //
  // Encodes type: `BitVec<u8>`
  group('Encode BitVec<u8>:', () {
    test('Lowest acceptable value is [0] and the output should be \'0x0400\'',
        () {
      final encoded = Codec(types).encode(usageIndex, [0]);
      expect('0x0400', equals(encoded));
    });

    test(
        'Highest acceptable value is \'[1, 1, 1, 1, 1, 1]\' and the output should be \'0x183f\'',
        () {
      final encoded = Codec(types).encode(usageIndex, [1, 1, 1, 1, 1, 1]);
      expect('0x183f', equals(encoded));
    });
  });

  //
  // Decodes type: `BitVec<u8>`
  group('Decode BitVec<u8>:', () {
    test(
        'On decoding \'0x2000\' we must get lowest acceptable value: [0, 0, 0, 0, 0, 0, 0, 0]',
        () {
      final decoded = Codec(types).decode(usageIndex, '0x2000');
      expect([0, 0, 0, 0, 0, 0, 0, 0], equals(decoded));
    });

    test(
        'On decoding \'0x20ff\' we must get lowest acceptable value: [1, 1, 1, 1, 1, 1, 1, 1]',
        () {
      final decoded = Codec(types).decode(usageIndex, '0x20ff');
      expect([1, 1, 1, 1, 1, 1, 1, 1], equals(decoded));
    });
  });

  //
  // Exception on Encode at (lowest - 1) and (highest + 1): `BitVec<u8>`
  group('Exception on Encode BitVec<u8>:', () {
    test(
        'should throw exception \'UnexpectedCaseException\' when encoding [-1] which is 1 lesser than lowest acceptable.',
        () {
      expect(
          () => Codec(types).encode(usageIndex, [-1]),
          throwsA(predicate((e) =>
              e is UnexpectedCaseException &&
              e.toString() == 'Invalid byte, unable to encode [-1].')));
    });

    test(
        'should throw exception \'UnexpectedCaseException\' when encoding [256] which is 1 greater tham highest acceptable.',
        () {
      expect(
          () => Codec(types).encode(usageIndex, [256]),
          throwsA(predicate((e) =>
              e is UnexpectedCaseException &&
              e.toString() == 'Invalid byte, unable to encode [256].')));
    });
  });

  //
  // Exception on Decode at wrong value type: `BitVec<u8>`
  group('Exception on Decode BitVec<u8>:', () {
    test(
        'On decoding \'integer\' value should throw exception \'AssertionException\' for BitVec<u8>',
        () {
      final exceptionMessage =
          'Source(data) -> `data` should be either String, List<int> or Uint8List.';
      expect(
          () => Codec(types).decode(usageIndex, 0),
          throwsA(predicate((e) =>
              e is AssertionException && e.toString() == exceptionMessage)));
    });

    test(
        'On decoding \'double\' should throw exception \'AssertionException\' for BitVec<u8>',
        () {
      final exceptionMessage =
          'Source(data) -> `data` should be either String, List<int> or Uint8List.';
      expect(
          () => Codec(types).decode(usageIndex, 0.0),
          throwsA(predicate((e) =>
              e is AssertionException && e.toString() == exceptionMessage)));
    });
  });

  //
  // Exception on Encode at wrong value type: `BitVec<u8>`
  group('Exception on Encode BitVec<u8>:', () {
    test(
        'On encoding \'integer\' value should throw exception \'AssertionException\' for BitVec<u8>',
        () {
      final exceptionMessage =
          'BitSequence can have bits of type `List<int>` only.';
      expect(
          () => Codec(types).encode(usageIndex, 0),
          throwsA(predicate((e) =>
              e is AssertionException && e.toString() == exceptionMessage)));
    });

    test(
        'On encoding \'float\' value should throw exception \'AssertionException\' for BitVec<u8>',
        () {
      final exceptionMessage =
          'BitSequence can have bits of type `List<int>` only.';
      expect(
          () => Codec(types).encode(usageIndex, 0.0),
          throwsA(predicate((e) =>
              e is AssertionException && e.toString() == exceptionMessage)));
    });
  });
}
