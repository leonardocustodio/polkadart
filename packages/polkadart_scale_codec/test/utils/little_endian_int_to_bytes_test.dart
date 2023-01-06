import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Test littleEndianIntToBytes', () {
    // 1 byte
    test('When value 0 is encoded then it returns 0x00', () {
      final bytes = littleEndianIntToBytes(0, 1);
      expect(bytes, equals([0x00]));
    });

    test('When value 255 is encoded then it returns 0xff', () {
      final bytes = littleEndianIntToBytes(255, 1);
      expect(bytes, equals([0xff]));
    });

    // 2 bytes

    test('When value 0 is encoded then it returns 0x0000', () {
      final bytes = littleEndianIntToBytes(0, 2);
      expect(bytes, equals([0x00, 0x00]));
    });

    test('When value 65535 is encoded then it returns 0xffff', () {
      final bytes = littleEndianIntToBytes(65535, 2);
      expect(bytes, equals([0xff, 0xff]));
    });

    // 4 bytes

    test('When value 0 is encoded then it returns 0x00000000', () {
      final bytes = littleEndianIntToBytes(0, 4);
      expect(bytes, equals([0x00, 0x00, 0x00, 0x00]));
    });

    test('When value 4294967295 is encoded then it returns 0xffffffff', () {
      final bytes = littleEndianIntToBytes(4294967295, 4);
      expect(bytes, equals([0xff, 0xff, 0xff, 0xff]));
    });

    // 8 bytes

    test('When value 0 is encoded then it returns 0x0000000000000000', () {
      final bytes = littleEndianIntToBytes(0, 8);
      expect(bytes, equals([0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]));
    });

    test('When value 9223372036854775807 is encoded then it returns 0xffffffffffffff7f', () {
      final bytes = littleEndianIntToBytes(9223372036854775807, 8);
      expect(bytes, equals([0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x7f]));
    });
  });
}
