import 'dart:math';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  final registry = OldTypeRegistry(
    types: <String, dynamic>{
      'Codec': {
        'vec_u8': 'Vec<u8>',
        'option_u8': 'Option<u8>',
        'DoNotConstruct': 'DoNotConstruct',
        'primitive_char': 'char',
        'primitive__compact_u8': 'Compact<u8>',
        'primitive_i8': 'i8',
        'primitive_i16': 'i16',
        'primitive_i32': 'i32',
        'primitive_i64': 'i64',
        'primitive_i128': 'i128',
        'primitive_i256': 'i256',
        'primitive_u8': 'u8',
        'primitive_u16': 'u16',
        'primitive_u32': 'u32',
        'primitive_u64': 'u64',
        'primitive_u128': 'u128',
        'primitive_u256': 'u256',
      },
    },
  );
  registry.select('Codec');
  final types = registry.getTypes();
  final codec = Codec(types);

  {
    //
    // Expect Exception when decoding list and list type is not `List<int> or Uint8List`
    // or
    // when the list is empty.
    //
    group('Exception Vec:', () {
      test('List<int> is empty', () {
        expect(
            () => codec.decodeBinary(registry.getIndex('Vec<u8>'), <int>[]),
            throwsA(predicate((e) =>
                e is EOFException && e.toString() == 'Unexpected EOF.')));
      });
      test('List<dynamic>', () {
        expect(
            () => codec.decodeBinary(registry.getIndex('Vec<u8>'), []),
            throwsA(predicate((e) =>
                e is AssertionException &&
                e.toString() ==
                    'Source(data) -> `data` should be either String, List<int> or Uint8List.')));
      });
    });
  }

  {
    //
    // Exception when setting Option Flag to greator than `1`.
    //
    // Option flag can be `0` or `1`.
    //
    group('Exception Option:', () {
      test('Flag at 2', () {
        expect(
            () => codec.decodeBinary(registry.getIndex('Option<u8>'), '0x0208'),
            throwsA(predicate((e) =>
                e is UnexpectedCaseException &&
                e.toString() == 'Unexpcted byte: 2.')));
      });
      test('Flag at 3', () {
        expect(
            () => codec.decodeBinary(registry.getIndex('Option<u8>'), '0x0308'),
            throwsA(predicate((e) =>
                e is UnexpectedCaseException &&
                e.toString() == 'Unexpcted byte: 3.')));
      });
      test('Flag at 4', () {
        expect(
            () => codec.decodeBinary(
                registry.getIndex('Option<u8>'), '0x04015231'),
            throwsA(predicate((e) =>
                e is UnexpectedCaseException &&
                e.toString() == 'Unexpcted byte: 4.')));
      });
    });
  }

  {
    // Primitive (usigned / signed) (2, 16, 32) type encode / decode
    group('Encode/Decode Primitive:', () {
      for (var bit in ['i', 'u']) {
        var multiplier = bit == 'i' ? -1 : 0;
        for (var size in [8, 16, 32]) {
          // concates i with 8 and so on
          // i + (8 | 16 | 32)  -> i8 || i16 || i32
          // u + (8 | 16 | 32)  -> u8 || u16 || u32
          //
          var bitSize = '$bit$size';
          test(bitSize, () {
            // 2 ** (8 || 16 || 32)
            var poweredValue = pow(2, size - 1);

            // lowest accepted value
            var lowest = multiplier * poweredValue;

            var encodedLow =
                codec.encodeToHex(registry.getIndex(bitSize), lowest);
            var decodedLow =
                codec.decodeBinary(registry.getIndex(bitSize), encodedLow);

            expect(lowest, equals(decodedLow));

            // highest accepted value
            var highest = poweredValue - 1;

            var encodedHigh =
                codec.encodeToHex(registry.getIndex(bitSize), highest);
            var decodedHigh =
                codec.decodeBinary(registry.getIndex(bitSize), encodedHigh);

            expect(highest, equals(decodedHigh));
          });
        }
      }
    });
  }

  {
    //
    // Testing exceptions when the signed and unsigned can't hold values out of boundaries.
    //
    // Testing with values ver `first lowest negative value` which throws exception and with `very first highest positive value` to cause exception.
    //
    group('Exception Value out of bounds Primitive:', () {
      for (var bit in ['i', 'u']) {
        var multiplier = bit == 'i' ? -1 : 0;
        for (var size in [8, 16, 32]) {
          // concates i with 8 and so on
          // i + (8 | 16 | 32)  -> i8 || i16 || i32
          // u + (8 | 16 | 32)  -> u8 || u16 || u32
          //
          var bitSize = '$bit$size';
          test(bitSize.toUpperCase(), () {
            // 2 ** (8 || 16 || 32)
            var poweredValue = pow(2, size - 1);

            var lowest = (multiplier * poweredValue) - 1;

            expect(
                () => codec.encodeToHex(registry.getIndex(bitSize), lowest),
                throwsA(predicate((e) =>
                    e is InvalidSizeException &&
                    e.toString() ==
                        'Invalid ${bitSize.toUpperCase()}: $lowest')));

            var highest = poweredValue * (bit == 'u' ? 2 : 1);

            expect(
                () => codec.encodeToHex(registry.getIndex(bitSize), highest),
                throwsA(predicate((e) =>
                    e is InvalidSizeException &&
                    e.toString() ==
                        'Invalid ${bitSize.toUpperCase()}: $highest')));
          });
        }
      }
    });
  }

  {
    //
    // Needed to be BigInt but we're forcing exception with u64, u128, u256
    //
    group('UnexpectedCase Exception Unsigned:', () {
      for (var size in [64, 128, 256]) {
        test('Unknown Unsigned Bit-size: u$size', () {
          expect(
              () => checkUnsignedInt(1, size),
              throwsA(predicate((e) =>
                  e is UnexpectedCaseException &&
                  e.toString() == 'Unexpected BitSize: $size.')));
        });
      }
    });
  }

  {
    //
    // Needed to be BigInt but we're forcing exception with i64, i128, i256
    //
    group('UnexpectedCase Exception Signed:', () {
      for (var size in [64, 128, 256]) {
        test('Unknown Signed Bit-size: i$size', () {
          expect(
              () => checkSignedInt(1, size),
              throwsA(predicate((e) =>
                  e is UnexpectedCaseException &&
                  e.toString() == 'Unexpected BitSize: $size.')));
        });
      }
    });
  }

  {
    //
    // Exception checking at DoNotConstruct
    //
    group('Exception at DoNotConstruct:', () {
      test('Encode', () {
        expect(
            () => codec.encodeToHex(registry.getIndex('DoNotConstruct'), 'A'),
            throwsA(predicate((e) =>
                e is UnexpectedCaseException &&
                e.toString() ==
                    'Unexpected TypeKind: TypeKind.DoNotConstruct.')));
      });
      test('Decode', () {
        expect(
            () =>
                codec.decodeBinary(registry.getIndex('DoNotConstruct'), '0x01'),
            throwsA(predicate((e) =>
                e is UnexpectedCaseException &&
                e.toString() ==
                    'Unexpected TypeKind: TypeKind.DoNotConstruct.')));
      });
    });
  }

  {
    //
    // Exception checking at Primitive.Char
    //
    group('Exception at Primitive.Char:', () {
      test('Encode', () {
        expect(
            () => codec.encodeToHex(registry.getIndex('char'), 'A'),
            throwsA(predicate((e) =>
                e is UnexpectedCaseException &&
                e.toString() == 'Unexpected PrimitiveType: Primitive.Char.')));
      });
      test('Decode', () {
        expect(
            () => codec.decodeBinary(registry.getIndex('char'), '0x01'),
            throwsA(predicate((e) =>
                e is UnexpectedCaseException &&
                e.toString() == 'Unexpected PrimitiveType: Primitive.Char.')));
      });
    });
  }

  {
    //
    // Exceptions expected in case scenario of wrong bit sizes
    //

    //
    // Here we are testing random bit sizes and checking if it passes from unsigned and signed or not ?
    //
    group('Bit Size checking', () {
      var randomBits = [1, 30, 88, 100];
      for (var bitSize in randomBits) {
        test('Unexpected Case Exception at $bitSize bit', () {
          expect(
              () => toSignedBigInt('1', bitSize),
              throwsA(predicate((e) =>
                  e is UnexpectedCaseException &&
                  e.toString() == 'Unexpected BitSize: $bitSize.')));
          expect(
              () => toUnsignedBigInt('1', bitSize),
              throwsA(predicate((e) =>
                  e is UnexpectedCaseException &&
                  e.toString() == 'Unexpected BitSize: $bitSize.')));
        });
      }
    });
  }

  {
    //
    // Testing Compact exception
    //
    group('Compact Exception', () {
      test('Encode Compact<u8>', () {
        //
        // Invalid int compacting
        //
        expect(
            () => codec.encodeToHex(registry.getIndex('Compact<u8>'), -1),
            throwsA(predicate((e) =>
                e is InvalidCompactException &&
                e.toString() == 'Value can\'t be less than 0.')));

        //
        // Invalid BigInt compacting
        //
        expect(
            () => codec.encodeToHex(
                registry.getIndex('Compact<u8>'), BigInt.from(-1)),
            throwsA(predicate((e) =>
                e is InvalidCompactException &&
                e.toString() == 'Value can\'t be less than 0.')));

        //
        // Invalid Type Compacting
        //
        expect(
            () => codec.encodeToHex(registry.getIndex('Compact<u8>'), 'A'),
            throwsA(predicate((e) =>
                e is UnexpectedTypeException &&
                e.toString() ==
                    'Expected `int` or `BigInt`, but found String.')));

        //
        // Exceeding BigInt Compacting value range: 2 ** 536
        //
        BigInt invalidValue = 2.toBigInt.pow(536.toBigInt.toInt());
        expect(
            () => codec.encodeToHex(
                registry.getIndex('Compact<u8>'), invalidValue),
            throwsA(predicate((e) =>
                e is IncompatibleCompactException &&
                e.toString() ==
                    '${invalidValue.toRadixString(16)} is too large for a compact')));

        //
        // Exceeding int Compacting value range: 2 ** 536
        //
        expect(
            () => codec.encodeToHex(
                registry.getIndex('Compact<u8>'), invalidValue.toInt()),
            throwsA(predicate((e) =>
                e is IncompatibleCompactException &&
                e.toString() ==
                    '${invalidValue.toInt().toRadixString(16)} is too large for a compact')));
      });
    });
  }
  {
    //
    // Primitive Unsigned (64, 128, 256) type encode
    //
    group('Encode/Decode Primitive:', () {
      for (var bit in ['i', 'u']) {
        var multiplier = bit == 'i' ? -1.toBigInt : 0.toBigInt;
        for (var size in [64, 128, 256]) {
          // concates `i` or `u` with `size` and so on
          // i + (64 | 128 | 256)  -> i64 || i128 || i256
          // u + (64 | 128 | 256)  -> u64 || u128 || u256
          //
          var bitSize = '$bit$size';
          test(bitSize, () {
            // 2 ** (64 || 128 || 256)
            var poweredValue = calculateBigIntPow(2, size - 1);

            // lowest accepted value
            var lowest = multiplier * poweredValue;

            var encodedLow =
                codec.encodeToHex(registry.getIndex(bitSize), lowest);
            var decodedLow =
                codec.decodeBinary(registry.getIndex(bitSize), encodedLow);

            expect(lowest, equals(decodedLow));

            // highest accepted value
            var highest = poweredValue - 1.toBigInt;

            var encodedHigh =
                codec.encodeToHex(registry.getIndex(bitSize), highest);
            var decodedHigh =
                codec.decodeBinary(registry.getIndex(bitSize), encodedHigh);

            expect(highest, equals(decodedHigh));
          });
        }
      }
    });
  }
}
