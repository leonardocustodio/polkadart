import 'package:path/path.dart' as p;
import 'package:scale_codec_serializable/scale_codec_serializable.dart';
import 'package:scale_codec_serializable/src/config.dart';
import 'package:source_gen_test/source_gen_test.dart';

Future<void> main() async {
  initializeBuildLogTracking();

  /// name of all classes test must find and run
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

  /// location of the file which contain [expectedAnnotatedTests]
  /// classes
  final reader = await initializeLibraryReaderForDirectory(
    p.join('test', 'inputs'),
    'encoded_fields_test_input.dart',
  );

  /// test the `build_runner` and [ScaleCodecSerializableGenerator]
  /// for each case of [expectedAnnotatedTests]
  testAnnotatedElements(
    reader,
    const ScaleCodecSerializableGenerator(config: ClassConfig.defaults),
    expectedAnnotatedTests: expectedAnnotatedTests,
  );
}
