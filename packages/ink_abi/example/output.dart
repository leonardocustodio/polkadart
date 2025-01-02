import 'package:ink_abi/ink_abi_base.dart';
import 'package:polkadart/polkadart.dart' show StateApi;
import 'dart:typed_data';
import 'dart:convert';

const String metadataJson = r'''
  {
      "source": {
          "hash": "0x2ab457554b75e4fa0be68a2a768a7e422d3f39ffc0fdcb00faeda8f5a8683bdd",
          "language": "ink! 3.0.1",
          "compiler": "rustc 1.63.0-nightly"
      },
      "contract": {
          "name": "erc20",
          "version": "3.2.0",
          "authors": [
              "Parity Technologies <admin@parity.io>"
          ]
      },
      "V3": {
          "spec": {
              "constructors": [
                  {
                      "args": [
                          {
                              "label": "initial_supply",
                              "type": {
                                  "displayName": [
                                      "Balance"
                                  ],
                                  "type": 0
                              }
                          }
                      ],
                      "docs": [
                          "Creates a new ERC-20 contract with the specified initial supply."
                      ],
                      "label": "new",
                      "payable": false,
                      "selector": "0x9bae9d5e"
                  }
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
                                  "displayName": [
                                      "Option"
                                  ],
                                  "type": 11
                              }
                          },
                          {
                              "docs": [],
                              "indexed": true,
                              "label": "to",
                              "type": {
                                  "displayName": [
                                      "Option"
                                  ],
                                  "type": 11
                              }
                          },
                          {
                              "docs": [],
                              "indexed": false,
                              "label": "value",
                              "type": {
                                  "displayName": [
                                      "Balance"
                                  ],
                                  "type": 0
                              }
                          }
                      ],
                      "docs": [
                          " Event emitted when a token transfer occurs."
                      ],
                      "label": "Transfer"
                  },
                  {
                      "args": [
                          {
                              "docs": [],
                              "indexed": true,
                              "label": "owner",
                              "type": {
                                  "displayName": [
                                      "AccountId"
                                  ],
                                  "type": 2
                              }
                          },
                          {
                              "docs": [],
                              "indexed": true,
                              "label": "spender",
                              "type": {
                                  "displayName": [
                                      "AccountId"
                                  ],
                                  "type": 2
                              }
                          },
                          {
                              "docs": [],
                              "indexed": false,
                              "label": "value",
                              "type": {
                                  "displayName": [
                                      "Balance"
                                  ],
                                  "type": 0
                              }
                          }
                      ],
                      "docs": [
                          " Event emitted when an approval occurs that `spender` is allowed to withdraw",
                          " up to the amount of `value` tokens from `owner`."
                      ],
                      "label": "Approval"
                  }
              ],
              "messages": [
                  {
                      "args": [],
                      "docs": [
                          " Returns the total token supply."
                      ],
                      "label": "total_supply",
                      "mutates": false,
                      "payable": false,
                      "returnType": {
                          "displayName": [
                              "Balance"
                          ],
                          "type": 0
                      },
                      "selector": "0xdb6375a8"
                  },
                  {
                      "args": [
                          {
                              "label": "owner",
                              "type": {
                                  "displayName": [
                                      "AccountId"
                                  ],
                                  "type": 2
                              }
                          }
                      ],
                      "docs": [
                          " Returns the account balance for the specified `owner`.",
                          "",
                          " Returns `0` if the account is non-existent."
                      ],
                      "label": "balance_of",
                      "mutates": false,
                      "payable": false,
                      "returnType": {
                          "displayName": [
                              "Balance"
                          ],
                          "type": 0
                      },
                      "selector": "0x0f755a56"
                  },
                  {
                      "args": [
                          {
                              "label": "owner",
                              "type": {
                                  "displayName": [
                                      "AccountId"
                                  ],
                                  "type": 2
                              }
                          },
                          {
                              "label": "spender",
                              "type": {
                                  "displayName": [
                                      "AccountId"
                                  ],
                                  "type": 2
                              }
                          }
                      ],
                      "docs": [
                          " Returns the amount which `spender` is still allowed to withdraw from `owner`.",
                          "",
                          " Returns `0` if no allowance has been set."
                      ],
                      "label": "allowance",
                      "mutates": false,
                      "payable": false,
                      "returnType": {
                          "displayName": [
                              "Balance"
                          ],
                          "type": 0
                      },
                      "selector": "0x6a00165e"
                  },
                  {
                      "args": [
                          {
                              "label": "to",
                              "type": {
                                  "displayName": [
                                      "AccountId"
                                  ],
                                  "type": 2
                              }
                          },
                          {
                              "label": "value",
                              "type": {
                                  "displayName": [
                                      "Balance"
                                  ],
                                  "type": 0
                              }
                          }
                      ],
                      "docs": [
                          " Transfers `value` amount of tokens from the caller's account to account `to`.",
                          "",
                          " On success a `Transfer` event is emitted.",
                          "",
                          " # Errors",
                          "",
                          " Returns `InsufficientBalance` error if there are not enough tokens on",
                          " the caller's account balance."
                      ],
                      "label": "transfer",
                      "mutates": true,
                      "payable": false,
                      "returnType": {
                          "displayName": [
                              "Result"
                          ],
                          "type": 8
                      },
                      "selector": "0x84a15da1"
                  },
                  {
                      "args": [
                          {
                              "label": "spender",
                              "type": {
                                  "displayName": [
                                      "AccountId"
                                  ],
                                  "type": 2
                              }
                          },
                          {
                              "label": "value",
                              "type": {
                                  "displayName": [
                                      "Balance"
                                  ],
                                  "type": 0
                              }
                          }
                      ],
                      "docs": [
                          " Allows `spender` to withdraw from the caller's account multiple times, up to",
                          " the `value` amount.",
                          "",
                          " If this function is called again it overwrites the current allowance with `value`.",
                          "",
                          " An `Approval` event is emitted."
                      ],
                      "label": "approve",
                      "mutates": true,
                      "payable": false,
                      "returnType": {
                          "displayName": [
                              "Result"
                          ],
                          "type": 8
                      },
                      "selector": "0x681266a0"
                  },
                  {
                      "args": [
                          {
                              "label": "from",
                              "type": {
                                  "displayName": [
                                      "AccountId"
                                  ],
                                  "type": 2
                              }
                          },
                          {
                              "label": "to",
                              "type": {
                                  "displayName": [
                                      "AccountId"
                                  ],
                                  "type": 2
                              }
                          },
                          {
                              "label": "value",
                              "type": {
                                  "displayName": [
                                      "Balance"
                                  ],
                                  "type": 0
                              }
                          }
                      ],
                      "docs": [
                          " Transfers `value` tokens on the behalf of `from` to the account `to`.",
                          "",
                          " This can be used to allow a contract to transfer tokens on ones behalf and/or",
                          " to charge fees in sub-currencies, for example.",
                          "",
                          " On success a `Transfer` event is emitted.",
                          "",
                          " # Errors",
                          "",
                          " Returns `InsufficientAllowance` error if there are not enough tokens allowed",
                          " for the caller to withdraw from `from`.",
                          "",
                          " Returns `InsufficientBalance` error if there are not enough tokens on",
                          " the account balance of `from`."
                      ],
                      "label": "transfer_from",
                      "mutates": true,
                      "payable": false,
                      "returnType": {
                          "displayName": [
                              "Result"
                          ],
                          "type": 8
                      },
                      "selector": "0x0b396f18"
                  }
              ]
          },
          "storage": {
              "struct": {
                  "fields": [
                      {
                          "layout": {
                              "cell": {
                                  "key": "0x0000000000000000000000000000000000000000000000000000000000000000",
                                  "ty": 0
                              }
                          },
                          "name": "total_supply"
                      },
                      {
                          "layout": {
                              "cell": {
                                  "key": "0x0100000000000000000000000000000000000000000000000000000000000000",
                                  "ty": 1
                              }
                          },
                          "name": "balances"
                      },
                      {
                          "layout": {
                              "cell": {
                                  "key": "0x0200000000000000000000000000000000000000000000000000000000000000",
                                  "ty": 6
                              }
                          },
                          "name": "allowances"
                      }
                  ]
              }
          },
          "types": [
              {
                  "id": 0,
                  "type": {
                      "def": {
                          "primitive": "u128"
                      }
                  }
              },
              {
                  "id": 1,
                  "type": {
                      "def": {
                          "composite": {
                              "fields": [
                                  {
                                      "name": "offset_key",
                                      "type": 5,
                                      "typeName": "Key"
                                  }
                              ]
                          }
                      },
                      "params": [
                          {
                              "name": "K",
                              "type": 2
                          },
                          {
                              "name": "V",
                              "type": 0
                          }
                      ],
                      "path": [
                          "ink_storage",
                          "lazy",
                          "mapping",
                          "Mapping"
                      ]
                  }
              },
              {
                  "id": 2,
                  "type": {
                      "def": {
                          "composite": {
                              "fields": [
                                  {
                                      "type": 3,
                                      "typeName": "[u8; 32]"
                                  }
                              ]
                          }
                      },
                      "path": [
                          "ink_env",
                          "types",
                          "AccountId"
                      ]
                  }
              },
              {
                  "id": 3,
                  "type": {
                      "def": {
                          "array": {
                              "len": 32,
                              "type": 4
                          }
                      }
                  }
              },
              {
                  "id": 4,
                  "type": {
                      "def": {
                          "primitive": "u8"
                      }
                  }
              },
              {
                  "id": 5,
                  "type": {
                      "def": {
                          "composite": {
                              "fields": [
                                  {
                                      "type": 3,
                                      "typeName": "[u8; 32]"
                                  }
                              ]
                          }
                      },
                      "path": [
                          "ink_primitives",
                          "Key"
                      ]
                  }
              },
              {
                  "id": 6,
                  "type": {
                      "def": {
                          "composite": {
                              "fields": [
                                  {
                                      "name": "offset_key",
                                      "type": 5,
                                      "typeName": "Key"
                                  }
                              ]
                          }
                      },
                      "params": [
                          {
                              "name": "K",
                              "type": 7
                          },
                          {
                              "name": "V",
                              "type": 0
                          }
                      ],
                      "path": [
                          "ink_storage",
                          "lazy",
                          "mapping",
                          "Mapping"
                      ]
                  }
              },
              {
                  "id": 7,
                  "type": {
                      "def": {
                          "tuple": [
                              2,
                              2
                          ]
                      }
                  }
              },
              {
                  "id": 8,
                  "type": {
                      "def": {
                          "variant": {
                              "variants": [
                                  {
                                      "fields": [
                                          {
                                              "type": 9
                                          }
                                      ],
                                      "index": 0,
                                      "name": "Ok"
                                  },
                                  {
                                      "fields": [
                                          {
                                              "type": 10
                                          }
                                      ],
                                      "index": 1,
                                      "name": "Err"
                                  }
                              ]
                          }
                      },
                      "params": [
                          {
                              "name": "T",
                              "type": 9
                          },
                          {
                              "name": "E",
                              "type": 10
                          }
                      ],
                      "path": [
                          "Result"
                      ]
                  }
              },
              {
                  "id": 9,
                  "type": {
                      "def": {
                          "tuple": []
                      }
                  }
              },
              {
                  "id": 10,
                  "type": {
                      "def": {
                          "variant": {
                              "variants": [
                                  {
                                      "index": 0,
                                      "name": "InsufficientBalance"
                                  },
                                  {
                                      "index": 1,
                                      "name": "InsufficientAllowance"
                                  }
                              ]
                          }
                      },
                      "path": [
                          "erc20",
                          "erc20",
                          "Error"
                      ]
                  }
              },
              {
                  "id": 11,
                  "type": {
                      "def": {
                          "variant": {
                              "variants": [
                                  {
                                      "index": 0,
                                      "name": "None"
                                  },
                                  {
                                      "fields": [
                                          {
                                              "type": 2
                                          }
                                      ],
                                      "index": 1,
                                      "name": "Some"
                                  }
                              ]
                          }
                      },
                      "params": [
                          {
                              "name": "T",
                              "type": 2
                          }
                      ],
                      "path": [
                          "Option"
                      ]
                  }
              }
          ]
      }
  }
''';

final InkAbi _abi = InkAbi(jsonDecode(metadataJson));

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
  final StateApi api;
  final Uint8List address;
  final Uint8List? blockHash;

  Contract({required this.api, required this.address, this.blockHash});

  ///
  /// Returns the total token supply.
  Future<Balance> total_supply() async {
    return await _stateCall<Balance>('0xdb6375a8', []);
  }

  ///
  /// Returns the account balance for the specified `owner`.
  ///
  /// Returns `0` if the account is non-existent.
  Future<Balance> balance_of(final AccountId owner) async {
    return await _stateCall<Balance>('0x0f755a56', [owner]);
  }

  ///
  /// Returns the amount which `spender` is still allowed to withdraw from `owner`.
  ///
  /// Returns `0` if no allowance has been set.
  Future<Balance> allowance(
      final AccountId owner, final AccountId spender) async {
    return await _stateCall<Balance>('0x6a00165e', [owner, spender]);
  }

  Future<T> _stateCall<T>(
      final String selector, final List<dynamic> args) async {
    final input = _abi.encodeMessageInput(selector, args);
    final data = encodeCall(address, input);
    final result = await api.call('ContractsApi_call', data, at: blockHash);
    final value = decodeResult(result);
    return _abi.decodeMessageOutput(selector, value);
  }
}

typedef AccountId = List<int>;

typedef Balance = BigInt;
