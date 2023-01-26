import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Input Test', () {
    test('Constructor', () {
      final input = DefaultInput.fromHex('0x0102030405060708090a0b0c0d0e0f');
      expect(input.buffer,
          equals([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]));
      expect(input.currentIndex, equals(0));
      expect(input.length, equals(15));
      expect(input.remainingLength, equals(15));
    });

    test('read single byte', () {
      final input = DefaultInput.fromHex('0x0102030405060708090a0b0c0d0e0f');
      expect(input.byte(), equals(1));
      expect(input.currentIndex, equals(1));
      expect(input.length, equals(15));
      expect(input.remainingLength, equals(14));
    });

    test('read multiple bytes', () {
      final input = DefaultInput.fromHex('0x0102030405060708090a0b0c0d0e0f');
      expect(input.bytes(3), equals([1, 2, 3]));
      expect(input.currentIndex, equals(3));
      expect(input.length, equals(15));
      expect(input.remainingLength, equals(12));
    });

    test('read multiple bytes with presetting offset', () {
      final input = DefaultInput.fromHex('0x0102030405060708090a0b0c0d0e0f');
      input.currentIndex = 3;
      expect(input.bytes(3), equals([4, 5, 6]));
      expect(input.currentIndex, equals(6));
      expect(input.length, equals(15));
      expect(input.remainingLength, equals(9));
    });

    test('EOFException', () {
      final input = DefaultInput.fromHex('0x0102');
      expect(input.bytes(2), equals([1, 2]));
      expect(input.currentIndex, equals(2));
      expect(input.length, equals(2));
      expect(input.remainingLength, equals(0));
      expect(() => input.byte(), throwsA(isA<EOFException>()));
    });

    test('hasBytes', () {
      final input = DefaultInput.fromHex('0x0102');
      expect(input.byte(), equals(1));
      expect(input.hasBytes(), equals(true));
      expect(input.byte(), equals(2));
      expect(input.hasBytes(), equals(false));
    });
  });
}
