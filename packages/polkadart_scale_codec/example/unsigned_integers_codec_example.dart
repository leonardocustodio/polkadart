// ignore_for_file: unused_local_variable
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  // defining used types
  final typesRegistry = <String, dynamic>{
    'Codec': {
      'a': 'u8',
      'b': 'u16',
      'c': 'u32',
      'd': 'u64',
      'e': 'u128',
      'f': 'u256',
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

  // encoding and decoding 69 as unsigned 8bit int
  String encodedInt = codec.encode(registry.getIndex('u8'), 69);
  int decodedInt = codec.decode(registry.getIndex('u8'), encodedInt);

  // encoding and decoding 65535 as ununsigned 16bit
  encodedInt = codec.encode(registry.getIndex('u16'), 65535);
  decodedInt = codec.decode(registry.getIndex('u16'), encodedInt);

  // encoding and decoding 16777215 as unsigned 32bit
  encodedInt = codec.encode(registry.getIndex('u32'), 16777215);
  decodedInt = codec.decode(registry.getIndex('u32'), encodedInt);

  // encoding and decoding 18446744073709551615 as unsigned 64bit
  String encodedBigInt =
      codec.encode(registry.getIndex('u64'), '18446744073709551615'.toBigInt);
  BigInt decodedBigInt = codec.decode(registry.getIndex('u64'), encodedBigInt);

  // encoding and decoding 340282366920938463463374607431768211455 as unsigned 128bit
  encodedBigInt = codec.encode(
    registry.getIndex('u128'),
    '340282366920938463463374607431768211455'.toBigInt,
  );
  decodedBigInt = codec.decode(
    registry.getIndex('u128'),
    encodedBigInt,
  );

  // encoding and decoding 115792089237316195423570985008687907853269984665640564039457584007913129639935 as unsigned 256bit
  encodedBigInt = codec.encode(
    registry.getIndex('u256'),
    '115792089237316195423570985008687907853269984665640564039457584007913129639935'
        .toBigInt,
  );
  decodedBigInt = codec.decode(
    registry.getIndex('u256'),
    encodedBigInt,
  );
}
