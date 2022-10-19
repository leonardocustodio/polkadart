// ignore_for_file: unused_local_variable
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  // defining used types
  final typesRegistry = <String, dynamic>{
    'Codec': {
      'a': '(Compact<u8>, bool)',
      'b': '(String, u8)',
      'c': '(BitVec, Bytes, Option<bool>)',
      'd': '(i256, Result<u8, bool>)',
      'e': '(Vec<String>, Vec<u8>)',
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

  // encoding and decoding [3, true] as Tuple<[Compact<u8>, bool]>
  String encoded =
      codec.encode(registry.getIndex('(Compact<u8>, bool)'), [3, true]);
  List<dynamic> decoded =
      codec.decode(registry.getIndex('(Compact<u8>, bool)'), encoded);

  // encoding and decoding ['Tuple', 133] as Tuple<[String, u8]>
  encoded = codec.encode(registry.getIndex('(String, u8)'), ['Tuple', 133]);
  decoded = codec.decode(registry.getIndex('(String, u8)'), encoded);

  // encoding and decoding [[0],[255, 255],true] as Tuple<[BitVec, Bytes, Option<bool>]>
  encoded = codec.encode(registry.getIndex('(BitVec, Bytes, Option<bool>)'), [
    [0],
    [255, 255],
    true
  ]);
  decoded =
      codec.decode(registry.getIndex('(BitVec, Bytes, Option<bool>)'), encoded);

  // encoding and decoding [(-313113131423413).toBigInt,{'Ok': 42}] as Tuple<[i256, Result<u8, bool>]>
  encoded = codec.encode(registry.getIndex('(i256, Result<u8, bool>)'), [
    (-313113131423413).toBigInt,
    {'Ok': 42}
  ]);
  decoded =
      codec.decode(registry.getIndex('(i256, Result<u8, bool>)'), encoded);

  // encoding and decoding [['tuple', 'test'], [100, 10]] as Tuple<[Vec<String>, Vec<u8>]>
  encoded = codec.encode(registry.getIndex('(Vec<String>, Vec<u8>)'), [
    ['tuple', 'test'],
    [100, 10]
  ]);
  decoded = codec.decode(registry.getIndex('(Vec<String>, Vec<u8>)'), encoded);
}
