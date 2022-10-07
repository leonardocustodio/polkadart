part of polkadart_scale_codec_core;

/// enum [TypeKind] helps the child's of [Type] to tell about their type and the properties and fields they consist
enum TypeKind {
  Primitive,
  Compact,
  Sequence,
  BitSequence,
  Array,
  Tuple,
  Composite,
  Variant,
  Option,
  DoNotConstruct,
  Bytes,
  BytesArray,
  Struct
}
