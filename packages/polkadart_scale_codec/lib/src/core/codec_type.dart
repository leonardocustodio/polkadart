part of polkadart_scale_codec_core;

///
/// CodecStructTypeFields
class CodecStructTypeFields {
  final String name;
  final int type;
  const CodecStructTypeFields({required this.name, required this.type});
}

///
/// Mixin Class [CodecType] to provide a ref to sub CodecTypes: CodecStructType......
/// and [PrimitiveType] and with similar types extended to [Type].
mixin CodecType {
  TypeKind get kind;
}

///
/// CodecStructType
class CodecStructType with CodecType {
  final List<CodecStructTypeFields> fields;
  const CodecStructType({this.fields = const <CodecStructTypeFields>[]});

  @override
  TypeKind get kind => TypeKind.Struct;
}

///
/// CodecVariantType
class CodecVariantType with CodecType {
  final List<CodecVariant?> variants;
  final Map<String, CodecVariant> variantsByName;
  const CodecVariantType(
      {this.variants = const <CodecVariant?>[],
      this.variantsByName = const <String, CodecVariant>{}});

  @override
  TypeKind get kind => TypeKind.Variant;
}

///
/// CodecBytesType
class CodecBytesType with CodecType {
  const CodecBytesType();

  @override
  TypeKind get kind => TypeKind.Bytes;
}

///
/// CodecBytesArrayType
class CodecBytesArrayType with CodecType {
  final int length;
  const CodecBytesArrayType({required this.length});

  @override
  TypeKind get kind => TypeKind.BytesArray;
}

///
/// CodecCompactType
class CodecCompactType with CodecType {
  final Primitive integer;
  const CodecCompactType({required this.integer});

  @override
  TypeKind get kind => TypeKind.Compact;
}
