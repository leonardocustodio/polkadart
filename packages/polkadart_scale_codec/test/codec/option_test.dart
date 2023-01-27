import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Option Encode Test', () {
    test('Given a Some([3, true] it should be encoded to 0x010c01', () {
      const value = Some([3, true]);
      const expectedResult = '0x010c01';

      final codec = Codec().fetchTypeCodec('Option<(Compact<u8>, bool)>');

      final encoder = HexEncoder();

      codec.encode(encoder, value);
      expect(encoder.toHex(), expectedResult);
    });

    test('Given a None it should be encoded to 0x00', () {
      const value = None;
      const expectedResult = '0x00';

      final codec = Codec().fetchTypeCodec('Option<bool>');

      final encoder = HexEncoder();

      codec.encode(encoder, value);
      expect(encoder.toHex(), expectedResult);
    });

    test('Given a Some(true) it should be encoded to 0x0101', () {
      const value = Some(true);
      const expectedResult = '0x0101';

      final codec = Codec().fetchTypeCodec('Option<bool>');

      final encoder = HexEncoder();

      codec.encode(encoder, value);
      expect(encoder.toHex(), expectedResult);
    });

    test('Given a Some(false) it should be encoded to 0x0100', () {
      const value = Some(false);
      const expectedResult = '0x0100';

      final codec = Codec().fetchTypeCodec('Option<bool>');

      final encoder = HexEncoder();

      codec.encode(encoder, value);
      expect(encoder.toHex(), expectedResult);
    });

    test('Given a Some(None) it should be encoded to 0x0100', () {
      const value = Some(None);
      const expectedResult = '0x0100';

      final codec = Codec().fetchTypeCodec('Option<Option<bool>>');

      final encoder = HexEncoder();

      codec.encode(encoder, value);
      expect(encoder.toHex(), expectedResult);
    });

    test('Given a Some(Some(true)) it should be encoded to 0x010101', () {
      const value = Some(Some(true));
      const expectedResult = '0x010101';

      final codec = Codec().fetchTypeCodec('Option<Option<bool>>');

      final encoder = HexEncoder();

      codec.encode(encoder, value);
      expect(encoder.toHex(), expectedResult);
    });

    test('Given a Some(Some(false)) it should be encoded to 0x010100', () {
      const value = Some(Some(false));
      const expectedResult = '0x010100';

      final codec = Codec().fetchTypeCodec('Option<Option<bool>>');

      final encoder = HexEncoder();

      codec.encode(encoder, value);
      expect(encoder.toHex(), expectedResult);
    });

    test('Given a Some(Some(None)) it should be encoded to 0x010100', () {
      const value = Some(Some(None));
      const expectedResult = '0x010100';

      final codec = Codec().fetchTypeCodec('Option<Option<Option<bool>>>');

      final encoder = HexEncoder();

      codec.encode(encoder, value);
      expect(encoder.toHex(), expectedResult);
    });
  });

  // Decode Tests
  group('Option Decode Test', () {
    test('Given a 0x010c01 it should be decoded to Some([3, true])', () {
      const value = '0x010c01';
      const expectedResult = Some([3, true]);

      final codec = Codec().fetchTypeCodec('Option<(Compact<u8>, bool)>');

      expect(codec.decode(DefaultInput.fromHex(value)).value,
          expectedResult.value);
    });

    test('Given a 0x00 it should be decoded to None', () {
      const value = '0x00';
      const expectedResult = None;

      final codec = Codec().fetchTypeCodec('Option<bool>');

      expect(codec.decode(DefaultInput.fromHex(value)), expectedResult);
    });

    test('Given a 0x0101 it should be decoded to Some(true)', () {
      const value = '0x0101';
      const expectedResult = Some(true);

      final codec = Codec().fetchTypeCodec('Option<bool>');

      expect(codec.decode(DefaultInput.fromHex(value)), expectedResult);
    });

    test('Given a 0x0100 it should be decoded to Some(false)', () {
      const value = '0x0100';
      const expectedResult = Some(false);

      final codec = Codec().fetchTypeCodec('Option<bool>');

      expect(codec.decode(DefaultInput.fromHex(value)), expectedResult);
    });

    test('Given a 0x0100 it should be decoded to Some(None)', () {
      const value = '0x0100';
      const expectedResult = Some(None);

      final codec = Codec().fetchTypeCodec('Option<Option<bool>>');

      expect(codec.decode(DefaultInput.fromHex(value)), expectedResult);
    });

    test('Given a 0x010101 it should be decoded to Some(Some(true))', () {
      const value = '0x010101';
      const expectedResult = Some(Some(true));

      final codec = Codec().fetchTypeCodec('Option<Option<bool>>');

      expect(codec.decode(DefaultInput.fromHex(value)), expectedResult);
    });

    test('Given a 0x010100 it should be decoded to Some(Some(false))', () {
      const value = '0x010100';
      const expectedResult = Some(Some(false));

      final codec = Codec().fetchTypeCodec('Option<Option<bool>>');

      expect(codec.decode(DefaultInput.fromHex(value)), expectedResult);
    });

    test('Given a 0x010100 it should be decoded to Some(Some(None))', () {
      const value = '0x010100';
      const expectedResult = Some(Some(None));

      final codec = Codec().fetchTypeCodec('Option<Option<Option<bool>>>');

      expect(codec.decode(DefaultInput.fromHex(value)), expectedResult);
    });

    test('Given a 0x01010101 it should be decoded to Some(Some(Some(true)))',
        () {
      const value = '0x01010101';
      const expectedResult = Some(Some(Some(true)));

      final codec = Codec().fetchTypeCodec('Option<Option<Option<bool>>>');

      expect(codec.decode(DefaultInput.fromHex(value)), expectedResult);
    });

    test('Given a 0x01010100 it should be decoded to Some(Some(Some(false)))',
        () {
      const value = '0x01010100';
      const expectedResult = Some(Some(Some(false)));

      final codec = Codec().fetchTypeCodec('Option<Option<Option<bool>>>');

      expect(codec.decode(DefaultInput.fromHex(value)), expectedResult);
    });

    test('Given a 0x01010100 it should be decoded to Some(Some(Some(None)))',
        () {
      const value = '0x01010100';
      const expectedResult = Some(Some(Some(None)));

      final codec =
          Codec().fetchTypeCodec('Option<Option<Option<Option<bool>>>>');

      expect(codec.decode(DefaultInput.fromHex(value)), expectedResult);
    });
  });

  group('Option Exception Test', () {
    test('Given a 0x01 it should throw an exception', () {
      const value = '';

      final codec = Codec().fetchTypeCodec('Option<bool>');

      expect(() => codec.decode(DefaultInput.fromHex(value)),
          throwsA(isA<EOFException>()));
    });

    test('Given a 0x010101 it should throw an exception', () {
      const value = '0x010101';

      final codec = Codec().fetchTypeCodec('Option');

      expect(() => codec.decode(DefaultInput.fromHex(value)),
          throwsA(isA<AssertionException>()));
    });
  });

  {
    // Creates the registry for parsing the types
    final registry = TypeRegistry.createRegistry();
    registry.registerCustomCodec(<String, dynamic>{
      'C': 'Option<B>',
      'A': 'Option<bool>',
      'B': 'Option<A>',
      'D': 'Option<(Compact<u8>, bool)>',
    });

    group('Encode Option Test', () {
      test('Given a None for type C it should be encoded to 0x00', () {
        const value = None;
        const expectedResult = '0x00';

        final codec = Codec(registry: registry).fetchTypeCodec('C');

        final encoder = HexEncoder();

        codec.encode(encoder, value);
        expect(encoder.toHex(), expectedResult);
      });

      test('Given a Some(None) for type C it should be encoded to 0x0100', () {
        const value = Some(None);
        const expectedResult = '0x0100';

        final codec = Codec(registry: registry).fetchTypeCodec('C');

        final encoder = HexEncoder();

        codec.encode(encoder, value);
        expect(encoder.toHex(), expectedResult);
      });

      test(
          'Given a Some(Some(None)) for type C it should be encoded to 0x010100',
          () {
        const value = Some(Some(None));
        const expectedResult = '0x010100';

        final codec = Codec(registry: registry).fetchTypeCodec('C');

        final encoder = HexEncoder();

        codec.encode(encoder, value);
        expect(encoder.toHex(), expectedResult);
      });

      test(
          'Given a Some(Some(Some(false))) for type C it should be encoded to 0x01010100',
          () {
        const value = Some(Some(Some(false)));
        const expectedResult = '0x01010100';

        final codec = Codec(registry: registry).fetchTypeCodec('C');

        final encoder = HexEncoder();

        codec.encode(encoder, value);
        expect(encoder.toHex(), expectedResult);
      });

      test(
          'Given a Some(Some(Some(true))) for type C it should be encoded to 0x01010101',
          () {
        const value = Some(Some(Some(true)));
        const expectedResult = '0x01010101';

        final codec = Codec(registry: registry).fetchTypeCodec('C');

        final encoder = HexEncoder();

        codec.encode(encoder, value);
        expect(encoder.toHex(), expectedResult);
      });

      test('Given a None for type A it should be encoded to 0x00', () {
        const value = None;
        const expectedResult = '0x00';

        final codec = Codec(registry: registry).fetchTypeCodec('A');

        final encoder = HexEncoder();

        codec.encode(encoder, value);
        expect(encoder.toHex(), expectedResult);
      });

      test('Given a Some(false) for type A it should be encoded to 0x0100', () {
        const value = Some(false);
        const expectedResult = '0x0100';

        final codec = Codec(registry: registry).fetchTypeCodec('A');

        final encoder = HexEncoder();

        codec.encode(encoder, value);
        expect(encoder.toHex(), expectedResult);
      });

      test('Given a Some(true) for type A it should be encoded to 0x0101', () {
        const value = Some(true);
        const expectedResult = '0x0101';

        final codec = Codec(registry: registry).fetchTypeCodec('A');

        final encoder = HexEncoder();

        codec.encode(encoder, value);
        expect(encoder.toHex(), expectedResult);
      });

      test('Given a None for type B it should be encoded to 0x00', () {
        const value = None;
        const expectedResult = '0x00';

        final codec = Codec(registry: registry).fetchTypeCodec('B');

        final encoder = HexEncoder();

        codec.encode(encoder, value);
        expect(encoder.toHex(), expectedResult);
      });

      test('Given a Some(None) for type B it should be encoded to 0x0100', () {
        const value = Some(None);
        const expectedResult = '0x0100';

        final codec = Codec(registry: registry).fetchTypeCodec('B');

        final encoder = HexEncoder();

        codec.encode(encoder, value);
        expect(encoder.toHex(), expectedResult);
      });

      test(
          'Given a Some(Some(false)) for type B it should be encoded to 0x010100',
          () {
        const value = Some(Some(false));
        const expectedResult = '0x010100';

        final codec = Codec(registry: registry).fetchTypeCodec('B');

        final encoder = HexEncoder();

        codec.encode(encoder, value);
        expect(encoder.toHex(), expectedResult);
      });

      test(
          'Given a Some(Some(true)) for type B it should be encoded to 0x010101',
          () {
        const value = Some(Some(true));
        const expectedResult = '0x010101';

        final codec = Codec(registry: registry).fetchTypeCodec('B');

        final encoder = HexEncoder();

        codec.encode(encoder, value);
        expect(encoder.toHex(), expectedResult);
      });

      test(
          'Given a Some([3, true]) for type E it should be encoded to 0x010c01',
          () {
        const value = Some([3, true]);
        const expectedResult = '0x010c01';

        final codec = Codec(registry: registry).fetchTypeCodec('D');

        final encoder = HexEncoder();

        codec.encode(encoder, value);
        expect(encoder.toHex(), expectedResult);
      });
    });

    group('Decode Option Test', () {
      test('Given a 0x00 for type C it should be decoded to None', () {
        const value = '0x00';
        const expectedResult = None;

        final codec = Codec(registry: registry).fetchTypeCodec('C');

        expect(codec.decode(DefaultInput.fromHex(value)), expectedResult);
      });

      test('Given a 0x0100 for type C it should be decoded to Some(None)', () {
        const value = '0x0100';
        const expectedResult = Some(None);

        final codec = Codec(registry: registry).fetchTypeCodec('C');

        expect(codec.decode(DefaultInput.fromHex(value)), expectedResult);
      });

      test(
          'Given a 0x010100 for type C it should be decoded to Some(Some(None))',
          () {
        const value = '0x010100';
        const expectedResult = Some(Some(None));

        final codec = Codec(registry: registry).fetchTypeCodec('C');

        expect(codec.decode(DefaultInput.fromHex(value)), expectedResult);
      });

      test(
          'Given a 0x01010101 for type C it should be decoded to Some(Some(Some(true)))',
          () {
        const value = '0x01010101';
        const expectedResult = Some(Some(Some(true)));

        final codec = Codec(registry: registry).fetchTypeCodec('C');

        expect(codec.decode(DefaultInput.fromHex(value)), expectedResult);
      });

      test('Given a 0x00 for type A it should be decoded to None', () {
        const value = '0x00';
        const expectedResult = None;

        final codec = Codec(registry: registry).fetchTypeCodec('A');

        expect(codec.decode(DefaultInput.fromHex(value)), expectedResult);
      });

      test('Given a 0x0100 for type A it should be decoded to Some(false)', () {
        const value = '0x0100';
        const expectedResult = Some(false);

        final codec = Codec(registry: registry).fetchTypeCodec('A');

        expect(codec.decode(DefaultInput.fromHex(value)), expectedResult);
      });

      test('Given a 0x0101 for type A it should be decoded to Some(true)', () {
        const value = '0x0101';
        const expectedResult = Some(true);

        final codec = Codec(registry: registry).fetchTypeCodec('A');

        expect(codec.decode(DefaultInput.fromHex(value)), expectedResult);
      });

      test('Given a 0x00 for type B it should be decoded to None', () {
        const value = '0x00';
        const expectedResult = None;

        final codec = Codec(registry: registry).fetchTypeCodec('B');

        expect(codec.decode(DefaultInput.fromHex(value)), expectedResult);
      });

      test('Given a 0x0100 for type B it should be decoded to Some(None)', () {
        const value = '0x0100';
        const expectedResult = Some(None);

        final codec = Codec(registry: registry).fetchTypeCodec('B');

        expect(codec.decode(DefaultInput.fromHex(value)), expectedResult);
      });

      test(
          'Given a 0x010100 for type B it should be decoded to Some(Some(false))',
          () {
        const value = '0x010100';
        const expectedResult = Some(Some(false));

        final codec = Codec(registry: registry).fetchTypeCodec('B');

        expect(codec.decode(DefaultInput.fromHex(value)), expectedResult);
      });

      test(
          'Given a 0x010101 for type B it should be decoded to Some(Some(true))',
          () {
        const value = '0x010101';
        const expectedResult = Some(Some(true));

        final codec = Codec(registry: registry).fetchTypeCodec('B');

        expect(codec.decode(DefaultInput.fromHex(value)), expectedResult);
      });

      test(
          'Given a 0x010c01 for type D it should be decoded to Some([3, true])',
          () {
        const value = '0x010c01';
        const expectedResult = Some([3, true]);

        final codec = Codec(registry: registry).fetchTypeCodec('D');

        expect(codec.decode(DefaultInput.fromHex(value)).value,
            expectedResult.value);
      });
    });
  }
}
