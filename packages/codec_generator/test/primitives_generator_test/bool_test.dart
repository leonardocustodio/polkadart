import 'package:codec_generator/generator_types/generator_base.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Primitive bool Generator test', () {
    test('should generate correct code for a primitive type bool', () {
      // Given
      final json = {
        "id": 10, // can be any number
        "type": {
          "def": {
            "Primitive": "bool",
          },
        },
      };

      // When
      final generator = PrimitiveTypeGenerator.fromJson(json);

      final expectedGeneratedCode =
          '''import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'; as scale_codec

class BoolCodec extends scale_codec.Encoder {

final bool value;

  BoolCodec({
    required this.value,
  });

  @override
  void encode(scale_codec.Encoder encoder) {
    // scale_codec.BoolCodec().encode(encoder, value);
  }

}
''';

      // Then
      expect(generator.toClass(), expectedGeneratedCode);
    });
  });
}
