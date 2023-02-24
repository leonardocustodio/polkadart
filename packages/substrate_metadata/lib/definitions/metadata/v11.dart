/// (From Tag: @subsquid/substrate-metadata_v1.1.0)
///
/// Referenced from: https://github.com/subsquid/squid/blob/%40subsquid/substrate-metadata_v1.1.0/substrate-metadata/src/old/definitions/metadata/v11.ts

// ignore_for_file: constant_identifier_names

part of metadata;

const V11 = <String, dynamic>{
  'ErrorMetadataV11': 'ErrorMetadataV10',
  'EventMetadataV11': 'EventMetadataV10',
  'ExtrinsicMetadataV11': {'version': 'U8', 'signedExtensions': 'Vec<Text>'},
  'FunctionArgumentMetadataV11': 'FunctionArgumentMetadataV10',
  'FunctionMetadataV11': 'FunctionMetadataV10',
  'MetadataV11': {
    'modules': 'Vec<ModuleMetadataV11>',
    'extrinsic': 'ExtrinsicMetadataV11'
  },
  'ModuleConstantMetadataV11': 'ModuleConstantMetadataV10',
  'ModuleMetadataV11': {
    'name': 'Text',
    'storage': 'Option<StorageMetadataV11>',
    'calls': 'Option<Vec<FunctionMetadataV11>>',
    'events': 'Option<Vec<EventMetadataV11>>',
    'constants': 'Vec<ModuleConstantMetadataV11>',
    'errors': 'Vec<ErrorMetadataV11>'
  },
  'StorageEntryModifierV11': 'StorageEntryModifierV10',
  'StorageEntryMetadataV11': {
    'name': 'Text',
    'modifier': 'StorageEntryModifierV11',
    'type': 'StorageEntryTypeV11',
    'fallback': 'Bytes',
    'docs': 'Vec<Text>'
  },
  'StorageEntryTypeV11': {
    '_enum': {
      'Plain': 'Type',
      'Map': {
        'hasher': 'StorageHasherV11',
        'key': 'Type',
        'value': 'Type',
        'linked': 'bool'
      },
      'DoubleMap': {
        'hasher': 'StorageHasherV11',
        'key1': 'Type',
        'key2': 'Type',
        'value': 'Type',
        'key2Hasher': 'StorageHasherV11'
      }
    }
  },
  'StorageMetadataV11': {
    'prefix': 'Text',
    'items': 'Vec<StorageEntryMetadataV11>'
  },
  'StorageHasherV11': {
    '_enum': {
      'Blake2_128': 'Null',
      'Blake2_256': 'Null',
      'Blake2_128Concat': 'Null',
      'Twox128': 'Null',
      'Twox256': 'Null',
      'Twox64Concat': 'Null',
      // new in v11
      'Identity': 'Null'
    }
  }
};
