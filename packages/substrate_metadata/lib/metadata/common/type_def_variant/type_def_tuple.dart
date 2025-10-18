part of metadata;

/// Tuple type
///
/// Represents a tuple like (u32, bool, AccountId).
class TypeDefTuple extends TypeDefVariant {
  final List<int> fields;
  const TypeDefTuple({required this.fields});

  static const $TypeDefVariant codec = TypeDefVariant.codec;

  @override
  Set<int> typeDependencies() {
    return fields.toSet();
  }

  @override
  Map<String, dynamic> toJson() {
    return {'fields': fields};
  }
}

class $TypeDefTuple with Codec<TypeDefTuple> {
  const $TypeDefTuple._();

  @override
  TypeDefTuple decode(Input input) {
    final fields = SequenceCodec(CompactCodec.codec).decode(input);
    return TypeDefTuple(fields: fields);
  }

  @override
  void encodeTo(TypeDefTuple value, Output output) {
    SequenceCodec(CompactCodec.codec).encodeTo(value.fields, output);
  }

  @override
  int sizeHint(TypeDefTuple value) {
    return SequenceCodec(CompactCodec.codec).sizeHint(value.fields);
  }
}
