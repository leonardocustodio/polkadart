// ignore_for_file: unused_local_variable

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  // defining used types
  final typesRegistry = <String, dynamic>{
    'Codec': {
      'a': 'Vec<Text>',
      'b': 'String',
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

  // encoding and decoding "scale codec" as Vec<Text>
  String encoded =
      codec.encode(registry.getIndex('Vec<Text>'), ['scale codec']);
  List<dynamic> decodedList =
      codec.decode(registry.getIndex('Vec<Text>'), encoded);

  // encoding and decoding "scale codec" as String
  encoded = codec.encode(registry.getIndex('String'), 'scale codec');
  final decodedString = codec.decode(registry.getIndex('String'), encoded);
}
