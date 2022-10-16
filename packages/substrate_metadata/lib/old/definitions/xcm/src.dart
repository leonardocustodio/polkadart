/// (From Tag: @subsquid/substrate-metadata_v1.1.0)
///
/// Referenced from: https://github.com/subsquid/squid/blob/%40subsquid/substrate-metadata_v1.1.0/substrate-metadata/src/old/definitions/xcm/index.ts

part of xcm;

final types = LegacyTypes(
  types: <String, dynamic>{
    ...V0,
    ...V1,
    ...V2,
    'VersionedXcm': {
      '_enum': {'V0': 'XcmV0', 'V1': 'XcmV1', 'V2': 'XcmV2'}
    },
    'XcmVersion': 'u32',
    'VersionedMultiLocation': {
      '_enum': {
        'V0': 'MultiLocationV0',
        'V1': 'MultiLocationV1',
      }
    },
    'VersionedResponse': {
      '_enum': {
        'V0': 'XcmResponseV0',
        'V1': 'XcmResponseV1',
        'V2': 'XcmResponseV2',
      }
    },
    'VersionedMultiAsset': {
      '_enum': {
        'V0': 'MultiAssetV0',
        'V1': 'MultiAssetV1',
      }
    },
    'VersionedMultiAssets': {
      '_enum': {
        'V0': 'Vec<MultiAssetV0>',
        'V1': 'MultiAssetsV1',
      }
    }
  },
);
