// ignore_for_file: non_constant_identifier_names

import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:ink_abi/ink_abi.dart';
import 'package:ink_cli/ink_cli.dart';
import 'package:polkadart/polkadart.dart';
import 'dart:typed_data';

final _metadataJson = {
  "source": {
    "hash": "0xf43f22075f6c49ffa9f861c680f895f71cd04767ee539708c8371b7a063e8c46",
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
    "name": "erc20",
    "version": "0.1.0",
    "authors": ["[your_name] <[your_email]>"],
  },
  "spec": {
    "constructors": [
      {
        "args": [
          {
            "label": "total_supply",
            "type": {
              "displayName": ["Balance"],
              "type": 0,
            },
          },
        ],
        "docs": ["Create a new ERC-20 contract with an initial supply."],
        "label": "new",
        "payable": false,
        "returnType": {
          "displayName": ["ink_primitives", "ConstructorResult"],
          "type": 1,
        },
        "selector": "0x9bae9d5e",
      },
    ],
    "docs": [],
    "events": [
      {
        "args": [
          {
            "docs": [],
            "indexed": true,
            "label": "from",
            "type": {
              "displayName": ["Option"],
              "type": 11,
            },
          },
          {
            "docs": [],
            "indexed": true,
            "label": "to",
            "type": {
              "displayName": ["Option"],
              "type": 11,
            },
          },
          {
            "docs": [],
            "indexed": true,
            "label": "value",
            "type": {
              "displayName": ["Balance"],
              "type": 0,
            },
          },
        ],
        "docs": [],
        "label": "Transfer",
      },
      {
        "args": [
          {
            "docs": [],
            "indexed": true,
            "label": "owner",
            "type": {
              "displayName": ["AccountId"],
              "type": 5,
            },
          },
          {
            "docs": [],
            "indexed": true,
            "label": "spender",
            "type": {
              "displayName": ["AccountId"],
              "type": 5,
            },
          },
          {
            "docs": [],
            "indexed": true,
            "label": "value",
            "type": {
              "displayName": ["Balance"],
              "type": 0,
            },
          },
        ],
        "docs": [],
        "label": "Approval",
      },
    ],
    "lang_error": {
      "displayName": ["ink", "LangError"],
      "type": 3,
    },
    "messages": [
      {
        "args": [],
        "docs": [" Returns the total token supply."],
        "label": "total_supply",
        "mutates": false,
        "payable": false,
        "returnType": {
          "displayName": ["ink", "MessageResult"],
          "type": 4,
        },
        "selector": "0xdb6375a8",
      },
      {
        "args": [
          {
            "label": "owner",
            "type": {
              "displayName": ["AccountId"],
              "type": 5,
            },
          },
        ],
        "docs": [" Returns the account balance for the specified `owner`."],
        "label": "balance_of",
        "mutates": false,
        "payable": false,
        "returnType": {
          "displayName": ["ink", "MessageResult"],
          "type": 4,
        },
        "selector": "0x0f755a56",
      },
      {
        "args": [
          {
            "label": "to",
            "type": {
              "displayName": ["AccountId"],
              "type": 5,
            },
          },
          {
            "label": "value",
            "type": {
              "displayName": ["Balance"],
              "type": 0,
            },
          },
        ],
        "docs": [],
        "label": "transfer",
        "mutates": true,
        "payable": false,
        "returnType": {
          "displayName": ["ink", "MessageResult"],
          "type": 8,
        },
        "selector": "0x84a15da1",
      },
      {
        "args": [
          {
            "label": "from",
            "type": {
              "displayName": ["AccountId"],
              "type": 5,
            },
          },
          {
            "label": "to",
            "type": {
              "displayName": ["AccountId"],
              "type": 5,
            },
          },
          {
            "label": "value",
            "type": {
              "displayName": ["Balance"],
              "type": 0,
            },
          },
        ],
        "docs": [" Transfers tokens on the behalf of the `from` account to the `to account"],
        "label": "transfer_from",
        "mutates": true,
        "payable": false,
        "returnType": {
          "displayName": ["ink", "MessageResult"],
          "type": 8,
        },
        "selector": "0x0b396f18",
      },
      {
        "args": [
          {
            "label": "spender",
            "type": {
              "displayName": ["AccountId"],
              "type": 5,
            },
          },
          {
            "label": "value",
            "type": {
              "displayName": ["Balance"],
              "type": 0,
            },
          },
        ],
        "docs": [],
        "label": "approve",
        "mutates": true,
        "payable": false,
        "returnType": {
          "displayName": ["ink", "MessageResult"],
          "type": 8,
        },
        "selector": "0x681266a0",
      },
      {
        "args": [
          {
            "label": "owner",
            "type": {
              "displayName": ["AccountId"],
              "type": 5,
            },
          },
          {
            "label": "spender",
            "type": {
              "displayName": ["AccountId"],
              "type": 5,
            },
          },
        ],
        "docs": [],
        "label": "allowance",
        "mutates": false,
        "payable": false,
        "returnType": {
          "displayName": ["ink", "MessageResult"],
          "type": 4,
        },
        "selector": "0x6a00165e",
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
              "name": "total_supply",
            },
            {
              "layout": {
                "root": {
                  "layout": {
                    "leaf": {"key": "0x2623dce7", "ty": 0},
                  },
                  "root_key": "0x2623dce7",
                },
              },
              "name": "balances",
            },
            {
              "layout": {
                "root": {
                  "layout": {
                    "leaf": {"key": "0xeca021b7", "ty": 0},
                  },
                  "root_key": "0xeca021b7",
                },
              },
              "name": "allowances",
            },
          ],
          "name": "Erc20",
        },
      },
      "root_key": "0x00000000",
    },
  },
  "types": [
    {
      "id": 0,
      "type": {
        "def": {"primitive": "u128"},
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
    {
      "id": 5,
      "type": {
        "def": {
          "composite": {
            "fields": [
              {"type": 6, "typeName": "[u8; 32]"},
            ],
          },
        },
        "path": ["ink_primitives", "types", "AccountId"],
      },
    },
    {
      "id": 6,
      "type": {
        "def": {
          "array": {"len": 32, "type": 7},
        },
      },
    },
    {
      "id": 7,
      "type": {
        "def": {"primitive": "u8"},
      },
    },
    {
      "id": 8,
      "type": {
        "def": {
          "variant": {
            "variants": [
              {
                "fields": [
                  {"type": 9},
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
          {"name": "T", "type": 9},
          {"name": "E", "type": 3},
        ],
        "path": ["Result"],
      },
    },
    {
      "id": 9,
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
                  {"type": 10},
                ],
                "index": 1,
                "name": "Err",
              },
            ],
          },
        },
        "params": [
          {"name": "T", "type": 2},
          {"name": "E", "type": 10},
        ],
        "path": ["Result"],
      },
    },
    {
      "id": 10,
      "type": {
        "def": {
          "variant": {
            "variants": [
              {"index": 0, "name": "InsufficientBalance"},
              {"index": 1, "name": "InsufficientAllowance"},
            ],
          },
        },
        "path": ["erc20", "erc20", "Error"],
      },
    },
    {
      "id": 11,
      "type": {
        "def": {
          "variant": {
            "variants": [
              {"index": 0, "name": "None"},
              {
                "fields": [
                  {"type": 5},
                ],
                "index": 1,
                "name": "Some",
              },
            ],
          },
        },
        "params": [
          {"name": "T", "type": 5},
        ],
        "path": ["Option"],
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
  /// Create a new ERC-20 contract with an initial supply.
  static Future<InstantiateRequest> new_contract({
    required final Balance total_supply,
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
      constructorArgs: [total_supply],
    );
  }

  ///
  ///  Returns the total token supply.
  Future<dynamic> total_supply() async {
    return _stateCall('0xdb6375a8', []);
  }

  ///
  ///  Returns the account balance for the specified `owner`.
  Future<dynamic> balance_of({required final List<int> owner}) async {
    return _stateCall('0x0f755a56', [owner]);
  }

  Future<dynamic> transfer({
    required final KeyPair keyPair,
    required final ContractMutator mutator,
    BigInt? storageDepositLimit,
    GasLimit? gasLimit,
    final dynamic tip = 0,
    final int eraPeriod = 0,
    required final List<int> to,
    required final Balance value,
  }) async {
    return _contractCall(
      selector: '0x84a15da1',
      keypair: keyPair,
      args: [to, value],
      mutator: mutator,
      storageDepositLimit: storageDepositLimit,
      gasLimit: gasLimit,
      tip: tip,
      eraPeriod: eraPeriod,
    );
  }

  ///
  ///  Transfers tokens on the behalf of the `from` account to the `to account
  Future<dynamic> transfer_from({
    required final KeyPair keyPair,
    required final ContractMutator mutator,
    BigInt? storageDepositLimit,
    GasLimit? gasLimit,
    final dynamic tip = 0,
    final int eraPeriod = 0,
    required final List<int> from,
    required final List<int> to,
    required final Balance value,
  }) async {
    return _contractCall(
      selector: '0x0b396f18',
      keypair: keyPair,
      args: [from, to, value],
      mutator: mutator,
      storageDepositLimit: storageDepositLimit,
      gasLimit: gasLimit,
      tip: tip,
      eraPeriod: eraPeriod,
    );
  }

  Future<dynamic> approve({
    required final KeyPair keyPair,
    required final ContractMutator mutator,
    BigInt? storageDepositLimit,
    GasLimit? gasLimit,
    final dynamic tip = 0,
    final int eraPeriod = 0,
    required final List<int> spender,
    required final Balance value,
  }) async {
    return _contractCall(
      selector: '0x681266a0',
      keypair: keyPair,
      args: [spender, value],
      mutator: mutator,
      storageDepositLimit: storageDepositLimit,
      gasLimit: gasLimit,
      tip: tip,
      eraPeriod: eraPeriod,
    );
  }

  Future<dynamic> allowance({
    required final List<int> owner,
    required final List<int> spender,
  }) async {
    return _stateCall('0x6a00165e', [owner, spender]);
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

typedef Balance = BigInt;
