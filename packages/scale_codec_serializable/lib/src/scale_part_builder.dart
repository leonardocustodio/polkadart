import 'package:build/build.dart';
import 'package:scale_codec_annotation/scale_codec_annotation.dart';
import 'package:scale_codec_serializable/src/scale_codec_serializable_generator.dart';
import 'package:scale_codec_serializable/src/type_helpers/config_types.dart';
import 'package:source_gen/source_gen.dart';

/// Returns a [Builder] for use within a `package:build_runner`
/// `BuildAction`.
///
/// The default Dart code formatter is used.
Builder scaleCodecPartBuilder({ScaleCodecSerializable? config}) {
  ClassConfig classConfig;

  classConfig = config != null
      ? ClassConfig.fromScaleCodecSerializable(config)
      : ClassConfig.defaults;

  return SharedPartBuilder(
      [ScaleCodecSerializableGenerator.withConfig(classConfig)],
      'scale_codec_serializable');
}
