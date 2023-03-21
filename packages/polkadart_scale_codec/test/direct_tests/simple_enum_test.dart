import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('SimpleEnumCodec.fromList Encode', () {
    test('should encode and decode', () {
      final output = HexOutput();
      final codec = SimpleEnumCodec.fromList(['a', 'b', 'c']);
      codec.encodeTo('b', output);
      expect(output.toString(), '0x01');
    });

    test('should throw error when invalid value', () {
      final output = HexOutput();
      final codec = SimpleEnumCodec.fromList(['a', 'b', 'c']);
      expect(() => codec.encodeTo('d', output), throwsA(isA<EnumException>()));
    });
  });

  group('SimpleEnumCodec.sparse Encode', () {
    test('should encode and decode', () {
      final output = HexOutput();
      final codec = SimpleEnumCodec.sparse({0: 'a', 1: 'b', 2: 'c'});
      codec.encodeTo('b', output);
      expect(output.toString(), '0x01');
    });

    test('should throw error when invalid value', () {
      final output = HexOutput();
      final codec = SimpleEnumCodec.sparse({0: 'a', 1: 'b', 2: 'c'});
      expect(() => codec.encodeTo('d', output), throwsA(isA<EnumException>()));
    });
  });

  group('SimpleEnumCodec.fromList Decode', () {
    test('should encode and decode', () {
      final input = Input.fromHex('0x01');
      final codec = SimpleEnumCodec.fromList(['a', 'b', 'c']);
      expect(codec.decode(input), 'b');
    });

    test('should throw error when invalid index', () {
      final input = Input.fromHex('0x03');
      final codec = SimpleEnumCodec.fromList(['a', 'b', 'c']);
      expect(() => codec.decode(input), throwsA(isA<EnumException>()));
    });
  });
  group('SimpleEnumCodec.sparse Decode', () {
    test('should encode and decode', () {
      final input = Input.fromHex('0x01');
      final codec = SimpleEnumCodec.sparse({0: 'a', 1: 'b', 2: 'c'});
      expect(codec.decode(input), 'b');
    });

    test('should throw error when invalid index', () {
      final input = Input.fromHex('0x03');
      final codec = SimpleEnumCodec.sparse({0: 'a', 1: 'b', 4: 'c'});
      expect(() => codec.decode(input), throwsA(isA<EnumException>()));
      expect(input.remainingLength, 0);
    });
  });
}
