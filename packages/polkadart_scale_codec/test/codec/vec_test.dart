import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Vec Decode Test', () {
    final registry = TypeRegistry.createRegistry();
    test('When value 0x041001020304 is decoded then it returns [[1, 2, 3, 4]]',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('Vec<Vec<u8>>');
      final compactValue = codec.decode(Input('0x041001020304'));
      expect(
          compactValue,
          equals([
            [1, 2, 3, 4]
          ]));
    });

    test(
        'When value 0x0810010203041005060708 is decoded then it returns [[1, 2, 3, 4], [5, 6, 7, 8]]',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('Vec<Vec<u8>>');
      final compactValue = codec.decode(Input('0x0810010203041005060708'));
      expect(
          compactValue,
          equals([
            [1, 2, 3, 4],
            [5, 6, 7, 8]
          ]));
    });

    /// Vec<Vec<bool>>
    test(
        'When value 0x0810010001000c010000 is decoded then it returns [[true, false, true, false], [true, false, false]]',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('Vec<Vec<bool>>');
      final compactValue = codec.decode(Input('0x0810010001000c010000'));
      expect(
          compactValue,
          equals([
            [true, false, true, false],
            [true, false, false]
          ]));
    });
  });

  group('Vec Encode Test', () {
    final registry = TypeRegistry.createRegistry();

    test('When value [[1, 2, 3, 4]] is encoded then it returns 0x041001020304',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('Vec<Vec<u8>>');
      final encoder = HexEncoder();
      codec.encode(encoder, [
        [1, 2, 3, 4]
      ]);
      expect(encoder.toHex(), equals('0x041001020304'));
    });

    test(
        'When value [[1, 2, 3, 4], [5, 6, 7, 8]] is encoded then it returns 0x0810010203041005060708',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('Vec<Vec<u8>>');
      final encoder = HexEncoder();
      codec.encode(encoder, [
        [1, 2, 3, 4],
        [5, 6, 7, 8]
      ]);
      expect(encoder.toHex(), equals('0x0810010203041005060708'));
    });

    /// Vec<Vec<bool>>
    test(
        'When value [[true, false, true, false], [true, false, false]] is encoded then it returns 0x0810010001000c010000',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('Vec<Vec<bool>>');
      final encoder = HexEncoder();
      codec.encode(encoder, [
        [true, false, true, false],
        [true, false, false]
      ]);
      expect(encoder.toHex(), equals('0x0810010001000c010000'));
    });
  });

  group('Exception Test', () {
    final registry = TypeRegistry.createRegistry();

    test(
        'When Vector with empty subtype is encoded then it throws an SubtypeNotFoundException',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('Vec');
      final encoder = HexEncoder();
      expect(() => codec.encode(encoder, []),
          throwsA(isA<SubtypeNotFoundException>()));
    });

    test('When type other than list is encoded then it throws an exception',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('Vec<u8>');
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
      final codec = Codec(registry: registry).fetchTypeCodec('Vec');
      expect(() => codec.decode(Input('0x041001020304')),
          throwsA(isA<SubtypeNotFoundException>()));
    });
  });

  group('Custom Json Test', () {
    final registry = TypeRegistry.createRegistry();
    registry.addCustomCodec(
      <String, dynamic>{
        'A': 'Vec<u8>',
        'Vec_key': 'Vec<A>',
        'Vec_Without_Subtype': 'Vec',
      },
    );

    test('When value 0x041001020304 is decoded then it returns [[1, 2, 3, 4]]',
        () {
      final codec = Codec(registry: registry).fetchTypeCodec('Vec_key');
      final compactValue = codec.decode(Input('0x041001020304'));
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
      final compactValue = codec.decode(Input('0x0810010203041005060708'));
      expect(
          compactValue,
          equals([
            [1, 2, 3, 4],
            [5, 6, 7, 8]
          ]));
    });

    test('When value 0x1001020304 is decoded then it returns [1, 2, 3, 4]', () {
      final codec = Codec(registry: registry).fetchTypeCodec('A');
      final compactValue = codec.decode(Input('0x1001020304'));
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
      expect(() => codec.decode(Input('0x041001020304')),
          throwsA(isA<SubtypeNotFoundException>()));
    });
  });
}
