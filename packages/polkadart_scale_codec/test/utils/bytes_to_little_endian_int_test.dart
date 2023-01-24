import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Test bytesToLittleEndianInt', () {
    test('When [1] is evaluated then it returns 1', () {
      final intValue = bytesToLittleEndianInt([1]);
      expect(intValue, equals(1));
    });

    test('When [0] is evaluated irrespective of bytes then it returns 0', () {
      final intValue = bytesToLittleEndianInt([0]);
      expect(intValue, equals(0));
    });

    test('When [1, 0] is evaluated then it returns 1', () {
      final intValue = bytesToLittleEndianInt([1, 0]);
      expect(intValue, equals(1));
    });

    test('When [0, 1] is evaluated then it returns 256', () {
      final intValue = bytesToLittleEndianInt([0, 1]);
      expect(intValue, equals(256));
    });

    test('When [1, 0, 0, 0] is evaluated then it returns 1', () {
      final intValue = bytesToLittleEndianInt([1, 0, 0, 0]);
      expect(intValue, equals(1));
    });

    test('When [0, 1, 0, 0] is evaluated then it returns 256', () {
      final intValue = bytesToLittleEndianInt([0, 1, 0, 0]);
      expect(intValue, equals(256));
    });

    test('When [0, 0, 1, 0] is evaluated then it returns 65536', () {
      final intValue = bytesToLittleEndianInt([0, 0, 1, 0]);
      expect(intValue, equals(65536));
    });

    test('When [0, 0, 0, 1] is evaluated then it returns 16777216', () {
      final intValue = bytesToLittleEndianInt([0, 0, 0, 1]);
      expect(intValue, equals(16777216));
    });

    test('When [1, 0, 0, 0, 0, 0, 0, 0] is evaluated then it returns 1', () {
      final intValue = bytesToLittleEndianInt([1, 0, 0, 0, 0, 0, 0, 0]);
      expect(intValue, equals(1));
    });

    test('When [0, 1, 0, 0, 0, 0, 0, 0] is evaluated then it returns 256', () {
      final intValue = bytesToLittleEndianInt([0, 1, 0, 0, 0, 0, 0, 0]);
      expect(intValue, equals(256));
    });

    test('When [0, 0, 1, 0, 0, 0, 0, 0] is evaluated then it returns 65536',
        () {
      final intValue = bytesToLittleEndianInt([0, 0, 1, 0, 0, 0, 0, 0]);
      expect(intValue, equals(65536));
    });

    test('When [0, 0, 0, 1, 0, 0, 0, 0] is evaluated then it returns 16777216',
        () {
      final intValue = bytesToLittleEndianInt([0, 0, 0, 1, 0, 0, 0, 0]);
      expect(intValue, equals(16777216));
    });

    test(
        'When [0, 0, 0, 0, 1, 0, 0, 0] is evaluated then it returns 4294967296',
        () {
      final intValue = bytesToLittleEndianInt([0, 0, 0, 0, 1, 0, 0, 0]);
      expect(intValue, equals(4294967296));
    });

    test(
        'When [0, 0, 0, 0, 0, 1, 0, 0] is evaluated then it returns 1099511627776',
        () {
      final intValue = bytesToLittleEndianInt([0, 0, 0, 0, 0, 1, 0, 0]);
      expect(intValue, equals(1099511627776));
    });

    test(
        'When [0, 0, 0, 0, 0, 0, 1, 0] is evaluated then it returns 281474976710656',
        () {
      final intValue = bytesToLittleEndianInt([0, 0, 0, 0, 0, 0, 1, 0]);
      expect(intValue, equals(281474976710656));
    });

    test(
        'When [0, 0, 0, 0, 0, 0, 0, 1] is evaluated then it returns 72057594037927936',
        () {
      final intValue = bytesToLittleEndianInt([0, 0, 0, 0, 0, 0, 0, 1]);
      expect(intValue, equals(72057594037927936));
    });

    test(
        'When bytes of length 0 is evaluated then it throws AssertionException',
        () {
      expect(
          () => bytesToLittleEndianInt([]), throwsA(isA<AssertionException>()));
    });

    test('When [0, 0, 1] is evaluated then it returns 65536', () {
      final intValue = bytesToLittleEndianInt([0, 0, 1]);
      expect(intValue, equals(65536));
    });

    test('When [0, 0, 1, 0] is evaluated then it returns 16777216', () {
      final intValue = bytesToLittleEndianInt([0, 0, 0, 1, 0]);
      expect(intValue, equals(16777216));
    });

    test('When [0, 0, 0, 0, 0, 0] is evaluated then it returns 0', () {
      final intValue = bytesToLittleEndianInt([0, 0, 0, 0, 0, 0]);
      expect(intValue, equals(0));
    });

    test('When [0, 0, 1, 0, 0, 0, 0] is evaluated then it returns 65536', () {
      final intValue = bytesToLittleEndianInt([0, 0, 1, 0, 0, 0, 0]);
      expect(intValue, equals(65536));
    });

    test(
        'When bytes of length greator than 8 is evaluated irrespective of bytes then it throws AssertionException',
        () {
      expect(() => bytesToLittleEndianInt([0, 0, 0, 0, 0, 0, 0, 0, 0]),
          throwsA(isA<AssertionException>()));
    });
  });
}
