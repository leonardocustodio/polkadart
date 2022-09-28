import 'package:test/test.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    as scale_codec;
import 'package:substrate_metadata/old/types.dart' as old_types;
import 'package:substrate_metadata/old/type_registry.dart';

void main() {
  var registry = OldTypeRegistry(
    old_types.OldTypes(
      types: <String, dynamic>{
        'Codec': {
          'bit_sequence_value_u8': 'BitVec<u8>',
        },
      },
    ),
  );
  var _ = registry.use('Codec');
  var types = registry.getTypes();
  var codec = scale_codec.Codec(types);

  ///
  ///
  /// BitVec<u8> type encode / decode
  ///
  ///
  group('Encode/Decode BitVec<u8>: ', () {
    for (var vec in [1, 2, 3]) {
      test('$vec', () {
        var encoded = codec.encodeToHex(registry.use('BitVec<u8>'), [vec]);

        var decoded = codec.decodeBinary(registry.use('BitVec<u8>'), encoded);

        expect([vec], equals(decoded));
      });
    }
  });
}
