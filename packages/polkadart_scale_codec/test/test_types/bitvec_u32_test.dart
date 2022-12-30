import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  //
  // Encodes type: `BitVec<u32, bitvec::order::Lsb0>`
  group('Encode BitVec<u32, bitvec::order::Lsb0>:', () {
    // Creates the registry for parsing the types
    final registry = TypeRegistry();

    // specifying which type to use.
    final usageIndex = registry.getIndex('BitVec<u32, bitvec::order::Lsb0>');

    // fetching the parsed types from `Json` to `Type`
    final types = registry.getTypes();
    test(
        'When \'[1, 1, 0, 1, 1]\' is encoded then result \'0x141b000000\' is produced',
        () {
      final encoded = Codec(types).encode(usageIndex, [1, 1, 0, 1, 1]);
      expect('0x141b000000', equals(encoded));
    });

    test(
        'When \'[1, 1, 0, 1, 1, 0]\' is encoded then result \'0x181b000000\' is produced',
        () {
      final encoded = Codec(types).encode(usageIndex, [1, 1, 0, 1, 1, 0]);
      expect('0x181b000000', equals(encoded));
    });

    test(
        'When \'[1, 1, 0, 1, 1, 0, 0]\' is encoded then result \'0x1c1b000000\' is produced',
        () {
      final encoded = Codec(types).encode(usageIndex, [1, 1, 0, 1, 1, 0, 0]);
      expect('0x1c1b000000', equals(encoded));
    });

    test(
        'When \'[1, 1, 1, 1, 1, 0, 1]\' is encoded then result \'0x1c5f000000\' is produced',
        () {
      final encoded = Codec(types).encode(usageIndex, [1, 1, 1, 1, 1, 0, 1]);
      expect('0x1c5f000000', equals(encoded));
    });

    test(
        'When \'[1, 1, 0, 1, 1, 0, 0, 0]\' is encoded then result \'0x201b000000\' is produced',
        () {
      final encoded = Codec(types).encode(usageIndex, [1, 1, 0, 1, 1, 0, 0, 0]);
      expect('0x201b000000', equals(encoded));
    });

    test(
        'When \'[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]\' is encoded then result \'0x4000000000\' is produced',
        () {
      final encoded = Codec(types)
          .encode(usageIndex, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
      expect('0x4000000000', equals(encoded));
    });
  });

  group('Decode BitVec<u32, bitvec::order::Lsb0>:', () {
    // Creates the registry for parsing the types
    final registry = TypeRegistry();

    // specifying which type to use.
    final usageIndex = registry.getIndex('BitVec<u32, bitvec::order::Lsb0>');

    // fetching the parsed types from `Json` to `Type`
    final types = registry.getTypes();
    test(
        'When \'0x141b000000\' is decoded then result \'[1, 1, 0, 1, 1]\' is produced',
        () {
      final decoded = Codec(types).decode(usageIndex, '0x141b000000');
      expect([1, 1, 0, 1, 1], equals(decoded));
    });

    test(
        'When \'0x181b000000\' is decoded then result \'[1, 1, 0, 1, 1, 0]\' is produced',
        () {
      final decoded = Codec(types).decode(usageIndex, '0x181b000000');
      expect([1, 1, 0, 1, 1, 0], equals(decoded));
    });

    test(
        'When \'0x1c1b000000\' is decoded then result \'[1, 1, 0, 1, 1, 0, 0]\' is produced',
        () {
      final decoded = Codec(types).decode(usageIndex, '0x1c1b000000');
      expect([1, 1, 0, 1, 1, 0, 0], equals(decoded));
    });

    test(
        'When \'0x1c5f000000\' is decoded then result \'[1, 1, 1, 1, 1, 0, 1]\' is produced',
        () {
      final decoded = Codec(types).decode(usageIndex, '0x1c5f000000');
      expect([1, 1, 1, 1, 1, 0, 1], equals(decoded));
    });

    test(
        'When \'0x201b000000\' is decoded then result \'[1, 1, 0, 1, 1, 0, 0, 0]\' is produced',
        () {
      final decoded = Codec(types).decode(usageIndex, '0x201b000000');
      expect([1, 1, 0, 1, 1, 0, 0, 0], equals(decoded));
    });

    test(
        'When \'0x4000000000\' is decoded then result \'[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]\' is produced',
        () {
      final decoded = Codec(types).decode(usageIndex, '0x4000000000');
      expect([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], equals(decoded));
    });
  });
  {
    // Creates the registry for parsing the types
    final registry = TypeRegistry();

    // specifying which type to use.
    final usageIndex = registry.getIndex('BitVec<u32, bitvec::order::Lsb0>');

    // fetching the parsed types from `Json` to `Type`
    final types = registry.getTypes();
    //
    // Exception on Encode at (lowest - 1) and (highest + 1): `BitVec<u32, bitvec::order::Lsb0>`
    group('Exception on Encode BitVec<u32, bitvec::order::Lsb0>:', () {
      test(
          'should throw exception \'UnexpectedCaseException\' when encoding [-1] which is 1 lesser than lowest acceptable.',
          () {
        expect(
            () => Codec(types).encode(usageIndex, [-1]),
            throwsA(predicate((e) =>
                e is UnexpectedCaseException &&
                e.toString() == 'Invalid byte, unable to encode [-1].')));
      });

      test(
          'should throw exception \'UnexpectedCaseException\' when encoding [256] which is 1 greater than highest acceptable.',
          () {
        expect(
            () => Codec(types).encode(usageIndex, [256]),
            throwsA(predicate((e) =>
                e is UnexpectedCaseException &&
                e.toString() == 'Invalid byte, unable to encode [256].')));
      });
    });

    //
    // Exception on Decode at wrong value type: `BitVec<u32, bitvec::order::Lsb0>`
    group('Exception on Decode BitVec<u32, bitvec::order::Lsb0>:', () {
      test(
          'On decoding \'integer\' value should throw exception \'AssertionException\' for BitVec<u32, bitvec::order::Lsb0>',
          () {
        final exceptionMessage =
            'Source(data) -> `data` should be either String, List<int> or Uint8List.';
        expect(
            () => Codec(types).decode(usageIndex, 0),
            throwsA(predicate((e) =>
                e is AssertionException && e.toString() == exceptionMessage)));
      });

      test(
          'On decoding \'double\' should throw exception \'AssertionException\' for BitVec<u32, bitvec::order::Lsb0>',
          () {
        final exceptionMessage =
            'Source(data) -> `data` should be either String, List<int> or Uint8List.';
        expect(
            () => Codec(types).decode(usageIndex, 0.0),
            throwsA(predicate((e) =>
                e is AssertionException && e.toString() == exceptionMessage)));
      });
    });

    //
    // Exception on Encode at wrong value type: `BitVec<u32, bitvec::order::Lsb0>`
    group('Exception on Encode BitVec<u32, bitvec::order::Lsb0>:', () {
      test(
          'On encoding \'integer\' value should throw exception \'AssertionException\' for BitVec<u32, bitvec::order::Lsb0>',
          () {
        final exceptionMessage =
            'BitSequence can have bits of type `List<int>` only.';
        expect(
            () => Codec(types).encode(usageIndex, 0),
            throwsA(predicate((e) =>
                e is AssertionException && e.toString() == exceptionMessage)));
      });

      test(
          'On encoding \'float\' value should throw exception \'AssertionException\' for BitVec<u32, bitvec::order::Lsb0>',
          () {
        final exceptionMessage =
            'BitSequence can have bits of type `List<int>` only.';
        expect(
            () => Codec(types).encode(usageIndex, 0.0),
            throwsA(predicate((e) =>
                e is AssertionException && e.toString() == exceptionMessage)));
      });
    });
  }
}
