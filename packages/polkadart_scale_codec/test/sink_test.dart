import 'dart:math';

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void testCompact(String expectedHex, dynamic value) {
  test('When $value is compacted, it should produce result: $expectedHex.', () {
    final sink = HexEncoder();

    sink.compact(value);

    final computedHex = sink.toHex();
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
      final sink = HexEncoder();

      sink.write(pow(2, 62) as int);

      final expectedHex = '0x4000000000000000';

      final calculatedHex = sink.toHex();

      expect(calculatedHex, expectedHex);
    });

    test('When passed any negative integer, then it generates hex easily.', () {
      final sink = HexEncoder();

      sink.write(-pow(2, 62) as int);

      final expectedHex = '0xc000000000000000';

      final calculatedHex = sink.toHex();
      expect(calculatedHex, expectedHex);
    });
  });

  group('Sink bytes() Test', () {
    test('When passed with correct bytes, then it calculates hex easily.', () {
      final sink = HexEncoder();

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
      final sink = HexEncoder();

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
      final sink = HexEncoder();

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
      final sink = HexEncoder();

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
      final sink = HexEncoder();

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

      test('When u8() is provided with args 0, it must produce result: 0x00.',
          () {
        final expectedResult = '0x00';

        final encoder = HexEncoder();
        encoder.u8(0);

        final computedHex = encoder.toHex();

        expect(computedHex, expectedResult);
      });

      // highest acceptable possible

      test('When u8() is provided with args 255, it must produce result: 0xff.',
          () {
        final expectedResult = '0xff';

        final encoder = HexEncoder();
        encoder.u8(255);

        final computedHex = encoder.toHex();

        expect(computedHex, expectedResult);
      });
    }

    // u16
    {
      // lowest acceptable possible

      test(
          'When u16() is provided with args 0, it must produce result: 0x0000.',
          () {
        final expectedResult = '0x0000';

        final encoder = HexEncoder();
        encoder.u16(0);

        final computedHex = encoder.toHex();

        expect(computedHex, expectedResult);
      });

      // highest acceptable possible

      test(
          'When u16() is provided with args 65535, it must produce result: 0xffff.',
          () {
        final expectedResult = '0xffff';

        final encoder = HexEncoder();
        encoder.u16(65535);

        final computedHex = encoder.toHex();

        expect(computedHex, expectedResult);
      });
    }

    // u32
    {
      // lowest acceptable possible

      test(
          'When u32() is provided with args 0, it must produce result: 0x00000000.',
          () {
        final expectedResult = '0x00000000';

        final encoder = HexEncoder();
        encoder.u32(0);

        final computedHex = encoder.toHex();

        expect(computedHex, expectedResult);
      });

      // highest acceptable possible
      test(
          'When u32() is provided with args 4294967295, it must produce result: 0xffffffff.',
          () {
        final expectedResult = '0xffffffff';

        final encoder = HexEncoder();
        final value = pow(2, 32) - 1;
        encoder.u32(value as int);

        final computedHex = encoder.toHex();

        expect(computedHex, expectedResult);
      });
    }

    // u64
    {
      // lowest acceptable possible
      test(
          'When u64() is provided with args 0, it must produce result: 0x0000000000000000.',
          () {
        final expectedResult = '0x0000000000000000';

        final encoder = HexEncoder();
        encoder.u64(BigInt.from(0));

        final computedHex = encoder.toHex();

        expect(computedHex, expectedResult);
      });

      // highest acceptable possible
      test(
          'When u64() is provided with args 18446744073709551615, it must produce result: 0xffffffffffffffff.',
          () {
        final expectedResult = '0xffffffffffffffff';

        final encoder = HexEncoder();
        encoder.u64(2.toBigInt.pow(64) - 1.toBigInt);

        final computedHex = encoder.toHex();

        expect(computedHex, expectedResult);
      });
    }

    // u128
    {
      // lowest acceptable possible
      test(
          'When u128() is provided with args 0, it must produce result: 0x00000000000000000000000000000000.',
          () {
        final expectedResult = '0x00000000000000000000000000000000';

        final encoder = HexEncoder();
        encoder.u128(BigInt.from(0));

        final computedHex = encoder.toHex();

        expect(computedHex, expectedResult);
      });

      // highest acceptable possible
      test(
          'When u128() is provided with args 340282366920938463463374607431768211455, it must produce result: 0xffffffffffffffffffffffffffffffff.',
          () {
        final expectedResult = '0xffffffffffffffffffffffffffffffff';

        final encoder = HexEncoder();
        encoder.u128(2.toBigInt.pow(128) - 1.toBigInt);

        final computedHex = encoder.toHex();

        expect(computedHex, expectedResult);
      });
    }

    // u256
    {
      // lowest acceptable possible
      test(
          'When u256() is provided with args 0, it must produce result: 0x0000000000000000000000000000000000000000000000000000000000000000.',
          () {
        final expectedResult =
            '0x0000000000000000000000000000000000000000000000000000000000000000';

        final encoder = HexEncoder();
        encoder.u256(BigInt.from(0));

        final computedHex = encoder.toHex();

        expect(computedHex, expectedResult);
      });

      // highest acceptable possible
      test(
          'When u256() is provided with args 115792089237316195423570985008687907853269984665640564039457584007913129639935, it must produce result: 0xffffffffffffffffffffffffffffffff00000000000000000000000000000000.',
          () {
        final expectedResult =
            '0xffffffffffffffffffffffffffffffff00000000000000000000000000000000';

        final encoder = HexEncoder();
        encoder.u256(2.toBigInt.pow(128) - 1.toBigInt);

        final computedHex = encoder.toHex();

        expect(computedHex, expectedResult);
      });
    }

    // Signed Bits
    //i8
    {
      // i8 lowest acceptable possible
      test('it should convert lowest acceptable possible 8 bit value', () {
        final expectedResult = '0x80';

        final encoder = HexEncoder();
        encoder.i8(-128);

        final computedHex = encoder.toHex();

        expect(computedHex, expectedResult);
      });

      // i8 highest acceptable possible

      test('When i8() is provided with args 127, it must produce result: 0x7f.',
          () {
        final expectedResult = '0x7f';

        final encoder = HexEncoder();
        encoder.i8(127);

        final computedHex = encoder.toHex();

        expect(computedHex, expectedResult);
      });
    }

    // i16
    {
      // lowest acceptable possible
      test(
          'When i16() is provided with args -32768, it must produce result: 0x0080.',
          () {
        final expectedResult = '0x0080';

        final encoder = HexEncoder();
        encoder.i16(-32768);

        final computedHex = encoder.toHex();

        expect(computedHex, expectedResult);
      });

      // highest acceptable possible

      test(
          'When i16() is provided with args 32767, it must produce result: 0xff7f.',
          () {
        final expectedResult = '0xff7f';

        final encoder = HexEncoder();
        encoder.i16(32767);

        final computedHex = encoder.toHex();

        expect(computedHex, expectedResult);
      });
    }

    // i32
    {
      // lowest acceptable possible
      test(
          'When i32() is provided with args -2147483648, it must produce result: 0x00000080.',
          () {
        final expectedResult = '0x00000080';

        final encoder = HexEncoder();
        encoder.i32(-2147483648);

        final computedHex = encoder.toHex();

        expect(computedHex, expectedResult);
      });

      // highest acceptable possilbe

      test(
          'When i32() is provided with args 2147483647, it must produce result: 0xffffff7f.',
          () {
        final expectedResult = '0xffffff7f';

        final encoder = HexEncoder();
        encoder.i32(2147483647);

        final computedHex = encoder.toHex();

        expect(computedHex, expectedResult);
      });
    }

    // i64
    {
      // lowest acceptable possible
      test(
          'When i64() is provided with args -9223372036854775808, it must produce result: 0x0000000000000080.',
          () {
        final expectedResult = '0x0000000000000080';

        final encoder = HexEncoder();
        encoder.i64(-2.toBigInt.pow(64 - 1));

        final computedHex = encoder.toHex();

        expect(computedHex, expectedResult);
      });

      // highest acceptable possible
      test(
          'When i64() is provided with args 9223372036854775807, it must produce result: 0xffffffffffffff7f.',
          () {
        final expectedResult = '0xffffffffffffff7f';

        final encoder = HexEncoder();
        encoder.i64(2.toBigInt.pow(64 - 1) - 1.toBigInt);

        final computedHex = encoder.toHex();

        expect(computedHex, expectedResult);
      });
    }

    // i128
    {
      // lowest acceptable possible
      test(
          'When i128() is provided with args -170141183460469231731687303715884105728, it must produce result: 0x00000000000000000000000000000080.',
          () {
        final expectedResult = '0x00000000000000000000000000000080';

        final encoder = HexEncoder();
        encoder.i128(-2.toBigInt.pow(128 - 1));

        final computedHex = encoder.toHex();

        expect(computedHex, expectedResult);
      });

      // highest acceptable possible
      test(
          'When i128() is provided with args 170141183460469231731687303715884105727, it must produce result: 0xffffffffffffffffffffffffffffff7f.',
          () {
        final expectedResult = '0xffffffffffffffffffffffffffffff7f';

        final encoder = HexEncoder();
        encoder.i128(2.toBigInt.pow(128 - 1) - 1.toBigInt);

        final computedHex = encoder.toHex();

        expect(computedHex, expectedResult);
      });
    }

    // i256
    {
      // lowest acceptable possible
      test(
          'When i256() is provided with args -57896044618658097711785492504343953926634992332820282019728792003956564819968, it must produce result: 0x0000000000000000000000000000000000000000000000000000000000000080.',
          () {
        final expectedResult =
            '0x0000000000000000000000000000000000000000000000000000000000000080';

        final encoder = HexEncoder();
        encoder.i256(-2.toBigInt.pow(256 - 1));

        final computedHex = encoder.toHex();

        expect(computedHex, expectedResult);
      });

      // highest acceptable possible
      test(
          'When i256() is provided with args 57896044618658097711785492504343953926634992332820282019728792003956564819967, it must produce result: 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f.',
          () {
        final expectedResult =
            '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f';

        final encoder = HexEncoder();
        encoder.i256(2.toBigInt.pow(256 - 1) - 1.toBigInt);

        final computedHex = encoder.toHex();

        expect(computedHex, expectedResult);
      });
    }

    // Bool
    // true

    test(
        'When boolean() is provided with args true, it must produce result: 0x01.',
        () {
      final expectedResult = '0x01';

      final encoder = HexEncoder();
      encoder.boolean(true);

      final computedHex = encoder.toHex();

      expect(computedHex, expectedResult);
    });
    // false

    test(
        'When boolean() is provided with args false, it must produce result: 0x00.',
        () {
      final expectedResult = '0x00';

      final encoder = HexEncoder();
      encoder.boolean(false);

      final computedHex = encoder.toHex();

      expect(computedHex, expectedResult);
    });

    test(
        'When str() is provided with args \'This is polkadart_scale_codec 🔥🚀\', it must produce result: 0x985468697320697320706f6c6b61646172745f7363616c655f636f64656320f09f94a5f09f9a80.',
        () {
      final expectedResult =
          '0x985468697320697320706f6c6b61646172745f7363616c655f636f64656320f09f94a5f09f9a80';

      final encoder = HexEncoder();
      encoder.str('This is polkadart_scale_codec 🔥🚀');

      final computedHex = encoder.toHex();

      expect(computedHex, expectedResult);
    });
  });
}
