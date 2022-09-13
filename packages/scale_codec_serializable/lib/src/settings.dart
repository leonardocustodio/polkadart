import 'package:scale_codec_annotation/scale_codec_annotation.dart';
import 'package:scale_codec_serializable/src/type_helper.dart';
import 'package:scale_codec_serializable/src/type_helpers/config_types.dart';

class Settings {
  static const _coreHelpers = <TypeHelper>[];

  static const defaultHelpers = <TypeHelper>[];
  final List<TypeHelper> _typeHelpers;

  Iterable<TypeHelper> get allHelpers =>
      const <TypeHelper>[].followedBy(_typeHelpers).followedBy(_coreHelpers);

  final ClassConfig config;

  /// Creates an instance of [Settings].
  ///
  /// If [typeHelpers] is not provided, the built-in helpers are used:
  /// [BigIntHelper], [DateTimeHelper], [DurationHelper], [JsonHelper], and
  /// [UriHelper].
  Settings({
    ScaleCodecSerializable? config,
    List<TypeHelper>? typeHelpers,
  })  : config = config != null
            ? ClassConfig.fromScaleCodecSerializable(config)
            : ClassConfig.defaults,
        _typeHelpers = typeHelpers ?? defaultHelpers;

  /// Creates an instance of [Settings].
  ///
  /// [typeHelpers] provides a set of [TypeHelper] that will be used along with
  /// the built-in helpers:
  /// [BigIntHelper], [DateTimeHelper], [DurationHelper], [JsonHelper], and
  /// [UriHelper].
  factory Settings.withDefaultHelpers(
    Iterable<TypeHelper> typeHelpers, {
    ScaleCodecSerializable? config,
  }) =>
      Settings(
        config: config,
        typeHelpers: List.unmodifiable(typeHelpers.followedBy(defaultHelpers)),
      );
}
