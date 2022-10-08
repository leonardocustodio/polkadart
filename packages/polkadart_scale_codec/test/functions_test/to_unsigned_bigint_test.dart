import 'package:polkadart_scale_codec/src/util/utils.dart';
import 'package:test/test.dart';

void main() {
  {
    group('Unsigned BigInt 64 bit:', () {
      test(
          'Given the lowest supported value, it should be converted to string.',
          () {
        final lowestValue = 0;

        final expectedConvertedValue = 0;

        final actualConvertedValue = toUnsignedBigInt(lowestValue, 64).toInt();

        expect(actualConvertedValue, equals(expectedConvertedValue));
      });
      test(
          'Given the highest supported value, it should be converted to string.',
          () {
        final highestValue = '18446744073709551615';

        final expectedConvertedValue = '18446744073709551615';

        final actualConvertedValue =
            toUnsignedBigInt(highestValue, 64).toString();

        expect(actualConvertedValue, equals(expectedConvertedValue));
      });
    });

    group('Unsigned BigInt 128 bit:', () {
      test(
          'Given the lowest supported value, it should be converted to string.',
          () {
        final lowestValue = 0;

        final expectedConvertedValue = 0;

        final actualConvertedValue = toUnsignedBigInt(lowestValue, 128).toInt();

        expect(actualConvertedValue, equals(expectedConvertedValue));
      });
      test(
          'Given the highest supported value, it should be converted to string.',
          () {
        final highestValue = '340282366920938463463374607431768211455';

        final expectedConvertedValue =
            '340282366920938463463374607431768211455';

        final actualConvertedValue =
            toUnsignedBigInt(highestValue, 128).toString();

        expect(actualConvertedValue, equals(expectedConvertedValue));
      });
    });

    group('Unsigned BigInt 256 bit:', () {
      test(
          'Given the lowest supported value, it should be converted to string.',
          () {
        final lowestValue = 0;

        final expectedConvertedValue = 0;

        final actualConvertedValue = toUnsignedBigInt(lowestValue, 256).toInt();

        expect(actualConvertedValue, equals(expectedConvertedValue));
      });
      test(
          'Given the highest supported value, it should be converted to string.',
          () {
        final highestValue =
            '115792089237316195423570985008687907853269984665640564039457584007913129639935';

        final expectedConvertedValue =
            '115792089237316195423570985008687907853269984665640564039457584007913129639935';

        final actualConvertedValue =
            toUnsignedBigInt(highestValue, 256).toString();

        expect(actualConvertedValue, equals(expectedConvertedValue));
      });
    });
  }

  {
    group('Throws Exception on Unsigned 64 bit:', () {
      test(
          'When value is lowest - 1 then, it will throw \'InvalidSizeException\'.',
          () {
        final bitsize = 64;
        final value = -1;

        expect(() => toUnsignedBigInt(value, bitsize),
            throwsA(isA<InvalidSizeException>()));
      });
      test(
          'When value is highest + 1 then, it will throw \'InvalidSizeException\'.',
          () {
        final bitsize = 64;
        final value = '18446744073709551616';

        expect(() => toUnsignedBigInt(value, bitsize),
            throwsA(isA<InvalidSizeException>()));
      });
    });

    group('Throws Exception on Unsigned 128 bit:', () {
      test(
          'When value is lowest - 1 then, it will throw \'InvalidSizeException\'.',
          () {
        final bitsize = 128;
        final value = -1;

        expect(() => toUnsignedBigInt(value, bitsize),
            throwsA(isA<InvalidSizeException>()));
      });
      test(
          'When value is highest + 1 then, it will throw \'InvalidSizeException\'.',
          () {
        final bitsize = 128;
        final value = '340282366920938463463374607431768211456';

        expect(() => toUnsignedBigInt(value, bitsize),
            throwsA(isA<InvalidSizeException>()));
      });
    });

    group('Throws Exception on Unsigned 256 bit:', () {
      test(
          'When value is lowest - 1 then, it will throw \'InvalidSizeException\'.',
          () {
        final bitsize = 256;
        final value = -1;

        expect(() => toUnsignedBigInt(value, bitsize),
            throwsA(isA<InvalidSizeException>()));
      });
      test(
          'When value is highest + 1 then, it will throw \'InvalidSizeException\'.',
          () {
        final bitsize = 256;
        final value =
            '115792089237316195423570985008687907853269984665640564039457584007913129639936';

        expect(() => toUnsignedBigInt(value, bitsize),
            throwsA(isA<InvalidSizeException>()));
      });
    });
  }

  {
    group('UnexpectedTypeException', () {
      test(
          'When value of type BigInt is provided to toUnsignedBigInt, then it will throw \'UnexpectedTypeException\'.',
          () {
        final bitsize = 64;
        final value = BigInt.parse('57896045664819967');

        expect(() => toUnsignedBigInt(value, bitsize),
            throwsA(isA<UnexpectedTypeException>()));
      });
    });
  }

  {
    group('UnexpectedCaseException', () {
      test(
          'When unknown bit-size: 20 is passed to: toUnsignedBigInt, it will throw \'UnexpectedCaseException\'.',
          () {
        final bitsize = 20;
        final value = 200;

        expect(() => toUnsignedBigInt(value, bitsize),
            throwsA(isA<UnexpectedCaseException>()));
      });
    });
  }
}
