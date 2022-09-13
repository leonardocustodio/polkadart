import 'package:scale_codec_annotation/scale_codec_annotation.dart';

/// Represents values from [JsonKey] when merged with local configuration.
class KeyConfig {
  final bool ignore;

  KeyConfig({
    required this.ignore,
  });
}

/// Represents values from [ScaleCodecSerializable] when merged with local
/// configuration.
///
/// Values are all known, so types are non-nullable.
class ClassConfig {
  final bool createDecodeMethod;
  final bool createEncodeMethod;

  const ClassConfig(
      {required this.createDecodeMethod, required this.createEncodeMethod});

  factory ClassConfig.fromScaleCodecSerializable(
          ScaleCodecSerializable config) =>
      ClassConfig(
        createDecodeMethod: config.createDecodeMethod ??
            ClassConfig.defaults.createDecodeMethod,
        createEncodeMethod: config.createEncodeMethod ??
            ClassConfig.defaults.createEncodeMethod,
      );

  /// An instance of [ScaleCodecSerializable] with all fields set to their default
  /// values.
  static const defaults = ClassConfig(
    createDecodeMethod: true,
    createEncodeMethod: true,
  );

  ScaleCodecSerializable toScaleCodecSerializable() => ScaleCodecSerializable(
        createDecodeMethod: createDecodeMethod,
        createEncodeMethod: createEncodeMethod,
      );
}
