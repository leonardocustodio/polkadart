import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  // Creates the registry for parsing the types
  final registry = TypeRegistry();

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
      final encoded = codec.encode(usageIndex, '0xffff');
      expect('0x08ffff', encoded);
    });
  });

  //
  // Decode type: `Bytes`
  group('Decode Bytes:', () {
    test('\'0x08ffff\' when decoded must produce result \'[255, 255]\'', () {
      final decoded = codec.decode(usageIndex, '0x08ffff');
      expect([255, 255], decoded);
    });
  });

  //
  // Exception at type: `Bytes`
  group('Exception Bytes:', () {
    test('should throw \'AssertionException\' when trying to encode \'0\'', () {
      final exceptionMessage =
          'Unable to encode due to invalid byte type, Try to pass \'Hex String\' or \'List<int>\'.';
      expect(
          () => codec.encode(usageIndex, 0),
          throwsA(predicate((e) =>
              e is AssertionException && e.toString() == exceptionMessage)));
    });

    test('should throw \'EOFException\' when trying to decode \'0x08ff\'', () {
      final exceptionMessage = 'Unexpected end of file/source exception.';
      expect(
          () => codec.decode(usageIndex, '0x08ff'),
          throwsA(predicate(
              (e) => e is EOFException && e.toString() == exceptionMessage)));
    });
  });
}
