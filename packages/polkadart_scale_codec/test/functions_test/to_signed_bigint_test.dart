import 'package:polkadart_scale_codec/src/util/utils.dart';
import 'package:test/test.dart';

void main() {
  //
  // Signed BigInt
  //
  // This test will pass at the boundaries of max and min values of BigInt according to bitsize
  //
  // All the test cases will pass with [low, high] values with low and high being inclusive
  //
  {
    group('Signed BigInt 64 bit:', () {
      test(
          'toSignedBigInt will pass with lowest value: `-9223372036854775808` and must return the same value as output.',
          () {
        final lowestValue = -9223372036854775808;
        expect(toSignedBigInt(lowestValue, 64).toInt(), equals(lowestValue));
      });
      test(
          'toSignedBigInt will pass with highest value: \'9223372036854775807\' and must return the same value as output.',
          () {
        final highestValue = '9223372036854775807';
        expect(
            toSignedBigInt(highestValue, 64).toString(), equals(highestValue));
      });
    });

    group('Signed BigInt 128 bit:', () {
      test(
          'toSignedBigInt will pass with lowest value: `-170141183460469231731687303715884105728` and must return the same value as output.',
          () {
        final lowestValue = '-170141183460469231731687303715884105728';
        expect(
            toSignedBigInt(lowestValue, 128).toString(), equals(lowestValue));
      });
      test(
          'toSignedBigInt will pass with highest value: `170141183460469231731687303715884105727` and must return the same value as output.',
          () {
        final highestValue = '170141183460469231731687303715884105727';
        expect(
            toSignedBigInt(highestValue, 128).toString(), equals(highestValue));
      });
    });

    group('Signed BigInt 256 bit:', () {
      test(
          'toSignedBigInt will pass with lowest value: `-57896044618658097711785492504343953926634992332820282019728792003956564819968` and must return the same value as output.',
          () {
        final lowestValue =
            '-57896044618658097711785492504343953926634992332820282019728792003956564819968';
        expect(
            toSignedBigInt(lowestValue, 256).toString(), equals(lowestValue));
      });
      test(
          'toSignedBigInt will pass with highest value: `57896044618658097711785492504343953926634992332820282019728792003956564819967` and must return the same value as output.',
          () {
        final highestValue =
            '57896044618658097711785492504343953926634992332820282019728792003956564819967';
        expect(
            toSignedBigInt(highestValue, 256).toString(), equals(highestValue));
      });
    });
  }

  // throws `InvalidSizeException` when value is:
  // - 1 less than lowest acceptable or
  // - 1 greater than highest acceptable
  {
    group('Throws Exception on Signed 64 bit:', () {
      test(
          'toSignedBigInt will throw \'InvalidSizeException\' when value is -9223372036854775809.',
          () {
        final exceptionMessage = 'Invalid I64: -9223372036854775809';
        expect(
            () => toSignedBigInt('-9223372036854775809', 64),
            throwsA(
              predicate((e) =>
                  e is InvalidSizeException &&
                  e.toString() == exceptionMessage),
            ));
      });
      test(
          'toSignedBigInt will throw \'InvalidSizeException\' when value is 9223372036854775808.',
          () {
        final exceptionMessage = 'Invalid I64: 9223372036854775808';
        expect(
            () => toSignedBigInt('9223372036854775808', 64),
            throwsA(
              predicate((e) =>
                  e is InvalidSizeException &&
                  e.toString() == exceptionMessage),
            ));
      });
    });

    group('Throws Exception on Signed 128 bit:', () {
      test(
          'toSignedBigInt will throw \'InvalidSizeException\' when value is -170141183460469231731687303715884105729.',
          () {
        final exceptionMessage =
            'Invalid I128: -170141183460469231731687303715884105729';
        expect(
            () =>
                toSignedBigInt('-170141183460469231731687303715884105729', 128),
            throwsA(
              predicate((e) =>
                  e is InvalidSizeException &&
                  e.toString() == exceptionMessage),
            ));
      });
      test(
          'toSignedBigInt will throw \'InvalidSizeException\' when value is 170141183460469231731687303715884105728.',
          () {
        final exceptionMessage =
            'Invalid I128: 170141183460469231731687303715884105728';
        expect(
            () =>
                toSignedBigInt('170141183460469231731687303715884105728', 128),
            throwsA(
              predicate((e) =>
                  e is InvalidSizeException &&
                  e.toString() == exceptionMessage),
            ));
      });
    });

    group('Throws Exception on Signed 256 bit:', () {
      test(
          'toSignedBigInt will throw \'InvalidSizeException\' when value is -57896044618658097711785492504343953926634992332820282019728792003956564819969.',
          () {
        final exceptionMessage =
            'Invalid I256: -57896044618658097711785492504343953926634992332820282019728792003956564819969';
        expect(
            () => toSignedBigInt(
                '-57896044618658097711785492504343953926634992332820282019728792003956564819969',
                256),
            throwsA(
              predicate((e) =>
                  e is InvalidSizeException &&
                  e.toString() == exceptionMessage),
            ));
      });
      test(
          'toSignedBigInt will throw \'InvalidSizeException\' when value is 57896044618658097711785492504343953926634992332820282019728792003956564819968.',
          () {
        final exceptionMessage =
            'Invalid I256: 57896044618658097711785492504343953926634992332820282019728792003956564819968';
        expect(
            () => toSignedBigInt(
                '57896044618658097711785492504343953926634992332820282019728792003956564819968',
                256),
            throwsA(
              predicate((e) =>
                  e is InvalidSizeException &&
                  e.toString() == exceptionMessage),
            ));
      });
    });
  }

  // This test will throw `UnexpectedTypeException`
  {
    group('UnexpectedTypeException', () {
      final exceptionMessage = 'Only `String` and `int` are valid parameters.';
      test(
          'toSignedBigInt will throw \'UnexpectedTypeException\' when value of type BigInt is passes are argument.',
          () {
        expect(
            () => toSignedBigInt(BigInt.from(429496726), 64),
            throwsA(predicate((e) =>
                e is UnexpectedTypeException &&
                e.toString() == exceptionMessage)));
      });
    });
  }

  // This test will throw `UnexpectedCaseException` when unknow bit-size is passed as an argument
  {
    group('UnexpectedCaseException', () {
      final exceptionMessage = 'Unexpected BitSize: 20.';
      test(
          'toSignedBigInt will throw \'UnexpectedCaseException\' when unknow bit-size: \'20\' is passed as an argument',
          () {
        expect(
            () => toSignedBigInt(200, 20),
            throwsA(predicate((e) =>
                e is UnexpectedCaseException &&
                e.toString() == exceptionMessage)));
      });
    });
  }
}
