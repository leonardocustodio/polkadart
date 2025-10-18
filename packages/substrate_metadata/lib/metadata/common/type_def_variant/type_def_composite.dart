part of metadata;

/// Composite type (struct-like)
class TypeDefComposite extends TypeDefVariant {
  final List<Field> fields;
  const TypeDefComposite({required this.fields});

  static const $TypeDefVariant codec = TypeDefVariant.codec;

  @override
  Set<int> typeDependencies() {
    return fields.map((final Field field) => field.type).toSet();
  }

  @override
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (fields.isNotEmpty) {
      json['fields'] = fields.map((final Field e) => e.toJson()).toList();
    }
    return json;
  }
}

class $TypeDefComposite with Codec<TypeDefComposite> {
  const $TypeDefComposite._();

  @override
  TypeDefComposite decode(Input input) {
    final fields = SequenceCodec(Field.codec).decode(input);
    return TypeDefComposite(fields: fields);
  }

  @override
  void encodeTo(TypeDefComposite value, Output output) {
    SequenceCodec(Field.codec).encodeTo(value.fields, output);
  }

  @override
  int sizeHint(TypeDefComposite value) {
    return SequenceCodec(Field.codec).sizeHint(value.fields);
  }
}
