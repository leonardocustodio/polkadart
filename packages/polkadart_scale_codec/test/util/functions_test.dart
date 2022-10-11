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

  group('functions compare()', () {
    test(
        'Should return true when an integer value is within the integers range',
        () {
      final min = 0;
      final max = 100;

      final value = 50;

      expect(compare(value, min, max), true);
    });

    test(
        'Should return true an integer value is within the integers range and is equal to min',
        () {
      final min = 0;
      final max = 100;

      final value = 0;

      expect(compare(value, min, max), true);
    });

    test(
        'Should return true when an integer value is whitin the range and is equal to max',
        () {
      final min = 0;
      final max = 100;

      final value = 100;

      expect(compare(value, min, max), true);
    });

    test('Should return false when an integer value is out of the range', () {
      final min = 0;
      final max = 100;

      final value = 110;

      expect(compare(value, min, max), false);
    });

    test('Should throw TypeError when values have different types', () {
      final min = 0;
      final max = BigInt.from(100);

      final value = 150;

      expect(() => compare(value, min, max), throwsA(isA<TypeError>()));
    });

    test('Should return true when a BigInt value is within the BigInts range',
        () {
      final min = BigInt.from(0);
      final max = BigInt.from(100);

      final value = BigInt.from(50);

      expect(compare(value, min, max), true);
    });

    test(
        'Should return true a BigInt value is within the BigInts range and is equal to min',
        () {
      final min = BigInt.from(0);
      final max = BigInt.from(100);

      final value = BigInt.from(0);

      expect(compare(value, min, max), true);
    });

    test(
        'Should return true when a BigInt value is whitin the BigInts range and is equal to max',
        () {
      final min = BigInt.from(0);
      final max = BigInt.from(100);

      final value = BigInt.from(100);

      expect(compare(value, min, max), true);
    });

    test('Should return false when a BigInt value is out of the BigInt range',
        () {
      final min = BigInt.from(0);
      final max = BigInt.from(100);

      final value = BigInt.from(110);

      expect(compare(value, min, max), false);
    });
  });
}
