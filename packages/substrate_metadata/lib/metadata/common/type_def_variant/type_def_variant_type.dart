part of metadata;

/// Variant type (enum-like)
///
/// Represents an enum with multiple variants, each potentially having fields.
class TypeDefVariantType extends TypeDefVariant {
  final List<VariantDef> variants;
  const TypeDefVariantType({required this.variants});

  static const $TypeDefVariant codec = TypeDefVariant.codec;

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

class $TypeDefVariantType with Codec<TypeDefVariantType> {
  const $TypeDefVariantType._();

  @override
  TypeDefVariantType decode(Input input) {
    final variants = SequenceCodec(VariantDef.codec).decode(input);
    return TypeDefVariantType(variants: variants);
  }

  @override
  void encodeTo(TypeDefVariantType value, Output output) {
    SequenceCodec(VariantDef.codec).encodeTo(value.variants, output);
  }

  @override
  int sizeHint(TypeDefVariantType value) {
    return SequenceCodec(VariantDef.codec).sizeHint(value.variants);
  }
}
