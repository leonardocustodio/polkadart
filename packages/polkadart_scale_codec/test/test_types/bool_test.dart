import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  // Creates the registry for parsing the types and selecting particular schema.
  final registry = TypeRegistry();
  // specifying which schema key to select and use
  final registryIndex = registry.getIndex('bool');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);

  // Encodes: bool
  group('encodes bool:', () {
    test('true on encoding should be \'0x01\'', () {
      final encoded = codec.encode(registryIndex, true);

      expect('0x01', equals(encoded));
    });
    test('false on encoding should be \'0x00\'', () {
      final encoded = codec.encode(registryIndex, false);

      expect('0x00', equals(encoded));
    });
  });

  // Decodes: bool
  group('decodes bool:', () {
    test('\'0x01\' on decoding should be true', () {
      final decoded = codec.decode(registryIndex, '0x01');

      expect(true, equals(decoded));
    });
    test('\'0x00\' on decoding should be false', () {
      final encoded = codec.decode(registryIndex, '0x00');

      expect(false, equals(encoded));
    });
  });

  // Exception when encoding at different value: bool
  group('Exception on encoding: bool:', () {
    test(
        'should throw \'AssertionException\' when encoding \'integer\' value on bool type.',
        () {
      final exceptionMessage = 'Needed value of type \'bool\' but found int.';
      expect(
          () => codec.encode(registryIndex, 0),
          throwsA(predicate((e) =>
              e is AssertionException && e.toString() == exceptionMessage)));
    });
    test(
        'should throw \'AssertionException\' when encoding \'null\' value on bool type.',
        () {
      final exceptionMessage = 'Needed value of type \'bool\' but found Null.';
      expect(
          () => codec.encode(registryIndex, null),
          throwsA(predicate((e) =>
              e is AssertionException && e.toString() == exceptionMessage)));
    });
  });
}
