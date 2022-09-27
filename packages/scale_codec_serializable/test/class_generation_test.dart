import 'package:path/path.dart' as p;
import 'package:scale_codec_serializable/scale_codec_serializable.dart';
import 'package:scale_codec_serializable/src/config.dart';
import 'package:source_gen_test/source_gen_test.dart';

Future<void> main() async {
  initializeBuildLogTracking();

  /// name of all classes test must find and run
  const expectedAnnotatedTests = {
    'EnumExample',
    'MultipleConstructors',
    'FactoryConstructor',
    'AbstractClass',
    'ValidClassWithAllMethods',
    'ValidClassWithEncodeMethod',
    'ValidClassWithDecodeMethod',
    'ValidClassWithoutMethods',
    'ValidClass',
    'OnlyEncodeMethod',
    'OnlyDecodeMethod',
  };

  /// location of the file which contain [expectedAnnotatedTests]
  /// classes
  final reader = await initializeLibraryReaderForDirectory(
    p.join('test', 'inputs'),
    'class_generation_test_input.dart',
  );

  /// test the `build_runner` and [ScaleCodecSerializableGenerator]
  /// for each case of [expectedAnnotatedTests]
  testAnnotatedElements(
    reader,
    const ScaleCodecSerializableGenerator(config: ClassConfig.defaults),
    expectedAnnotatedTests: expectedAnnotatedTests,
  );
}
