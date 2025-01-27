import 'dart:convert';
import 'dart:io';
import 'package:polkadart/polkadart.dart';
import 'package:polkadart/scale_codec.dart';

void main() async {
  print(decodeHex('84'));
  return;
  final polkadart =
      Provider.fromUri(Uri.parse('wss://shibuya-rpc.dwellir.com'));
  final state = StateApi(polkadart);
  final RuntimeMetadata metadata = await state.getMetadata();
  metadata.chainInfo.scaleCodec.registry
      .registerCustomCodec(contractDefinitions);
  final allCodecs = metadata.chainInfo.scaleCodec.registry.codecs;
  final ComplexEnumCodec contractsCodec =
      (metadata.chainInfo.scaleCodec.registry.getCodec('Call') as ProxyCodec)
          .codec as ComplexEnumCodec;
  final contracts = contractsCodec.map['Contracts'];
  final dynamicJson = metadata.toJson();
  print('fetched - metadata');
}

final contractDefinitions = <String, dynamic>{
  'ContractInstantiateResult': <String, String>{
    'gasConsumed': 'WeightV2',
    'gasRequired': 'WeightV2',
    'StorageDeposit': 'StorageDeposit',
    'debugMessage': 'Text',
    'result': 'InstantiateReturnValue'
  },
/*"ContractExecResult": <String, String>{
    "gasConsumed": "Weight",
    "gasRequired": "Weight",
    "StorageDeposit": "StorageDeposit",
    "debugMessage": "Text",
    "result": "ContractExecResultResult"
  },
  "ContractExecResultResult": <String, dynamic>{
    "_enum": <String, String>{
      "Ok": "ContractExecResultOk",
      "Err": "DispatchError",
    }
  },
  "ContractExecResultOk": <String, String>{
    "flags": "ContractReturnFlags",
    "data": "Bytes",
  },
  "ContractReturnFlags": <String, dynamic>{
    "_set": <String, int>{
      "_bitLength": 32,
      "Revert": 1,
    }
  }, 
  "Weight": "WeightV1",
  "WeightV1": "U64",
  */
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
  'Bytes': 'Vec<u8>',
  'AccountId': 'GenericAccountId',
  'GenericAccountId': '[u8; 32]',
};
