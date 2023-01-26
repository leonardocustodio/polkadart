import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('encode tuple to hex ', () {
    test(
        'Given a list with compact unsigned integer and boolean it should be encoded to correct value',
        () {
      const value = [3, true];
      const expectedResult = '0x0c01';

      final codec = Codec().fetchTypeCodec('(Compact<u8>, bool)');

      final encoder = HexEncoder();

      codec.encode(encoder, value);
      expect(encoder.toHex(), expectedResult);
    });

    test(
        'Given a list of one String and one unsigned 8bit integer it should be encoded to correct value',
        () {
      const value = ['Tuple', 133];
      const expectedResult = '0x145475706c6585';

      final codec = Codec().fetchTypeCodec('(String, u8)');

      final encoder = HexEncoder();

      codec.encode(encoder, value);
      expect(encoder.toHex(), expectedResult);
    });

    test(
        'Given a list of one Vec<String> it should be encoded to correct value',
        () {
      final value = [
        ['tuple', 'test'],
        [100, 10]
      ];
      const expectedResult = '0x08147475706c65107465737408640a';

      final codec = Codec().fetchTypeCodec('(Vec<String>, Vec<u8>)');

      final encoder = HexEncoder();

      codec.encode(encoder, value);
      expect(encoder.toHex(), expectedResult);
    });

    test('Given an empty list it should throw InvalidTupleException', () {
      const value = [];

      final codec = Codec().fetchTypeCodec('(Compact<u8>, bool)');
      final encoder = HexEncoder();
      expect(
        () => codec.encode(encoder, value),
        throwsA(isA<InvalidTupleException>()),
      );
    });

    test(
        'Given a list bigger than tuple length it should throw InvalidTupleException',
        () {
      const value = [3, false, 3];

      final codec = Codec().fetchTypeCodec('(Compact<u8>, bool)');
      final encoder = HexEncoder();

      expect(
        () => codec.encode(encoder, value),
        throwsA(isA<InvalidTupleException>()),
      );
    });

    test(
        'Given a list smaller than tuple length it should throw InvalidTupleException',
        () {
      const value = [3, false];

      final codec = Codec().fetchTypeCodec('(Compact<u8>, bool, String)');
      final encoder = HexEncoder();

      expect(
        () => codec.encode(encoder, value),
        throwsA(isA<InvalidTupleException>()),
      );
    });
  });

  group('decode tuple tests ', () {
    test(
        'Given an encoded string when it represents a list of [Compact<u8>, bool] it should be decoded',
        () {
      const expectedResult = [3, true];
      const value = '0x0c01';

      final codec = Codec().fetchTypeCodec('(Compact<u8>, bool)');

      expect(codec.decode(DefaultInput.fromHex(value)), expectedResult);
    });

    test(
        'Given an encoded string when it represents a list of [String, u8] it should decoded',
        () {
      const expectedResult = ['Tuple', 133];
      const value = '0x145475706c6585';

      final codec = Codec().fetchTypeCodec('(String, u8)');

      expect(codec.decode(DefaultInput.fromHex(value)), expectedResult);
    });

    test(
        'Given an encoded string when it represents a list of [Vec<String>, Vec<u8>] it should decoded',
        () {
      final expectedResult = [
        ['tuple', 'test'],
        [100, 10]
      ];

      const value = '0x08147475706c65107465737408640a';

      final codec = Codec().fetchTypeCodec('(Vec<String>, Vec<u8>)');

      expect(codec.decode(DefaultInput.fromHex(value)), expectedResult);
    });

    test('Given an empty encoded string it should throw AssertionException',
        () {
      const value = '';

      final codec = Codec().fetchTypeCodec('(Compact<u8>, bool)');

      expect(
        () => codec.decode(DefaultInput.fromHex(value)),
        throwsA(isA<EOFException>()),
      );
    });
  });

  {
    // Creates the registry for parsing the types
    final registry = TypeRegistry.createRegistry();
    registry.addCustomCodec(<String, dynamic>{
      'a': '(Compact<u8>, bool)',
      'b': '(String, u8)',
      'c': '(Vec<String>, Vec<u8>)',
    });

    group('encode tuple to hex ', () {
      test(
          'Given a list with compact unsigned integer and boolean it should be encoded to correct value',
          () {
        const value = [3, true];
        const expectedResult = '0x0c01';

        final codec = Codec(registry: registry).fetchTypeCodec('a');

        final encoder = HexEncoder();

        codec.encode(encoder, value);
        expect(encoder.toHex(), expectedResult);
      });

      test(
          'Given a list of one String and one unsigned 8bit integer it should be encoded to correct value',
          () {
        const value = ['Tuple', 133];
        const expectedResult = '0x145475706c6585';

        final codec = Codec(registry: registry).fetchTypeCodec('b');

        final encoder = HexEncoder();

        codec.encode(encoder, value);
        expect(encoder.toHex(), expectedResult);
      });

      test(
          'Given a list of one Vec<String> it should be encoded to correct value',
          () {
        final value = [
          ['tuple', 'test'],
          [100, 10]
        ];
        const expectedResult = '0x08147475706c65107465737408640a';

        final codec = Codec(registry: registry).fetchTypeCodec('c');

        final encoder = HexEncoder();

        codec.encode(encoder, value);
        expect(encoder.toHex(), expectedResult);
      });

      test('Given an empty list it should throw InvalidTupleException', () {
        const value = [];

        final codec = Codec(registry: registry).fetchTypeCodec('a');
        final encoder = HexEncoder();
        expect(
          () => codec.encode(encoder, value),
          throwsA(isA<InvalidTupleException>()),
        );
      });

      test(
          'Given a list bigger than tuple length it should throw InvalidTupleException',
          () {
        const value = [3, false, 3];

        final codec = Codec(registry: registry).fetchTypeCodec('a');
        final encoder = HexEncoder();

        expect(
          () => codec.encode(encoder, value),
          throwsA(isA<InvalidTupleException>()),
        );
      });

      test(
          'Given a list smaller than tuple length it should throw InvalidTupleException',
          () {
        const value = [3, false];

        final codec = Codec(registry: registry)
            .fetchTypeCodec('(Compact<u8>, bool, String)');
        final encoder = HexEncoder();

        expect(
          () => codec.encode(encoder, value),
          throwsA(isA<InvalidTupleException>()),
        );
      });
    });

    group('decode tuple tests ', () {
      test(
          'Given an encoded string when it represents a list of [Compact<u8>, bool] it should be decoded',
          () {
        const expectedResult = [3, true];
        const value = '0x0c01';

        final codec = Codec(registry: registry).fetchTypeCodec('a');

        expect(codec.decode(DefaultInput.fromHex(value)), expectedResult);
      });

      test(
          'Given an encoded string when it represents a list of [String, u8] it should decoded',
          () {
        const expectedResult = ['Tuple', 133];
        const value = '0x145475706c6585';

        final codec = Codec(registry: registry).fetchTypeCodec('b');

        expect(codec.decode(DefaultInput.fromHex(value)), expectedResult);
      });

      test(
          'Given an encoded string when it represents a list of [Vec<String>, Vec<u8>] it should decoded',
          () {
        final expectedResult = [
          ['tuple', 'test'],
          [100, 10]
        ];

        const value = '0x08147475706c65107465737408640a';

        final codec = Codec(registry: registry).fetchTypeCodec('c');

        expect(codec.decode(DefaultInput.fromHex(value)), expectedResult);
      });

      test('Given an empty encoded string it should throw AssertionException',
          () {
        const value = '';

        final codec = Codec(registry: registry).fetchTypeCodec('a');

        expect(
          () => codec.decode(DefaultInput.fromHex(value)),
          throwsA(isA<EOFException>()),
        );
      });
    });
  }
}
