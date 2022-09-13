import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:scale_codec_annotation/scale_codec_annotation.dart';
import 'package:scale_codec_serializable/src/settings.dart';
import 'package:source_gen/source_gen.dart';

import 'generator_helper.dart';

class ScaleCodecSerializableGenerator
    extends GeneratorForAnnotation<ScaleCodecSerializable> {
  final Settings _settings;

  ScaleCodecSerializable get config =>
      _settings.config.toScaleCodecSerializable();

  ScaleCodecSerializableGenerator.fromSettings(this._settings);

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

    final helper = GeneratorHelper(_settings, element, annotation);
    return helper.generate();
  }
}
