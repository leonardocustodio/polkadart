/// (From Tag: @subsquid/substrate-metadata_v1.1.0)
///
/// Referenced from: https://github.com/subsquid/squid/blob/%40subsquid/substrate-metadata_v1.1.0/substrate-metadata/src/old/definitions/kusama.ts

const _sharedTypes = <String, dynamic>{
  'CompactAssignments': 'CompactAssignmentsWith24',
  'RawSolution': 'RawSolutionWith24',
  'Keys': 'SessionKeys6',
  'ProxyType': {
    '_enum': [
      'Any',
      'NonTransfer',
      'Governance',
      'Staking',
      'IdentityJudgement',
      'CancelProxy',
      'Auction'
    ]
  }
};

const _addrIndicesTypes = <String, String>{
  'AccountInfo': 'AccountInfoWithRefCount',
  'Address': 'LookupSource',
  'CompactAssignments': 'CompactAssignmentsWith16',
  'RawSolution': 'RawSolutionWith16',
  'Keys': 'SessionKeys5',
  'LookupSource': 'IndicesLookupSource',
  'ValidatorPrefs': 'ValidatorPrefsWithCommission'
};

const _addrAccountIdTypes = <String, String>{
  'AccountInfo': 'AccountInfoWithRefCount',
  'Address': 'AccountId',
  'CompactAssignments': 'CompactAssignmentsWith16',
  'RawSolution': 'RawSolutionWith16',
  'Keys': 'SessionKeys5',
  'LookupSource': 'AccountId',
  'ValidatorPrefs': 'ValidatorPrefsWithCommission'
};

Map<String, String> _mapXcmTypes(String version) {
  final types = <String, String>{};
  for (final name in [
    'AssetInstance',
    'Fungibility',
    'Junction',
    'Junctions',
    'MultiAsset',
    'MultiAssetFilter',
    'MultiLocation',
    'Response',
    'WildFungibility',
    'WildMultiAsset',
    'Xcm',
    'XcmError',
    'XcmOrder'
  ]) {
    types[name] = name + version;
  }
  return types;
}

final kusamaTypesBundle = <String, dynamic>{
  'types': <String, dynamic>{},
  'versions': [
    {
      // 1020 is first CC3
      'minmax': [1019, 1031],
      'types': {
        ..._addrIndicesTypes,
        'BalanceLock': 'BalanceLockTo212',
        'CompactAssignments': 'CompactAssignmentsTo257',
        'DispatchError': 'DispatchErrorTo198',
        'DispatchInfo': 'DispatchInfoTo244',
        'Heartbeat': 'HeartbeatTo244',
        'IdentityInfo': 'IdentityInfoTo198',
        'Keys': 'SessionKeys5',
        'Multiplier': 'Fixed64',
        'OpenTip': 'OpenTipTo225',
        'RefCount': 'RefCountTo259',
        'ReferendumInfo': 'ReferendumInfoTo239',
        'SlashingSpans': 'SlashingSpansTo204',
        'StakingLedger': 'StakingLedgerTo223',
        'Votes': 'VotesTo230',
        'Weight': 'u32'
      }
    },
    {
      'minmax': [1032, 1042],
      'types': {
        ..._addrIndicesTypes,
        'BalanceLock': 'BalanceLockTo212',
        'CompactAssignments': 'CompactAssignmentsTo257',
        'DispatchInfo': 'DispatchInfoTo244',
        'Heartbeat': 'HeartbeatTo244',
        'Keys': 'SessionKeys5',
        'Multiplier': 'Fixed64',
        'OpenTip': 'OpenTipTo225',
        'RefCount': 'RefCountTo259',
        'ReferendumInfo': 'ReferendumInfoTo239',
        'SlashingSpans': 'SlashingSpansTo204',
        'StakingLedger': 'StakingLedgerTo223',
        'Votes': 'VotesTo230',
        'Weight': 'u32'
      }
    },
    {
      // actual at 1045 (1043-1044 is dev)
      'minmax': [1043, 1045],
      'types': {
        ..._addrIndicesTypes,
        'BalanceLock': 'BalanceLockTo212',
        'CompactAssignments': 'CompactAssignmentsTo257',
        'DispatchInfo': 'DispatchInfoTo244',
        'Heartbeat': 'HeartbeatTo244',
        'Keys': 'SessionKeys5',
        'Multiplier': 'Fixed64',
        'OpenTip': 'OpenTipTo225',
        'RefCount': 'RefCountTo259',
        'ReferendumInfo': 'ReferendumInfoTo239',
        'StakingLedger': 'StakingLedgerTo223',
        'Votes': 'VotesTo230',
        'Weight': 'u32'
      }
    },
    {
      'minmax': [1046, 1054],
      'types': {
        // Indices optional, not in transaction
        ..._sharedTypes,
        ..._addrAccountIdTypes,
        'CompactAssignments': 'CompactAssignmentsTo257',
        'DispatchInfo': 'DispatchInfoTo244',
        'Heartbeat': 'HeartbeatTo244',
        'Multiplier': 'Fixed64',
        'OpenTip': 'OpenTipTo225',
        'RefCount': 'RefCountTo259',
        'ReferendumInfo': 'ReferendumInfoTo239',
        'StakingLedger': 'StakingLedgerTo240',
        'Weight': 'u32'
      }
    },
    {
      'minmax': [1055, 1056],
      'types': {
        ..._sharedTypes,
        ..._addrAccountIdTypes,
        'CompactAssignments': 'CompactAssignmentsTo257',
        'DispatchInfo': 'DispatchInfoTo244',
        'Heartbeat': 'HeartbeatTo244',
        'Multiplier': 'Fixed64',
        'OpenTip': 'OpenTipTo225',
        'RefCount': 'RefCountTo259',
        'StakingLedger': 'StakingLedgerTo240',
        'Weight': 'u32'
      }
    },
    {
      'minmax': [1057, 1061],
      'types': {
        ..._sharedTypes,
        ..._addrAccountIdTypes,
        'CompactAssignments': 'CompactAssignmentsTo257',
        'DispatchInfo': 'DispatchInfoTo244',
        'Heartbeat': 'HeartbeatTo244',
        'OpenTip': 'OpenTipTo225',
        'RefCount': 'RefCountTo259'
      }
    },
    {
      'minmax': [1062, 2012],
      'types': {
        ..._sharedTypes,
        ..._addrAccountIdTypes,
        'CompactAssignments': 'CompactAssignmentsTo257',
        'OpenTip': 'OpenTipTo225',
        'RefCount': 'RefCountTo259'
      }
    },
    {
      'minmax': [2013, 2022],
      'types': {
        ..._sharedTypes,
        ..._addrAccountIdTypes,
        'CompactAssignments': 'CompactAssignmentsTo257',
        'RefCount': 'RefCountTo259'
      }
    },
    {
      'minmax': [2023, 2024],
      'types': {
        ..._sharedTypes,
        ..._addrAccountIdTypes,
        'RefCount': 'RefCountTo259'
      }
    },
    {
      'minmax': [2025, 2027],
      'types': {..._sharedTypes, ..._addrAccountIdTypes}
    },
    {
      'minmax': [2028, 2029],
      'types': {
        ..._sharedTypes,
        'AccountInfo': 'AccountInfoWithDualRefCount',
        'CompactAssignments': 'CompactAssignmentsWith16',
        'RawSolution': 'RawSolutionWith16'
      }
    },
    {
      'minmax': [2030, 9000],
      'types': {
        ..._sharedTypes,
        'CompactAssignments': 'CompactAssignmentsWith16',
        'RawSolution': 'RawSolutionWith16'
      }
    },
    {
      'minmax': [9010, 9099],
      'types': {..._sharedTypes, ..._mapXcmTypes('V0')}
    },
    {
      // jump from 9100 to 9110, however align with Rococo
      'minmax': [9100, 9105],
      'types': {..._sharedTypes, ..._mapXcmTypes('V1')}
    },
    {
      // metadata v14
      'minmax': [9106, null],
      'types': {}
    }
  ],
  'signedExtensions': {
    'LimitParathreadCommits': 'Null',
    'OnlyStakingAndClaims': 'Null',
    'PrevalidateAttests': 'Null',
    'RestrictFunctionality': 'Null',
    'TransactionCallFilter': 'Null',
    'ValidateDoubleVoteReports': 'Null'
  }
};
