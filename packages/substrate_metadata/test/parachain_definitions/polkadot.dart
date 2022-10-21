/// (From Tag: @subsquid/substrate-metadata_v1.1.0)
///
/// Referenced from: https://github.com/subsquid/squid/blob/%40subsquid/substrate-metadata_v1.1.0/substrate-metadata/src/old/definitions/polkadot.ts

const sharedTypes = <String, dynamic>{
  'CompactAssignments': 'CompactAssignmentsWith16',
  'RawSolution': 'RawSolutionWith16',
  'Keys': 'SessionKeys6',
  'ProxyType': {
    '_enum': {
      'Any': 0,
      'NonTransfer': 1,
      'Governance': 2,
      'Staking': 3,
      'UnusedSudoBalances': 4,
      'IdentityJudgement': 5,
      'CancelProxy': 6,
      'Auction': 7
    }
  }
};

const addrAccountIdTypes = <String, String>{
  'AccountInfo': 'AccountInfoWithRefCount',
  'Address': 'AccountId',
  'Keys': 'SessionKeys5',
  'LookupSource': 'AccountId',
  'ValidatorPrefs': 'ValidatorPrefsWithCommission'
};

final polkadotTypesBundle = <String, dynamic>{
  'types': <String, dynamic>{},
  'versions': [
    {
      'minmax': [0, 12],
      'types': {
        ...sharedTypes,
        ...addrAccountIdTypes,
        'CompactAssignments': 'CompactAssignmentsTo257',
        'OpenTip': 'OpenTipTo225',
        'RefCount': 'RefCountTo259'
      }
    },
    {
      'minmax': [13, 22],
      'types': {
        ...sharedTypes,
        ...addrAccountIdTypes,
        'CompactAssignments': 'CompactAssignmentsTo257',
        'RefCount': 'RefCountTo259'
      }
    },
    {
      'minmax': [23, 24],
      'types': {
        ...sharedTypes,
        ...addrAccountIdTypes,
        'RefCount': 'RefCountTo259'
      }
    },
    {
      'minmax': [25, 27],
      'types': {...sharedTypes, ...addrAccountIdTypes}
    },
    {
      'minmax': [28, 29],
      'types': {...sharedTypes, 'AccountInfo': 'AccountInfoWithDualRefCount'}
    },
    {
      'minmax': [30, 9109],
      'types': sharedTypes
    },
    {
      // metadata v14
      'minmax': [9110, null],
      'types': <String, dynamic>{}
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
