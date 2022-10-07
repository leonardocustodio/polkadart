import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  // Creates the registry for parsing the types
  final registry = OldTypeRegistry();

  // specifying which type to use.
  final usageIndex = registry.getIndex('Address');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);

  // Test type: `Address`
  group('Test Address:', () {
    // Encode
    test(
        'Address:\'1fa9d1bd1db014b65872ee20aee4fd4d3a942d95d3357f463ea6c799130b6318\' when encoded should produce output \'0xff1fa9d1bd1db014b65872ee20aee4fd4d3a942d95d3357f463ea6c799130b6318\'',
        () {
      final encoded = codec.encodeToHex(usageIndex,
          '1fa9d1bd1db014b65872ee20aee4fd4d3a942d95d3357f463ea6c799130b6318');
      expect(
          '0xff1fa9d1bd1db014b65872ee20aee4fd4d3a942d95d3357f463ea6c799130b6318',
          encoded);
    });
    // Decode
    test(
        '\'0xff1fa9d1bd1db014b65872ee20aee4fd4d3a942d95d3357f463ea6c799130b6318\' when decoded should give the output address as: \'1fa9d1bd1db014b65872ee20aee4fd4d3a942d95d3357f463ea6c799130b6318\'',
        () {
      final decoded = codec.decodeBinary(usageIndex,
          '0xff1fa9d1bd1db014b65872ee20aee4fd4d3a942d95d3357f463ea6c799130b6318');
      expect('1fa9d1bd1db014b65872ee20aee4fd4d3a942d95d3357f463ea6c799130b6318',
          decoded);
    });
  });
}
