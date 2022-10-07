import 'package:polkadart_scale_codec/src/util/utils.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('functions checkSignedInt() tests', () {
    test('Should returns normally when bitSize is 8', () {
      int bitSize = 8;
      int value = 10;

      expect(() => checkSignedInt(value, bitSize), returnsNormally);
    });

    test('Should returns normally when bitSize is 16', () {
      int bitSize = 16;
      int value = 10;

      expect(() => checkSignedInt(value, bitSize), returnsNormally);
    });

    test('Should returns normally when bitSize is 32', () {
      int bitSize = 16;
      int value = 10;

      expect(() => checkSignedInt(value, bitSize), returnsNormally);
    });

    test(
        'Should throw UnexpectedCaseException when bitSize is different from defined values',
        () {
      int bitSize = 15;
      int value = 10;

      final expectedErrorMessage = 'Unexpected BitSize: 15.';

      expect(
        () => checkSignedInt(value, bitSize),
        throwsA(
          predicate((exception) =>
              exception is UnexpectedCaseException &&
              exception.toString() == expectedErrorMessage),
        ),
      );
    });
  });

  group('functions checkInt() tests', () {
    test('Should return true when value is in range', () {
      final int min = 0;
      final int max = 100;

      final int bitSize = 16;
      final String sign = 'u';
      final int value = 50;

      final result = checkInt(value, sign, bitSize, min, max);

      expect(result, true);
    });

    test('Should return true when value is in range and equal to min', () {
      final int min = 0;
      final int max = 100;

      final int bitSize = 16;
      final String sign = 'u';
      final int value = 0;

      final result = checkInt(value, sign, bitSize, min, max);

      expect(result, true);
    });

    test('Should return true when value is in range and equal to max', () {
      final int min = 0;
      final int max = 100;

      final int bitSize = 16;
      final String sign = 'u';
      final int value = 100;

      final result = checkInt(value, sign, bitSize, min, max);

      expect(result, true);
    });

    test('Should throw InvalidSizeException when value is out of range', () {
      final int min = 0;
      final int max = 100;

      final int bitSize = 16;
      final String sign = 'u';
      final int value = 150;

      final String expectedErrorMessage = 'Invalid u16: 150';

      expect(
        () => checkInt(value, sign, bitSize, min, max),
        throwsA(
          predicate((exception) =>
              exception is InvalidSizeException &&
              exception.toString() == expectedErrorMessage),
        ),
      );
    });
  });
}
