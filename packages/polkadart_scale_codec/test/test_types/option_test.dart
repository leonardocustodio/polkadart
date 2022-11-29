import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  // Creates the registry for parsing the types
  final registry = TypeRegistry(
    types: <String, dynamic>{
      'Codec': {
        'a': 'Option<bool>',
        'b': 'Option<u8>',
        'c': 'Option<u128>',
        'd': 'Option<i8>',
        'e': 'Option<Compact<u8>>',
        'f': 'Option<BitVec<u8>>',
      },
    },
  );

  registry.select('Codec');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);

  {
    // Encode Option<bool> with values
    group('Encode Option<bool>:', () {
      test('Some(true) should encode to \'0x0101\'', () {
        final encoded =
            codec.encode(registry.getIndex('Option<bool>'), Some(true));
        expect('0x0101', equals(encoded));
      });
      test('Some(false) should encode to \'0x0100\'', () {
        final encoded =
            codec.encode(registry.getIndex('Option<bool>'), Some(false));
        expect('0x0100', equals(encoded));
      });
      test('None should encode to \'0x00\'', () {
        final encoded = codec.encode(registry.getIndex('Option<bool>'), None);
        expect('0x00', equals(encoded));
      });
    });
  }

  {
    // Decode Option<bool> with values
    group('Decode Option<bool>:', () {
      test('\'0x0101\' should decode to Some(true)', () {
        final decoded =
            codec.decode(registry.getIndex('Option<bool>'), '0x0101');
        expect(Some(true), decoded);
      });
      test('\'0x0100\' should decode to Some(false)', () {
        final decoded =
            codec.decode(registry.getIndex('Option<bool>'), '0x0100');
        expect(Some(false), decoded);
      });
      test('\'0x00\' should decode to None', () {
        final decoded = codec.decode(registry.getIndex('Option<bool>'), '0x00');
        expect(None, equals(decoded));
      });
    });
  }

  {
    // Encode Option<u128> with values
    group('Encode Option<u128>:', () {
      test(
          'Some(BigInt.from(1)) should encode to \'0x0101000000000000000000000000000000\'',
          () {
        final encoded = codec.encode(
            registry.getIndex('Option<u128>'), Some(BigInt.from(1)));
        expect('0x0101000000000000000000000000000000', equals(encoded));
      });
      test('\'null\' should encode to \'0x00\'', () {
        final encoded = codec.encode(registry.getIndex('Option<u128>'), None);
        expect('0x00', equals(encoded));
      });
    });
  }

  {
    // Decode Option<u128> with values
    group('Decode Option<u128>:', () {
      test(
          '\'0x0101000000000000000000000000000000\' should decode to Some(BigInt.from(1))',
          () {
        final decoded = codec.decode(registry.getIndex('Option<u128>'),
            '0x0101000000000000000000000000000000');
        expect(Some(BigInt.from(1)), decoded);
      });
      test('\'0x00\' should decode to None', () {
        final decoded = codec.decode(registry.getIndex('Option<u128>'), '0x00');
        expect(None, equals(decoded));
      });
    });
  }

  {
    // Encode Option<Compact<u8>> with values
    group('Encode Option<Compact<u8>>:', () {
      test('Some(63) should encode to \'0x01fc\'', () {
        final encoded =
            codec.encode(registry.getIndex('Option<Compact<u8>>'), Some(63));
        expect('0x01fc', equals(encoded));
      });
      test('None should encode to \'0x00\'', () {
        final encoded =
            codec.encode(registry.getIndex('Option<Compact<u8>>'), None);
        expect('0x00', equals(encoded));
      });
    });
  }

  {
    // Decode Option<u128> with values
    group('Decode Option<Compact<u8>>:', () {
      test('\'0x01fc\' should decode to Some(63)', () {
        final decoded =
            codec.decode(registry.getIndex('Option<Compact<u8>>'), '0x01fc');
        expect(Some(63), decoded);
      });
      test('\'0x00\' should decode to None', () {
        final decoded =
            codec.decode(registry.getIndex('Option<Compact<u8>>'), '0x00');
        expect(None, equals(decoded));
      });
    });
  }

  //
  // Encodes type: `Option<BitVec<u8>>`
  group('Encode Option<BitVec<u8>>:', () {
    test(
        'Lowest acceptable value is Some([0]) and the output should be \'0x012000\'',
        () {
      final encoded =
          codec.encode(registry.getIndex('Option<BitVec<u8>>'), Some([0]));
      expect(encoded, equals('0x012000'));
    });

    test(
        'Highest acceptable value is Some([255]) and the output should be \'0x0120ff\'',
        () {
      final encoded =
          codec.encode(registry.getIndex('Option<BitVec<u8>>'), Some([255]));
      expect(encoded, equals('0x0120ff'));
    });

    test('None should encode to \'0x00\'', () {
      final encoded =
          codec.encode(registry.getIndex('Option<BitVec<u8>>'), None);
      expect('0x00', equals(encoded));
    });
  });

  //
  // Decodes type: `Option<BitVec<u8>>`
  group('Decode Option<BitVec<u8>>:', () {
    test(
        'On decoding \'0x012000\' we must get lowest acceptable value: Some([0])',
        () {
      final decoded =
          codec.decode(registry.getIndex('Option<BitVec<u8>>'), '0x012000');
      expect(Some([0]), decoded);
    });

    test(
        'On decoding \'0x0120ff\' we must get lowest acceptable value: Some([255])',
        () {
      final decoded =
          codec.decode(registry.getIndex('Option<BitVec<u8>>'), '0x0120ff');
      expect(Some([255]), decoded);
    });

    test('\'0x00\' should decode to None', () {
      final decoded =
          codec.decode(registry.getIndex('Option<BitVec<u8>>'), '0x00');
      expect(None, decoded);
    });
  });

  {
    //
    // Exception when setting Option Flag to greator than `1`.
    //
    // Option flag can be `0` or `1`.
    //
    group('Exception when decoding Option<u8>:', () {
      test('should throw error when flag 2 is set to option flag as \'0x02\'',
          () {
        expect(
            () => codec.decode(registry.getIndex('Option<u8>'), '0x0208'),
            throwsA(predicate((e) =>
                e is InvalidOptionByteException &&
                e.toString() == 'Invalid Option byte: 2.')));
      });
      test('Flag at 3', () {
        expect(
            () => codec.decode(registry.getIndex('Option<u8>'), '0x0308'),
            throwsA(predicate((e) =>
                e is InvalidOptionByteException &&
                e.toString() == 'Invalid Option byte: 3.')));
      });
    });
  }
}
