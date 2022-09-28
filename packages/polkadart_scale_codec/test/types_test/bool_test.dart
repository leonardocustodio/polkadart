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
          'bool_value': 'bool',
          'bool_option_value': 'Option<bool>',
          'array_value': '[bool; 1]'
        },
      },
    ),
  );
  var _ = registry.use('Codec');
  var types = registry.getTypes();
  var codec = scale_codec.Codec(types);

  ///
  ///
  /// bool type encode / decode
  ///
  ///
  group('Encode/Decode Bool: ', () {
    for (var bool in [true, false]) {
      test('$bool', () {
        var encoded = codec.encodeToHex(registry.use('bool'), bool);

        var decoded = codec.decodeBinary(registry.use('bool'), encoded);

        expect(bool, equals(decoded));
      });
    }
  });

  ///
  ///
  /// Option<bool> type encode / decode
  ///
  ///
  group('Encode/Decode Option<Bool>: ', () {
    for (var bool in [null, true, false]) {
      test('$bool', () {
        var encoded = codec.encodeToHex(registry.use('Option<bool>'), bool);

        var decoded = codec.decodeBinary(registry.use('Option<bool>'), encoded);

        expect(bool, equals(decoded));
      });
    }
  });

  ///
  ///
  /// Array<bool> type encode / decode
  ///
  ///
  group('Encode/Decode Array<bool>: ', () {
    for (var bool in [true, false]) {
      test('$bool', () {
        var encoded = codec.encodeToHex(registry.use('[bool; 1]'), [bool]);

        var decoded = codec.decodeBinary(registry.use('[bool; 1]'), encoded);

        expect([bool], equals(decoded));
      });
    }
  });
}
