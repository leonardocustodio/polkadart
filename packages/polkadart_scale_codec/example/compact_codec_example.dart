// ignore_for_file: unused_local_variable
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  // defining used types
  final typesRegistry = <String, dynamic>{
    'Codec': {
      'a': 'Compact<u8>',
      'b': 'Compact<u16>',
      'c': 'Compact<u32>',
      'd': 'Compact<u64>',
      'e': 'Compact<u128>',
      'f': 'Compact<u256>',
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

  // encoding and decoding 256 as Compact<u8>
  String encodedInt = codec.encode(registry.getIndex('Compact<u8>'), 69);
  int decodedInt = codec.decode(registry.getIndex('Compact<u8>'), encodedInt);

  // encoding and decoding 65535 as Compact<u16>
  encodedInt = codec.encode(registry.getIndex('Compact<u16>'), 65535);
  decodedInt = codec.decode(registry.getIndex('Compact<u16>'), encodedInt);

  // encoding and decoding 16777215 as Compact<u32>
  encodedInt = codec.encode(registry.getIndex('Compact<u32>'), 16777215);
  decodedInt = codec.decode(registry.getIndex('Compact<u32>'), encodedInt);

  // encoding and decoding 18446744073709551615 as Compact<u64>
  String encodedBigInt = codec.encode(
      registry.getIndex('Compact<u64>'), '18446744073709551615'.toBigInt);
  BigInt decodedBigInt =
      codec.decode(registry.getIndex('Compact<u64>'), encodedBigInt);

  // encoding and decoding 340282366920938463463374607431768211455 as Compact<u128>
  encodedBigInt = codec.encode(
    registry.getIndex('Compact<u128>'),
    '340282366920938463463374607431768211455'.toBigInt,
  );
  decodedBigInt = codec.decode(
    registry.getIndex('Compact<u128>'),
    encodedBigInt,
  );

  // encoding and decoding 115792089237316195423570985008687907853269984665640564039457584007913129639935
  // as Compact<u256>
  encodedBigInt = codec.encode(
    registry.getIndex('Compact<u256>'),
    '115792089237316195423570985008687907853269984665640564039457584007913129639935'
        .toBigInt,
  );
  decodedBigInt = codec.decode(
    registry.getIndex('Compact<u256>'),
    encodedBigInt,
  );
}
