import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:scale_codec_annotation/scale_codec_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'generator_helper.dart';
import 'type_helpers/config_types.dart';

class ScaleCodecSerializableGenerator
    extends GeneratorForAnnotation<ScaleCodecSerializable> {
  final ClassConfig _config;
  ScaleCodecSerializableGenerator.withConfig(this._config);

  @override
  Iterable<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (!element.library!.isNonNullableByDefault) {
      throw InvalidGenerationSourceError(
          'Generator cannot target libraries that have not been migrated to '
          'null-safety.',
          element: element);
    }

    if (element is! ClassElement || element is EnumElement) {
      throw InvalidGenerationSourceError(
          '`@ScaleCodecSerializable` can only be used on classes. ',
          element: element);
    }

    final helper = GeneratorHelper(
      element,
      _config,
      annotation,
    );
    return helper.generate();
  }
}
