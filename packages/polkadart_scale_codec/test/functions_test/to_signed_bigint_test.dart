import 'package:polkadart_scale_codec/src/util/utils.dart';
import 'package:test/test.dart';

void main() {
  {
    group('Signed BigInt 64 bit:', () {
      test(
          'Given the lowest supported value, it should be converted to string.',
          () {
        final lowestValue = '-9223372036854775808';

        final expectedConvertedValue = '-9223372036854775808';

        final actualConvertedValue = toSignedBigInt(lowestValue, 64).toString();

        expect(actualConvertedValue, equals(expectedConvertedValue));
      });
      test(
          'Given the highest supported value, it should be converted to string.',
          () {
        final highestValue = '9223372036854775807';

        final expectedConvertedValue = '9223372036854775807';

        final actualConvertedValue =
            toSignedBigInt(highestValue, 64).toString();

        expect(actualConvertedValue, equals(expectedConvertedValue));
      });
    });

    group('Signed BigInt 128 bit:', () {
      test(
          'Given the lowest supported value, it should be converted to string.',
          () {
        final lowestValue = '-170141183460469231731687303715884105728';

        final expectedConvertedValue =
            '-170141183460469231731687303715884105728';

        final actualConvertedValue =
            toSignedBigInt(lowestValue, 128).toString();

        expect(actualConvertedValue, equals(expectedConvertedValue));
      });
      test(
          'Given the highest supported value, it should be converted to string.',
          () {
        final highestValue = '170141183460469231731687303715884105727';

        final expectedConvertedValue =
            '170141183460469231731687303715884105727';

        final actualConvertedValue =
            toSignedBigInt(highestValue, 128).toString();

        expect(actualConvertedValue, equals(expectedConvertedValue));
      });
    });

    group('Signed BigInt 256 bit:', () {
      test(
          'Given the lowest supported value, it should be converted to string.',
          () {
        final lowestValue =
            '-57896044618658097711785492504343953926634992332820282019728792003956564819968';

        final expectedConvertedValue =
            '-57896044618658097711785492504343953926634992332820282019728792003956564819968';

        final actualConvertedValue =
            toSignedBigInt(lowestValue, 256).toString();

        expect(actualConvertedValue, equals(expectedConvertedValue));
      });
      test(
          'Given the highest supported value, it should be converted to string.',
          () {
        final highestValue =
            '57896044618658097711785492504343953926634992332820282019728792003956564819967';

        final expectedConvertedValue =
            '57896044618658097711785492504343953926634992332820282019728792003956564819967';

        final actualConvertedValue =
            toSignedBigInt(highestValue, 256).toString();

        expect(actualConvertedValue, equals(expectedConvertedValue));
      });
    });
  }

  {
    group('Throws Exception on Signed 64 bit:', () {
      test('When value is lowest - 1, it will throw \'InvalidSizeException\'.',
          () {
        final bitsize = 64;
        final value = '-9223372036854775809';

        expect(() => toSignedBigInt(value, bitsize),
            throwsA(isA<InvalidSizeException>()));
      });
      test('When value is highest + 1, it will throw \'InvalidSizeException\'.',
          () {
        final bitsize = 64;
        final value = '9223372036854775808';

        expect(() => toSignedBigInt(value, bitsize),
            throwsA(isA<InvalidSizeException>()));
      });
    });

    group('Throws Exception on Signed 128 bit:', () {
      test('When value is lowest - 1, it will throw \'InvalidSizeException\'.',
          () {
        final bitsize = 128;
        final value = '-170141183460469231731687303715884105729';

        expect(() => toSignedBigInt(value, bitsize),
            throwsA(isA<InvalidSizeException>()));
      });

      test('When value is highest + 1, it will throw \'InvalidSizeException\'.',
          () {
        final bitsize = 128;
        final value = '170141183460469231731687303715884105728';

        expect(() => toSignedBigInt(value, bitsize),
            throwsA(isA<InvalidSizeException>()));
      });
    });

    group('Throws Exception on Signed 256 bit:', () {
      test('When value is lowest - 1, it will throw \'InvalidSizeException\'.',
          () {
        final bitsize = 256;
        final value =
            '-57896044618658097711785492504343953926634992332820282019728792003956564819969';

        expect(() => toSignedBigInt(value, bitsize),
            throwsA(isA<InvalidSizeException>()));
      });
      test('When value is highest + 1, it will throw \'InvalidSizeException\'.',
          () {
        final bitsize = 256;
        final value =
            '57896044618658097711785492504343953926634992332820282019728792003956564819968';

        expect(() => toSignedBigInt(value, bitsize),
            throwsA(isA<InvalidSizeException>()));
      });
    });
  }

  {
    group('UnexpectedTypeException', () {
      test(
          'When value of type BigInt is passed to toSignedBigInt, it will throw \'UnexpectedTypeException\'.',
          () {
        final bitsize = 64;
        final value = BigInt.from(429496726);

        expect(() => toSignedBigInt(value, bitsize),
            throwsA(isA<UnexpectedTypeException>()));
      });
    });
  }

  {
    group('UnexpectedCaseException', () {
      test(
          'When unknown Bit-size: 20 is passed to toSignedBigInt, it will throw \'UnexpectedCaseException\'.',
          () {
        final bitsize = 20;
        final value = 200;

        expect(() => toSignedBigInt(value, bitsize),
            throwsA(isA<UnexpectedCaseException>()));
      });
    });
  }
}
