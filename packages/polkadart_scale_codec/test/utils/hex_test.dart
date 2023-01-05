import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Hex Encode Test: ', () {
    test('When [1] is encoded to hex then hex value is 0x01', () {
      final hexValue = encodeHex([1]);
      expect(hexValue, equals('01'));
    });

    test('When [0] is encoded to hex then hex value is 0x00', () {
      final hexValue = encodeHex([0]);
      expect(hexValue, equals('00'));
    });
  });

  group('Hex Decode Test: ', () {
    test('When 0x01 is decoded then hex value is [1]', () {
      final decodedValue = decodeHex('01');
      expect(decodedValue, equals([1]));
    });

    test('When 0x00 is decoded then hex value is [0]', () {
      final decodedValue = decodeHex('00');
      expect(decodedValue, equals([0]));
    });
  });

  group('Hex Invalid Input Test: ', () {
    test('When 0x1 is decoded then it throws HexDecodeException.', () {
      expect(() => decodeHex('0x1'), throwsA(isA<HexDecodeException>()));
    });

    test('When \'-1\' is decoded then it throws HexEncodeException.', () {
      expect(() => decodeHex('-1'), throwsA(isA<HexDecodeException>()));
    });

    test('When [-1] is encoded to hex then it throws HexEncodeException.', () {
      expect(() => encodeHex([-1]), throwsA(isA<HexEncodeException>()));
    });
  });
}
