import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  // Creates the registry for parsing the types
  final registry = TypeRegistry(
    types: {
      'Codec': {
        'a': 'Result<u8, bool>',
      }
    },
  );

  // specifying which type to use.
  registry.select('Codec');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);

  //
  // Encode type: `Result<u8, bool>`
  group('Encode Result<u8, bool>:', () {
    test('\'{"Ok": 42}\' when encoded must produce result \'0x002a\'', () {
      final encoded =
          codec.encode(registry.getIndex('Result<u8, bool>'), {"Ok": 42});
      expect(encoded, equals('0x002a'));
    });
    test('\'{"Err": 42}\' when encoded must produce result \'0x0100\'', () {
      final encoded =
          codec.encode(registry.getIndex('Result<u8, bool>'), {"Err": false});
      expect(encoded, equals('0x0100'));
    });
  });

  //
  // Decode type: `String`
  group('Decode String:', () {
    test('\'0x002a\' when encoded must produce result \'{"Ok": 42}\'', () {
      final decoded =
          codec.decode(registry.getIndex('Result<u8, bool>'), '0x002a');
      expect({"Ok": 42}, equals(decoded));
    });
    test('\'0x0100\' when encoded must produce result \'{"Err": false}\'', () {
      final decoded =
          codec.decode(registry.getIndex('Result<u8, bool>'), '0x0100');
      expect({"Err": false}, equals(decoded));
    });
  });
}
