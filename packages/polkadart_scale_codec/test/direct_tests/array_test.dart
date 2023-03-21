import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Array Codec Encode Test', () {
    test('When value [1, 2, 3, 4] is encoded then it returns 0x01020304', () {
      final output = HexOutput();
      ArrayCodec(U8Codec.codec, 4).encodeTo([1, 2, 3, 4], output);
      expect(output.toString(), '0x01020304');
    });

    test('When value [[1, 2], [3, 4]] is encoded then it returns 0x01020304',
        () {
      final output = HexOutput();
      ArrayCodec(
        ArrayCodec(U8Codec.codec, 2),
        2,
      ).encodeTo([
        [1, 2],
        [3, 4]
      ], output);
      expect(output.toString(), '0x01020304');
    });
    test('When value [5, 6, 7, 8] is encoded then it returns 0x05060708', () {
      final output = HexOutput();
      ArrayCodec(U8Codec.codec, 4).encodeTo([5, 6, 7, 8], output);
      expect(output.toString(), '0x05060708');
    });

    test(
        'When value [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20] is encoded then it returns 0x05060708090a0b0c0d0e0f1011121314',
        () {
      final output = HexOutput();
      ArrayCodec(U8Codec.codec, 16).encodeTo(
          [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], output);
      expect(output.toString(), '0x05060708090a0b0c0d0e0f1011121314');
    });
    test(
        'When value [[0, true], [1, false], [2, true], [3, false]] is encoded then it returns 0x0001010002010300',
        () {
      final output = HexOutput();
      ArrayCodec(
        TupleCodec([U8Codec.codec, BoolCodec.codec]),
        4,
      ).encodeTo(
        [
          [0, true],
          [1, false],
          [2, true],
          [3, false]
        ],
        output,
      );
      expect(output.toString(), '0x0001010002010300');
    });
  });

  group('Array Codec Decode Test', () {
    test('When value 0x01020304 is decoded then it returns [1, 2, 3, 4]', () {
      final input = Input.fromHex('0x01020304');
      final result = ArrayCodec(U8Codec.codec, 4).decode(input);
      expect(result, [1, 2, 3, 4]);
      expect(input.remainingLength, 0);
    });

    test('When value 0x01020304 is decoded then it returns [[1, 2], [3, 4]]',
        () {
      final input = Input.fromHex('0x01020304');
      final result = ArrayCodec(
        ArrayCodec(U8Codec.codec, 2),
        2,
      ).decode(input);
      expect(result, [
        [1, 2],
        [3, 4]
      ]);
      expect(input.remainingLength, 0);
    });
    test('When value 0x05060708 is decoded then it returns [5, 6, 7, 8]', () {
      final input = Input.fromHex('0x05060708');
      final result = ArrayCodec(U8Codec.codec, 4).decode(input);
      expect(result, [5, 6, 7, 8]);
      expect(input.remainingLength, 0);
    });

    test(
        'When value 0x05060708090a0b0c0d0e0f1011121314 is decoded then it returns [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]',
        () {
      final input = Input.fromHex('0x05060708090a0b0c0d0e0f1011121314');
      final result = ArrayCodec(U8Codec.codec, 16).decode(input);
      expect(
          result, [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]);
      expect(input.remainingLength, 0);
    });
    test(
        'When value 0x0001010002010300 is decoded then it returns [[0, true], [1, false], [2, true], [3, false]]',
        () {
      final input = Input.fromHex('0x0001010002010300');
      final result = ArrayCodec(
        TupleCodec([U8Codec.codec, BoolCodec.codec]),
        4,
      ).decode(input);
      expect(result, [
        [0, true],
        [1, false],
        [2, true],
        [3, false]
      ]);
      expect(input.remainingLength, 0);
    });
  });
}
