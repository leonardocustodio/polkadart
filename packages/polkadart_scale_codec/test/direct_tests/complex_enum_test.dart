import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('ComplexEnumCodec.sparse Encode Test', () {
    test('should encode and decode', () {
      final output = HexOutput();
      final codec = ComplexEnumCodec.sparse(
        {
          0: MapEntry('a', SimpleEnumCodec.fromList(['a', 'b', 'c'])),
          1: MapEntry('b', SimpleEnumCodec.sparse({0: 'd', 1: 'e', 2: 'f'})),
          2: MapEntry('c', SimpleEnumCodec.fromList(['g', 'h', 'i'])),
        },
      );
      codec.encodeTo(MapEntry('b', 'f'), output);
      expect(output.toString(), '0x0102');
    });

    test('should throw error when invalid value', () {
      final output = HexOutput();
      final codec = ComplexEnumCodec.sparse(
        {
          0: MapEntry('a', SimpleEnumCodec.fromList(['a', 'b', 'c'])),
          1: MapEntry('b', SimpleEnumCodec.sparse({0: 'd', 1: 'e', 2: 'f'})),
          2: MapEntry('c', SimpleEnumCodec.fromList(['g', 'h', 'i'])),
        },
      );
      expect(() => codec.encodeTo(MapEntry('d', 'unknown'), output),
          throwsA(isA<EnumException>()));
    });
  });
  group('ComplexEnumCodec.fromList Encode Test', () {
    test('should encode and decode', () {
      final output = HexOutput();
      final codec = ComplexEnumCodec.fromList([
        MapEntry('a', SimpleEnumCodec.fromList(['a', 'b', 'c'])),
        MapEntry('b', SimpleEnumCodec.fromList(['d', 'e', 'f'])),
        MapEntry('c', SimpleEnumCodec.fromList(['g', 'h', 'i'])),
      ]);
      codec.encodeTo(MapEntry('b', 'f'), output);
      expect(output.toString(), '0x0102');
    });

    test('should throw error when invalid value', () {
      final output = HexOutput();
      final codec = ComplexEnumCodec.fromList([
        MapEntry('a', SimpleEnumCodec.fromList(['a', 'b', 'c'])),
        MapEntry('b', SimpleEnumCodec.fromList(['d', 'e', 'f'])),
        MapEntry('c', SimpleEnumCodec.fromList(['g', 'h', 'i'])),
      ]);
      expect(() => codec.encodeTo(MapEntry('d', 'unknown'), output),
          throwsA(isA<EnumException>()));
    });
  });

  group('ComplexEnumCodec.sparse Decode Test', () {
    test('should decode and encode', () {
      final input = Input.fromHex('0x0102');
      final codec = ComplexEnumCodec.sparse(
        {
          0: MapEntry('a', SimpleEnumCodec.fromList(['a', 'b', 'c'])),
          1: MapEntry('b', SimpleEnumCodec.sparse({0: 'd', 1: 'e', 2: 'f'})),
          2: MapEntry('c', SimpleEnumCodec.fromList(['g', 'h', 'i'])),
        },
      );
      expect(codec.decode(input).toString(), MapEntry('b', 'f').toString());
    });

    test('should throw error when invalid index', () {
      final input = Input.fromHex('0x0302');
      final codec = ComplexEnumCodec.sparse(
        {
          0: MapEntry('a', SimpleEnumCodec.fromList(['a', 'b', 'c'])),
          3: MapEntry('b', SimpleEnumCodec.sparse({0: 'd', 1: 'e', 4: 'f'})),
          4: MapEntry('c', SimpleEnumCodec.fromList(['g', 'h', 'i'])),
        },
      );
      expect(() => codec.decode(input), throwsA(isA<EnumException>()));
    });
  });

  group('ComplexEnumCodec.fromList Decode Test', () {
    test('should decode and encode', () {
      final input = Input.fromHex('0x0102');
      final codec = ComplexEnumCodec.fromList([
        MapEntry('a', SimpleEnumCodec.fromList(['a', 'b', 'c'])),
        MapEntry('b', SimpleEnumCodec.fromList(['d', 'e', 'f'])),
        MapEntry('c', SimpleEnumCodec.fromList(['g', 'h', 'i'])),
      ]);
      expect(codec.decode(input).toString(), MapEntry('b', 'f').toString());
    });

    test('should throw error when invalid index', () {
      final input = Input.fromHex('0x0302');
      final codec = ComplexEnumCodec.fromList([
        MapEntry('a', SimpleEnumCodec.fromList(['a', 'b', 'c'])),
        MapEntry('b', SimpleEnumCodec.fromList(['d', 'e', 'f'])),
        MapEntry('c', SimpleEnumCodec.fromList(['g', 'h', 'i'])),
      ]);
      expect(() => codec.decode(input), throwsA(isA<EnumException>()));
    });
  });
}
