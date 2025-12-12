import 'dart:typed_data';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:test/test.dart';

void main() {
  group('StrCodec Tests', () {
    test('Should encode and decode normal strings correctly', () {
      const testString = 'Hello, World!';
      final encoded = StrCodec.codec.encode(testString);
      final decoded = StrCodec.codec.decode(ByteInput(encoded));

      expect(decoded, equals(testString));
    });

    test('Should encode and decode empty strings correctly', () {
      const testString = '';
      final encoded = StrCodec.codec.encode(testString);
      final decoded = StrCodec.codec.decode(ByteInput(encoded));

      expect(decoded, equals(testString));
    });

    test('Should encode and decode unicode strings correctly', () {
      const testString = '🚀 Polkadart 🎯';
      final encoded = StrCodec.codec.encode(testString);
      final decoded = StrCodec.codec.decode(ByteInput(encoded));

      expect(decoded, equals(testString));
    });

    test('Should strip trailing null bytes when decoding', () {
      // Create a string with null bytes like in blockchain metadata
      // "root" followed by null bytes
      final bytes = [
        16, // compact encoding of length 16
        114, 111, 111, 116, // "root"
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, // 12 null bytes
      ];

      final decoded = StrCodec.codec.decode(
        ByteInput(Uint8List.fromList(bytes)),
      );
      expect(decoded, equals('root'));
      expect(decoded.length, equals(4));
    });

    test('Should preserve null bytes in the middle of strings', () {
      // String with null byte in the middle: "test\x00data"
      final bytes = [
        36, // compact encoding of length 9
        116, 101, 115, 116, // "test"
        0, // null byte
        100, 97, 116, 97, // "data"
      ];

      final decoded = StrCodec.codec.decode(
        ByteInput(Uint8List.fromList(bytes)),
      );
      expect(decoded, equals('test')); // Should stop at first null
      expect(decoded.length, equals(4));
    });

    test('Should handle strings that are exactly the encoded length', () {
      // "whitelisted_caller" - exactly 18 bytes
      final testString = 'whitelisted_caller';
      final encoded = [
        72, // compact encoding of length 18
        119, 104, 105, 116, 101, 108, 105, 115, 116, 101, 100, 95, 99, 97, 108,
        108, 101, 114,
      ];

      final decoded = StrCodec.codec.decode(
        ByteInput(Uint8List.fromList(encoded)),
      );
      expect(decoded, equals(testString));
    });

    test('Should calculate correct size hint', () {
      const testString = 'Hello';
      final sizeHint = StrCodec.codec.sizeHint(testString);
      final encoded = StrCodec.codec.encode(testString);

      expect(sizeHint, equals(encoded.length));
    });
  });
}
