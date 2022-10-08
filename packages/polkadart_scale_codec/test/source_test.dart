import 'dart:math';
import 'dart:mirrors';

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void unCompactHexFromSource(String compactedHex, dynamic expectedVal) {
  test(
      'When a hex:$compactedHex is compacted, it should produce result: $expectedVal.',
      () {
    final source = Source(compactedHex);

    var computedVal = source.compact();

    expect(computedVal, expectedVal);
  });
}

///
/// What this function does ?
/// [methodName] : It's the name of the method to execute.
///
/// ```dart
/// // What's happening here ?
/// // [methodName]   : 'u8'
/// // [compactedHex] : '0x04'
/// // [expectedVal]  : 1
/// // Below code is similar to
///
/// var source = Source('0x04');
///
/// final computedVal = source.u8();
///
/// expect(computedVal, expectedVal);
/// ```
void testPrimitiveUnCompactingFromSource(
    {required String methodName,
    required String compactedHex,
    required dynamic expectedValue}) {
  test(
      'When Source({compactedHex}).$methodName() is executed, it should return result: $expectedValue.',
      () {
    final source = Source(compactedHex);
    final mirrorSource = reflect(source);
    final computedValue = mirrorSource.invoke(Symbol(methodName), []).reflectee;

    expect(computedValue, expectedValue);
  });
}

void main() {
  group('Test Compact from Sink Object:', () {
    //
    // Supported Compact values can range from  0 - ((2 ^ 536) - 1)
    //
    unCompactHexFromSource('0x00', 0);
    unCompactHexFromSource('0x04', 1);
    unCompactHexFromSource('0xa8', 42);
    unCompactHexFromSource('0x1501', 69);
    unCompactHexFromSource('0xfeff0300', 65535);
    unCompactHexFromSource('0x0b00407a10f35a', 100000000000000);
    unCompactHexFromSource(
        '0x1700007014057fd8b806', BigInt.parse('124000000000000000000'));
    unCompactHexFromSource(
        '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
        2.toBigInt.pow(536.toBigInt.toInt()) - 1.toBigInt);
  });

  group('Exception on Compact:', () {
    test(
        'When compacted with highest + 1 value as int, it will throw \'IncompatibleCompactException\'',
        () {
      // highest + 1 value
      final val = 2.toBigInt.pow(536.toBigInt.toInt());

      // Sink Object
      final sink = HexSink();

      // Match exception
      expect(() => sink.compact(val),
          throwsA(isA<IncompatibleCompactException>()));
    });
    test(
        'When compacted with highest + 1 value as BigInt, it will throw \'IncompatibleCompactException\'',
        () {
      // highest + 1 value
      final val = 2.toBigInt.pow(536.toBigInt.toInt()).toInt();

      // Sink Object
      final sink = HexSink();

      // Match exception
      expect(() => sink.compact(val),
          throwsA(isA<IncompatibleCompactException>()));
    });
    test(
        'When compacted with -1 value, it will throw \'IncompatibleCompactException\'',
        () {
      // lowest - 1 value
      final val = -1;
      // Sink Object
      final sink = HexSink();

      // Match exception
      expect(() => sink.compact(val),
          throwsA(isA<IncompatibleCompactException>()));
    });
  });

  group('Testing Primitives with Sink:', () {
    // Unsigned Bits
    // u8
    {
      // lowest acceptable possible
      testPrimitiveUnCompactingFromSource(
          methodName: 'u8', expectedValue: 0, compactedHex: '0x00');

      // highest acceptable possible
      testPrimitiveUnCompactingFromSource(
          methodName: 'u8', expectedValue: 255, compactedHex: '0xff');
    }

    // u16
    {
      // lowest acceptable possible
      testPrimitiveUnCompactingFromSource(
          methodName: 'u16', expectedValue: 0, compactedHex: '0x0000');

      // highest acceptable possible
      testPrimitiveUnCompactingFromSource(
          methodName: 'u16', expectedValue: 65535, compactedHex: '0xffff');
    }

    // u32
    {
      // lowest acceptable possible
      testPrimitiveUnCompactingFromSource(
          methodName: 'u32', expectedValue: 0, compactedHex: '0x00000000');

      // highest acceptable possible
      testPrimitiveUnCompactingFromSource(
          methodName: 'u32',
          expectedValue: pow(2, 32) - 1,
          compactedHex: '0xffffffff');
    }

    // u64
    {
      // lowest acceptable possible
      testPrimitiveUnCompactingFromSource(
          methodName: 'u64',
          expectedValue: BigInt.from(0),
          compactedHex: '0x0000000000000000');

      // highest acceptable possible
      testPrimitiveUnCompactingFromSource(
          methodName: 'u64',
          expectedValue: 2.toBigInt.pow(64) - 1.toBigInt,
          compactedHex: '0xffffffffffffffff');
    }

    // u128
    {
      // lowest acceptable possible
      testPrimitiveUnCompactingFromSource(
          methodName: 'u128',
          expectedValue: BigInt.from(0),
          compactedHex: '0x00000000000000000000000000000000');

      // highest acceptable possible
      testPrimitiveUnCompactingFromSource(
          methodName: 'u128',
          expectedValue: 2.toBigInt.pow(128) - 1.toBigInt,
          compactedHex: '0xffffffffffffffffffffffffffffffff');
    }

    // u256
    {
      // lowest acceptable possible
      testPrimitiveUnCompactingFromSource(
          methodName: 'u256',
          expectedValue: BigInt.from(0),
          compactedHex:
              '0x0000000000000000000000000000000000000000000000000000000000000000');

      // highest acceptable possible
      testPrimitiveUnCompactingFromSource(
          methodName: 'u256',
          expectedValue: 2.toBigInt.pow(128) - 1.toBigInt,
          compactedHex:
              '0xffffffffffffffffffffffffffffffff00000000000000000000000000000000');
    }

    // Signed Bits
    //i8
    {
      // i8 lowest acceptable possible
      testPrimitiveUnCompactingFromSource(
          methodName: 'i8', expectedValue: -128, compactedHex: '0x80');

      // i8 highest acceptable possible
      testPrimitiveUnCompactingFromSource(
          methodName: 'i8', expectedValue: 127, compactedHex: '0x7f');
    }

    // i16
    {
      // lowest acceptable possible
      testPrimitiveUnCompactingFromSource(
          methodName: 'i16', expectedValue: -32768, compactedHex: '0x0080');

      // highest acceptable possible
      testPrimitiveUnCompactingFromSource(
          methodName: 'i16', expectedValue: 32767, compactedHex: '0xff7f');
    }

    // i32
    {
      // lowest acceptable possible
      testPrimitiveUnCompactingFromSource(
          methodName: 'i32',
          expectedValue: -2147483648,
          compactedHex: '0x00000080');

      // highest acceptable possilbe
      testPrimitiveUnCompactingFromSource(
          methodName: 'i32',
          expectedValue: 2147483647,
          compactedHex: '0xffffff7f');
    }

    // i64
    {
      // lowest acceptable possible
      testPrimitiveUnCompactingFromSource(
          methodName: 'i64',
          expectedValue: -2.toBigInt.pow(64 - 1),
          compactedHex: '0x0000000000000080');

      // highest acceptable possible
      testPrimitiveUnCompactingFromSource(
          methodName: 'i64',
          expectedValue: 2.toBigInt.pow(64 - 1) - 1.toBigInt,
          compactedHex: '0xffffffffffffff7f');
    }

    // i128
    {
      // lowest acceptable possible
      testPrimitiveUnCompactingFromSource(
          methodName: 'i128',
          expectedValue: -2.toBigInt.pow(128 - 1),
          compactedHex: '0x00000000000000000000000000000080');

      // highest acceptable possible
      testPrimitiveUnCompactingFromSource(
          methodName: 'i128',
          expectedValue: 2.toBigInt.pow(128 - 1) - 1.toBigInt,
          compactedHex: '0xffffffffffffffffffffffffffffff7f');
    }

    // i256
    {
      // lowest acceptable possible
      testPrimitiveUnCompactingFromSource(
          methodName: 'i256',
          expectedValue: -2.toBigInt.pow(256 - 1),
          compactedHex:
              '0x0000000000000000000000000000000000000000000000000000000000000080');

      // highest acceptable possible
      testPrimitiveUnCompactingFromSource(
          methodName: 'i256',
          expectedValue: 2.toBigInt.pow(256 - 1) - 1.toBigInt,
          compactedHex:
              '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f');
    }

    // Bool
    // true
    testPrimitiveUnCompactingFromSource(
        methodName: 'boolean', expectedValue: true, compactedHex: '0x01');
    // false
    testPrimitiveUnCompactingFromSource(
        methodName: 'boolean', expectedValue: false, compactedHex: '0x00');

    testPrimitiveUnCompactingFromSource(
        methodName: 'str',
        expectedValue: 'github: justkawal',
        compactedHex: '0x446769746875623a206a7573746b6177616c');
  });
}
