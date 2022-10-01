import 'dart:math';
import 'package:polkadart_scale_codec/src/util/utils.dart';
import 'package:test/test.dart';

void main() {
  //
  // This test will pass at the boundaries of max and min values of BigInt according to bitsize
  //
  // All the test cases will pass with [low, high] values with low and high being inclusive
  //
  group('Signed BigInt passes easily: ', () {
    var tests = {
      64: <String, String>{
        'low': '-9223372036854775808',
        'high': '9223372036854775807',
      },
      128: <String, String>{
        'low': '-170141183460469231731687303715884105728',
        'high': '170141183460469231731687303715884105727',
      },
      256: <String, String>{
        'low':
            '-57896044618658097711785492504343953926634992332820282019728792003956564819968',
        'high':
            '57896044618658097711785492504343953926634992332820282019728792003956564819967',
      },
    };

    for (var entry in tests.entries) {
      var bitSize = entry.key;
      var value = entry.value;
      test('$bitSize bit', () {
        //
        // Testing Low value
        expect(toSignedBigInt(value['low'], bitSize).toString(),
            equals(value['low']));

        //
        // Testing High value
        expect(toSignedBigInt(value['high'], bitSize).toString(),
            equals(value['high']));
      });
    }
  });

  {
    //
    // This test will passes for the values in between low and high.
    //
    group('Unsigned/Signed BigInt passes easily: ', () {
      var tests = {
        64: <String, dynamic>{
          'low': Random.secure().nextInt(4294967296),
          'high': '9223372036854775807',
        },
        128: <String, dynamic>{
          'low': Random.secure().nextInt(4294967296),
          'high': '170141183460469231731687303715884105727',
        },
        256: <String, dynamic>{
          'low': Random.secure().nextInt(4294967296),
          'high':
              '57896044618658097711785492504343953926634992332820282019728792003956564819967',
        },
      };

      for (var entry in tests.entries) {
        var bitSize = entry.key;
        var value = entry.value;
        test('$bitSize bit', () {
          //
          // Testing Low value
          expect(toSignedBigInt(value['low'], bitSize).toString(),
              equals(value['low'].toString()));
          expect(toUnsignedBigInt(value['low'], bitSize).toString(),
              equals(value['low'].toString()));

          //
          // Testing High value
          expect(toSignedBigInt(value['high'], bitSize).toString(),
              equals(value['high']));
          expect(toUnsignedBigInt(value['high'], bitSize).toString(),
              equals(value['high']));
        });
      }
    });
  }

  {
    //
    // This test will throw UnexpectedTypeException
    //
    group('Unsigned/Signed BigInt UnexpectedTypeException: ', () {
      var values = [
        BigInt.from(429496726),
        BigInt.from(123),
        BigInt.parse('57896045664819967')
      ];

      for (var val in values) {
        test('$val', () {
          expect(
              () => toSignedBigInt(val, 256),
              throwsA(predicate((e) =>
                  e is UnexpectedTypeException &&
                  e.toString() ==
                      'Only `String` and `int` are valid parameters.')));

          expect(
              () => toUnsignedBigInt(val, 256),
              throwsA(predicate((e) =>
                  e is UnexpectedTypeException &&
                  e.toString() ==
                      'Only `String` and `int` are valid parameters.')));
        });
      }
    });
  }

  //
  // Here InvalidSizeException will be thrown as testing with
  //
  // lowest - 1 and high + 1 that a bitsize can't hold.
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
                  e.toString() == 'Unexpected case: $bitSize.')));
          expect(
              () => toUnsignedBigInt('1', bitSize),
              throwsA(predicate((e) =>
                  e is UnexpectedCaseException &&
                  e.toString() == 'Unexpected case: $bitSize.')));
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
