import 'package:meta/meta_meta.dart';

/// An annotation used to specify how a field is serialized
@Target({TargetKind.field, TargetKind.getter})
class ScaleCodecKey {
  /// `true` if the generator should ignore this field completely.
  ///
  /// If `false`, the field will be considered for
  /// serialization.
  final bool isIgnored;

  /// Creates a new [ScaleCodecKey] instance.
  ///
  /// Only required when the default behavior is not desired.
  const ScaleCodecKey({
    this.isIgnored = false,
  });
}
