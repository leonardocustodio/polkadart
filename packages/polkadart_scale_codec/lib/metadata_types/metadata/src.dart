part of metadata;

const types = <String, dynamic>{
  'Type': 'Str',
  ...ScaleInfoTypes,
  ...V9,
  ...V10,
  ...V11,
  ...V12,
  ...V13,
  ...V14,
  /* 'Metadata': {
    '_enum': {
      // First version on Kusama is V9, dropping will be problematic
      'V9': 'MetadataV9',
      'V10': 'MetadataV10',
      'V11': 'MetadataV11',
      'V12': 'MetadataV12',
      'V13': 'MetadataV13',
      'V14': 'MetadataV14'
    }
  } */
};
