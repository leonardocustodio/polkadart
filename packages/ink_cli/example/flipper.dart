// ignore_for_file: non_constant_identifier_names

import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:ink_abi/ink_abi.dart';
import 'package:ink_cli/ink_cli.dart';
import 'package:polkadart/polkadart.dart';
import 'dart:typed_data';

final _metadataJson = {
  "source": {
    "hash": "0xc1c8f7908a009379743280998a998580c8c7415919cb873cb320756b972a7d3a",
    "language": "ink! 4.0.0-rc",
    "compiler": "rustc 1.67.0",
    "build_info": {
      "build_mode": "Debug",
      "cargo_contract_version": "2.0.0-rc",
      "rust_toolchain": "stable-aarch64-apple-darwin",
      "wasm_opt_settings": {"keep_debug_symbols": false, "optimization_passes": "Z"},
    },
  },
  "contract": {
    "name": "flipper",
    "version": "0.1.0",
    "authors": ["[your_name] <[your_email]>"],
  },
  "spec": {
    "constructors": [
      {
        "args": [
          {
            "label": "init_value",
            "type": {
              "displayName": ["bool"],
              "type": 0,
            },
          },
        ],
        "docs": ["Creates a new flipper smart contract initialized with the given value."],
        "label": "new",
        "payable": false,
        "returnType": {
          "displayName": ["ink_primitives", "ConstructorResult"],
          "type": 1,
        },
        "selector": "0x9bae9d5e",
      },
      {
        "args": [],
        "docs": ["Creates a new flipper smart contract initialized to `false`."],
        "label": "new_default",
        "payable": false,
        "returnType": {
          "displayName": ["ink_primitives", "ConstructorResult"],
          "type": 1,
        },
        "selector": "0x61ef7e3e",
      },
    ],
    "docs": [],
    "events": [],
    "lang_error": {
      "displayName": ["ink", "LangError"],
      "type": 3,
    },
    "messages": [
      {
        "args": [],
        "docs": [" Flips the current value of the Flipper's boolean."],
        "label": "flip",
        "mutates": true,
        "payable": false,
        "returnType": {
          "displayName": ["ink", "MessageResult"],
          "type": 1,
        },
        "selector": "0x633aa551",
      },
      {
        "args": [],
        "docs": [" Returns the current value of the Flipper's boolean."],
        "label": "get",
        "mutates": false,
        "payable": false,
        "returnType": {
          "displayName": ["ink", "MessageResult"],
          "type": 4,
        },
        "selector": "0x2f865bd9",
      },
    ],
  },
  "storage": {
    "root": {
      "layout": {
        "struct": {
          "fields": [
            {
              "layout": {
                "leaf": {"key": "0x00000000", "ty": 0},
              },
              "name": "value",
            },
          ],
          "name": "Flipper",
        },
      },
      "root_key": "0x00000000",
    },
  },
  "types": [
    {
      "id": 0,
      "type": {
        "def": {"primitive": "bool"},
      },
    },
    {
      "id": 1,
      "type": {
        "def": {
          "variant": {
            "variants": [
              {
                "fields": [
                  {"type": 2},
                ],
                "index": 0,
                "name": "Ok",
              },
              {
                "fields": [
                  {"type": 3},
                ],
                "index": 1,
                "name": "Err",
              },
            ],
          },
        },
        "params": [
          {"name": "T", "type": 2},
          {"name": "E", "type": 3},
        ],
        "path": ["Result"],
      },
    },
    {
      "id": 2,
      "type": {
        "def": {"tuple": []},
      },
    },
    {
      "id": 3,
      "type": {
        "def": {
          "variant": {
            "variants": [
              {"index": 1, "name": "CouldNotReadInput"},
            ],
          },
        },
        "path": ["ink_primitives", "LangError"],
      },
    },
    {
      "id": 4,
      "type": {
        "def": {
          "variant": {
            "variants": [
              {
                "fields": [
                  {"type": 0},
                ],
                "index": 0,
                "name": "Ok",
              },
              {
                "fields": [
                  {"type": 3},
                ],
                "index": 1,
                "name": "Err",
              },
            ],
          },
        },
        "params": [
          {"name": "T", "type": 0},
          {"name": "E", "type": 3},
        ],
        "path": ["Result"],
      },
    },
  ],
  "version": "4",
};

final InkAbi _abi = InkAbi(_metadataJson);

dynamic decodeEvent(final String hex) {
  return _abi.decodeEvent(hex);
}

dynamic decodeMessage(final String hex) {
  return _abi.decodeMessage(hex);
}

dynamic decodeConstructor(final String hex) {
  return _abi.decodeConstructor(hex);
}

class Contract {
  final Provider provider;
  final Uint8List address;
  final Uint8List contractAddress;
  final Uint8List? blockHash;

  const Contract({
    required this.provider,
    required this.contractAddress,
    required this.address,
    this.blockHash,
  });

  ///
  /// Creates a new flipper smart contract initialized with the given value.
  static Future<InstantiateRequest> new_contract({
    required final bool init_value,
    required final Uint8List code,
    required final KeyPair keyPair,
    required final ContractDeployer deployer,
    final Map<String, dynamic> extraOptions = const <String, dynamic>{},
    final BigInt? storageDepositLimit,
    final Uint8List? salt,
    final GasLimit? gasLimit,
    final dynamic tip = 0,
    final int eraPeriod = 0,
  }) async {
    return await deployer.deployContract(
      inkAbi: _abi,
      selector: '0x9bae9d5e',
      code: code,
      keypair: keyPair,
      extraOptions: extraOptions,
      storageDepositLimit: storageDepositLimit,
      salt: salt,
      gasLimit: gasLimit,
      tip: tip,
      eraPeriod: eraPeriod,
      constructorArgs: [init_value],
    );
  }

  ///
  /// Creates a new flipper smart contract initialized to `false`.
  static Future<InstantiateRequest> new_default_contract({
    required final Uint8List code,
    required final KeyPair keyPair,
    required final ContractDeployer deployer,
    final Map<String, dynamic> extraOptions = const <String, dynamic>{},
    final BigInt? storageDepositLimit,
    final Uint8List? salt,
    final GasLimit? gasLimit,
    final dynamic tip = 0,
    final int eraPeriod = 0,
  }) async {
    return await deployer.deployContract(
      inkAbi: _abi,
      selector: '0x61ef7e3e',
      code: code,
      keypair: keyPair,
      extraOptions: extraOptions,
      storageDepositLimit: storageDepositLimit,
      salt: salt,
      gasLimit: gasLimit,
      tip: tip,
      eraPeriod: eraPeriod,
      constructorArgs: [],
    );
  }

  ///
  ///  Flips the current value of the Flipper's boolean.
  Future<dynamic> flip({
    required final KeyPair keyPair,
    required final ContractMutator mutator,
    BigInt? storageDepositLimit,
    GasLimit? gasLimit,
    final dynamic tip = 0,
    final int eraPeriod = 0,
  }) async {
    return _contractCall(
      selector: '0x633aa551',
      keypair: keyPair,
      args: [],
      mutator: mutator,
      storageDepositLimit: storageDepositLimit,
      gasLimit: gasLimit,
      tip: tip,
      eraPeriod: eraPeriod,
    );
  }

  ///
  ///  Returns the current value of the Flipper's boolean.
  Future<dynamic> get() async {
    return _stateCall('0x2f865bd9', []);
  }

  Future<dynamic> _contractCall({
    required final String selector,
    required final KeyPair keypair,
    required final List<dynamic> args,
    required final ContractMutator mutator,
    BigInt? storageDepositLimit,
    GasLimit? gasLimit,
    final dynamic tip = 0,
    final int eraPeriod = 0,
  }) async {
    final input = _abi.encodeMessageInput(selector, args);
    final result = await _baseCall(input, args);
    final value = await mutator.mutate(
      keypair: keypair,
      input: input,
      result: result,
      contractAddress: contractAddress,
      storageDepositLimit: storageDepositLimit,
      gasLimit: gasLimit,
      tip: tip,
      eraPeriod: eraPeriod,
    );
    return value;
  }

  Future<dynamic> _stateCall(final String selector, final List<dynamic> args) async {
    final input = _abi.encodeMessageInput(selector, args);
    final baseResult = await _baseCall(input, args);
    final decodedResult = decodeResult(baseResult);
    return _abi.decodeMessageOutput(selector, decodedResult);
  }

  Future<Uint8List> _baseCall(final Uint8List input, final List<dynamic> args) async {
    final data = encodeCall(address, input, contractAddress);
    final api = StateApi(provider);
    final result = await api.call('ContractsApi_call', data, at: blockHash);
    return result;
  }
}
