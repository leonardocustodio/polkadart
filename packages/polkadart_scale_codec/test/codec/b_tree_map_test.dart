import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('BTreeMap Encode Test', () {
    test('When value {42: true} is encoded then it returns 0x042a01', () {
      final codec = Codec().fetchTypeCodec('BTreeMap<u8, bool>');
      final encoder = HexEncoder();
      codec.encode(encoder, {42: true});
      expect(encoder.toHex(), equals('0x042a01'));
    });

    test('When value {6: false} is encoded then it returns 0x040600', () {
      final codec = Codec().fetchTypeCodec('BTreeMap<u8, bool>');
      final encoder = HexEncoder();
      codec.encode(encoder, {6: false});
      expect(encoder.toHex(), equals('0x040600'));
    });

    test(
        'When value {{632: false}: true} is encoded then it returns 0x0404780200000001',
        () {
      final codec =
          Codec().fetchTypeCodec('BTreeMap<BTreeMap<u32, bool>, bool>');
      final encoder = HexEncoder();
      codec.encode(encoder, {
        {632: false}: true
      });
      expect(encoder.toHex(), equals('0x0404780200000001'));
    });

    test(
        'When value {{"1291": true}: false} is encoded then it returns 0x040410313239310100',
        () {
      final codec =
          Codec().fetchTypeCodec('BTreeMap<BTreeMap<String, bool>, bool>');
      final encoder = HexEncoder();
      codec.encode(encoder, {
        {'1291': true}: false
      });
      expect(encoder.toHex(), equals('0x040410313239310100'));
    });

    test('When value {[42, true]: false} is encoded then it returns 0x042a0100',
        () {
      final codec = Codec().fetchTypeCodec('BTreeMap<(u8, bool), bool>');
      final encoder = HexEncoder();
      codec.encode(encoder, {
        [42, true]: false
      });
      expect(encoder.toHex(), equals('0x042a0100'));
    });

    test('When value {0: false} is encoded then it returns 0x040000', () {
      final codec = Codec().fetchTypeCodec('BTreeMap<u8, bool>');
      final encoder = HexEncoder();
      codec.encode(encoder, {0: false});
      expect(encoder.toHex(), equals('0x040000'));
    });
  });

  // Decode Test
  group('BTreeMap Decode Test', () {
    test('When value 0x042a01 is decoded then it returns {42: true}', () {
      final codec = Codec().fetchTypeCodec('BTreeMap<u8, bool>');

      final input = DefaultInput.fromHex('0x042a01');

      expect(codec.decode(input), {42: true});
    });

    test('When value 0x040600 is decoded then it returns {6: false}', () {
      final codec = Codec().fetchTypeCodec('BTreeMap<u8, bool>');

      final input = DefaultInput.fromHex('0x040600');

      expect(codec.decode(input).toString(), {6: false}.toString());
    });

    test(
        'When value 0x0404780200000001 is decoded then it returns {{632: false}: true}',
        () {
      final codec =
          Codec().fetchTypeCodec('BTreeMap<BTreeMap<u32, bool>, bool>');

      final input = DefaultInput.fromHex('0x0404780200000001');

      expect(
          codec.decode(input).toString(),
          {
            {632: false}: true
          }.toString());
    });

    test(
        'When value 0x040410313239310100 is decoded then it returns {{"1291": true}: false}',
        () {
      final codec =
          Codec().fetchTypeCodec('BTreeMap<BTreeMap<String, bool>, bool>');

      final input = DefaultInput.fromHex('0x040410313239310100');

      expect(
          codec.decode(input).toString(),
          {
            {'1291': true}: false
          }.toString());
    });

    test('When value 0x042a0100 is decoded then it returns {[42, true]: false}',
        () {
      final codec = Codec().fetchTypeCodec('BTreeMap<(u8, bool), bool>');

      final input = DefaultInput.fromHex('0x042a0100');

      expect(
          codec.decode(input).toString(),
          {
            [42, true]: false
          }.toString());
    });

    test('When value 0x040000 is decoded then it returns {0: false}', () {
      final codec = Codec().fetchTypeCodec('BTreeMap<u8, bool>');

      final input = DefaultInput.fromHex('0x040000');

      expect(codec.decode(input).toString(), {0: false}.toString());
    });
  });

  group('Exception Test', () {
    test(
        'When value BTreeMap<u8> is used as type for codec then it returns AssertionException',
        () {
      expect(() => Codec().fetchTypeCodec('BTreeMap<u8>'),
          throwsA(isA<AssertionException>()));
    });

    test(
        'When value BTreeMap<u8, u8, u8> is used as type for codec then it returns UnexpectedCaseException',
        () {
      expect(() => Codec().fetchTypeCodec('BTreeMap<u8, u8, u8>'),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });

  group('BTreeMap Registry Encode Test', () {
    final registry = TypeRegistry.createRegistry()
      ..registerCustomCodec({
        'Res': 'BTreeMap<A, bool>',
        'B': 'BTreeMap<u8, bool>',
        'A': 'BTreeMap<u32, bool>',
        'C': 'BTreeMap<BTreeMap<String, bool>, bool>',
        'BTreeMap_With_Tuple': 'BTreeMap<(u8, bool), bool>',
      });

    test('When value {42: true} is encoded then it returns 0x042a01', () {
      final codec = Codec(registry: registry).fetchTypeCodec('B');
      final encoder = HexEncoder();
      codec.encode(encoder, {42: true});
      expect(encoder.toHex(), equals('0x042a01'));
    });

    test('When value {6: false} is encoded then it returns 0x040600', () {
      final codec = Codec(registry: registry).fetchTypeCodec('B');
      final encoder = HexEncoder();
      codec.encode(encoder, {6: false});
      expect(encoder.toHex(), equals('0x040600'));
    });

    test(
        'When value {{632: false}: true} is encoded then it returns 0x0404780200000001',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('Res');
      final encoder = HexEncoder();
      codec.encode(encoder, {
        {632: false}: true
      });
      expect(encoder.toHex(), equals('0x0404780200000001'));
    });

    test(
        'When value {{"1291": true}: false} is encoded then it returns 0x040410313239310100',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('C');
      final encoder = HexEncoder();
      codec.encode(encoder, {
        {'1291': true}: false
      });
      expect(encoder.toHex(), equals('0x040410313239310100'));
    });

    test('When value {[42, true]: false} is encoded then it returns 0x042a0100',
        () {
      final codec =
          Codec(registry: registry).fetchTypeCodec('BTreeMap_With_Tuple');
      final encoder = HexEncoder();
      codec.encode(encoder, {
        [42, true]: false
      });
      expect(encoder.toHex(), equals('0x042a0100'));
    });

    test('When value {0: false} is encoded then it returns 0x040000', () {
      final codec = Codec(registry: registry).fetchTypeCodec('B');
      final encoder = HexEncoder();
      codec.encode(encoder, {0: false});
      expect(encoder.toHex(), equals('0x040000'));
    });
  });

  // Decode Test
  group('BTreeMap Registry Decode Test', () {
    final registry = TypeRegistry.createRegistry()
      ..registerCustomCodec({
        'Res': 'BTreeMap<A, bool>',
        'B': 'BTreeMap<u8, bool>',
        'A': 'BTreeMap<u32, bool>',
        'C': 'BTreeMap<BTreeMap<String, bool>, bool>',
        'BTreeMap_With_Tuple': 'BTreeMap<(u8, bool), bool>',
      });

    test('When value 0x042a01 is decoded then it returns {42: true}', () {
      final codec = Codec(registry: registry).fetchTypeCodec('B');

      final input = DefaultInput.fromHex('0x042a01');

      expect(codec.decode(input), {42: true});
    });

    test('When value 0x040600 is decoded then it returns {6: false}', () {
      final codec = Codec(registry: registry).fetchTypeCodec('B');

      final input = DefaultInput.fromHex('0x040600');

      expect(codec.decode(input).toString(), {6: false}.toString());
    });

    test(
        'When value 0x0404780200000001 is decoded then it returns {{632: false}: true}',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('Res');

      final input = DefaultInput.fromHex('0x0404780200000001');

      expect(
          codec.decode(input).toString(),
          {
            {632: false}: true
          }.toString());
    });

    test(
        'When value 0x040410313239310100 is decoded then it returns {{"1291": true}: false}',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('C');

      final input = DefaultInput.fromHex('0x040410313239310100');

      expect(
          codec.decode(input).toString(),
          {
            {'1291': true}: false
          }.toString());
    });

    test('When value 0x042a0100 is decoded then it returns {[42, true]: false}',
        () {
      final codec =
          Codec(registry: registry).fetchTypeCodec('BTreeMap_With_Tuple');

      final input = DefaultInput.fromHex('0x042a0100');

      expect(
          codec.decode(input).toString(),
          {
            [42, true]: false
          }.toString());
    });

    test('When value 0x040000 is decoded then it returns {0: false}', () {
      final codec = Codec(registry: registry).fetchTypeCodec('B');

      final input = DefaultInput.fromHex('0x040000');

      expect(codec.decode(input).toString(), {0: false}.toString());
    });
  });

  group('BTreeMap Registry Exception', () {
    final registry = TypeRegistry.createRegistry();
    test(
        'When value BTreeMap<u8> is used as type for codec then it returns AssertionException',
        () {
      expect(
          () => registry.registerCustomCodec({
                'Res': 'BTreeMap<u8>',
              }),
          throwsA(isA<AssertionException>()));
    });

    test(
        'When value BTreeMap<u8, u8, u8> is used as type for codec then it returns UnexpectedCaseException',
        () {
      expect(
          () => registry.registerCustomCodec({
                'A': 'BTreeMap<u32, bool, bool>',
              }),
          throwsA(isA<UnexpectedCaseException>()));
    });
  });
}
