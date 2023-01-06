import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Test littleEndianIntToBytes', () {
    // 1 byte

    test('When 255 is evaluated and length is 1 then it returns [255]', () {
      final bytes = littleEndianIntToBytes(255, 1);
      expect(bytes, equals([255]));
    });

    test('When 256 is evaluated and length is 1 then it returns [256]', () {
      final bytes = littleEndianIntToBytes(256, 1);
      expect(bytes, equals([256]));
    });

    test('When 65535 is evaluated and length is 1 then it returns [65535]', () {
      final bytes = littleEndianIntToBytes(65535, 1);
      expect(bytes, equals([65535]));
    });

    test('When 65536 is evaluated and length is 1 then it returns [65536]', () {
      final bytes = littleEndianIntToBytes(65536, 1);
      expect(bytes, equals([65536]));
    });

    test(
        'When 16777215 is evaluated and length is 1 then it returns [16777215]',
        () {
      final bytes = littleEndianIntToBytes(16777215, 1);
      expect(bytes, equals([16777215]));
    });

    test(
        'When 16777216 is evaluated and length is 1 then it returns [16777216]',
        () {
      final bytes = littleEndianIntToBytes(16777216, 1);
      expect(bytes, equals([16777216]));
    });

    test(
        'When 4294967295 is evaluated and length is 1 then it returns [4294967295]',
        () {
      final bytes = littleEndianIntToBytes(4294967295, 1);
      expect(bytes, equals([4294967295]));
    });

    test(
        'When 4294967296 is evaluated and length is 1 then it returns [4294967296]',
        () {
      final bytes = littleEndianIntToBytes(4294967296, 1);
      expect(bytes, equals([4294967296]));
    });

    test(
        'When 1099511627775 is evaluated and length is 1 then it returns [1099511627775]',
        () {
      final bytes = littleEndianIntToBytes(1099511627775, 1);
      expect(bytes, equals([1099511627775]));
    });

    test(
        'When 1099511627776 is evaluated and length is 1 then it returns [1099511627776]',
        () {
      final bytes = littleEndianIntToBytes(1099511627776, 1);
      expect(bytes, equals([1099511627776]));
    });

    test(
        'When 281474976710655 is evaluated and length is 1 then it returns [281474976710655]',
        () {
      final bytes = littleEndianIntToBytes(281474976710655, 1);
      expect(bytes, equals([281474976710655]));
    });

    test(
        'When 281474976710656 is evaluated and length is 1 then it returns [281474976710656]',
        () {
      final bytes = littleEndianIntToBytes(281474976710656, 1);
      expect(bytes, equals([281474976710656]));
    });

    // 2 bytes

    test('When 255 is evaluated and length is 2 then it returns [255, 0]', () {
      final bytes = littleEndianIntToBytes(255, 2);
      expect(bytes, equals([255, 0]));
    });

    test('When 256 is evaluated and length is 2 then it returns [256, 1]', () {
      final bytes = littleEndianIntToBytes(256, 2);
      expect(bytes, equals([256, 1]));
    });

    test('When 65535 is evaluated and length is 2 then it returns [65535, 255]',
        () {
      final bytes = littleEndianIntToBytes(65535, 2);
      expect(bytes, equals([65535, 255]));
    });

    test('When 65536 is evaluated and length is 2 then it returns [65536, 256]',
        () {
      final bytes = littleEndianIntToBytes(65536, 2);
      expect(bytes, equals([65536, 256]));
    });

    test(
        'When 16777215 is evaluated and length is 2 then it returns [16777215, 65535]',
        () {
      final bytes = littleEndianIntToBytes(16777215, 2);
      expect(bytes, equals([16777215, 65535]));
    });

    test(
        'When 16777216 is evaluated and length is 2 then it returns [16777216, 65536]',
        () {
      final bytes = littleEndianIntToBytes(16777216, 2);
      expect(bytes, equals([16777216, 65536]));
    });

    test(
        'When 4294967295 is evaluated and length is 2 then it returns [4294967295, 16777215]',
        () {
      final bytes = littleEndianIntToBytes(4294967295, 2);
      expect(bytes, equals([4294967295, 16777215]));
    });

    test(
        'When 4294967296 is evaluated and length is 2 then it returns [4294967296, 16777216]',
        () {
      final bytes = littleEndianIntToBytes(4294967296, 2);
      expect(bytes, equals([4294967296, 16777216]));
    });

    test(
        'When 1099511627775 is evaluated and length is 2 then it returns [1099511627775, 4294967295]',
        () {
      final bytes = littleEndianIntToBytes(1099511627775, 2);
      expect(bytes, equals([1099511627775, 4294967295]));
    });

    test(
        'When 1099511627776 is evaluated and length is 2 then it returns [1099511627776, 4294967296]',
        () {
      final bytes = littleEndianIntToBytes(1099511627776, 2);
      expect(bytes, equals([1099511627776, 4294967296]));
    });

    // 4 bytes

    test('When 255 is evaluated and length is 4 then it returns [255, 0, 0, 0]',
        () {
      final bytes = littleEndianIntToBytes(255, 4);
      expect(bytes, equals([255, 0, 0, 0]));
    });

    test('When 256 is evaluated and length is 4 then it returns [256, 1, 0, 0]',
        () {
      final bytes = littleEndianIntToBytes(256, 4);
      expect(bytes, equals([256, 1, 0, 0]));
    });

    test(
        'When 65535 is evaluated and length is 4 then it returns [65535, 255, 0, 0]',
        () {
      final bytes = littleEndianIntToBytes(65535, 4);
      expect(bytes, equals([65535, 255, 0, 0]));
    });

    test(
        'When 65536 is evaluated and length is 4 then it returns [65536, 256, 1, 0]',
        () {
      final bytes = littleEndianIntToBytes(65536, 4);
      expect(bytes, equals([65536, 256, 1, 0]));
    });

    test(
        'When 16777215 is evaluated and length is 4 then it returns [16777215, 65535, 255, 0]',
        () {
      final bytes = littleEndianIntToBytes(16777215, 4);
      expect(bytes, equals([16777215, 65535, 255, 0]));
    });

    test(
        'When 16777216 is evaluated and length is 4 then it returns [16777216, 65536, 256, 1]',
        () {
      final bytes = littleEndianIntToBytes(16777216, 4);
      expect(bytes, equals([16777216, 65536, 256, 1]));
    });

    test(
        'When 4294967295 is evaluated and length is 4 then it returns [4294967295, 16777215, 65535, 255]',
        () {
      final bytes = littleEndianIntToBytes(4294967295, 4);
      expect(bytes, equals([4294967295, 16777215, 65535, 255]));
    });

    test(
        'When 4294967296 is evaluated and length is 4 then it returns [4294967296, 16777216, 65536, 256]',
        () {
      final bytes = littleEndianIntToBytes(4294967296, 4);
      expect(bytes, equals([4294967296, 16777216, 65536, 256]));
    });

    test(
        'When 1099511627775 is evaluated and length is 4 then it returns [1099511627775, 4294967295, 16777215, 65535]',
        () {
      final bytes = littleEndianIntToBytes(1099511627775, 4);
      expect(bytes, equals([1099511627775, 4294967295, 16777215, 65535]));
    });

    test(
        'When 1099511627776 is evaluated and length is 4 then it returns [1099511627776, 4294967296, 16777216, 65536]',
        () {
      final bytes = littleEndianIntToBytes(1099511627776, 4);
      expect(bytes, equals([1099511627776, 4294967296, 16777216, 65536]));
    });

    // 8 bytes

    test(
        'When 255 is evaluated and length is 8 then it returns [255, 0, 0, 0, 0, 0, 0, 0]',
        () {
      final bytes = littleEndianIntToBytes(255, 8);
      expect(bytes, equals([255, 0, 0, 0, 0, 0, 0, 0]));
    });

    test(
        'When 256 is evaluated and length is 8 then it returns [256, 1, 0, 0, 0, 0, 0, 0]',
        () {
      final bytes = littleEndianIntToBytes(256, 8);
      expect(bytes, equals([256, 1, 0, 0, 0, 0, 0, 0]));
    });

    test(
        'When 65535 is evaluated and length is 8 then it returns [65535, 255, 0, 0, 0, 0, 0, 0]',
        () {
      final bytes = littleEndianIntToBytes(65535, 8);
      expect(bytes, equals([65535, 255, 0, 0, 0, 0, 0, 0]));
    });

    test(
        'When 65536 is evaluated and length is 8 then it returns [65536, 256, 1, 0, 0, 0, 0, 0]',
        () {
      final bytes = littleEndianIntToBytes(65536, 8);
      expect(bytes, equals([65536, 256, 1, 0, 0, 0, 0, 0]));
    });

    test(
        'When 16777215 is evaluated and length is 8 then it returns [16777215, 65535, 255, 0, 0, 0, 0, 0]',
        () {
      final bytes = littleEndianIntToBytes(16777215, 8);
      expect(bytes, equals([16777215, 65535, 255, 0, 0, 0, 0, 0]));
    });

    test(
        'When 16777216 is evaluated and length is 8 then it returns [16777216, 65536, 256, 1, 0, 0, 0, 0]',
        () {
      final bytes = littleEndianIntToBytes(16777216, 8);
      expect(bytes, equals([16777216, 65536, 256, 1, 0, 0, 0, 0]));
    });

    test(
        'When 4294967295 is evaluated and length is 8 then it returns [4294967295, 16777215, 65535, 255, 0, 0, 0, 0]',
        () {
      final bytes = littleEndianIntToBytes(4294967295, 8);
      expect(bytes, equals([4294967295, 16777215, 65535, 255, 0, 0, 0, 0]));
    });

    test(
        'When 4294967296 is evaluated and length is 8 then it returns [4294967296, 16777216, 65536, 256, 1, 0, 0, 0]',
        () {
      final bytes = littleEndianIntToBytes(4294967296, 8);
      expect(bytes, equals([4294967296, 16777216, 65536, 256, 1, 0, 0, 0]));
    });

    test(
        'When 1099511627775 is evaluated and length is 8 then it returns [1099511627775, 4294967295, 16777215, 65535, 255, 0, 0, 0]',
        () {
      final bytes = littleEndianIntToBytes(1099511627775, 8);
      expect(bytes,
          equals([1099511627775, 4294967295, 16777215, 65535, 255, 0, 0, 0]));
    });

    test(
        'When 1099511627776 is evaluated and length is 8 then it returns [1099511627776, 4294967296, 16777216, 65536, 256, 1, 0, 0]',
        () {
      final bytes = littleEndianIntToBytes(1099511627776, 8);
      expect(bytes,
          equals([1099511627776, 4294967296, 16777216, 65536, 256, 1, 0, 0]));
    });
  });
}
