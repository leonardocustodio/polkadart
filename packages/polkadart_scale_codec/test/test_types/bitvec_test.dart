import 'package:test/test.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  // Creates the registry for parsing the types and selecting particular schema.
  final registry = OldTypeRegistry();

  // specifying which type to use.
  int usageIndex = registry.getIndex('BitVec<u8>');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);

  //
  // Encodes type: `BitVec<u8>`
  group('Encode BitVec<u8>:', () {
    test('1', () {
      final encoded = codec.encodeToHex(usageIndex, [1]);
      expect(encoded, equals('0x2001'));
    });

    test('Encode: 2', () {
      final encoded = codec.encodeToHex(usageIndex, [2]);
      expect(encoded, equals('0x2002'));
    });

    test('Encode: 3', () {
      final encoded = codec.encodeToHex(usageIndex, [3]);
      expect(encoded, equals('0x2003'));
    });
  });

  //
  // Decodes type: `BitVec<u8>`
  group('Decode BitVec<u8>:', () {
    test('1', () {
      final decoded = codec.decodeBinary(usageIndex, '0x2001');
      expect(decoded, equals([1]));
    });

    test('2', () {
      final decoded = codec.decodeBinary(usageIndex, '0x2002');
      expect(decoded, equals([2]));
    });

    test('3', () {
      final decoded = codec.decodeBinary(usageIndex, '0x2003');
      expect(decoded, equals([3]));
    });
  });
}
