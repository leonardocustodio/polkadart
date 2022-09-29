import 'package:test/test.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    as scale_codec;
import 'package:substrate_metadata/old/types.dart' as old_types;
import 'package:substrate_metadata/old/type_registry.dart';

void main() {
  // Creates the registry for parsing the types and selecting particular schema.
  var registry = OldTypeRegistry(
    old_types.OldTypes(
      types: <String, dynamic>{
        'Codec': {
          'bit_sequence_value_u8': 'BitVec<u8>',
        },
      },
    ),
  );

  // specifying which schema type to use.
  registry.use('Codec');

  // fetching the parsed types from `Json` to `Type`
  var types = registry.getTypes();

  // Initializing Scale-Codec object
  var codec = scale_codec.Codec(types);

  //
  // Encodes adn Decodes type: `BitVec<u8>`
  group('Encode/Decode BitVec<u8>: ', () {
    for (var vec in [1, 2, 3]) {
      test('$vec', () {
        var encoded = codec.encodeToHex(registry.use('BitVec<u8>'), [vec]);

        var decoded = codec.decodeBinary(registry.use('BitVec<u8>'), encoded);

        expect([vec], equals(decoded));
      });
    }
  });
}
