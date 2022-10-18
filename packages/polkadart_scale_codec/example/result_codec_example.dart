// ignore_for_file: unused_local_variable
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  // defining used types
  final typesRegistry = <String, dynamic>{
    'Codec': {
      'a': 'Result<u8, bool>',
    },
  };

  // Creates the registry for parsing the types and selecting particular schema.
  final registry = TypeRegistry(types: typesRegistry);

  // specifyng which schema type to use
  registry.select('Codec');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);

  // encoding and decoding {"Ok": 42} as Result<u8, bool>
  String encoded =
      codec.encode(registry.getIndex('Result<u8, bool>'), {'Ok': 42});
  final decodedResultU8 =
      codec.decode(registry.getIndex('Result<u8, bool>'), encoded);

  // encoding and decoding {'Err': false} as Result<u8, bool>
  encoded = codec.encode(registry.getIndex('Result<u8, bool>'), {'Err': false});
  final decodedResultBool =
      codec.decode(registry.getIndex('Result<u8, bool>'), encoded);
}
