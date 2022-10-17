// ignore_for_file: unused_local_variable

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  // Creates the registry for parsing the types and selecting particular schema.
  final registry = TypeRegistry();

  // specifying which schema key to select and use
  final registryIndex = registry.getIndex('Bytes');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);

  // encoding and decoding [255, 255] as Bites
  String encoded = codec.encode(registryIndex, [255, 255]);
  List<int> decoded = codec.decode(registryIndex, encoded);
}
