part of ink_cli;

final _contractDefinitions = <String, dynamic>{
  'ContractInstantiateResult': <String, String>{
    'gasConsumed': 'WeightV2',
    'gasRequired': 'WeightV2',
    'storageDeposit': 'StorageDeposit',
    'debugMessage': 'Text',
    'result': 'InstantiateReturnValue'
  },
'ContractExecResult': <String, String>{
    'gasConsumed': 'Weight',
    'gasRequired': 'Weight',
    'StorageDeposit': 'StorageDeposit',
    'debugMessage': 'Text',
    'result': 'ContractExecResultResult'
  },
  'ContractExecResultResult': <String, dynamic>{
    '_enum': <String, String>{
      'Ok': 'ContractExecResultOk',
      'Err': 'DispatchError',
    }
  },
  'ContractExecResultOk': <String, String>{
    'flags': 'ContractReturnFlags',
    'data': 'Bytes',
  },
  'ContractReturnFlags': <String, dynamic>{
    '_set': <String, int>{
      '_bitLength': 32,
      'Revert': 1,
    }
  }, 
  'Weight': 'WeightV1',
  'WeightV1': 'U64',
  'WeightV2': <String, String>{
    'refTime': 'Compact<u64>',
    'proofSize': 'Compact<u64>',
  },
  'StorageDeposit': <String, dynamic>{
    '_enum': <String, String>{
      'Refund': 'Balance',
      'Charge': 'Balance',
    }
  },
  'Balance': 'U128',
  'InstantiateReturnValue': 'Result<InstantiateReturnValueOk, DispatchError>',
  'InstantiateReturnValueOk': <String, String>{
    'result': 'ExecReturnValue',
    'accountId': 'AccountId'
  },
  'ExecReturnValue': <String, String>{
    'flags': 'u32',
    'data': 'Bytes',
  },
  'Bytes': 'Vec<U8>',
  'AccountId': 'GenericAccountId',
  'GenericAccountId': '[u8; 32]',
};
