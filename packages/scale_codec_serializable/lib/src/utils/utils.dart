import 'package:scale_codec_annotation/scale_codec_annotation.dart';
import 'package:source_gen/source_gen.dart';

import '../config.dart';

/// Used to define types for [_valueForAnnotation].
class _Annotations {
  bool? shouldCreateDecodeMethod;
  bool? shouldCreateEncodeMethod;
  _Annotations(this.shouldCreateDecodeMethod, this.shouldCreateEncodeMethod);
}

/// Return an instance of [ScaleCodecSerializable] corresponding to the
/// provided [reader].
// #CHANGE WHEN UPDATING scale_codec_annotation
_Annotations _valueForAnnotation(ConstantReader reader) {
  final shouldCreateDecodeMethod =
      reader.read('shouldCreateDecodeMethod').literalValue as bool?;
  final shouldCreateEncodeMethod =
      reader.read('shouldCreateEncodeMethod').literalValue as bool?;

  return _Annotations(shouldCreateDecodeMethod, shouldCreateEncodeMethod);
}

/// Returns a [ClassConfig] with values from the [ScaleCodecSerializable]
/// instance represented by [reader].
///
/// For fields that are not defined in [ScaleCodecSerializable] or `null` in [reader],
/// use the values in [config].
ClassConfig mergeConfig(
    {required ClassConfig config, required ConstantReader reader}) {
  final annotation = _valueForAnnotation(reader);

  return ClassConfig(
    shouldCreateDecodeMethod:
        annotation.shouldCreateDecodeMethod ?? config.shouldCreateDecodeMethod,
    shouldCreateEncodeMethod:
        annotation.shouldCreateEncodeMethod ?? config.shouldCreateEncodeMethod,
  );
}
