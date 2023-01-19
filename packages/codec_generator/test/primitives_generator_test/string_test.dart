import 'package:codec_generator/generator_types/generator_base.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Primitive Str Generator test', () {
    test('should generate correct code for a primitive type Str', () {
      // Given
      final json = {
        "id": 100, // can be any number
        "type": {
          "def": {
            "Primitive": "Str",
          },
        },
      };

      // When
      final generator = PrimitiveTypeGenerator.fromJson(json);

      final expectedGeneratedCode =
          '''import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'; as scale_codec

class StrCodec extends scale_codec.Encoder {

final String value;

  StrCodec({
    required this.value,
  });

  @override
  void encode(scale_codec.Encoder encoder) {
    // scale_codec.StringCodec().encode(encoder, value);
  }

}
''';

      // Then
      expect(generator.toClass(), expectedGeneratedCode);
    });
  });
}
