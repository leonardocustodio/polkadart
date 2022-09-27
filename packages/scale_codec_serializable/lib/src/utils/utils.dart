import 'package:scale_codec_annotation/scale_codec_annotation.dart';
import 'package:source_gen/source_gen.dart';

import '../config.dart';

/// Returns a [ClassConfig] with values from the [ScaleCodecSerializable]
/// instance represented by [ConstantReader].
///
/// For fields that are not defined in [ScaleCodecSerializable] or `null` in [ConstantReader],
/// use the values in [ClassConfig].
extension ConfigMerger on ClassConfig {
  ClassConfig mergeWith(ConstantReader reader) {
    //#CHANGE WHEN UPDATING scale_codec_annotation
    final shouldCreateDecodeMethod =
        reader.read('shouldCreateDecodeMethod').literalValue as bool?;
    final shouldCreateEncodeMethod =
        reader.read('shouldCreateEncodeMethod').literalValue as bool?;

    return ClassConfig(
      shouldCreateDecodeMethod:
          shouldCreateDecodeMethod ?? this.shouldCreateDecodeMethod,
      shouldCreateEncodeMethod:
          shouldCreateEncodeMethod ?? this.shouldCreateEncodeMethod,
    );
  }
}
