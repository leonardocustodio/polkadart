import 'dart:math';
import 'dart:mirrors';

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void testCompact(String expectedHex, dynamic val) {
  test('On compacting $val should produce result: $expectedHex', () {
    final sink = HexSink();
    sink.compact(val);

    final computedHex = sink.toHex();
    expect(computedHex, expectedHex);
  });
}

///
/// What this function does ?
/// [method] : It's the name of the method to execute.
///
/// ```dart
/// // What's happening here ?
/// // [method]      : 'u8'
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
void testPrimitiveCompact(String method, dynamic args, String expectedHex) {
  test('$method($args) must produce result: $expectedHex.', () {
    var sink = HexSink();
    var mirrorSink = reflect(sink);
    mirrorSink.invoke(Symbol(method), [args]);

    var computedHex = mirrorSink.invoke(Symbol('toHex'), []).reflectee;
    expect(computedHex, expectedHex);
  });
}

void main() {
  group('Test Compact:', () {
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
    testCompact('0x13feffffffffffff7f',
        2.toBigInt.pow(536.toBigInt.toInt()).toInt() - 1);
  });

  group('Exception on Compact:', () {
    test(
        'sink.compact( highest BigInt ) should throw \'IncompatibleCompactException\' when compacted with highest + 1 value.',
        () {
      // highest + 1 value
      final val = 2.toBigInt.pow(536.toBigInt.toInt());

      final exceptionMessage = '$val is too large for a compact.';

      // Sink Object
      final sink = HexSink();

      // Match exception
      expect(
          () => sink.compact(val),
          throwsA(predicate((e) =>
              e is IncompatibleCompactException &&
              e.toString() == exceptionMessage)));
    });
    test(
        'sink.compact( highest int ) should throw \'IncompatibleCompactException\' when compacted with highest + 1 value.',
        () {
      // highest + 1 value
      final val = 2.toBigInt.pow(536.toBigInt.toInt()).toInt();

      final exceptionMessage = '$val is too large for a compact.';

      // Sink Object
      final sink = HexSink();

      // Match exception
      expect(
          () => sink.compact(val),
          throwsA(predicate((e) =>
              e is IncompatibleCompactException &&
              e.toString() == exceptionMessage)));
    });
    test(
        'sink.compact(-1) should throw \'IncompatibleCompactException\' when compacted with \'-1\' value.',
        () {
      // lowest - 1 value
      final val = -1;
      final exceptionMessage = 'Value can\'t be less than 0.';
      // Sink Object
      final sink = HexSink();

      // Match exception
      expect(
          () => sink.compact(val),
          throwsA(predicate((e) =>
              e is IncompatibleCompactException &&
              e.toString() == exceptionMessage)));
    });
  });

  group('Testing primitives:', () {
    // Unsigned Bits
    // u8
    {
      // lowest acceptable possible
      testPrimitiveCompact('u8', 0, '0x00');

      // highest acceptable possible
      testPrimitiveCompact('u8', 255, '0xff');
    }

    // u16
    {
      // lowest acceptable possible
      testPrimitiveCompact('u16', 0, '0x0000');

      // highest acceptable possible
      testPrimitiveCompact('u16', 65535, '0xffff');
    }

    // u32
    {
      // lowest acceptable possible
      testPrimitiveCompact('u32', 0, '0x00000000');

      // highest acceptable possible
      testPrimitiveCompact('u32', pow(2, 32) - 1, '0xffffffff');
    }

    // u64
    {
      // lowest acceptable possible
      testPrimitiveCompact('u64', BigInt.from(0), '0x0000000000000000');

      // highest acceptable possible
      testPrimitiveCompact(
          'u64', 2.toBigInt.pow(64) - 1.toBigInt, '0xffffffffffffffff');
    }

    // u128
    {
      // lowest acceptable possible
      testPrimitiveCompact(
          'u128', BigInt.from(0), '0x00000000000000000000000000000000');

      // highest acceptable possible
      testPrimitiveCompact('u128', 2.toBigInt.pow(128) - 1.toBigInt,
          '0xffffffffffffffffffffffffffffffff');
    }

    // u256
    {
      // lowest acceptable possible
      testPrimitiveCompact('u256', BigInt.from(0),
          '0x0000000000000000000000000000000000000000000000000000000000000000');

      // highest acceptable possible
      testPrimitiveCompact('u256', 2.toBigInt.pow(128) - 1.toBigInt,
          '0xffffffffffffffffffffffffffffffff00000000000000000000000000000000');
    }

    // Signed Bits
    //i8
    {
      // i8 lowest acceptable possible
      testPrimitiveCompact('i8', -128, '0x80');

      // i8 highest acceptable possible
      testPrimitiveCompact('i8', 127, '0x7f');
    }

    // i16
    {
      // lowest acceptable possible
      testPrimitiveCompact('i16', -32768, '0x0080');

      // highest acceptable possible
      testPrimitiveCompact('i16', 32767, '0xff7f');
    }

    // i32
    {
      // lowest acceptable possible
      testPrimitiveCompact('i32', -2147483648, '0x00000080');

      // highest acceptable possilbe
      testPrimitiveCompact('i32', 2147483647, '0xffffff7f');
    }

    // i64
    {
      // lowest acceptable possible
      testPrimitiveCompact(
          'i64', -2.toBigInt.pow(64 - 1), '0x0000000000000080');

      // highest acceptable possible
      testPrimitiveCompact(
          'i64', 2.toBigInt.pow(64 - 1) - 1.toBigInt, '0xffffffffffffff7f');
    }

    // i128
    {
      // lowest acceptable possible
      testPrimitiveCompact('i128', -2.toBigInt.pow(128 - 1),
          '0x00000000000000000000000000000080');

      // highest acceptable possible
      testPrimitiveCompact('i128', 2.toBigInt.pow(128 - 1) - 1.toBigInt,
          '0xffffffffffffffffffffffffffffff7f');
    }

    // i256
    {
      // lowest acceptable possible
      testPrimitiveCompact('i256', -2.toBigInt.pow(256 - 1),
          '0x0000000000000000000000000000000000000000000000000000000000000080');

      // highest acceptable possible
      testPrimitiveCompact('i256', 2.toBigInt.pow(256 - 1) - 1.toBigInt,
          '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f');
    }

    // Bool
    // true
    testPrimitiveCompact('boolean', true, '0x01');
    // false
    testPrimitiveCompact('boolean', false, '0x00');

    testPrimitiveCompact(
        'str', 'github: justkawal', '0x446769746875623a206a7573746b6177616c');
  });
}
