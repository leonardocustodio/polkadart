import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  // Creates the registry for parsing the types
  final registry = TypeRegistry(
    types: {
      'Codec': {
        'a': 'Vec<Text>',
        'b': 'String',
      }
    },
  );

  // specifying which type to use.
  registry.select('Codec');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);

  //
  // Encode type: `String`
  group('Encode String:', () {
    test('\'Test\' when encoded must produce result \'0x1054657374\'', () {
      final encoded = codec.encode(registry.getIndex('String'), 'Test');
      expect(encoded, equals('0x1054657374'));
    });
  });

  //
  // Decode type: `String`
  group('Decode String:', () {
    test('\'0x1054657374\' when decoded must produce result \'Test\'', () {
      final decoded = codec.decode(registry.getIndex('String'), '0x1054657374');
      expect(decoded, equals('Test'));
    });
  });

  //
  // Exception at type: `String`
  group('Exception String:', () {
    test('should throw \'AssertionException\' when trying to encode 0', () {
      final exceptionMessage = 'Needed value of type \'String\' but found int.';

      expect(
          () => codec.encode(registry.getIndex('String'), 0),
          throwsA(predicate((e) =>
              e is AssertionException && e.toString() == exceptionMessage)));
    });

    test('should throw \'UnexpectedCaseException\' when trying to decode \'0\'',
        () {
      final exceptionMessage = 'Invalid byte, unable to decode 0.';
      expect(
          () => codec.decode(registry.getIndex('String'), '0'),
          throwsA(predicate((e) =>
              e is UnexpectedCaseException &&
              e.toString() == exceptionMessage)));
    });

    test('should throw \'EOFException\' when trying to decode \'0x08ff\'', () {
      final exceptionMessage = 'Unexpected end of file/source exception.';
      expect(
          () => codec.decode(registry.getIndex('String'), '0x08ff'),
          throwsA(predicate(
              (e) => e is EOFException && e.toString() == exceptionMessage)));
    });
  });
}
