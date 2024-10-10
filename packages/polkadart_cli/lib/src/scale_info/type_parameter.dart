part of scale_info;

/// A generic type parameter.
class TypeParameter {
  /// The name of the generic type parameter e.g. "T".
  final String name;

  /// The concrete type for the type parameter.
  ///
  /// `null` if the type parameter is skipped.
  final int? type;

  const TypeParameter({required this.name, this.type});
}
