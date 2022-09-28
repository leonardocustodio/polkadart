part of polkadart_scale_codec_core;

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
