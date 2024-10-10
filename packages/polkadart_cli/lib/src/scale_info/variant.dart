part of scale_info;

/// A struct enum variant with either named (struct) or unnamed (tuple struct)
/// fields.
class Variant {
  /// Index of the variant, used in `parity-scale-codec`.
  final int index;

  /// The name of the variant.
  final String name;

  /// The fields of the variant.
  final List<Field> fields;

  /// Documentation
  final List<String> docs;

  /// Creates a new variant.
  const Variant(
      {required this.index,
      required this.name,
      required this.fields,
      required this.docs});

  factory Variant.fromJson(Map<String, dynamic> json) {
    final List<Field> fields =
        (json['fields'] as List).map((field) => Field.fromJson(field)).toList();
    return Variant(
      index: json['index'] as int,
      name: json['name'] as String,
      fields: fields,
      docs: (json['docs'] as List).cast<String>(),
    );
  }

  Set<int> typeDependencies() {
    return fields.map((field) => field.type).toSet();
  }
}
