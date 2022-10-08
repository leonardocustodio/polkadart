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

  group('Test Address:', () {
    // Encode
    test(
        'When Address:\'1fa9d1bd1db014b65872ee20aee4fd4d3a942d95d3357f463ea6c799130b6318\' is encoded then it should produce output: \'0xff1fa9d1bd1db014b65872ee20aee4fd4d3a942d95d3357f463ea6c799130b6318\'',
        () {
      final expectedValue =
          '0xff1fa9d1bd1db014b65872ee20aee4fd4d3a942d95d3357f463ea6c799130b6318';

      final encodedValue = codec.encodeToHex(usageIndex,
          '1fa9d1bd1db014b65872ee20aee4fd4d3a942d95d3357f463ea6c799130b6318');

      expect(expectedValue, encodedValue);
    });
    // Decode
    test(
        'When \'0xff1fa9d1bd1db014b65872ee20aee4fd4d3a942d95d3357f463ea6c799130b6318\' is decoded then it should give the output in Address',
        () {
      final expectedValue =
          '1fa9d1bd1db014b65872ee20aee4fd4d3a942d95d3357f463ea6c799130b6318';

      final decodedValue = codec.decodeBinary(usageIndex,
          '0xff1fa9d1bd1db014b65872ee20aee4fd4d3a942d95d3357f463ea6c799130b6318');

      expect(expectedValue, decodedValue);
    });
  });
}
