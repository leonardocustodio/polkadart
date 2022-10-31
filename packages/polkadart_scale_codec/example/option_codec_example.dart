// ignore_for_file: unused_local_variable
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  // defining used types
  final typesRegistry = <String, dynamic>{
    'Codec': {
      'a': 'Option<bool>',
      'b': 'Option<Option<bool>>',
      'c': 'Option<Option<Option<bool>>>',
      'd': 'Option<u128>',
      'e': 'Option<Compact<u8>>',
      'f': 'Option<BitVec<u8>>',
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

  // encoding and decoding `true` as Option<bool>
  String encoded = codec.encode(registry.getIndex('Option<bool>'), true);
  final decodedBool = codec.decode(registry.getIndex('Option<bool>'), encoded);

  // encoding and decoding 1 as Option<u128>
  encoded = codec.encode(registry.getIndex('Option<u128>'), 1.toBigInt);
  final decodedU128 = codec.decode(registry.getIndex('Option<u128>'), encoded);

  // encoding and decoding 63 as Option<Compact<u8>>
  encoded = codec.encode(registry.getIndex('Option<Compact<u8>>'), 63);
  final decodedCompactU8 =
      codec.decode(registry.getIndex('Option<Compact<u8>>'), encoded);

  // encoding and decoding [0] as Option<BitVec<u8>>
  encoded = codec.encode(registry.getIndex('Option<BitVec<u8>>'), [0]);
  final decodedBitVec =
      codec.decode(registry.getIndex('Option<BitVec<u8>>'), encoded);

  // encoding and decoding
  String encodedTwoOptions =
      codec.encode(registry.getIndex('Option<Option<bool>>'), Some(None));

  final decodedTwoBool = codec.decode(
      registry.getIndex('Option<Option<bool>>'), encodedTwoOptions);

  // encoding and decoding
  String encodedThreeOptions = codec.encode(
      registry.getIndex('Option<Option<Option<bool>>>'),
      Some(Some(Some(true))));

  final decodedThreeBool = codec.decode(
      registry.getIndex('Option<Option<Option<bool>>>'), encodedThreeOptions);
}
