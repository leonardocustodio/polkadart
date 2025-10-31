part of metadata;

/// Variant type (enum-like)
///
/// Represents an enum with multiple variants, each potentially having fields.
class TypeDefVariant extends TypeDef {
  final List<VariantDef> variants;
  const TypeDefVariant({required this.variants});

  static const $TypeDef codec = TypeDef.codec;

  @override
  Set<int> typeDependencies() {
    final Set<int> dependencies = <int>{};
    for (final variant in variants) {
      dependencies.addAll(variant.typeDependencies());
    }
    return dependencies;
  }

  @override
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (variants.isNotEmpty) {
      json['variants'] = variants.map((e) => e.toJson()).toList();
    }
    return json;
  }
}

class $TypeDefVariant with Codec<TypeDefVariant> {
  const $TypeDefVariant._();

  @override
  TypeDefVariant decode(Input input) {
    final variants = SequenceCodec(VariantDef.codec).decode(input);
    return TypeDefVariant(variants: variants);
  }

  @override
  void encodeTo(TypeDefVariant value, Output output) {
    SequenceCodec(VariantDef.codec).encodeTo(value.variants, output);
  }

  @override
  int sizeHint(TypeDefVariant value) {
    return SequenceCodec(VariantDef.codec).sizeHint(value.variants);
  }

  @override
  bool isSizeZero() => SequenceCodec(VariantDef.codec).isSizeZero();
}
