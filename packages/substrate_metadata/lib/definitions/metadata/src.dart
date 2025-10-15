part of metadata;

// Metadata type definitions for v14 and v15
final metadataTypes = <String, dynamic>{
  'Type': 'Str',
  'Bytes': 'Vec<U8>',
  'H256': '[u8; 32]',
  ...ScaleInfoTypes,
  ...V14,
  ...V15,
};
