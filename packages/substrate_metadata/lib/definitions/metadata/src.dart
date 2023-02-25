part of metadata;

final metadataTypes = LegacyTypes(
  types: <String, dynamic>{
    'Type': 'Str',
    'Bytes': 'Vec<U8>',
    ...ScaleInfoTypes,
    ...V9,
    ...V10,
    ...V11,
    ...V12,
  },
);
