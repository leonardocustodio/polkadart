import 'dart:math';

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  {
    // Unexpected case: TypeKind.Sequence.
    //
    // We can't compact `Vector` so it should throw `Exception`.
    group('Compact Exception', () {
      test(
          'On using Compact<Vec<u8>> as Types then Codec initialization should throw UnexpectedCaseException',
          () {
        final registry = TypeRegistry();

        // specifying which schema type to use.
        registry.select('Compact<Vec<u8>>');

        // fetching the parsed types from `Json` to `Type`
        final types = registry.getTypes();

        // Invalid Case Exception
        expect(
            () => Codec(types),
            throwsA(predicate((e) =>
                e is UnexpectedCaseException &&
                e.toString() == 'Unexpected TypeKind: TypeKind.Sequence.')));
      });
      test(
          'On using Compact<i8> as Types then Codec initialization should throw AssertionException',
          () {
        final registry = TypeRegistry();

        // specifying which schema type to use.
        registry.select('Compact<i8>');

        // fetching the parsed types from `Json` to `Type`
        final types = registry.getTypes();

        // Invalid Case Exception
        expect(
            () => Codec(types),
            throwsA(predicate((e) =>
                e is AssertionException &&
                e.toString() == 'Assertion Error occured.')));
      });

      test(
          'On using Compact<i16> as Types then Codec initialization should throw \'AssertionException\'',
          () {
        final registry = TypeRegistry();

        // specifying which schema type to use.
        registry.select('Compact<i16>');

        // fetching the parsed types from `Json` to `Type`
        final types = registry.getTypes();

        // Invalid Case Exception
        expect(
            () => Codec(types),
            throwsA(predicate((e) =>
                e is AssertionException &&
                e.toString() == 'Assertion Error occured.')));
      });
    });
  }

  // Creates the registry for parsing the types and selecting particular schema.
  final registry = TypeRegistry(
    types: <String, dynamic>{
      'Codec': {
        'a': 'Compact<u8>',
        'b': 'Compact<u16>',
        'c': 'Compact<u32>',
        'd': 'Compact<u64>',
        'e': 'Compact<u128>',
        'f': 'Compact<u256>',
      },
    },
  );

  // specifying which schema type to use.
  registry.select('Codec');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);

  {
    //
    // Encode Compact<u8>
    group('Encode Compact<u8>:', () {
      test('0 when encoded must return \'0x00\'', () {
        final encoded = codec.encode(registry.getIndex('Compact<u8>'), 0);
        expect('0x00', equals(encoded));
      });
      test('256 when encoded must return \'0x0104\'', () {
        final encoded = codec.encode(registry.getIndex('Compact<u8>'), 256);
        expect('0x0104', equals(encoded));
      });
    });

    //
    // Encode Compact<u16>
    group('Encode Compact<u16>:', () {
      test('\'pow(2, 16) - 1\' when encoded must return \'0xfeff0300\'', () {
        final encoded =
            codec.encode(registry.getIndex('Compact<u16>'), pow(2, 16) - 1);
        expect('0xfeff0300', equals(encoded));
      });
    });

    //
    // Encode Compact<u32>
    group('Encode Compact<u32>:', () {
      test('\'pow(2, 32) - 1\' when encoded must return \'0x03ffffffff\'', () {
        final encoded =
            codec.encode(registry.getIndex('Compact<u32>'), pow(2, 32) - 1);
        expect('0x03ffffffff', equals(encoded));
      });
    });

    //
    // Encode Compact<u64>
    group('Encode Compact<u64>:', () {
      test(
          '\'BigInt.from(2).pow(64) - BigInt.from(1)\' when encoded must return \'0x13ffffffffffffffff\'',
          () {
        final encoded = codec.encode(registry.getIndex('Compact<u64>'),
            BigInt.from(2).pow(64) - BigInt.from(1));
        expect('0x13ffffffffffffffff', equals(encoded));
      });
    });

    //
    // Encode Compact<u128>
    group('Encode Compact<u128>:', () {
      test(
          '\'BigInt.from(2).pow(128) - BigInt.from(1)\' when encoded must return \'0x33ffffffffffffffffffffffffffffffff\'',
          () {
        final encoded = codec.encode(registry.getIndex('Compact<u128>'),
            BigInt.from(2).pow(128) - BigInt.from(1));
        expect('0x33ffffffffffffffffffffffffffffffff', equals(encoded));
      });
    });

    //
    // Encode Compact<u256>
    group('Encode Compact<u256>:', () {
      test(
          '\'BigInt.from(2).pow(256) - BigInt.from(1)\' when encoded must return \'0x73ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff\'',
          () {
        final encoded = codec.encode(registry.getIndex('Compact<u256>'),
            BigInt.from(2).pow(256) - BigInt.from(1));
        expect(
            '0x73ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
            equals(encoded));
      });
    });
  }

  {
    //
    // Decode Compact<u8>
    group('Decode Compact<u8>:', () {
      test('\'0x00\' when decoded must return 0', () {
        final decoded = codec.decode(registry.getIndex('Compact<u8>'), '0x00');
        expect(0, equals(decoded));
      });
      test('\'0x0104\' when decoded must return 256', () {
        final decoded =
            codec.decode(registry.getIndex('Compact<u8>'), '0x0104');
        expect(256, equals(decoded));
      });
    });

    //
    // Decode Compact<u16>
    group('Decode Compact<u16>:', () {
      test('\'0xfeff0300\' when decoded must return \'pow(2, 16) - 1\'', () {
        final actualValue = pow(2, 16) - 1;
        final decoded =
            codec.decode(registry.getIndex('Compact<u8>'), '0xfeff0300');
        expect(actualValue, equals(decoded));
      });
    });

    //
    // Decode Compact<u32>
    group('Decode Compact<u32>:', () {
      test('\'0x03ffffffff\' when decoded must return \'pow(2, 32) - 1\'', () {
        final actualValue = pow(2, 32) - 1;
        final decoded =
            codec.decode(registry.getIndex('Compact<u32>'), '0x03ffffffff');
        expect(actualValue, equals(decoded));
      });
    });

    //
    // Decode Compact<u64>
    group('Decode Compact<u64>:', () {
      test(
          '\'0x13ffffffffffffffff\' when decoded must return \'BigInt.from(2).pow(64) - BigInt.from(1)\'',
          () {
        final actualValue = BigInt.from(2).pow(64) - BigInt.from(1);
        final decoded = codec.decode(
            registry.getIndex('Compact<u64>'), '0x13ffffffffffffffff');
        expect(actualValue, equals(decoded));
      });
    });

    //
    // Decode Compact<u128>
    group('Decode Compact<u128>:', () {
      test(
          '\'0x33ffffffffffffffffffffffffffffffff\' when decoded must return \'BigInt.from(2).pow(128) - BigInt.from(1)\'',
          () {
        final actualValue = BigInt.from(2).pow(128) - BigInt.from(1);
        final decoded = codec.decode(registry.getIndex('Compact<u128>'),
            '0x33ffffffffffffffffffffffffffffffff');
        expect(actualValue, equals(decoded));
      });
    });

    //
    // Decode Compact<u256>
    group('Decode Compact<u256>:', () {
      test(
          '\'0x73ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff\' when decoded must return \'BigInt.from(2).pow(256) - BigInt.from(1)\'',
          () {
        final actualValue = BigInt.from(2).pow(256) - BigInt.from(1);
        final decoded = codec.decode(registry.getIndex('Compact<u256>'),
            '0x73ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff');
        expect(actualValue, equals(decoded));
      });
    });
  }

  //
  //
  //Exceptions Testing
  //
  //
  {
    // Testing Compact exception
    group('Compact Exception Testing', () {
      // Invalid int compacting
      test(
          'should throw \'InvalidCompactException\' when encoding -1 with Compact<u8>',
          () {
        final exceptionMessage = 'Value can\'t be less than 0.';
        expect(
            () => codec.encode(registry.getIndex('Compact<u8>'), -1),
            throwsA(predicate((e) =>
                e is IncompatibleCompactException &&
                e.toString() == exceptionMessage)));
      });

      // Invalid BigInt compacting
      test(
          'should throw \'InvalidCompactException\' when encoding BigInt.from(-1) with Compact<u8>',
          () {
        final exceptionMessage = 'Value can\'t be less than 0.';
        expect(
            () =>
                codec.encode(registry.getIndex('Compact<u8>'), BigInt.from(-1)),
            throwsA(predicate((e) =>
                e is IncompatibleCompactException &&
                e.toString() == exceptionMessage)));
      });

      // Invalid Type Compacting
      test(
          'should throw \'InvalidCompactException\' when encoding \'A\' with Compact<u8>',
          () {
        expect(() => codec.encode(registry.getIndex('Compact<u8>'), 'A'),
            throwsA(isA<UnexpectedTypeException>()));
      });

      // Exceeding BigInt Compacting value range: 2 ** 536
      test(
          'should throw \'InvalidCompactException\' when encoding BigInt.from(2).pow(536) with Compact<u8>',
          () {
        final BigInt invalidValue = BigInt.from(2).pow(536);
        final exceptionMessage = '$invalidValue is too large for a compact.';
        expect(
            () => codec.encode(registry.getIndex('Compact<u8>'), invalidValue),
            throwsA(predicate((e) =>
                e is IncompatibleCompactException &&
                e.toString() == exceptionMessage)));
      });

      // Exceeding int Compacting value range: 2 ** 536
      test(
          'should throw \'InvalidCompactException\' when encoding pow(2,536) with Compact<u8>',
          () {
        // Using help of BigInt to calculate 2 ^ (536) as BigInt and then converting to int.
        // as normal pow(2, 536) returns 0.
        final int invalidValue = BigInt.from(2).pow(536).toInt();
        final exceptionMessage = '$invalidValue is too large for a compact.';
        expect(
            () => codec.encode(registry.getIndex('Compact<u8>'), invalidValue),
            throwsA(predicate((e) =>
                e is IncompatibleCompactException &&
                e.toString() == exceptionMessage)));
      });
    });
  }
}
