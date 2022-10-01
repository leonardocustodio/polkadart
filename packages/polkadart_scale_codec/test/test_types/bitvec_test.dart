import 'package:test/test.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    as scale_codec;
import 'package:substrate_metadata/old/types.dart' as old_types;
import 'package:substrate_metadata/old/type_registry.dart';

void main() {
  // Creates the registry for parsing the types and selecting particular schema.
  var registry = OldTypeRegistry(
    old_types.OldTypes(
      types: <String, dynamic>{
        'Codec': {
          'bit_sequence_value_u8': 'BitVec<u8>',
        },
      },
    ),
  );

  // specifying which schema type to use.
  registry.use('Codec');

  // fetching the parsed types from `Json` to `Type`
  var types = registry.getTypes();

  // Initializing Scale-Codec object
  var codec = scale_codec.Codec(types);

  //
  // Encodes type: `BitVec<u8>`
  group('Encode BitVec<u8>:', () {
    test('1', () {
      var encoded = codec.encodeToHex(registry.use('BitVec<u8>'), [1]);
      expect(encoded, equals('0x2001'));
    });

    test('Encode: 2', () {
      var encoded = codec.encodeToHex(registry.use('BitVec<u8>'), [2]);
      expect(encoded, equals('0x2002'));
    });

    test('Encode: 3', () {
      var encoded = codec.encodeToHex(registry.use('BitVec<u8>'), [3]);
      expect(encoded, equals('0x2003'));
    });
  });

  //
  // Decodes type: `BitVec<u8>`
  group('Decode BitVec<u8>:', () {
    test('1', () {
      var decoded = codec.decodeBinary(registry.use('BitVec<u8>'), '0x2001');
      expect(decoded, equals([1]));
    });

    test('2', () {
      var decoded = codec.decodeBinary(registry.use('BitVec<u8>'), '0x2002');
      expect(decoded, equals([2]));
    });

    test('3', () {
      var decoded = codec.decodeBinary(registry.use('BitVec<u8>'), '0x2003');
      expect(decoded, equals([3]));
    });
  });
}
