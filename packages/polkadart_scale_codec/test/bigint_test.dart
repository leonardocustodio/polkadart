import 'dart:math';

import 'package:polkadart_scale_codec/src/util/utils.dart';
import 'package:test/test.dart';

void main() {
  //
  //
  //
  //
  //
  // Signed BigInt
  //
  // This test will pass at the boundaries of max and min values of BigInt according to bitsize
  //
  // All the test cases will pass with [low, high] values with low and high being inclusive
  //
  //
  //
  //
  //
  {
    group('Signed BigInt 64 bit:', () {
      //
      // Testing Low value
      test('Lowest value `-9223372036854775808` must pass', () {
        final lowestValue = '-9223372036854775808';
        expect(toSignedBigInt(lowestValue, 64).toString(), equals(lowestValue));
      });
      //
      // Testing High value
      test('Highest value `9223372036854775807` must pass', () {
        final highestValue = '9223372036854775807';
        expect(
            toSignedBigInt(highestValue, 64).toString(), equals(highestValue));
      });
    });

    group('Signed BigInt 128 bit:', () {
      //
      // Testing Low value
      //
      test('Lowest value `-170141183460469231731687303715884105728` must pass',
          () {
        final lowestValue = '-170141183460469231731687303715884105728';
        expect(
            toSignedBigInt(lowestValue, 128).toString(), equals(lowestValue));
      });
      //
      // Testing High value
      //
      test('Highest value `170141183460469231731687303715884105727` must pass',
          () {
        final highestValue = '170141183460469231731687303715884105727';
        expect(
            toSignedBigInt(highestValue, 128).toString(), equals(highestValue));
      });
    });

    group('Signed BigInt 256 bit:', () {
      //
      // Testing Low value
      //
      test(
          'Lowest value `-57896044618658097711785492504343953926634992332820282019728792003956564819968` must pass',
          () {
        final lowestValue =
            '-57896044618658097711785492504343953926634992332820282019728792003956564819968';
        expect(
            toSignedBigInt(lowestValue, 256).toString(), equals(lowestValue));
      });
      //
      // Testing High value
      //
      test(
          'Highest value `57896044618658097711785492504343953926634992332820282019728792003956564819967` must pass',
          () {
        final highestValue =
            '57896044618658097711785492504343953926634992332820282019728792003956564819967';
        expect(
            toSignedBigInt(highestValue, 256).toString(), equals(highestValue));
      });
    });
  }

  //
  //
  //
  //
  //
  // Unsigned BigInt
  //
  // This test will pass at the boundaries of min and max values of BigInt according to bitsize.
  //
  // All the test cases will pass with [low, high] values with low and high being `inclusive`.
  //
  //
  //
  //
  //
  {
    group('Unsigned BigInt 64 bit:', () {
      //
      // Testing Low value
      //
      test('Lowest value `0` must pass', () {
        final lowestValue = 0;
        expect(toUnsignedBigInt(lowestValue, 64).toInt(), equals(lowestValue));
      });
      //
      // Testing High value
      //
      test('Highest value `9223372036854775807` must pass', () {
        final highestValue = 9223372036854775807;
        expect(
            toUnsignedBigInt(highestValue, 64).toInt(), equals(highestValue));
      });
    });

    group('Unsigned BigInt 128 bit:', () {
      //
      // Testing Low value
      //
      test('Lowest value `0` must pass', () {
        final lowestValue = 0;
        expect(toUnsignedBigInt(lowestValue, 128).toInt(), equals(lowestValue));
      });
      test('Highest value `170141183460469231731687303715884105727` must pass',
          () {
        //
        // Testing High value
        //
        final highestValue = '170141183460469231731687303715884105727';
        expect(toUnsignedBigInt(highestValue, 128).toString(),
            equals(highestValue));
      });
    });

    group('Unsigned BigInt 256 bit:', () {
      //
      // Testing Low value
      //
      test('Lowest value `0` must pass', () {
        final lowestValue = 0;
        expect(toUnsignedBigInt(lowestValue, 256).toInt(), equals(lowestValue));
      });
      //
      // Testing High value
      //
      test(
          'Highest value `57896044618658097711785492504343953926634992332820282019728792003956564819967` must pass',
          () {
        final highestValue =
            '57896044618658097711785492504343953926634992332820282019728792003956564819967';
        expect(toUnsignedBigInt(highestValue, 256).toString(),
            equals(highestValue));
      });
    });
  }

  //
  //
  //
  //
  //
  // This test will throw UnexpectedTypeException when called `toSignedBigInt`
  //
  //
  //
  //
  //
  {
    group('toSignedBigInt should throw UnexpectedTypeException', () {
      final exceptionMessage = 'Only `String` and `int` are valid parameters.';
      test('at val: BigInt.from(429496726)', () {
        expect(
            () => toSignedBigInt(BigInt.from(429496726), 256),
            throwsA(predicate((e) =>
                e is UnexpectedTypeException &&
                e.toString() == exceptionMessage)));
      });

      test('at val: BigInt.parse(\'57896045664819967\')', () {
        expect(
            () => toSignedBigInt(BigInt.parse('57896045664819967'), 256),
            throwsA(predicate((e) =>
                e is UnexpectedTypeException &&
                e.toString() == exceptionMessage)));
      });
    });
  }

  //
  //
  //
  //
  //
  // This test will throw UnexpectedTypeException when called `toUnsignedBigInt`
  //
  //
  //
  //
  //
  {
    group('toUnsignedBigInt should throw UnexpectedTypeException', () {
      final exceptionMessage = 'Only `String` and `int` are valid parameters.';
      test('at val: BigInt.from(429496726)', () {
        expect(
            () => toUnsignedBigInt(BigInt.from(429496726), 256),
            throwsA(predicate((e) =>
                e is UnexpectedTypeException &&
                e.toString() == exceptionMessage)));
      });

      test('at val: BigInt.parse(\'57896045664819967\')', () {
        expect(
            () => toUnsignedBigInt(BigInt.parse('57896045664819967'), 256),
            throwsA(predicate((e) =>
                e is UnexpectedTypeException &&
                e.toString() == exceptionMessage)));
      });
    });
  }

  //
  //
  //
  //
  //
  // Unsigned BigInt
  //
  // checkUnsignedBigInt should return true when value within range according to bit sizes are passed.
  //
  //
  //
  //
  //
  {
    group('Unsigned BigInt at 64 bit:', () {
      //
      // Testing Low value
      //
      test('Lowest value `0` must return `true`', () {
        expect(checkUnsignedBigInt(BigInt.from(0), 64), equals(true));
      });
      //
      // Testing High value
      //
      test('Highest value `9223372036854775807` must return `true`', () {
        expect(checkUnsignedBigInt(BigInt.from(9223372036854775807), 64),
            equals(true));
      });
    });

    group('Unsigned BigInt at 128 bit:', () {
      //
      // Testing Low value
      //
      test('Lowest value `0` must return `true`', () {
        expect(checkUnsignedBigInt(BigInt.from(0), 128), equals(true));
      });
      //
      // Testing High value
      //
      test(
          'Highest value `170141183460469231731687303715884105727` must return `true`',
          () {
        expect(
            checkUnsignedBigInt(
                BigInt.parse('170141183460469231731687303715884105727'), 128),
            equals(true));
      });
    });

    group('Unsigned BigInt at 256 bit:', () {
      //
      // Testing Low value
      //
      test('Lowest value `0` must return `true`', () {
        expect(checkUnsignedBigInt(BigInt.from(0), 256), equals(true));
      });
      //
      // Testing High value
      //
      test(
          'Highest value `57896044618658097711785492504343953926634992332820282019728792003956564819967` must return `true`',
          () {
        expect(
            checkUnsignedBigInt(
                BigInt.parse(
                    '57896044618658097711785492504343953926634992332820282019728792003956564819967'),
                256),
            equals(true));
      });
    });
  }

  //
  //
  //
  //
  //
  // Signed BigInt
  //
  // checkSignedBigInt should return true when value within range according to bit sizes are passed.
  //
  //
  //
  //
  //
  {
    group('Signed BigInt at 64 bit:', () {
      //
      // Testing Low value
      //
      test('Lowest value `-9223372036854775808` must return `true`', () {
        expect(checkSignedBigInt(BigInt.from(-9223372036854775808), 64),
            equals(true));
      });
      //
      // Testing High value
      //
      test('Highest value `9223372036854775807` must return `true`', () {
        expect(checkSignedBigInt(BigInt.from(9223372036854775807), 64),
            equals(true));
      });
    });

    group('Signed BigInt at 128 bit:', () {
      //
      // Testing Low value
      //
      test(
          'Lowest value `-170141183460469231731687303715884105728` must return `true`',
          () {
        expect(
            checkSignedBigInt(
                BigInt.parse('-170141183460469231731687303715884105728'), 128),
            equals(true));
      });
      //
      // Testing High value
      //
      test(
          'Highest value `170141183460469231731687303715884105727` must return `true`',
          () {
        expect(
            checkSignedBigInt(
                BigInt.parse('170141183460469231731687303715884105727'), 128),
            equals(true));
      });
    });

    group('Signed BigInt at 256 bit:', () {
      //
      // Testing Low value
      //
      test(
          'Lowest value `-57896044618658097711785492504343953926634992332820282019728792003956564819968` must return `true`',
          () {
        expect(
            checkSignedBigInt(
                BigInt.parse(
                    '-57896044618658097711785492504343953926634992332820282019728792003956564819968'),
                256),
            equals(true));
      });
      //
      // Testing High value
      //
      test(
          'Highest value `57896044618658097711785492504343953926634992332820282019728792003956564819967` must return `true`',
          () {
        expect(
            checkSignedBigInt(
                BigInt.parse(
                    '57896044618658097711785492504343953926634992332820282019728792003956564819967'),
                256),
            equals(true));
      });
    });
  }

  //
  //
  //
  //
  //
  // Unsigned BigInt
  //
  // checkUnsignedBigInt should throw `UnexpectedCaseException` when an unknow bitsize is passed.
  //
  //
  //
  //
  //
  {
    group('checkUnsignedBigInt must throw "UnexpectedCaseException":', () {
      test('at bitsize: 20', () {
        final exceptionMessage = 'Unexpected BitSize: 20.';
        expect(
            () => checkUnsignedBigInt(BigInt.from(0), 20),
            throwsA(predicate((e) =>
                e is UnexpectedCaseException &&
                e.toString() == exceptionMessage)));
      });
      test('at bitsize: 0', () {
        final exceptionMessage = 'Unexpected BitSize: 0.';
        expect(
            () => checkUnsignedBigInt(BigInt.from(0), 0),
            throwsA(predicate((e) =>
                e is UnexpectedCaseException &&
                e.toString() == exceptionMessage)));
      });
      test('at bitsize: 120', () {
        final exceptionMessage = 'Unexpected BitSize: 120.';
        expect(
            () => checkUnsignedBigInt(BigInt.from(0), 120),
            throwsA(predicate((e) =>
                e is UnexpectedCaseException &&
                e.toString() == exceptionMessage)));
      });
      test('at bitsize: 255', () {
        final exceptionMessage = 'Unexpected BitSize: 255.';
        expect(
            () => checkUnsignedBigInt(BigInt.from(0), 255),
            throwsA(predicate((e) =>
                e is UnexpectedCaseException &&
                e.toString() == exceptionMessage)));
      });
    });
  }

  //
  //
  //
  //
  //
  // Signed BigInt
  //
  // checkSignedBigInt should throw `UnexpectedCaseException` when an unknow bitsize is passed.
  //
  //
  //
  //
  //
  {
    group('checkSignedBigInt must throw "UnexpectedCaseException":', () {
      test('at bitsize: 20', () {
        final exceptionMessage = 'Unexpected BitSize: 20.';
        expect(
            () => checkSignedBigInt(BigInt.from(0), 20),
            throwsA(predicate((e) =>
                e is UnexpectedCaseException &&
                e.toString() == exceptionMessage)));
      });
      test('at bitsize: 0', () {
        final exceptionMessage = 'Unexpected BitSize: 0.';
        expect(
            () => checkSignedBigInt(BigInt.from(0), 0),
            throwsA(predicate((e) =>
                e is UnexpectedCaseException &&
                e.toString() == exceptionMessage)));
      });
      test('at bitsize: 120', () {
        final exceptionMessage = 'Unexpected BitSize: 120.';
        expect(
            () => checkSignedBigInt(BigInt.from(0), 120),
            throwsA(predicate((e) =>
                e is UnexpectedCaseException &&
                e.toString() == exceptionMessage)));
      });
      test('at bitsize: 255', () {
        final exceptionMessage = 'Unexpected BitSize: 255.';
        expect(
            () => checkSignedBigInt(BigInt.from(0), 255),
            throwsA(predicate((e) =>
                e is UnexpectedCaseException &&
                e.toString() == exceptionMessage)));
      });
    });
  }

  //
  //
  //
  //
  //
  // Here InvalidSizeException will be thrown as testing with
  //
  // lowest - 1 and high + 1 that a bitsize can't hold.
  //
  //
  //
  //
  //
  group('Signed BigInt: InvalidSizeException: ', () {
    var tests = {
      64: <String, String>{
        'low': '-9223372036854775809',
        'high': '9223372036854775808',
      },
      128: <String, String>{
        'low': '-170141183460469231731687303715884105729',
        'high': '170141183460469231731687303715884105728',
      },
      256: <String, String>{
        'low':
            '-57896044618658097711785492504343953926634992332820282019728792003956564819969',
        'high':
            '57896044618658097711785492504343953926634992332820282019728792003956564819968',
      },
    };

    for (var entry in tests.entries) {
      var bitSize = entry.key;
      var value = entry.value;
      test('$bitSize bit: ${value['low']}', () {
        //
        // Testing Low value
        expect(
            () => toSignedBigInt(value['low'], bitSize),
            throwsA(predicate((e) =>
                e is InvalidSizeException &&
                e.toString() == 'Invalid I$bitSize: ${value['low']}')));
      });
      test('$bitSize bit: ${value['high']}', () {
        //
        // Testing High value
        expect(
            () => toSignedBigInt(value['high'], bitSize),
            throwsA(predicate((e) =>
                e is InvalidSizeException &&
                e.toString() == 'Invalid I$bitSize: ${value['high']}')));
      });
    }
  });

  //
  // Here we are testing random bit sizes and checking if it passes from unsigned and signed or not ?
  //
  group('Bit Size checking ', () {
    final allowedBits = [64, 128, 256];
    var randomBits = List.generate(
        20,
        (index) =>
            Random(Random.secure().nextInt(4294967296)).nextInt(4294967296));
    randomBits
      ..addAll(allowedBits)
      ..shuffle();

    for (var bitSize in randomBits) {
      var willPass = allowedBits.contains(bitSize);
      test(
          '${willPass ? 'Unexpected Case Exception at' : 'passes at'} $bitSize bit ',
          () {
        if (willPass) {
          expect(toSignedBigInt('1', bitSize).toInt(), equals(1));
          expect(toUnsignedBigInt('1', bitSize).toInt(), equals(1));
        } else {
          expect(
              () => toSignedBigInt('1', bitSize),
              throwsA(predicate((e) =>
                  e is UnexpectedCaseException &&
                  e.toString() == 'Unexpected BitSize: $bitSize.')));
          expect(
              () => toUnsignedBigInt('1', bitSize),
              throwsA(predicate((e) =>
                  e is UnexpectedCaseException &&
                  e.toString() == 'Unexpected BitSize: $bitSize.')));
        }
      });
    }
  });

  //
  // This test will pass at the boundaries of max and min values of BigInt according to bitsize
  //
  // All the test cases will pass with [low, high] values with low and high being inclusive
  //
  group('Unsigned BigInt passes easily: ', () {
    var tests = {
      64: <String, String>{
        'low': '0',
        'high': '18446744073709551615',
      },
      128: <String, String>{
        'low': '0',
        'high': '340282366920938463463374607431768211455',
      },
      256: <String, String>{
        'low': '0',
        'high':
            '115792089237316195423570985008687907853269984665640564039457584007913129639935',
      },
    };

    for (var entry in tests.entries) {
      var bitSize = entry.key;
      var value = entry.value;
      test('$bitSize bit', () {
        //
        // Testing Low value
        expect(toUnsignedBigInt(value['low'], bitSize).toString(),
            equals(value['low']));

        //
        // Testing High value
        expect(toUnsignedBigInt(value['high'], bitSize).toString(),
            equals(value['high']));
      });
    }
  });

  //
  // Here InvalidSizeException will be thrown as testing with
  //
  // lowest - 1 and high + 1 that a bitsize can hold.
  //
  group('Unsigned BigInt: InvalidSizeException: ', () {
    var tests = {
      64: <String, String>{
        'low': '-1',
        'high': '18446744073709551616',
      },
      128: <String, String>{
        'low': '-1',
        'high': '340282366920938463463374607431768211456',
      },
      256: <String, String>{
        'low': '-1',
        'high':
            '115792089237316195423570985008687907853269984665640564039457584007913129639936',
      },
    };

    for (var entry in tests.entries) {
      var bitSize = entry.key;
      var value = entry.value;
      test('$bitSize bit: ${value['low']}', () {
        //
        // Testing Low value
        expect(
            () => toUnsignedBigInt(value['low'], bitSize),
            throwsA(predicate((e) =>
                e is InvalidSizeException &&
                e.toString() == 'Invalid U$bitSize: ${value['low']}')));
      });
      test('$bitSize bit: ${value['high']}', () {
        //
        // Testing High value
        expect(
            () => toUnsignedBigInt(value['high'], bitSize),
            throwsA(predicate((e) =>
                e is InvalidSizeException &&
                e.toString() == 'Invalid U$bitSize: ${value['high']}')));
      });
    }
  });
}
