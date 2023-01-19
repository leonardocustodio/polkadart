import 'package:codec_generator/generator_types/generator_base.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Primitive UnSigned Integers Generator test', () {
    test('should generate correct code for a primitive type u8', () {
      // Given
      final json = {
        "id": 100, // can be any number
        "type": {
          "def": {
            "Primitive": "u8",
          },
        },
      };

      // When
      final generator = PrimitiveTypeGenerator.fromJson(json);

      final expectedGeneratedCode =
          '''import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'; as scale_codec

class U8Codec extends scale_codec.Encoder {

final int value;

  U8Codec({
    required this.value,
  });

  @override
  void encode(scale_codec.Encoder encoder) {
    // scale_codec.U8().encode(encoder, value);
  }

}
''';

      // Then
      expect(generator.toClass(), expectedGeneratedCode);
    });

    test('should generate correct code for a primitive type u16', () {
      // Given
      final json = {
        "id": 23, // can be any number
        "type": {
          "def": {
            "Primitive": "u16",
          },
        },
      };

      // When
      final generator = PrimitiveTypeGenerator.fromJson(json);

      final expectedGeneratedCode =
          '''import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'; as scale_codec

class U16Codec extends scale_codec.Encoder {

final int value;

  U16Codec({
    required this.value,
  });

  @override
  void encode(scale_codec.Encoder encoder) {
    // scale_codec.U16().encode(encoder, value);
  }

}
''';

      // Then
      expect(generator.toClass(), expectedGeneratedCode);
    });

    test('should generate correct code for a primitive type u32', () {
      // Given
      final json = {
        "id": 74, // can be any number
        "type": {
          "def": {
            "Primitive": "u32",
          },
        },
      };

      // When
      final generator = PrimitiveTypeGenerator.fromJson(json);

      final expectedGeneratedCode =
          '''import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'; as scale_codec

class U32Codec extends scale_codec.Encoder {

final int value;

  U32Codec({
    required this.value,
  });

  @override
  void encode(scale_codec.Encoder encoder) {
    // scale_codec.U32().encode(encoder, value);
  }

}
''';

      // Then
      expect(generator.toClass(), expectedGeneratedCode);
    });

    test('should generate correct code for a primitive type u64', () {
      // Given
      final json = {
        "id": 2323, // can be any number
        "type": {
          "def": {
            "Primitive": "u64",
          },
        },
      };

      // When
      final generator = PrimitiveTypeGenerator.fromJson(json);

      final expectedGeneratedCode =
          '''import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'; as scale_codec

class U64Codec extends scale_codec.Encoder {

final BigInt value;

  U64Codec({
    required this.value,
  });

  @override
  void encode(scale_codec.Encoder encoder) {
    // scale_codec.U64().encode(encoder, value);
  }

}
''';

      // Then
      expect(generator.toClass(), expectedGeneratedCode);
    });

    test('should generate correct code for a primitive type u128', () {
      // Given
      final json = {
        "id": 128, // can be any number
        "type": {
          "def": {
            "Primitive": "u128",
          },
        },
      };

      // When
      final generator = PrimitiveTypeGenerator.fromJson(json);

      final expectedGeneratedCode =
          '''import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'; as scale_codec

class U128Codec extends scale_codec.Encoder {

final BigInt value;

  U128Codec({
    required this.value,
  });

  @override
  void encode(scale_codec.Encoder encoder) {
    // scale_codec.U128().encode(encoder, value);
  }

}
''';

      // Then
      expect(generator.toClass(), expectedGeneratedCode);
    });

    test('should generate correct code for a primitive type u256', () {
      // Given
      final json = {
        "id": 213,
        "type": {
          "def": {
            "Primitive": "u256",
          },
        },
      };

      // When
      final generator = PrimitiveTypeGenerator.fromJson(json);

      final expectedGeneratedCode =
          '''import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'; as scale_codec

class U256Codec extends scale_codec.Encoder {

final BigInt value;

  U256Codec({
    required this.value,
  });

  @override
  void encode(scale_codec.Encoder encoder) {
    // scale_codec.U256().encode(encoder, value);
  }

}
''';

      // Then
      expect(generator.toClass(), expectedGeneratedCode);
    });
  });
}
