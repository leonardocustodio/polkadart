import 'package:build/build.dart';
import 'package:scale_codec_annotation/scale_codec_annotation.dart';
import 'package:source_gen/source_gen.dart';

import 'scale_codec_serializable.dart';
import 'src/type_helpers/config_types.dart';

/// Returns a [Builder] for use within a `package:build_runner`
///
/// The default Dart code formatter is used.
///
/// [BuilderOptions] came from `options`
/// in `scale_codec_serializable` builder target
/// on `build.yaml`.
///
/// User can customize these options like the following example:
///
/// On `build.yaml` file:
/// ```
/// targets:
///  $default:
///    builders:
///      scale_codec_serializable:
///        enabled: true
///        options:
///           should_generate_decode_method: false
///           should_generate_encode_method: true
///
/// ```
Builder scaleCodecBuilder(BuilderOptions options) {
  try {
    final builderConfig = ScaleCodecSerializable.fromMap(options.config);
    final classConfig = ClassConfig.fromScaleCodecSerializable(builderConfig);

    final builder = SharedPartBuilder(
        [ScaleCodecSerializableGenerator(config: classConfig)],
        'scale_codec_serializable');

    return builder;
  } catch (e) {
    throw StateError(
        'Could not parse the options provided for `scale_codec_serializable`: $e');
  }
}
