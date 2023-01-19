import 'package:codec_generator/exceptions.dart';
import 'package:codec_generator/generator_types/generator_base.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  group('Primitive Exceptions Test', () {
    test('should generate correct code for a primitive type Exception', () {
      // Given
      final json = {
        "id": 10, // can be any number
        "type": {
          "def": {
            "Primitive": "List<int>", // List can't be a primitive as List is a complex type!
          },
        },
      };

      expect(() => PrimitiveTypeGenerator.fromJson(json),
          throwsA(isA<UnknownPrimitiveException>()));
    });
  });
}
