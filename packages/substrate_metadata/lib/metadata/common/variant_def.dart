part of metadata;

/// Variant in an enum type
///
/// Represents a single variant in an enum, similar to Rust enum variants.
/// Each variant has a name, discriminant index, optional fields, and documentation.
class VariantDef {
  /// Codec instance for VariantDef
  static const $VariantDef codec = $VariantDef._();

  /// Name of the variant
  final String name;

  /// Fields in this variant
  final List<Field> fields;

  /// Index/discriminant of the variant
  final int index;

  /// Documentation for this variant
  final List<String> docs;

  const VariantDef({
    required this.name,
    required this.fields,
    required this.index,
    this.docs = const [],
  });

  Set<int> typeDependencies() {
    return fields.map((final Field field) => field.type).toSet();
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'name': name,
    };
    if (fields.isNotEmpty) {
      json['fields'] = fields.map((final Field field) => field.toJson()).toList();
    }
    json['index'] = index;
    if (docs.isNotEmpty) {
      json['docs'] = docs;
    }
    return json;
  }
}

/// Codec for VariantDef
///
/// Handles encoding and decoding of enum variant definitions.
class $VariantDef with Codec<VariantDef> {
  const $VariantDef._();

  @override
  VariantDef decode(Input input) {
    // Decode variant name
    final name = StrCodec.codec.decode(input);

    // Decode fields
    final fields = SequenceCodec(Field.codec).decode(input);

    // Decode variant index
    final index = U8Codec.codec.decode(input);

    // Decode documentation
    final docs = SequenceCodec(StrCodec.codec).decode(input);

    return VariantDef(
      name: name,
      fields: fields,
      index: index,
      docs: docs,
    );
  }

  @override
  void encodeTo(VariantDef value, Output output) {
    StrCodec.codec.encodeTo(value.name, output);
    SequenceCodec(Field.codec).encodeTo(value.fields, output);
    U8Codec.codec.encodeTo(value.index, output);
    SequenceCodec(StrCodec.codec).encodeTo(value.docs, output);
  }

  @override
  int sizeHint(VariantDef value) {
    var size = 0;
    size += StrCodec.codec.sizeHint(value.name);
    size += SequenceCodec(Field.codec).sizeHint(value.fields);
    size += U8Codec.codec.sizeHint(value.index);
    size += SequenceCodec(StrCodec.codec).sizeHint(value.docs);
    return size;
  }

  @override
  bool isSizeZero() {
    return StrCodec.codec.isSizeZero() &&
        SequenceCodec(Field.codec).isSizeZero() &&
        U8Codec.codec.isSizeZero() &&
        SequenceCodec(StrCodec.codec).isSizeZero();
  }
}
