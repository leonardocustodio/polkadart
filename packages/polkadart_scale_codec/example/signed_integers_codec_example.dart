// ignore_for_file: unused_local_variable
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  // defining used types
  final typesRegistry = <String, dynamic>{
    'Codec': {
      'a': 'i8',
      'b': 'i16',
      'c': 'i32',
      'd': 'i64',
      'e': 'i128',
      'f': 'i256',
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

  // encoding and decoding -128 as signed 8bit int
  String encodedInt = codec.encode(registry.getIndex('i8'), -128);
  int decodedInt = codec.decode(registry.getIndex('i8'), encodedInt);

  // encoding and decoding -32768 as signed 16bit
  encodedInt = codec.encode(registry.getIndex('i16'), -32768);
  decodedInt = codec.decode(registry.getIndex('i16'), encodedInt);

  // encoding and decoding -2147483648 as signed 32bit
  encodedInt = codec.encode(registry.getIndex('i32'), -2147483648);
  decodedInt = codec.decode(registry.getIndex('i32'), encodedInt);

  // encoding and decoding -9223372036854775808 as signed 64bit
  String encodedBigInt =
      codec.encode(registry.getIndex('i64'), '-9223372036854775808'.toBigInt);
  BigInt decodedBigInt = codec.decode(registry.getIndex('i64'), encodedBigInt);

  // encoding and decoding -170141183460469231731687303715884105728 as signed 128bit
  encodedBigInt = codec.encode(
    registry.getIndex('i128'),
    '-170141183460469231731687303715884105728'.toBigInt,
  );
  decodedBigInt = codec.decode(
    registry.getIndex('i128'),
    encodedBigInt,
  );

  // encoding and decoding -57896044618658097711785492504343953926634992332820282019728792003956564819968 as signed 256bit
  encodedBigInt = codec.encode(
    registry.getIndex('i256'),
    '-57896044618658097711785492504343953926634992332820282019728792003956564819968'
        .toBigInt,
  );
  decodedBigInt = codec.decode(
    registry.getIndex('i256'),
    encodedBigInt,
  );
}
