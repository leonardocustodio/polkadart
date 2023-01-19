import 'package:codec_generator/generator_types/generator_base.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Primitive Signed Integers Generator test', () {
    test('should generate correct code for a primitive type i8', () {
      // Given
      final json = {
        "id": 100, // can be any number
        "type": {
          "def": {
            "Primitive": "i8",
          },
        },
      };

      // When
      final generator = PrimitiveTypeGenerator.fromJson(json);

      final expectedGeneratedCode =
          '''import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'; as scale_codec

class I8Codec extends scale_codec.Encoder {

final int value;

  I8Codec({
    required this.value,
  });

  @override
  void encode(scale_codec.Encoder encoder) {
    // scale_codec.I8().encode(encoder, value);
  }

}
''';

      // Then
      expect(generator.toClass(), expectedGeneratedCode);
    });

    test('should generate correct code for a primitive type i16', () {
      // Given
      final json = {
        "id": 23, // can be any number
        "type": {
          "def": {
            "Primitive": "i16",
          },
        },
      };

      // When
      final generator = PrimitiveTypeGenerator.fromJson(json);

      final expectedGeneratedCode =
          '''import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'; as scale_codec

class I16Codec extends scale_codec.Encoder {

final int value;

  I16Codec({
    required this.value,
  });

  @override
  void encode(scale_codec.Encoder encoder) {
    // scale_codec.I16().encode(encoder, value);
  }

}
''';

      // Then
      expect(generator.toClass(), expectedGeneratedCode);
    });

    test('should generate correct code for a primitive type i32', () {
      // Given
      final json = {
        "id": 74, // can be any number
        "type": {
          "def": {
            "Primitive": "i32",
          },
        },
      };

      // When
      final generator = PrimitiveTypeGenerator.fromJson(json);

      final expectedGeneratedCode =
          '''import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'; as scale_codec

class I32Codec extends scale_codec.Encoder {

final int value;

  I32Codec({
    required this.value,
  });

  @override
  void encode(scale_codec.Encoder encoder) {
    // scale_codec.I32().encode(encoder, value);
  }

}
''';

      // Then
      expect(generator.toClass(), expectedGeneratedCode);
    });

    test('should generate correct code for a primitive type i64', () {
      // Given
      final json = {
        "id": 2323, // can be any number
        "type": {
          "def": {
            "Primitive": "i64",
          },
        },
      };

      // When
      final generator = PrimitiveTypeGenerator.fromJson(json);

      final expectedGeneratedCode =
          '''import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'; as scale_codec

class I64Codec extends scale_codec.Encoder {

final BigInt value;

  I64Codec({
    required this.value,
  });

  @override
  void encode(scale_codec.Encoder encoder) {
    // scale_codec.I64().encode(encoder, value);
  }

}
''';

      // Then
      expect(generator.toClass(), expectedGeneratedCode);
    });

    test('should generate correct code for a primitive type i128', () {
      // Given
      final json = {
        "id": 128, // can be any number
        "type": {
          "def": {
            "Primitive": "i128",
          },
        },
      };

      // When
      final generator = PrimitiveTypeGenerator.fromJson(json);

      final expectedGeneratedCode =
          '''import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'; as scale_codec

class I128Codec extends scale_codec.Encoder {

final BigInt value;

  I128Codec({
    required this.value,
  });

  @override
  void encode(scale_codec.Encoder encoder) {
    // scale_codec.I128().encode(encoder, value);
  }

}
''';

      // Then
      expect(generator.toClass(), expectedGeneratedCode);
    });

    test('should generate correct code for a primitive type i256', () {
      // Given
      final json = {
        "id": 213,
        "type": {
          "def": {
            "Primitive": "i256",
          },
        },
      };

      // When
      final generator = PrimitiveTypeGenerator.fromJson(json);

      final expectedGeneratedCode =
          '''import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'; as scale_codec

class I256Codec extends scale_codec.Encoder {

final BigInt value;

  I256Codec({
    required this.value,
  });

  @override
  void encode(scale_codec.Encoder encoder) {
    // scale_codec.I256().encode(encoder, value);
  }

}
''';

      // Then
      expect(generator.toClass(), expectedGeneratedCode);
    });
  });
}
