import './orml.dart';

const loans = <String, dynamic>{
  'Deposits': {'voucherBalance': 'Balance', 'isCollateral': 'bool'},
  'BorrowSnapshot': {'principal': 'Balance', 'borrowIndex': 'u128'},
  'EarnedSnapshot': {
    'totalEarnedPrior': 'Balance',
    'exchangeRatePrior': 'u128'
  },
  'JumpModel': {
    'baseRate': 'Rate',
    'jumpRate': 'Rate',
    'fullRate': 'Rate',
    'jumpUtilization': 'Ratio'
  },
  'CurveModel': {'baseRate': 'Rate'},
  'InterestRateModel': {
    '_enum': {'JumpModel': 'JumpModel', 'CurveModel': 'CurveModel'}
  },
  'Market': {
    'collateralFactor': 'Ratio',
    'reserveFactor': 'Ratio',
    'closeFactor': 'Ratio',
    'liquidateIncentive': 'Rate',
    'rateModel': 'InterestRateModel',
    'state': 'MarketState',
    'cap': 'Balance',
    'ptokenId': 'CurrencyId'
  },
  'MarketState': {
    '_enum': ['Active', 'Pending', 'Supervision']
  },
  'PriceWithDecimal': {'price': 'Price', 'decimal': 'u8'},
  'Liquidity': 'FixedU128',
  'Shortfall': 'FixedU128',
  'ValidatorInfo': {
    'name': 'Option<Text>',
    'address': 'AccountId',
    'stakes': 'u128',
    'score': 'u128'
  },
  'ValidatorSet': 'Vec<ValidatorInfo>',
  'UnstakeInfo': {
    'amount': 'Balance',
    'blockNumber': 'u32',
    'eraIndex': 'Option<u32>'
  }
};

const liquidStaking = <String, dynamic>{
  'MatchingLedger': {
    'totalStakeAmount': 'Balance',
    'totalUnstakeAmount': 'Balance'
  },
  'UnlockChunk': {'value': 'Balance', 'era': 'EraIndex'},
  'StakingLedger': {
    'stash': 'AccountId',
    'total': 'Balance',
    'active': 'Balance',
    'unlocking': 'Vec<UnlockChunk>',
    'claimedRewards': 'Vec<EraIndex>'
  },
  'DerivativeIndex': 'u16'
};

const amm = <String, dynamic>{
  'Pool': {
    'baseAmount': 'Balance',
    'quoteAmount': 'Balance',
    'baseAmountLast': 'Balance',
    'quoteAmountLast': 'Balance',
    'lpTokenId': 'AssetId',
    'blockTimestampLast': 'BlockNumber',
    'price0CumulativeLast': 'Balance',
    'price1CumulativeLast': 'Balance'
  }
};

const primitives = <String, String>{
  'Amount': 'i128',
  'AmountOf': 'Amount',
  'Rate': 'FixedU128',
  'Ratio': 'Permill',
  'Timestamp': 'u64',
  'PriceDetail': '(Price, Timestamp)',
  'CurrencyId': 'AssetId',
  'CurrencyIdOf': 'CurrencyId',
  'Currency': 'CurrencyId',
  'AssetIdOf': 'AssetId'
};

const router = <String, String>{'Route': 'Vec<(AssetId, AssetId)>'};

const runtime = <String, String>{
  'OracleKey': 'AssetId',
  'OracleValue': 'Price'
};

const farming = <String, dynamic>{
  'BoundedBalance': 'BoundedVec<(Balance, BlockNumber), u32>',
  'PoolInfo': {
    'isActive': 'bool',
    'totalDeposited': 'Balance',
    'lockDuration': 'BlockNumber',
    'duration': 'BlockNumber',
    'periodFinish': 'BlockNumber',
    'lastUpdateBlock': 'BlockNumber',
    'rewardRate': 'Balance',
    'rewardPerShareStored': 'Balance'
  },
  'UserPosition': {
    'depositBalance': 'Balance',
    'lockBalanceItems': 'BoundedBalance',
    'rewardAmount': 'Balance',
    'rewardPerSharePaid': 'Balance'
  }
};

const crowdloans = <String, dynamic>{
  'VaultPhase': {
    '_enum': [
      'Pending',
      'Contributing',
      'Closed',
      'Failed',
      'Succeeded',
      'Expired'
    ]
  },
  'ContributionStrategy': {
    '_enum': ['XCM']
  },
  'ChildStorageKind': {
    '_enum': ['Pending', 'Flying', 'Contributed']
  },
  'TrieIndex': 'u32',
  'LeasePeriod': 'BlockNumber',
  'Vault': {
    'ctoken': 'AssetId',
    'phase': 'VaultPhase',
    'contributed': 'Balance',
    'pending': 'Balance',
    'flying': 'Balance',
    'contributionStrategy': 'ContributionStrategy',
    'cap': 'Balance',
    'endBlock': 'BlockNumber',
    'trieIndex': 'TrieIndex',
    'leaseStart': 'LeasePeriod',
    'leaseEnd': 'LeasePeriod'
  }
};

const xcmHelper = <String, dynamic>{
  'XcmWeightFeeMisc': {'weight': 'Weight', 'fee': 'Balance'},
  'XcmCall': {
    '_enum': [
      'Bond',
      'BondExtra',
      'Unbond',
      'Rebond',
      'WithdrawUnbonded',
      'Nominate',
      'Contribute',
      'Withdraw',
      'AddMemo'
    ]
  }
};

const bridge = <String, dynamic>{
  'BridgeToken': {'id': 'CurrencyId', 'external': 'bool', 'fee': 'Balance'},
  'ProposalStatus': {
    '_enum': ['Initiated', 'Approved', 'Rejected']
  }
};

const types = <String, String>{
  ...loans,
  ...liquidStaking,
  ...amm,
  ...primitives,
  ...runtime,
  ...farming,
  ...router,
  ...crowdloans,
  ...xcmHelper,
  ...bridge
};

final bundle = <String, dynamic>{
  'types': {...ormlTypes, ...types},
  'typesAlias': {...ormlAlias},
  'versions': [
    {
      'minmax': [0, null],
      'types': {
        'Address': 'MultiAddress',
        'LookupSource': 'MultiAddress',
        'TAssetBalance': 'u128'
      }
    }
  ]
};
