import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('Complex Enum Codec Encode Test', () {
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

  group('Complex Enum Codec Decode Test', () {
    test('should decode and encode', () {
      final input = HexInput('0x0102');
      final codec = ComplexEnumCodec.fromList([
        MapEntry('a', SimpleEnumCodec.fromList(['a', 'b', 'c'])),
        MapEntry('b', SimpleEnumCodec.fromList(['d', 'e', 'f'])),
        MapEntry('c', SimpleEnumCodec.fromList(['g', 'h', 'i'])),
      ]);
      expect(codec.decode(input).toString(), MapEntry('b', 'f').toString());
    });

    test('should throw error when invalid index', () {
      final input = HexInput('0x0302');
      final codec = ComplexEnumCodec.fromList([
        MapEntry('a', SimpleEnumCodec.fromList(['a', 'b', 'c'])),
        MapEntry('b', SimpleEnumCodec.fromList(['d', 'e', 'f'])),
        MapEntry('c', SimpleEnumCodec.fromList(['g', 'h', 'i'])),
      ]);
      expect(() => codec.decode(input), throwsA(isA<EnumException>()));
    });
  });
}
