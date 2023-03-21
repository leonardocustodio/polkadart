part of metadata;

final metadataTypes = LegacyTypes(
  types: <String, dynamic>{
    'Type': 'Str',
    'Bytes': 'Vec<U8>',
    'H256': '[u8; 32]',
    ...ScaleInfoTypes,
    ...V9,
    ...V10,
    ...V11,
    ...V12,
    ...V13,
    ...V14,
  },
);
