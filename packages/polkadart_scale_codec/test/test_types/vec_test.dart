import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
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
        'f': 'Vec<bool>',
        'g': 'Vec<Option<bool>>',
        'h': 'Vec<Option<u8>>',
      },
    },
  );
  // specifying which schema key to select and use
  registry.select('Codec');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);

  group('Test Vec<(u32, u32, u16)>', () {
    test('', () {});
  });
}
