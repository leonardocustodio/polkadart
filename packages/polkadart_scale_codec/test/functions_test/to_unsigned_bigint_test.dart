import 'package:polkadart_scale_codec/src/util/utils.dart';
import 'package:test/test.dart';

void main() {
  //
  // Unsigned BigInt
  //
  // This test will pass at the boundaries of min and max values of BigInt according to bitsize.
  //
  // All the test cases will pass with [low, high] values with low and high being `inclusive`.
  //
  {
    group('Unsigned BigInt 64 bit:', () {
      test(
          'toSignedBigInt will pass with lowest value: `0` and must return the same value as output.',
          () {
        final lowestValue = 0;
        expect(toUnsignedBigInt(lowestValue, 64).toInt(), equals(lowestValue));
      });
      test(
          'toSignedBigInt will pass with highest value: `18446744073709551615` and must return the same value as output.',
          () {
        final highestValue = '18446744073709551615';
        expect(toUnsignedBigInt(highestValue, 64).toString(),
            equals(highestValue));
      });
    });

    group('Unsigned BigInt 128 bit:', () {
      test(
          'toSignedBigInt will pass with lowest value: `0` and must return the same value as output.',
          () {
        final lowestValue = 0;
        expect(toUnsignedBigInt(lowestValue, 128).toInt(), equals(lowestValue));
      });
      test(
          'toSignedBigInt will pass with highest value: `340282366920938463463374607431768211455` and must return the same value as output.',
          () {
        final highestValue = '340282366920938463463374607431768211455';
        expect(toUnsignedBigInt(highestValue, 128).toString(),
            equals(highestValue));
      });
    });

    group('Unsigned BigInt 256 bit:', () {
      test('Lowest value `0` must pass', () {
        final lowestValue = 0;
        expect(toUnsignedBigInt(lowestValue, 256).toInt(), equals(lowestValue));
      });
      test(
          'Highest value `115792089237316195423570985008687907853269984665640564039457584007913129639935` must pass',
          () {
        final highestValue =
            '115792089237316195423570985008687907853269984665640564039457584007913129639935';
        expect(toUnsignedBigInt(highestValue, 256).toString(),
            equals(highestValue));
      });
    });
  }

  // throws `InvalidSizeException` when value is:
  // - 1 less than lowest acceptable or
  // - 1 greater than highest acceptable
  {
    group('Throws Exception on Unsigned 64 bit:', () {
      test(
          'toUnsignedBigInt will throw \'InvalidSizeException\' when value is -1.',
          () {
        final exceptionMessage = 'Invalid U64: -1';
        expect(
            () => toUnsignedBigInt(-1, 64),
            throwsA(
              predicate((e) =>
                  e is InvalidSizeException &&
                  e.toString() == exceptionMessage),
            ));
      });
      test(
          'toUnsignedBigInt will throw \'InvalidSizeException\' when value is 18446744073709551616.',
          () {
        final exceptionMessage = 'Invalid U64: 18446744073709551616';
        expect(
            () => toUnsignedBigInt('18446744073709551616', 64),
            throwsA(
              predicate((e) =>
                  e is InvalidSizeException &&
                  e.toString() == exceptionMessage),
            ));
      });
    });

    group('Throws Exception on Unsigned 128 bit:', () {
      test(
          'toUnsignedBigInt will throw \'InvalidSizeException\' when value is -1.',
          () {
        final exceptionMessage = 'Invalid U128: -1';
        expect(
            () => toUnsignedBigInt(-1, 128),
            throwsA(
              predicate((e) =>
                  e is InvalidSizeException &&
                  e.toString() == exceptionMessage),
            ));
      });
      test(
          'toUnsignedBigInt will throw \'InvalidSizeException\' when value is 340282366920938463463374607431768211456.',
          () {
        final exceptionMessage =
            'Invalid U128: 340282366920938463463374607431768211456';
        expect(
            () => toUnsignedBigInt(
                '340282366920938463463374607431768211456', 128),
            throwsA(
              predicate((e) =>
                  e is InvalidSizeException &&
                  e.toString() == exceptionMessage),
            ));
      });
    });

    group('Throws Exception on Unsigned 256 bit:', () {
      test(
          'toUnsignedBigInt will throw \'InvalidSizeException\' when value is -1.',
          () {
        final exceptionMessage = 'Invalid U256: -1';
        expect(
            () => toUnsignedBigInt(-1, 256),
            throwsA(
              predicate((e) =>
                  e is InvalidSizeException &&
                  e.toString() == exceptionMessage),
            ));
      });
      test(
          'toUnsignedBigInt will throw \'InvalidSizeException\' when value is 115792089237316195423570985008687907853269984665640564039457584007913129639936.',
          () {
        final exceptionMessage =
            'Invalid U256: 115792089237316195423570985008687907853269984665640564039457584007913129639936';
        expect(
            () => toUnsignedBigInt(
                '115792089237316195423570985008687907853269984665640564039457584007913129639936',
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
          'toUnsignedBigInt will throw \'UnexpectedTypeException\' when value of type BigInt is passed as an argument.',
          () {
        expect(
            () => toUnsignedBigInt(BigInt.parse('57896045664819967'), 64),
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
          'toUnsignedBigInt will throw \'UnexpectedCaseException\' when unknow bit-size: \'20\' is passed as an argument',
          () {
        expect(
            () => toUnsignedBigInt(200, 20),
            throwsA(predicate((e) =>
                e is UnexpectedCaseException &&
                e.toString() == exceptionMessage)));
      });
    });
  }
}
