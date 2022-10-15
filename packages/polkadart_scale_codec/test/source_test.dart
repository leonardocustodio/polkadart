import 'dart:math';
import 'dart:mirrors';

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void decodeCompactHexFromSource(String compactedHex, dynamic expectedValue) {
  test(
      'When a hex:$compactedHex is compacted, it should produce result: $expectedValue.',
      () {
    final source = Source(compactedHex);

    var computedValue = source.decodeCompact();

    expect(computedValue, expectedValue);
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
/// // [expectedValue]  : 1
/// // Below code is similar to
///
/// var source = Source('0x04');
///
/// final computedValue = source.u8();
///
/// expect(computedValue, expectedValue);
/// ```
void testPrimitiveDecodeCompactingFromSource(
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
    decodeCompactHexFromSource('0x00', 0);
    decodeCompactHexFromSource('0x04', 1);
    decodeCompactHexFromSource('0xa8', 42);
    decodeCompactHexFromSource('0x1501', 69);
    decodeCompactHexFromSource('0xfeff0300', 65535);
    decodeCompactHexFromSource('0x0b00407a10f35a', 100000000000000);
    decodeCompactHexFromSource(
        '0x1700007014057fd8b806', BigInt.parse('124000000000000000000'));
    decodeCompactHexFromSource(
        '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
        2.toBigInt.pow(536.toBigInt.toInt()) - 1.toBigInt);
  });

  group('Testing Primitives with Sink:', () {
    // Unsigned Bits
    // u8
    {
      // lowest acceptable possible
      testPrimitiveDecodeCompactingFromSource(
          methodName: 'u8', expectedValue: 0, compactedHex: '0x00');

      // highest acceptable possible
      testPrimitiveDecodeCompactingFromSource(
          methodName: 'u8', expectedValue: 255, compactedHex: '0xff');
    }

    // u16
    {
      // lowest acceptable possible
      testPrimitiveDecodeCompactingFromSource(
          methodName: 'u16', expectedValue: 0, compactedHex: '0x0000');

      // highest acceptable possible
      testPrimitiveDecodeCompactingFromSource(
          methodName: 'u16', expectedValue: 65535, compactedHex: '0xffff');
    }

    // u32
    {
      // lowest acceptable possible
      testPrimitiveDecodeCompactingFromSource(
          methodName: 'u32', expectedValue: 0, compactedHex: '0x00000000');

      // highest acceptable possible
      testPrimitiveDecodeCompactingFromSource(
          methodName: 'u32',
          expectedValue: pow(2, 32) - 1,
          compactedHex: '0xffffffff');
    }

    // u64
    {
      // lowest acceptable possible
      testPrimitiveDecodeCompactingFromSource(
          methodName: 'u64',
          expectedValue: BigInt.from(0),
          compactedHex: '0x0000000000000000');

      // highest acceptable possible
      testPrimitiveDecodeCompactingFromSource(
          methodName: 'u64',
          expectedValue: 2.toBigInt.pow(64) - 1.toBigInt,
          compactedHex: '0xffffffffffffffff');
    }

    // u128
    {
      // lowest acceptable possible
      testPrimitiveDecodeCompactingFromSource(
          methodName: 'u128',
          expectedValue: BigInt.from(0),
          compactedHex: '0x00000000000000000000000000000000');

      // highest acceptable possible
      testPrimitiveDecodeCompactingFromSource(
          methodName: 'u128',
          expectedValue: 2.toBigInt.pow(128) - 1.toBigInt,
          compactedHex: '0xffffffffffffffffffffffffffffffff');
    }

    // u256
    {
      // lowest acceptable possible
      testPrimitiveDecodeCompactingFromSource(
          methodName: 'u256',
          expectedValue: BigInt.from(0),
          compactedHex:
              '0x0000000000000000000000000000000000000000000000000000000000000000');

      // highest acceptable possible
      testPrimitiveDecodeCompactingFromSource(
          methodName: 'u256',
          expectedValue: 2.toBigInt.pow(128) - 1.toBigInt,
          compactedHex:
              '0xffffffffffffffffffffffffffffffff00000000000000000000000000000000');
    }

    // Signed Bits
    //i8
    {
      // i8 lowest acceptable possible
      testPrimitiveDecodeCompactingFromSource(
          methodName: 'i8', expectedValue: -128, compactedHex: '0x80');

      // i8 highest acceptable possible
      testPrimitiveDecodeCompactingFromSource(
          methodName: 'i8', expectedValue: 127, compactedHex: '0x7f');
    }

    // i16
    {
      // lowest acceptable possible
      testPrimitiveDecodeCompactingFromSource(
          methodName: 'i16', expectedValue: -32768, compactedHex: '0x0080');

      // highest acceptable possible
      testPrimitiveDecodeCompactingFromSource(
          methodName: 'i16', expectedValue: 32767, compactedHex: '0xff7f');
    }

    // i32
    {
      // lowest acceptable possible
      testPrimitiveDecodeCompactingFromSource(
          methodName: 'i32',
          expectedValue: -2147483648,
          compactedHex: '0x00000080');

      // highest acceptable possilbe
      testPrimitiveDecodeCompactingFromSource(
          methodName: 'i32',
          expectedValue: 2147483647,
          compactedHex: '0xffffff7f');
    }

    // i64
    {
      // lowest acceptable possible
      testPrimitiveDecodeCompactingFromSource(
          methodName: 'i64',
          expectedValue: -2.toBigInt.pow(64 - 1),
          compactedHex: '0x0000000000000080');

      // highest acceptable possible
      testPrimitiveDecodeCompactingFromSource(
          methodName: 'i64',
          expectedValue: 2.toBigInt.pow(64 - 1) - 1.toBigInt,
          compactedHex: '0xffffffffffffff7f');
    }

    // i128
    {
      // lowest acceptable possible
      testPrimitiveDecodeCompactingFromSource(
          methodName: 'i128',
          expectedValue: -2.toBigInt.pow(128 - 1),
          compactedHex: '0x00000000000000000000000000000080');

      // highest acceptable possible
      testPrimitiveDecodeCompactingFromSource(
          methodName: 'i128',
          expectedValue: 2.toBigInt.pow(128 - 1) - 1.toBigInt,
          compactedHex: '0xffffffffffffffffffffffffffffff7f');
    }

    // i256
    {
      // lowest acceptable possible
      testPrimitiveDecodeCompactingFromSource(
          methodName: 'i256',
          expectedValue: -2.toBigInt.pow(256 - 1),
          compactedHex:
              '0x0000000000000000000000000000000000000000000000000000000000000080');

      // highest acceptable possible
      testPrimitiveDecodeCompactingFromSource(
          methodName: 'i256',
          expectedValue: 2.toBigInt.pow(256 - 1) - 1.toBigInt,
          compactedHex:
              '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f');
    }

    // Bool
    // true
    testPrimitiveDecodeCompactingFromSource(
        methodName: 'boolean', expectedValue: true, compactedHex: '0x01');
    // false
    testPrimitiveDecodeCompactingFromSource(
        methodName: 'boolean', expectedValue: false, compactedHex: '0x00');

    testPrimitiveDecodeCompactingFromSource(
        methodName: 'str',
        expectedValue: 'github: justkawal',
        compactedHex: '0x446769746875623a206a7573746b6177616c');
  });

  group('Test\'EOFException\'', () {
    // When the bytes are invalid in form of hexa-decimal and length is greater than bytes then it throws EOFException.
    test(
        'When invalid Hexa-decimal like: \'0x08ff\' is passed as an argument then it should throw \'EOFException\'.',
        () {
      final value = '0x08ff';

      final source = Source(value);

      expect(() => source.str(), throwsA(isA<EOFException>()));
    });
  });

  group('Test\'AssertionException\'', () {
    // When the bytes are invalid in form of hexa-decimal and identifier of BigInt length is used then it throws AssertionException.
    test(
        'When invalid Hexa-decimal like: \'0x1700007014057fd8b806\' is passed as an argument then it should throw \'AssertionException\'.',
        () {
      final value = '0x1700007014057fd8b806';

      final source = Source(value);

      expect(() => source.str(), throwsA(isA<AssertionException>()));
    });
  });
}
