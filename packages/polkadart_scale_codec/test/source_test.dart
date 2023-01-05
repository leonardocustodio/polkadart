import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Source Test', () {
    test('Constructor', () {
      final source = Source('0x0102030405060708090a0b0c0d0e0f');
      expect(source.data,
          equals([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]));
      expect(source.currentIndex, equals(0));
      expect(source.length, equals(15));
      expect(source.remainingLength, equals(15));
    });

    test('read single byte', () {
      final source = Source('0x0102030405060708090a0b0c0d0e0f');
      expect(source.byte(), equals(1));
      expect(source.currentIndex, equals(1));
      expect(source.length, equals(15));
      expect(source.remainingLength, equals(14));
    });

    test('read multiple bytes', () {
      final source = Source('0x0102030405060708090a0b0c0d0e0f');
      expect(source.bytes(3), equals([1, 2, 3]));
      expect(source.currentIndex, equals(3));
      expect(source.length, equals(15));
      expect(source.remainingLength, equals(12));
    });

    test('read multiple bytes with presetting offset', () {
      final source = Source('0x0102030405060708090a0b0c0d0e0f');
      source.currentIndex = 3;
      expect(source.bytes(3), equals([4, 5, 6]));
      expect(source.currentIndex, equals(6));
      expect(source.length, equals(15));
      expect(source.remainingLength, equals(9));
    });

    test('EOFException', () {
      final source = Source('0x0102');
      expect(source.bytes(2), equals([1, 2]));
      expect(source.currentIndex, equals(2));
      expect(source.length, equals(2));
      expect(source.remainingLength, equals(0));
      expect(() => source.byte(), throwsA(isA<EOFException>()));
    });

    test('hasBytes', () {
      final source = Source('0x0102');
      expect(source.byte(), equals(1));
      expect(source.hasBytes(), equals(true));
      expect(source.byte(), equals(2));
      expect(source.hasBytes(), equals(false));
    });
  });
}
