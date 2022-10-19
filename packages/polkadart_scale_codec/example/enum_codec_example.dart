import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  // Creates the registry for parsing the types and selecting particular schema.
  final registry = TypeRegistry(
    types: {
      'FavouriteColorEnum': {
        '_enum': ['Red', 'Orange']
      },
    },
  );

  // specifying which schema key to select and use
  final registryIndex = registry.getIndex('FavouriteColorEnum');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);

  final value = 'Red';

  // encoding and decoding zero as BitVec<u8>
  String encoded = codec.encode(registryIndex, value);
  String decoded = codec.decode(registryIndex, encoded);
  assert(decoded == value);
}
