import 'package:build/build.dart';
import 'package:scale_codec_annotation/scale_codec_annotation.dart';
import 'package:scale_codec_serializable/src/scale_codec_serializable_generator.dart';
import 'package:scale_codec_serializable/src/settings.dart';
import 'package:source_gen/source_gen.dart';

/// Returns a [Builder] for use within a `package:build_runner`
/// `BuildAction`.
///
/// The default Dart code formatter is used.
Builder scaleCodecPartBuilder({ScaleCodecSerializable? config}) {
  final settings = Settings(config: config);

  return SharedPartBuilder(
      [ScaleCodecSerializableGenerator.fromSettings(settings)],
      'scale_codec_serializable');
}
