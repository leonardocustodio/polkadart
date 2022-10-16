/// (From Tag: @subsquid/substrate-metadata_v1.1.0)
///
/// Referenced from: https://github.com/subsquid/squid/blob/%40subsquid/substrate-metadata_v1.1.0/substrate-metadata/src/old/definitions/metadata/v9.ts

// ignore_for_file: constant_identifier_names

part of metadata;

const V9 = <String, dynamic>{
  'ErrorMetadataV9': {'name': 'Text', 'docs': 'Vec<Text>'},
  'EventMetadataV9': {'name': 'Text', 'args': 'Vec<Type>', 'docs': 'Vec<Text>'},
  'FunctionArgumentMetadataV9': {'name': 'Text', 'type': 'Type'},
  'FunctionMetadataV9': {
    'name': 'Text',
    'args': 'Vec<FunctionArgumentMetadataV9>',
    'docs': 'Vec<Text>'
  },
  'MetadataV9': {'modules': 'Vec<ModuleMetadataV9>'},
  'ModuleConstantMetadataV9': {
    'name': 'Text',
    'type': 'Type',
    'value': 'Bytes',
    'docs': 'Vec<Text>'
  },
  'ModuleMetadataV9': {
    'name': 'Text',
    'storage': 'Option<StorageMetadataV9>',
    'calls': 'Option<Vec<FunctionMetadataV9>>',
    'events': 'Option<Vec<EventMetadataV9>>',
    'constants': 'Vec<ModuleConstantMetadataV9>',
    'errors': 'Vec<ErrorMetadataV9>'
  },
  'StorageEntryMetadataV9': {
    'name': 'Text',
    'modifier': 'StorageEntryModifierV9',
    'type': 'StorageEntryTypeV9',
    'fallback': 'Bytes',
    'docs': 'Vec<Text>'
  },
  'StorageEntryModifierV9': {
    '_enum': ['Optional', 'Default', 'Required']
  },
  'StorageEntryTypeV9': {
    '_enum': {
      'Plain': 'Type',
      'Map': {
        'hasher': 'StorageHasherV9',
        'key': 'Type',
        'value': 'Type',
        'linked': 'bool'
      },
      'DoubleMap': {
        'hasher': 'StorageHasherV9',
        'key1': 'Type',
        'key2': 'Type',
        'value': 'Type',
        'key2Hasher': 'StorageHasherV9'
      }
    }
  },
  'StorageHasherV9': {
    '_enum': {
      'Blake2_128': null,
      'Blake2_256': null,
      'Twox128': null,
      'Twox256': null,
      'Twox64Concat': null
    }
  },
  'StorageMetadataV9': {
    'prefix': 'Text',
    'items': 'Vec<StorageEntryMetadataV9>'
  }
};
