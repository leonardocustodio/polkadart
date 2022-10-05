import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  // Creates the registry for parsing the types
  final registry = OldTypeRegistry();

  // specifying which type to use.
  final usageIndex = registry.getIndex('Bytes');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);

  //
  // Encode type: `Bytes`
  group('Encode Bytes:', () {
    test('\'0xffff\' when encoded must produce result \'0x08ffff\'', () {
      final encoded = codec.encodeToHex(usageIndex, '0xffff');
      expect(encoded, equals('0x08ffff'));
    });
  });

  //
  // Decode type: `Bytes`
  group('Decode Bytes:', () {
    test('\'0x08ffff\' when decoded must produce result \'0xffff\'', () {
      final decoded = codec.decodeBinary(usageIndex, '0x08ffff');
      expect(decoded, equals('0xffff'));
    });
  });

  //
  // Exception at type: `Bytes`
  group('Exception Bytes:', () {
    test('should throw \'AssertionException\' when trying to encode \'0\'', () {
      final exceptionMessage =
          'Unable to encode due to invalid byte type, Try to pass \'Hex String\' or \'List<int>\'.';
      expect(
          () => codec.encodeToHex(usageIndex, 0),
          throwsA(predicate((e) =>
              e is AssertionException && e.toString() == exceptionMessage)));
    });

    test('should throw \'EOFException\' when trying to decode \'0x08ff\'', () {
      final exceptionMessage = 'Unexpected end of file/source exception.';
      expect(
          () => codec.decodeBinary(usageIndex, '0x08ff'),
          throwsA(predicate(
              (e) => e is EOFException && e.toString() == exceptionMessage)));
    });
  });
}
