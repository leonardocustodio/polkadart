// ignore_for_file: unused_local_variable
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  // defining used types
  final typesRegistry = <String, dynamic>{
    'Codec': {
      'a': 'Vec<u8>',
      'b': 'Vec<Vec<u8>>',
      'c': 'Vec<u256>',
      'd': 'Vec<i256>',
      'e': 'Vec<(u32, Option<bool>)>',
      'f': 'Vec<bool>',
      'g': 'Vec<Option<bool>>',
      'h': 'Vec<String>',
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

  // encoding and decoding [255, 255] as Vec<u8>
  String encoded = codec.encode(registry.getIndex('Vec<u8>'), [255, 255]);
  final decodedVecU8 = codec.decode(registry.getIndex('Vec<u8>'), encoded);

  // encoding and decoding [0, 133999773] as Vec<u256>
  encoded = codec
      .encode(registry.getIndex('Vec<u256>'), [0.toBigInt, 133999773.toBigInt]);
  final decodedVecU256 = codec.decode(registry.getIndex('Vec<u256>'), encoded);

  // encoding and decoding [0, -133999773] as Vec<i256>
  encoded = codec.encode(
      registry.getIndex('Vec<i256>'), [0.toBigInt, (-133999773).toBigInt]);
  final decodedVecI256 = codec.decode(registry.getIndex('Vec<i256>'), encoded);

  // encoding and decoding [true, false, true] as Vec<bool>
  encoded = codec.encode(registry.getIndex('Vec<bool>'), [true, false, true]);
  final decodedVecBool = codec.decode(registry.getIndex('Vec<bool>'), encoded);

  // encoding and decoding [true, false, true] as Vec<Option<bool>>
  encoded =
      codec.encode(registry.getIndex('Vec<Option<bool>>'), [true, false, true]);
  final decodedVecOptionBool =
      codec.decode(registry.getIndex('Vec<Option<bool>>'), encoded);

  // encoding and decoding [[0,1], [2,3], [4,5]] as Vec<Vec<u8>>
  encoded = codec.encode(registry.getIndex('Vec<Vec<u8>>'), [
    [0, 1],
    [2, 3],
    [4, 5],
  ]);
  final decodecVecVecU8 =
      codec.decode(registry.getIndex('Vec<Vec<u8>>'), encoded);

  // encoding and decoding ["Scale", "Codec"] as Vec<String>
  encoded = codec.encode(
    registry.getIndex('Vec<String>'),
    ["Scale", "Codec"],
  );
  final decodecVecString =
      codec.decode(registry.getIndex('Vec<String>'), encoded);

  // encoding and decoding [[716, 100], [256, true]] as Vec<(u32, Option<bool>)>
  encoded = codec.encode(registry.getIndex('Vec<(u32, Option<bool>)>'), [
    [716, false],
    [255, true],
  ]);
  final decodedVecTuple =
      codec.decode(registry.getIndex('Vec<(u32, Option<bool>)>'), encoded);
}
