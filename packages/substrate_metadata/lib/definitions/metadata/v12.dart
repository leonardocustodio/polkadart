/// (From Tag: @subsquid/substrate-metadata_v1.1.0)
///
/// Referenced from: https://github.com/subsquid/squid/blob/%40subsquid/substrate-metadata_v1.1.0/substrate-metadata/src/old/definitions/metadata/v12.ts

// ignore_for_file: constant_identifier_names

part of metadata;

const V12 = <String, dynamic>{
  'ErrorMetadataV12': 'ErrorMetadataV11',
  'EventMetadataV12': 'EventMetadataV11',
  'ExtrinsicMetadataV12': 'ExtrinsicMetadataV11',
  'FunctionArgumentMetadataV12': 'FunctionArgumentMetadataV11',
  'FunctionMetadataV12': 'FunctionMetadataV11',
  'MetadataV12': {
    'modules': 'Vec<ModuleMetadataV12>',
    'extrinsic': 'ExtrinsicMetadataV12'
  },
  'ModuleConstantMetadataV12': 'ModuleConstantMetadataV11',
  'ModuleMetadataV12': {
    'name': 'Text',
    'storage': 'Option<StorageMetadataV12>',
    'calls': 'Option<Vec<FunctionMetadataV12>>',
    'events': 'Option<Vec<EventMetadataV12>>',
    'constants': 'Vec<ModuleConstantMetadataV12>',
    'errors': 'Vec<ErrorMetadataV12>',
    'index': 'u8'
  },
  'StorageEntryModifierV12': 'StorageEntryModifierV11',
  'StorageEntryMetadataV12': 'StorageEntryMetadataV11',
  'StorageEntryTypeV12': 'StorageEntryTypeV11',
  'StorageMetadataV12': 'StorageMetadataV11',
  'StorageHasherV12': 'StorageHasherV11'
};
