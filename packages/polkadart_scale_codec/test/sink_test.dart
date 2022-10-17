import 'dart:math';
import 'dart:mirrors';

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void testCompact(String expectedHex, dynamic value) {
  test('When $value is compacted, it should produce result: $expectedHex.', () {
    final sink = HexSink();

    sink.compact(value);

    final computedHex = sink.toHex();
    expect(computedHex, expectedHex);
  });
}

///
/// What this function does ?
/// [methodName] : It's the name of the method to execute.
///
/// ```dart
/// // What's happening here ?
/// // [methodName]  : 'u8'
/// // [args]        : 1
/// // [expectedHex] : '0x04'
/// // Below code is similar to
///
/// var sink = HexSink();
/// sink.u8(1);
///
/// var computedHex = sink.toHex();
///
/// expect(computedHex, expectedHex);
/// ```
void testPrimitiveCompact(
    {required String methodName,
    required dynamic args,
    required String expectedHex}) {
  test(
      'When $methodName() is provided with args: $args, it must produce result: $expectedHex.',
      () {
    var sink = HexSink();
    var mirrorSink = reflect(sink);
    mirrorSink.invoke(Symbol(methodName), [args]);

    var computedHex = mirrorSink.invoke(Symbol('toHex'), []).reflectee;
    expect(computedHex, expectedHex);
  });
}

void main() {
  group('Test Compact from Sink Object:', () {
    //
    // Supported Compact values can range from 0 - (2 ^ 536)
    //
    testCompact('0x00', 0);
    testCompact('0x04', 1);
    testCompact('0xa8', 42);
    testCompact('0x1501', 69);
    testCompact('0xfeff0300', 65535);
    testCompact('0x0b00407a10f35a', 100000000000000);
    testCompact(
        '0x1700007014057fd8b806', BigInt.parse('124000000000000000000'));
    testCompact(
        '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
        2.toBigInt.pow(536.toBigInt.toInt()) - 1.toBigInt);
  });

  group('Sink write() Test', () {
    test('When passed any positive integer, then it generates hex easily.', () {
      final sink = HexSink();

      sink.write(pow(2, 62) as int);

      final expectedHex = '0x4000000000000000';

      final calculatedHex = sink.toHex();

      expect(calculatedHex, expectedHex);
    });

    test('When passed any negative integer, then it generates hex easily.', () {
      final sink = HexSink();

      sink.write(-pow(2, 62) as int);

      final expectedHex = '0xc000000000000000';

      final calculatedHex = sink.toHex();
      expect(calculatedHex, expectedHex);
    });
  });

  group('Sink bytes() Test', () {
    test('When passed with correct bytes, then it calculates hex easily.', () {
      final sink = HexSink();

      sink.bytes([
        68,
        103,
        105,
        116,
        104,
        117,
        98,
        58,
        32,
        106,
        117,
        115,
        116,
        107,
        97,
        119,
        97,
        108
      ]);

      final expectedHex = '0x446769746875623a206a7573746b6177616c';

      final calculatedHex = sink.toHex();

      expect(calculatedHex, expectedHex);
    });

    test(
        'When passed with incorrect bytes, then it throws \'UnexpectedCaseException\'',
        () {
      final sink = HexSink();

      final bytesValue = [
        68,
        103,
        105,
        -9,
        104,
        117,
        98,
        58,
        32,
        117,
        115,
        116,
        107,
        97,
        119,
        97,
        108
      ];

      expect(() => sink.bytes(bytesValue),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  group('Exception on Compact:', () {
    test(
        'When compacted with highest + 1 value as int, it will throw \'IncompatibleCompactException\'',
        () {
      // highest + 1 value
      final value = 2.toBigInt.pow(536.toBigInt.toInt());

      // Sink Object
      final sink = HexSink();

      // Match exception
      expect(() => sink.compact(value),
          throwsA(isA<IncompatibleCompactException>()));
    });
    test(
        'When compacted with highest + 1 value as BigInt, it will throw \'IncompatibleCompactException\'',
        () {
      // highest + 1 value
      final value = 2.toBigInt.pow(536.toBigInt.toInt()).toInt();

      // Sink Object
      final sink = HexSink();

      // Match exception
      expect(() => sink.compact(value),
          throwsA(isA<IncompatibleCompactException>()));
    });
    test(
        'When compacted with -1 value, it will throw \'IncompatibleCompactException\'',
        () {
      // lowest - 1 value
      final value = -1;
      // Sink Object
      final sink = HexSink();

      // Match exception
      expect(() => sink.compact(value),
          throwsA(isA<IncompatibleCompactException>()));
    });
  });

  group('Testing Primitives with Sink:', () {
    // Unsigned Bits
    // u8
    {
      // lowest acceptable possible
      testPrimitiveCompact(methodName: 'u8', args: 0, expectedHex: '0x00');

      // highest acceptable possible
      testPrimitiveCompact(methodName: 'u8', args: 255, expectedHex: '0xff');
    }

    // u16
    {
      // lowest acceptable possible
      testPrimitiveCompact(methodName: 'u16', args: 0, expectedHex: '0x0000');

      // highest acceptable possible
      testPrimitiveCompact(
          methodName: 'u16', args: 65535, expectedHex: '0xffff');
    }

    // u32
    {
      // lowest acceptable possible
      testPrimitiveCompact(
          methodName: 'u32', args: 0, expectedHex: '0x00000000');

      // highest acceptable possible
      testPrimitiveCompact(
          methodName: 'u32', args: pow(2, 32) - 1, expectedHex: '0xffffffff');
    }

    // u64
    {
      // lowest acceptable possible
      testPrimitiveCompact(
          methodName: 'u64',
          args: BigInt.from(0),
          expectedHex: '0x0000000000000000');

      // highest acceptable possible
      testPrimitiveCompact(
          methodName: 'u64',
          args: 2.toBigInt.pow(64) - 1.toBigInt,
          expectedHex: '0xffffffffffffffff');
    }

    // u128
    {
      // lowest acceptable possible
      testPrimitiveCompact(
          methodName: 'u128',
          args: BigInt.from(0),
          expectedHex: '0x00000000000000000000000000000000');

      // highest acceptable possible
      testPrimitiveCompact(
          methodName: 'u128',
          args: 2.toBigInt.pow(128) - 1.toBigInt,
          expectedHex: '0xffffffffffffffffffffffffffffffff');
    }

    // u256
    {
      // lowest acceptable possible
      testPrimitiveCompact(
          methodName: 'u256',
          args: BigInt.from(0),
          expectedHex:
              '0x0000000000000000000000000000000000000000000000000000000000000000');

      // highest acceptable possible
      testPrimitiveCompact(
          methodName: 'u256',
          args: 2.toBigInt.pow(128) - 1.toBigInt,
          expectedHex:
              '0xffffffffffffffffffffffffffffffff00000000000000000000000000000000');
    }

    // Signed Bits
    //i8
    {
      // i8 lowest acceptable possible
      testPrimitiveCompact(methodName: 'i8', args: -128, expectedHex: '0x80');

      // i8 highest acceptable possible
      testPrimitiveCompact(methodName: 'i8', args: 127, expectedHex: '0x7f');
    }

    // i16
    {
      // lowest acceptable possible
      testPrimitiveCompact(
          methodName: 'i16', args: -32768, expectedHex: '0x0080');

      // highest acceptable possible
      testPrimitiveCompact(
          methodName: 'i16', args: 32767, expectedHex: '0xff7f');
    }

    // i32
    {
      // lowest acceptable possible
      testPrimitiveCompact(
          methodName: 'i32', args: -2147483648, expectedHex: '0x00000080');

      // highest acceptable possilbe
      testPrimitiveCompact(
          methodName: 'i32', args: 2147483647, expectedHex: '0xffffff7f');
    }

    // i64
    {
      // lowest acceptable possible
      testPrimitiveCompact(
          methodName: 'i64',
          args: -2.toBigInt.pow(64 - 1),
          expectedHex: '0x0000000000000080');

      // highest acceptable possible
      testPrimitiveCompact(
          methodName: 'i64',
          args: 2.toBigInt.pow(64 - 1) - 1.toBigInt,
          expectedHex: '0xffffffffffffff7f');
    }

    // i128
    {
      // lowest acceptable possible
      testPrimitiveCompact(
          methodName: 'i128',
          args: -2.toBigInt.pow(128 - 1),
          expectedHex: '0x00000000000000000000000000000080');

      // highest acceptable possible
      testPrimitiveCompact(
          methodName: 'i128',
          args: 2.toBigInt.pow(128 - 1) - 1.toBigInt,
          expectedHex: '0xffffffffffffffffffffffffffffff7f');
    }

    // i256
    {
      // lowest acceptable possible
      testPrimitiveCompact(
          methodName: 'i256',
          args: -2.toBigInt.pow(256 - 1),
          expectedHex:
              '0x0000000000000000000000000000000000000000000000000000000000000080');

      // highest acceptable possible
      testPrimitiveCompact(
          methodName: 'i256',
          args: 2.toBigInt.pow(256 - 1) - 1.toBigInt,
          expectedHex:
              '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f');
    }

    // Bool
    // true
    testPrimitiveCompact(
        methodName: 'boolean', args: true, expectedHex: '0x01');
    // false
    testPrimitiveCompact(
        methodName: 'boolean', args: false, expectedHex: '0x00');

    testPrimitiveCompact(
        methodName: 'str',
        args: 'github: justkawal',
        expectedHex: '0x446769746875623a206a7573746b6177616c');
  });
}
