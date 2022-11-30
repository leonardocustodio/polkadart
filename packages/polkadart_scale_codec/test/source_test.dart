import 'dart:math';

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
      test(
          'When Source(\'0x00\').u8() is executed, then it should return result: 0.',
          () {
        final expectedResult = 0;

        final source = Source('0x00');
        final computedValue = source.u8();

        expect(computedValue, expectedResult);
      });

      // highest acceptable possible
      test(
          'When Source(\'0xff\').u8() is executed, then it should return result: 255.',
          () {
        final expectedResult = 255;

        final source = Source('0xff');
        final computedValue = source.u8();

        expect(computedValue, expectedResult);
      });
    }

    // u16
    {
      // lowest acceptable possible
      test(
          'When Source(\'0x0000\').u16() is executed, then it should return result: 0.',
          () {
        final expectedResult = 0;

        final source = Source('0x0000');
        final computedValue = source.u16();

        expect(computedValue, expectedResult);
      });

      // highest acceptable possible
      test(
          'When Source(\'0xffff\').u16() is executed, then it should return result: 65535.',
          () {
        final expectedResult = 65535;

        final source = Source('0xffff');
        final computedValue = source.u16();

        expect(computedValue, expectedResult);
      });
    }

    // u32
    {
      // lowest acceptable possible
      test(
          'When Source(\'0x00000000\').u32() is executed, then it should return result: 0.',
          () {
        final expectedResult = 0;

        final source = Source('0x00000000');
        final computedValue = source.u32();

        expect(computedValue, expectedResult);
      });

      // highest acceptable possible
      test(
          'When Source(\'0xffffffff\').u32() is executed, then it should return result: 4294967295.',
          () {
        final expectedResult = pow(2, 32) - 1;

        final source = Source('0xffffffff');
        final computedValue = source.u32();

        expect(computedValue, expectedResult);
      });
    }

    // u64
    {
      // lowest acceptable possible
      test(
          'When Source(\'0x0000000000000000\').u64() is executed, then it should return result: 0.',
          () {
        final expectedResult = BigInt.from(0);

        final source = Source('0x0000000000000000');
        final computedValue = source.u64();

        expect(computedValue, expectedResult);
      });

      // highest acceptable possible
      test(
          'When Source(\'0xffffffffffffffff\').u64() is executed, then it should return result: 18446744073709551615.',
          () {
        final expectedResult = 2.toBigInt.pow(64) - 1.toBigInt;

        final source = Source('0xffffffffffffffff');
        final computedValue = source.u64();

        expect(computedValue, expectedResult);
      });
    }

    // u128
    {
      // lowest acceptable possible
      test(
          'When Source(\'0x00000000000000000000000000000000\').u128() is executed, then it should return result: 0.',
          () {
        final expectedResult = BigInt.from(0);

        final source = Source('0x00000000000000000000000000000000');
        final computedValue = source.u128();

        expect(computedValue, expectedResult);
      });

      // highest acceptable possible
      test(
          'When Source(\'0xffffffffffffffffffffffffffffffff\').u128() is executed, then it should return result: 340282366920938463463374607431768211455.',
          () {
        final expectedResult = 2.toBigInt.pow(128) - 1.toBigInt;

        final source = Source('0xffffffffffffffffffffffffffffffff');
        final computedValue = source.u128();

        expect(computedValue, expectedResult);
      });
    }

    // u256
    {
      // lowest acceptable possible
      test(
          'When Source(\'0x0000000000000000000000000000000000000000000000000000000000000000\').u256() is executed, then it should return result: 0.',
          () {
        final expectedResult = BigInt.from(0);

        final source = Source(
            '0x0000000000000000000000000000000000000000000000000000000000000000');
        final computedValue = source.u256();

        expect(computedValue, expectedResult);
      });

      // highest acceptable possible
      test(
          'When Source(\'0xffffffffffffffffffffffffffffffff00000000000000000000000000000000\').u256() is executed, then it should return result: 115792089237316195423570985008687907853269984665640564039457584007913129639935.',
          () {
        final expectedResult = 2.toBigInt.pow(128) - 1.toBigInt;

        final source = Source(
            '0xffffffffffffffffffffffffffffffff00000000000000000000000000000000');
        final computedValue = source.u256();

        expect(computedValue, expectedResult);
      });
    }

    // Signed Bits
    //i8
    {
      // i8 lowest acceptable possible
      test(
          'When Source(\'0x80\').i8() is executed, then it should return result: -128.',
          () {
        final expectedResult = -128;

        final source = Source('0x80');
        final computedValue = source.i8();

        expect(computedValue, expectedResult);
      });

      // i8 highest acceptable possible
      test(
          'When Source(\'0x7f\').i8() is executed, then it should return result: 127.',
          () {
        final expectedResult = 127;

        final source = Source('0x7f');
        final computedValue = source.i8();

        expect(computedValue, expectedResult);
      });
    }

    // i16
    {
      // lowest acceptable possible
      test(
          'When Source(\'0x0080\').i16() is executed, then it should return result: -32768.',
          () {
        final expectedResult = -32768;

        final source = Source('0x0080');
        final computedValue = source.i16();

        expect(computedValue, expectedResult);
      });

      // highest acceptable possible
      test(
          'When Source(\'0xff7f\').i16() is executed, then it should return result: 32767.',
          () {
        final expectedResult = 32767;

        final source = Source('0xff7f');
        final computedValue = source.i16();

        expect(computedValue, expectedResult);
      });
    }

    // i32
    {
      // lowest acceptable possible
      test(
          'When Source(\'0x00000080\').i32() is executed, then it should return result: -2147483648.',
          () {
        final expectedResult = -2147483648;

        final source = Source('0x00000080');
        final computedValue = source.i32();

        expect(computedValue, expectedResult);
      });

      // highest acceptable possilbe
      test(
          'When Source(\'0xffffff7f\').i32() is executed, then it should return result: 2147483647.',
          () {
        final expectedResult = 2147483647;

        final source = Source('0xffffff7f');
        final computedValue = source.i32();

        expect(computedValue, expectedResult);
      });
    }

    // i64
    {
      // lowest acceptable possible
      test(
          'When Source(\'0x0000000000000080\').i64() is executed, then it should return result: -9223372036854775808.',
          () {
        final expectedResult = -2.toBigInt.pow(64 - 1);

        final source = Source('0x0000000000000080');
        final computedValue = source.i64();

        expect(computedValue, expectedResult);
      });

      // highest acceptable possible
      test(
          'When Source(\'0xffffffffffffff7f\').i64() is executed, then it should return result: 9223372036854775807.',
          () {
        final expectedResult = 2.toBigInt.pow(64 - 1) - 1.toBigInt;

        final source = Source('0xffffffffffffff7f');
        final computedValue = source.i64();

        expect(computedValue, expectedResult);
      });
    }

    // i128
    {
      // lowest acceptable possible
      test(
          'When Source(\'0x00000000000000000000000000000080\').i128() is executed, then it should return result: -170141183460469231731687303715884105728.',
          () {
        final expectedResult = -2.toBigInt.pow(128 - 1);

        final source = Source('0x00000000000000000000000000000080');
        final computedValue = source.i128();

        expect(computedValue, expectedResult);
      });

      // highest acceptable possible
      test(
          'When Source(\'0xffffffffffffffffffffffffffffff7f\').i128() is executed, then it should return result: 170141183460469231731687303715884105727.',
          () {
        final expectedResult = 2.toBigInt.pow(128 - 1) - 1.toBigInt;

        final source = Source('0xffffffffffffffffffffffffffffff7f');
        final computedValue = source.i128();

        expect(computedValue, expectedResult);
      });
    }

    // i256
    {
      // lowest acceptable possible
      test(
          'When Source(\'0x0000000000000000000000000000000000000000000000000000000000000080\').i256() is executed, then it should return result: -57896044618658097711785492504343953926634992332820282019728792003956564819968.',
          () {
        final expectedResult = -2.toBigInt.pow(256 - 1);

        final source = Source(
            '0x0000000000000000000000000000000000000000000000000000000000000080');
        final computedValue = source.i256();

        expect(computedValue, expectedResult);
      });

      // highest acceptable possible
      test(
          'When Source(\'0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f\').i256() is executed, then it should return result: 57896044618658097711785492504343953926634992332820282019728792003956564819967.',
          () {
        final expectedResult = 2.toBigInt.pow(256 - 1) - 1.toBigInt;

        final source = Source(
            '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff7f');
        final computedValue = source.i256();

        expect(computedValue, expectedResult);
      });
    }

    // Bool
    // true
    test(
        'When Source(\'0x01\').boolean() is executed, then it should return result: true.',
        () {
      final expectedResult = true;

      final source = Source('0x01');
      final computedValue = source.boolean();

      expect(computedValue, expectedResult);
    });
    // false
    test(
        'When Source(\'0x00\').boolean() is executed, then it should return result: false.',
        () {
      final expectedResult = false;

      final source = Source('0x00');
      final computedValue = source.boolean();

      expect(computedValue, expectedResult);
    });

    test(
        'When Source(\'0x985468697320697320706f6c6b61646172745f7363616c655f636f64656320f09f94a5f09f9a80\').str() is executed, then it should return result: \'This is polkadart_scale_codec 🔥🚀\'',
        () {
      final expectedResult = 'This is polkadart_scale_codec 🔥🚀';

      final source = Source(
          '0x985468697320697320706f6c6b61646172745f7363616c655f636f64656320f09f94a5f09f9a80');
      final computedValue = source.str();

      expect(computedValue, expectedResult);
    });
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
