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
        final registry = OldTypeRegistry();

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
        final registry = OldTypeRegistry();

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
        final registry = OldTypeRegistry();

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
  final registry = OldTypeRegistry(
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
    // Compact<u8>
    group('Encode Compact<u8>:', () {
      test('0 when compacted must return \'0x00\'', () {
        final compacted =
            codec.encodeToHex(registry.getIndex('Compact<u8>'), 0);
        expect('0x00', equals(compacted));
      });
      test('256 when compacted must return \'0x0104\'', () {
        final compacted =
            codec.encodeToHex(registry.getIndex('Compact<u8>'), 256);
        expect('0x0104', equals(compacted));
      });
    });

    //
    // Compact<u16>
    group('Encode Compact<u16>:', () {
      test('\'pow(2, 16) - 1\' when compacted must return \'0x02000400\'', () {
        final compacted = codec.encodeToHex(
            registry.getIndex('Compact<u16>'), pow(2, 16) - 1);
        expect('0xfeff0300', equals(compacted));
      });
    });

    //
    // Compact<u32>
    group('Encode Compact<u32>:', () {
      test('\'pow(2, 32) - 1\' when compacted must return \'0x03ffffffff\'',
          () {
        final compacted = codec.encodeToHex(
            registry.getIndex('Compact<u32>'), pow(2, 32) - 1);
        expect('0x03ffffffff', equals(compacted));
      });
    });

    //
    // Compact<u64>
    group('Encode Compact<u64>:', () {
      test(
          'BigInt.from(2).pow(64) - BigInt.from(1) when compacted must return \'0x13ffffffffffffffff\'',
          () {
        final compacted = codec.encodeToHex(registry.getIndex('Compact<u64>'),
            BigInt.from(2).pow(64) - BigInt.from(1));
        expect('0x13ffffffffffffffff', equals(compacted));
      });
    });

    //
    // Compact<u128>
    group('Encode/Decode Compact<u128>:', () {
      test(
          'BigInt.from(2).pow(128) - BigInt.from(1) when compacted must return \'0x33ffffffffffffffffffffffffffffffff\'',
          () {
        final compacted = codec.encodeToHex(registry.getIndex('Compact<u128>'),
            BigInt.from(2).pow(128) - BigInt.from(1));
        expect('0x33ffffffffffffffffffffffffffffffff', equals(compacted));
      });
    });

    //
    // Compact<u256>
    group('Encode Compact<u256>:', () {
      test(
          'BigInt.from(2).pow(256) - BigInt.from(1) when compacted must return \'0x73ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff\'',
          () {
        final compacted = codec.encodeToHex(registry.getIndex('Compact<u256>'),
            BigInt.from(2).pow(256) - BigInt.from(1));
        expect(
            '0x73ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
            equals(compacted));
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
            () => codec.encodeToHex(registry.getIndex('Compact<u8>'), -1),
            throwsA(predicate((e) =>
                e is InvalidCompactException &&
                e.toString() == exceptionMessage)));
      });

      // Invalid BigInt compacting
      test(
          'should throw \'InvalidCompactException\' when encoding BigInt.from(-1) with Compact<u8>',
          () {
        final exceptionMessage = 'Value can\'t be less than 0.';
        expect(
            () => codec.encodeToHex(
                registry.getIndex('Compact<u8>'), BigInt.from(-1)),
            throwsA(predicate((e) =>
                e is InvalidCompactException &&
                e.toString() == exceptionMessage)));
      });

      // Invalid Type Compacting
      test(
          'should throw \'InvalidCompactException\' when encoding \'A\' with Compact<u8>',
          () {
        final exceptionMessage =
            'Expected `int` or `BigInt`, but found String.';
        expect(
            () => codec.encodeToHex(registry.getIndex('Compact<u8>'), 'A'),
            throwsA(predicate((e) =>
                e is UnexpectedTypeException &&
                e.toString() == exceptionMessage)));
      });

      // Exceeding BigInt Compacting value range: 2 ** 536
      test(
          'should throw \'InvalidCompactException\' when encoding BigInt.from(2).pow(536) with Compact<u8>',
          () {
        final BigInt invalidValue = BigInt.from(2).pow(536);
        final exceptionMessage =
            '${invalidValue.toRadixString(16)} is too large for a compact.';
        expect(
            () => codec.encodeToHex(
                registry.getIndex('Compact<u8>'), invalidValue),
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
        final exceptionMessage =
            '${invalidValue.toRadixString(16)} is too large for a compact.';
        expect(
            () => codec.encodeToHex(
                registry.getIndex('Compact<u8>'), invalidValue),
            throwsA(predicate((e) =>
                e is IncompatibleCompactException &&
                e.toString() == exceptionMessage)));
      });
    });
  }
}
