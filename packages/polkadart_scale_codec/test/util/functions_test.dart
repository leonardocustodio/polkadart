import 'package:polkadart_scale_codec/src/util/utils.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('functions checkSignedInt()', () {
    test('Given bitSize is 8 and value is within range check should pass', () {
      int bitSize = 8;
      int value = 10;

      expect(() => checkSignedInt(value, bitSize), returnsNormally);
    });

    test('Given bitSize is 16 and value is within range check should pass', () {
      int bitSize = 16;
      int value = 10;

      expect(() => checkSignedInt(value, bitSize), returnsNormally);
    });

    test('Given bitSize is 32 and value is within range check should pass', () {
      int bitSize = 32;
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

  group('functions checkSignedBigInt()', () {
    test('Given bitSize is 64 and value is within range check should pass', () {
      int bitSize = 64;
      BigInt value = BigInt.from(10);

      expect(() => checkSignedBigInt(value, bitSize), returnsNormally);
    });

    test('Given bitSize is 128 and value is within range check should pass',
        () {
      int bitSize = 128;
      BigInt value = BigInt.from(10);

      expect(() => checkSignedBigInt(value, bitSize), returnsNormally);
    });

    test('Given bitSize is 256 and value is within range check should pass',
        () {
      int bitSize = 256;
      BigInt value = BigInt.from(10);

      expect(() => checkSignedBigInt(value, bitSize), returnsNormally);
    });

    test(
        'Should throw UnexpectedCaseException when bitSize is different from defined values',
        () {
      int bitSize = 15;
      BigInt value = BigInt.from(10);

      expect(
        () => checkSignedBigInt(value, bitSize),
        throwsA(isA<UnexpectedCaseException>()),
      );
    });
  });

  group('functions checkUnsignedInt()', () {
    test('Should returns normally when bitSize is 8', () {
      int bitSize = 8;
      int value = 10;

      expect(() => checkUnsignedInt(value, bitSize), returnsNormally);
    });

    test('Should returns normally when bitSize is 16', () {
      int bitSize = 16;
      int value = 10;

      expect(() => checkUnsignedInt(value, bitSize), returnsNormally);
    });

    test('Should returns normally when bitSize is 32', () {
      int bitSize = 16;
      int value = 10;

      expect(() => checkUnsignedInt(value, bitSize), returnsNormally);
    });

    test(
        'Should throw UnexpectedCaseException when bitSize is different from defined values',
        () {
      int bitSize = 15;
      int value = 10;

      final expectedErrorMessage = 'Unexpected BitSize: 15.';

      expect(
        () => checkUnsignedInt(value, bitSize),
        throwsA(
          predicate((exception) =>
              exception is UnexpectedCaseException &&
              exception.toString() == expectedErrorMessage),
        ),
      );
    });
  });

  group('functions checkUnsignedBigInt()', () {
    test('Should returns normally when bitSize is 64', () {
      int bitSize = 64;
      BigInt value = BigInt.from(10);

      expect(() => checkUnsignedBigInt(value, bitSize), returnsNormally);
    });

    test('Should returns normally when bitSize is 128', () {
      int bitSize = 128;
      BigInt value = BigInt.from(10);

      expect(() => checkUnsignedBigInt(value, bitSize), returnsNormally);
    });

    test('Should returns normally when bitSize is 256', () {
      int bitSize = 256;
      BigInt value = BigInt.from(10);

      expect(() => checkUnsignedBigInt(value, bitSize), returnsNormally);
    });

    test(
        'Should throw UnexpectedCaseException when bitSize is different from defined values',
        () {
      int bitSize = 15;
      BigInt value = BigInt.from(10);

      final expectedErrorMessage = 'Unexpected BitSize: 15.';

      expect(
        () => checkUnsignedBigInt(value, bitSize),
        throwsA(
          predicate((exception) =>
              exception is UnexpectedCaseException &&
              exception.toString() == expectedErrorMessage),
        ),
      );
    });
  });

  group('functions checkInt()', () {
    test('Should return true when value is in range', () {
      final int min = 0;
      final int max = 100;

      final int bitSize = 16;
      final String sign = 'u';
      final int value = 50;

      expect(checkInt(value, sign, bitSize, min, max), true);
    });

    test('Should return true when value is in range and equal to min', () {
      final int min = 0;
      final int max = 100;

      final int bitSize = 16;
      final String sign = 'u';
      final int value = 0;

      expect(checkInt(value, sign, bitSize, min, max), true);
    });

    test('Should return true when value is in range and equal to max', () {
      final int min = 0;
      final int max = 100;

      final int bitSize = 16;
      final String sign = 'u';
      final int value = 100;

      expect(checkInt(value, sign, bitSize, min, max), true);
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

  group('functions checkBigInt()', () {
    test('Should return true when value is in range', () {
      final BigInt min = BigInt.from(0);
      final BigInt max = BigInt.from(100);

      final int bitSize = 16;
      final String sign = 'u';
      final BigInt value = BigInt.from(50);

      expect(checkBigInt(value, sign, bitSize, min, max), true);
    });

    test('Should return true when value is in range and equal to min', () {
      final BigInt min = BigInt.from(0);
      final BigInt max = BigInt.from(100);

      final int bitSize = 16;
      final String sign = 'u';
      final BigInt value = BigInt.from(0);

      expect(checkBigInt(value, sign, bitSize, min, max), true);
    });

    test('Should return true when value is in range and equal to max', () {
      final BigInt min = BigInt.from(0);
      final BigInt max = BigInt.from(100);

      final int bitSize = 16;
      final String sign = 'u';
      final BigInt value = BigInt.from(100);

      expect(checkBigInt(value, sign, bitSize, min, max), true);
    });

    test('Should throw InvalidSizeException when value is out of range', () {
      final BigInt min = BigInt.from(0);
      final BigInt max = BigInt.from(100);

      final int bitSize = 16;
      final String sign = 'u';
      final BigInt value = BigInt.from(150);

      final String expectedErrorMessage = 'Invalid u16: 150';

      expect(
        () => checkBigInt(value, sign, bitSize, min, max),
        throwsA(
          predicate((exception) =>
              exception is InvalidSizeException &&
              exception.toString() == expectedErrorMessage),
        ),
      );
    });
  });
}
