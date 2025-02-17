/// (From Tag: @subsquid/substrate-metadata_v1.1.0)
///
/// Referenced from: https://github.com/subsquid/squid/blob/%40subsquid/substrate-metadata_v1.1.0/substrate-metadata/src/old/definitions/metadata/v14.ts

// ignore_for_file: constant_identifier_names

part of metadata;

const V15 = <String, dynamic>{
  'MetadataV15': {
    'types': 'PortableRegistryV15',
    'pallets': 'Vec<PalletMetadataV15>',
    'extrinsic': 'ExtrinsicMetadataV15',
    'type': 'Si1LookupTypeId',
    'apis': 'Vec<ApiMetadataV15>',
    'outerEnums': 'OuterEnumMetadataV15',
    'custom': 'CustomMetadataV15',
  },

  // registry
  'PortableRegistryV15': {
    'types': 'Vec<PortableTypeV15>',
  },
  'PortableTypeV15': {
    'id': 'Si1LookupTypeId',
    'type': 'Si1Type',
  },

  // compatibility with earlier layouts, i.e. don't break previous users
  'ErrorMetadataV15': {
    ...Si1Variant,
    'args': 'Vec<Type>',
  },
  'EventMetadataV15': {
    ...Si1Variant,
    'args': 'Vec<Type>',
  },
  'FunctionArgumentMetadataV15': {'name': 'Text', 'type': 'Type', 'typeName': 'Option<Type>'},
  'FunctionMetadataV15': {...Si1Variant, 'args': 'Vec<FunctionArgumentMetadataV15>'},

  // V15
  'CustomMetadataV15': {
    'map': 'BTreeMap<String, CustomMetadataEntryV15>',
  },
  'CustomMetadataEntryV15': {
    'type': 'Si1LookupTypeId',
    'value': 'Bytes',
  },
  'OuterEnumMetadataV15': {
    'callType': 'Si1LookupTypeId',
    'eventType': 'Si1LookupTypeId',
    'errorType': 'Si1LookupTypeId',
  },
  'ApiMetadataV15': {'name': 'Text', 'methods': 'Vec<ApiMethodMetadataV15>', 'docs': 'Vec<Text>'},
  'ApiMethodMetadataV15': {
    'name': 'Text',
    'inputs': 'Vec<MethodInputEntryTypeV15>',
    'output': 'Si1LookupTypeId',
    'docs': 'Vec<Text>'
  },
  'MethodInputEntryTypeV15': {
    'name': 'Text',
    'type': 'Si1LookupTypeId',
  },
  'ExtrinsicMetadataV15': {
    'type': 'Si1LookupTypeId',
    'version': 'u8',
    'addressType': 'Si1LookupTypeId',
    'callType': 'Si1LookupTypeId',
    'signatureType': 'Si1LookupTypeId',
    'extraType': 'Si1LookupTypeId',
    'signedExtensions': 'Vec<SignedExtensionMetadataV15>',
  },
  'PalletCallMetadataV15': {
    'type': 'Si1LookupTypeId',
  },
  'PalletConstantMetadataV15': {
    'name': 'Text',
    'type': 'Si1LookupTypeId',
    'value': 'Bytes',
    'docs': 'Vec<Text>'
  },
  'PalletErrorMetadataV15': {
    'type': 'Si1LookupTypeId',
  },
  'PalletEventMetadataV15': {
    'type': 'Si1LookupTypeId',
  },
  'PalletMetadataV15': {
    'name': 'Text',
    'storage': 'Option<PalletStorageMetadataV15>',
    'calls': 'Option<PalletCallMetadataV15>',
    'events': 'Option<PalletEventMetadataV15>',
    'constants': 'Vec<PalletConstantMetadataV15>',
    'errors': 'Option<PalletErrorMetadataV15>',
    'index': 'u8',
    'docs': 'Vec<Text>'
  },
  'PalletStorageMetadataV15': {
    'prefix': 'Text',
    // 'NOTE': Renamed from entries
    'items': 'Vec<StorageEntryMetadataV15>'
  },
  'SignedExtensionMetadataV15': {
    'identifier': 'Text',
    'type': 'Si1LookupTypeId',
    'additionalSigned': 'Si1LookupTypeId'
  },
  'StorageEntryMetadataV15': {
    'name': 'Text',
    'modifier': 'StorageEntryModifierV15',
    'type': 'StorageEntryTypeV15',
    'fallback': 'Bytes',
    'docs': 'Vec<Text>'
  },
  'StorageEntryModifierV15': 'StorageEntryModifierV13',
  'StorageEntryTypeV15': {
    '_enum': {
      'Plain': 'Si1LookupTypeId',
      'Map': {
        'hashers': 'Vec<StorageHasherV15>',
        'key': 'Si1LookupTypeId', // 'NOTE': Renamed from "keys"
        'value': 'Si1LookupTypeId'
      }
    }
  },
  'StorageHasherV15': 'StorageHasherV13'
};
