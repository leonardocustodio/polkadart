import 'package:path/path.dart' as p;
import 'package:scale_codec_serializable/scale_codec_serializable.dart';
import 'package:scale_codec_serializable/src/config.dart';
import 'package:source_gen_test/source_gen_test.dart';

Future<void> main() async {
  initializeBuildLogTracking();

  const expectedAnnotatedTests = {
    'OneStringField',
    'TwoStringFields',
    'DoubleField',
    'BooleanField',
    'IntegerField',
    'BigIntField',
    'MapField',
    'ListField',
    'NumberField',
    'SetField',
  };

  final reader = await initializeLibraryReaderForDirectory(
    p.join('test', 'inputs'),
    'encoded_fields_test_input.dart',
  );

  testAnnotatedElements(
    reader,
    const ScaleCodecSerializableGenerator(config: ClassConfig.defaults),
    expectedAnnotatedTests: expectedAnnotatedTests,
  );
}
