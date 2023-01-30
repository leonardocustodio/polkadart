/* import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('FixedVec Decode Test', () {
    test(
        'When value 0x0001010002010300 is decoded then it returns [[0, true], [1, false], [2, true], [3, false]]',
        () {
      final codec = Codec().fetchTypeCodec('[(u8, bool); 4]');
      final compactValue =
          codec.decode(DefaultInput.fromHex('0x0001010002010300'));
      expect(
          compactValue,
          equals([
            [0, true],
            [1, false],
            [2, true],
            [3, false]
          ]));
    });

    test(
        'When value 0x05060708090a0b0c0d0e0f1011121314 is decoded then it returns [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]',
        () {
      final codec = Codec().fetchTypeCodec('[u8; 16]');
      final compactValue = codec
          .decode(DefaultInput.fromHex('0x05060708090a0b0c0d0e0f1011121314'));
      expect(compactValue,
          equals([5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]));
    });
  });

  group('FixedVec Encode Test', () {
    test('When value [1, 2, 3, 4] is encoded then it returns 0x041001020304',
        () {
      final codec = Codec().fetchTypeCodec('[u8; 4]');
      final encoder = HexEncoder();
      codec.encode(encoder, [1, 2, 3, 4]);
      expect(encoder.toHex(), equals('0x01020304'));
    });

    test('When value [5, 6, 7, 8] is encoded then it returns 0x05060708', () {
      final codec = Codec().fetchTypeCodec('[u8; 4]');
      final encoder = HexEncoder();
      codec.encode(encoder, [5, 6, 7, 8]);
      expect(encoder.toHex(), equals('0x05060708'));
    });

    test(
        'When value [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20] is encoded then it returns 0x05060708090a0b0c0d0e0f1011121314',
        () {
      final codec = Codec().fetchTypeCodec('[u8; 16]');
      final encoder = HexEncoder();
      codec.encode(
          encoder, [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]);
      expect(encoder.toHex(), equals('0x05060708090a0b0c0d0e0f1011121314'));
    });

    test(
        'When value [[0, true], [1, false], [2, true], [3, false]] is encoded then it returns 0x0001010002010300',
        () {
      final codec = Codec().fetchTypeCodec('[(u8, bool); 4]');
      final encoder = HexEncoder();
      codec.encode(encoder, [
        [0, true],
        [1, false],
        [2, true],
        [3, false]
      ]);
      expect(encoder.toHex(), equals('0x0001010002010300'));
    });
  });

  group('Exception Test', () {
    test(
        'When negative length is used as codec then it throws an AssertionException',
        () {
      expect(() => Codec().fetchTypeCodec('[u8; -1]'),
          throwsA(isA<AssertionException>()));
    });

    test('When type other than list is encoded then it throws an exception',
        () {
      final codec = Codec().fetchTypeCodec('Vec<u8>');
      final encoder = HexEncoder();

      /// match exception string
      expect(
          () => codec.encode(encoder, 1),
          throwsA(predicate((e) =>
              e.toString() ==
              'type \'int\' is not a subtype of type \'List<dynamic>\' of \'values\'')));
    });

    test(
        'When Vector with empty subtype is decoded then it throws an SubtypeNotFoundException',
        () {
      final codec = Codec().fetchTypeCodec('Vec');
      expect(() => codec.decode(DefaultInput.fromHex('0x041001020304')),
          throwsA(isA<SubtypeNotFoundException>()));
    });
  });

  group('Custom Json Test', () {
    final registry = TypeRegistry.createRegistry()
      ..registerCustomCodec(
        <String, dynamic>{
          'Vec_key': 'Vec<A>',
          'A': 'Vec<u8>',
          'Vec_Without_Subtype': 'Vec',
        },
      );

    test('When value 0x041001020304 is decoded then it returns [[1, 2, 3, 4]]',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('Vec_key');
      final compactValue = codec.decode(DefaultInput.fromHex('0x041001020304'));
      expect(
          compactValue,
          equals([
            [1, 2, 3, 4]
          ]));
    });

    test(
        'When value 0x0810010203041005060708 is decoded then it returns [[1, 2, 3, 4], [5, 6, 7, 8]]',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('Vec_key');
      final compactValue =
          codec.decode(DefaultInput.fromHex('0x0810010203041005060708'));
      expect(
          compactValue,
          equals([
            [1, 2, 3, 4],
            [5, 6, 7, 8]
          ]));
    });

    test('When value 0x1001020304 is decoded then it returns [1, 2, 3, 4]', () {
      final codec = Codec(registry: registry).fetchTypeCodec('A');
      final compactValue = codec.decode(DefaultInput.fromHex('0x1001020304'));
      expect(compactValue, equals([1, 2, 3, 4]));
    });

    test(
        'When Vector with empty subtype is encoded then it throws an SubtypeNotFoundException',
        () {
      final codec =
          Codec(registry: registry).fetchTypeCodec('Vec_Without_Subtype');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, []),
          throwsA(isA<SubtypeNotFoundException>()));
    });

    test('When type other than list is encoded then it throws an exception',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('A');
      final encoder = HexEncoder();

      /// match exception string
      expect(
          () => codec.encode(encoder, 1),
          throwsA(predicate((e) =>
              e.toString() ==
              'type \'int\' is not a subtype of type \'List<dynamic>\' of \'values\'')));
    });

    test(
        'When Vector with empty subtype is decoded then it throws an SubtypeNotFoundException',
        () {
      final codec =
          Codec(registry: registry).fetchTypeCodec('Vec_Without_Subtype');
      expect(() => codec.decode(DefaultInput.fromHex('0x041001020304')),
          throwsA(isA<SubtypeNotFoundException>()));
    });
  });
}
 */