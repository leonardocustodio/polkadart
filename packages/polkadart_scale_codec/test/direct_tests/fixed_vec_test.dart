import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Fixed Vec Encode Test', () {
    test('When value [1, 2, 3, 4] is encoded then it returns 0x01020304', () {
      final output = HexOutput();
      FixedVecCodec(U8Codec.instance, 4).encodeTo([1, 2, 3, 4], output);
      expect(output.toString(), '0x01020304');
    });

    test('When value [[1, 2], [3, 4]] is encoded then it returns 0x01020304',
        () {
      final output = HexOutput();
      FixedVecCodec(
        FixedVecCodec(U8Codec.instance, 2),
        2,
      ).encodeTo([
        [1, 2],
        [3, 4]
      ], output);
      expect(output.toString(), '0x01020304');
    });
    test('When value [5, 6, 7, 8] is encoded then it returns 0x05060708', () {
      final output = HexOutput();
      FixedVecCodec(U8Codec.instance, 4).encodeTo([5, 6, 7, 8], output);
      expect(output.toString(), '0x05060708');
    });

    test(
        'When value [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20] is encoded then it returns 0x05060708090a0b0c0d0e0f1011121314',
        () {
      final output = HexOutput();
      FixedVecCodec(U8Codec.instance, 16).encodeTo(
          [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20], output);
      expect(output.toString(), '0x05060708090a0b0c0d0e0f1011121314');
    });
    test(
        'When value [[0, true], [1, false], [2, true], [3, false]] is encoded then it returns 0x0001010002010300',
        () {
      final output = HexOutput();
      FixedVecCodec(
        TupleCodec([U8Codec.instance, BoolCodec.instance]),
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

  group('Fixed Vec Decode Test', () {
    test('When value 0x01020304 is decoded then it returns [1, 2, 3, 4]', () {
      final input = HexInput('0x01020304');
      final result = FixedVecCodec(U8Codec.instance, 4).decode(input);
      expect(result, [1, 2, 3, 4]);
    });

    test('When value 0x01020304 is decoded then it returns [[1, 2], [3, 4]]',
        () {
      final input = HexInput('0x01020304');
      final result = FixedVecCodec(
        FixedVecCodec(U8Codec.instance, 2),
        2,
      ).decode(input);
      expect(result, [
        [1, 2],
        [3, 4]
      ]);
    });
    test('When value 0x05060708 is decoded then it returns [5, 6, 7, 8]', () {
      final input = HexInput('0x05060708');
      final result = FixedVecCodec(U8Codec.instance, 4).decode(input);
      expect(result, [5, 6, 7, 8]);
    });

    test(
        'When value 0x05060708090a0b0c0d0e0f1011121314 is decoded then it returns [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]',
        () {
      final input = HexInput('0x05060708090a0b0c0d0e0f1011121314');
      final result = FixedVecCodec(U8Codec.instance, 16).decode(input);
      expect(
          result, [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]);
    });
    test(
        'When value 0x0001010002010300 is decoded then it returns [[0, true], [1, false], [2, true], [3, false]]',
        () {
      final input = HexInput('0x0001010002010300');
      final result = FixedVecCodec(
        TupleCodec([U8Codec.instance, BoolCodec.instance]),
        4,
      ).decode(input);
      expect(result, [
        [0, true],
        [1, false],
        [2, true],
        [3, false]
      ]);
    });
  });
}
