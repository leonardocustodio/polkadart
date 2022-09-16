import 'package:scale_codec_annotation/scale_codec_annotation.dart';

/// Represents values from [ScaleCodecKey] when merged with local configuration.
class KeyConfig {
  final bool shouldIgnore;

  KeyConfig({
    required this.shouldIgnore,
  });
}

/// Represents values from [ScaleCodecSerializable] when merged with local
/// configuration.
///
/// Values are all known, so types are non-nullable.
class ClassConfig {
  final bool shouldCreateDecodeMethod;
  final bool shouldCreateEncodeMethod;

  const ClassConfig(
      {required this.shouldCreateDecodeMethod,
      required this.shouldCreateEncodeMethod});

  factory ClassConfig.fromScaleCodecSerializable(
          ScaleCodecSerializable config) =>
      ClassConfig(
          shouldCreateDecodeMethod: config.shouldCreateDecodeMethod,
          shouldCreateEncodeMethod: config.shouldCreateEncodeMethod);

  /// An instance of [ScaleCodecSerializable] with
  /// all fields set to their default values.
  static const defaults = ClassConfig(
    shouldCreateDecodeMethod: true,
    shouldCreateEncodeMethod: true,
  );

  ScaleCodecSerializable toScaleCodecSerializable() => ScaleCodecSerializable(
        shouldCreateDecodeMethod: shouldCreateDecodeMethod,
        shouldCreateEncodeMethod: shouldCreateEncodeMethod,
      );
}
