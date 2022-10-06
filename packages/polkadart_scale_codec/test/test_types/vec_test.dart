import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  // Creates the registry for parsing the types and selecting particular schema.
  final registry = OldTypeRegistry(
    types: <String, dynamic>{
      'Codec': {
        'a': 'Vec<u8>',
        'b': 'Vec<Vec<u8>>',
        'c': 'Vec<u256>',
        'd': 'Vec<u256>',
        'e': 'Vec<(u32, u32, u16)>',
        'f': 'Vec<(u32, bool)>',
        'g': 'Vec<(String, bool)>',
        'h': 'Vec<bool>',
        'i': 'Vec<Option<bool>>',
        'j': 'Vec<Option<u8>>',
      },
    },
  );
  // specifying which schema key to select and use
  registry.select('Codec');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);

  group('Encode Test Vec<(u32, u32, u16)>:', () {
    test(
        '[[716, 47054848, 0], [256, 0, 0]] when encoded should produce result: \'0x08cc0200000000ce02000000010000000000000000\'',
        () {
      var encoded =
          codec.encodeToHex(registry.getIndex('Vec<(u32, u32, u16)>'), [
        [716, 47054848, 0],
        [256, 0, 0]
      ]);
      expect('0x08cc0200000000ce02000000010000000000000000', encoded);
    });
  });

  group('Decode Test Vec<(u32, u32, u16)>:', () {
    test(
        '\'0x08cc0200000000ce02000000010000000000000000\' when decoded should produce result: [[716, 47054848, 0], [256, 0, 0]]',
        () {
      var decoded = codec.decodeBinary(
          registry.getIndex('Vec<(u32, u32, u16)>'),
          '0x08cc0200000000ce02000000010000000000000000');
      expect([
        [716, 47054848, 0],
        [256, 0, 0]
      ], decoded);
    });
  });

  group('Encode Exception Test Vec<(u32, u32, u16)>:', () {
    test(
        '[[716, 47054848], [256, 0, 0]] should throw \'AssertionException\' with message: \'Incorrect length of values to unwrap to tuple.\'.',
        () {
      expect(
          () => codec.encodeToHex(registry.getIndex('Vec<(u32, u32, u16)>'), [
                [716, 47054848],
                [256, 0, 0]
              ]),
          throwsA(predicate((e) =>
              e is AssertionException &&
              e.toString() ==
                  'Incorrect length of values to unwrap to tuple.')));
    });
  });
}
