import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  // Creates the registry for parsing the types
  final registry = TypeRegistry();

  // specifying which type to use.
  final usageIndex = registry.getIndex('BitVec<u8>');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);

  //
  // Encodes type: `BitVec<u8>`
  group('Encode BitVec<u8>:', () {
    test('Lowest acceptable value is [0] and the output should be \'0x2000\'',
        () {
      final encoded = codec.encode(usageIndex, [0]);
      expect(encoded, equals('0x2000'));
    });

    test(
        'Highest acceptable value is \'[255]\' and the output should be \'0x20ff\'',
        () {
      final encoded = codec.encode(usageIndex, [255]);
      expect(encoded, equals('0x20ff'));
    });
  });

  //
  // Decodes type: `BitVec<u8>`
  group('Decode BitVec<u8>:', () {
    test('On decoding \'0x2000\' we must get lowest acceptable value: [0]', () {
      final decoded = codec.decode(usageIndex, '0x2000');
      expect(decoded, equals([0]));
    });

    test('On decoding \'0x20ff\' we must get lowest acceptable value: [255]',
        () {
      final decoded = codec.decode(usageIndex, '0x20ff');
      expect(decoded, equals([255]));
    });
  });

  //
  // Exception on Encode at (lowest - 1) and (highest + 1): `BitVec<u8>`
  group('Exception on Encode BitVec<u8>:', () {
    test(
        'should throw exception \'UnexpectedCaseException\' when encoding [-1] which is 1 lesser than lowest acceptable.',
        () {
      expect(
          () => codec.encode(usageIndex, [-1]),
          throwsA(predicate((e) =>
              e is UnexpectedCaseException &&
              e.toString() == 'Invalid byte, unable to encode [-1].')));
    });

    test(
        'should throw exception \'UnexpectedCaseException\' when encoding [256] which is 1 greater tham highest acceptable.',
        () {
      expect(
          () => codec.encode(usageIndex, [256]),
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
          () => codec.decode(usageIndex, 0),
          throwsA(predicate((e) =>
              e is AssertionException && e.toString() == exceptionMessage)));
    });

    test(
        'On decoding \'double\' should throw exception \'AssertionException\' for BitVec<u8>',
        () {
      final exceptionMessage =
          'Source(data) -> `data` should be either String, List<int> or Uint8List.';
      expect(
          () => codec.decode(usageIndex, 0.0),
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
          'BitSequence can have bits of type List<int> only.';
      expect(
          () => codec.encode(usageIndex, 0),
          throwsA(predicate((e) =>
              e is AssertionException && e.toString() == exceptionMessage)));
    });

    test(
        'On encoding \'float\' value should throw exception \'AssertionException\' for BitVec<u8>',
        () {
      final exceptionMessage =
          'BitSequence can have bits of type List<int> only.';
      expect(
          () => codec.encode(usageIndex, 0.0),
          throwsA(predicate((e) =>
              e is AssertionException && e.toString() == exceptionMessage)));
    });
  });
}
