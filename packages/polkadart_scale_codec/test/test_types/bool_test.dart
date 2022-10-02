import 'package:test/test.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    as scale_codec;
import 'package:substrate_metadata/old/types.dart' as old_types;
import 'package:substrate_metadata/old/type_registry.dart';

void main() {
  // Creates the registry for parsing the types and selecting particular schema.
  final registry = OldTypeRegistry(
    old_types.OldTypes(
      types: <String, dynamic>{
        'Codec': {
          'bool_value': 'bool',
          'bool_option_value': 'Option<bool>',
          'array_value': '[bool; 2]'
        },
      },
    ),
  );
  // specifying which schema type to use.
  registry.use('Codec');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = scale_codec.Codec(types);

  // Encodes: bool
  group('encodes bool:', () {
    test('true on encoding should be \'0x01\'', () {
      final encoded = codec.encodeToHex(registry.use('bool'), true);

      expect('0x01', equals(encoded));
    });
    test('false on encoding should be \'0x00\'', () {
      final encoded = codec.encodeToHex(registry.use('bool'), false);

      expect('0x00', equals(encoded));
    });
  });

  // Decodes: bool
  group('decodes bool:', () {
    test('\'0x01\' on decoding should be true', () {
      final decoded = codec.decodeBinary(registry.use('bool'), '0x01');

      expect(true, equals(decoded));
    });
    test('\'0x00\' on decoding should be false', () {
      final encoded = codec.decodeBinary(registry.use('bool'), '0x00');

      expect(false, equals(encoded));
    });
  });

  // Encodes: Option<bool>
  group('Encode Option<Bool>:', () {
    test('true on encoding should be \'0x0101\'', () {
      final encoded = codec.encodeToHex(registry.use('Option<bool>'), true);

      expect('0x0101', equals(encoded));
    });
    test('false on encoding should be \'0x0100\'', () {
      final encoded = codec.encodeToHex(registry.use('Option<bool>'), false);

      expect('0x0100', equals(encoded));
    });
    test('null on encoding should be \'0x00\'', () {
      final encoded = codec.encodeToHex(registry.use('Option<bool>'), null);

      expect('0x00', equals(encoded));
    });
  });

  // Decodes: Option<bool>
  group('Decode Option<Bool>:', () {
    test('\'0x0101\' on decoding should be true', () {
      final decoded =
          codec.decodeBinary(registry.use('Option<bool>'), '0x0101');

      expect(true, equals(decoded));
    });
    test('\'0x0100\' on decoding should be false', () {
      final decoded =
          codec.decodeBinary(registry.use('Option<bool>'), '0x0100');

      expect(false, equals(decoded));
    });
    test('\'0x00\' on decoding should be null', () {
      final decoded = codec.decodeBinary(registry.use('Option<bool>'), '0x00');

      expect(null, equals(decoded));
    });
  });

  // Encodes Array<bool>
  group('Encode Array<bool>: ', () {
    test('[true, true] on encoding should be \'0x0101\'', () {
      final encoded =
          codec.encodeToHex(registry.use('[bool; 2]'), [true, true]);

      expect('0x0101', equals(encoded));
    });
    test('[true, false] on encoding should be \'0x0100\'', () {
      final encoded =
          codec.encodeToHex(registry.use('[bool; 2]'), [true, false]);

      expect('0x0100', equals(encoded));
    });
    test('[false, true] on encoding should be \'0x0001\'', () {
      final encoded =
          codec.encodeToHex(registry.use('[bool; 2]'), [false, true]);

      expect('0x0001', equals(encoded));
    });
    test('[false, false] on encoding should be \'0x0000\'', () {
      final encoded =
          codec.encodeToHex(registry.use('[bool; 2]'), [false, false]);

      expect('0x0000', equals(encoded));
    });
  });

  // Decodes: Array<bool>
  group('Decode Array<bool>:', () {
    test('\'0x0101\' on decoding should be [true, true]', () {
      final decoded = codec.decodeBinary(registry.use('[bool; 2]'), '0x0101');

      expect([true, true], equals(decoded));
    });
    test('\'0x0100\' on decoding should be [true, false]', () {
      final decoded = codec.decodeBinary(registry.use('[bool; 2]'), '0x0100');

      expect([true, false], equals(decoded));
    });
    test('\'0x0001\' on decoding should be [false, true]', () {
      final decoded = codec.decodeBinary(registry.use('[bool; 2]'), '0x0001');

      expect([false, true], equals(decoded));
    });
    test('\'0x0000\' on decoding should be [false, false]', () {
      final decoded = codec.decodeBinary(registry.use('[bool; 2]'), '0x0000');

      expect([false, false], equals(decoded));
    });
  });
}
