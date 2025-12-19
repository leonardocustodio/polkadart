# ink_cli

A CLI tool and library for generating Dart code to interact with ink! smart contracts on Substrate-based blockchains.

---

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  ink_cli: ^0.3.1
```

Or for CLI usage:

```bash
dart pub global activate ink_cli
```

## Quick Start

### 1. Generate Contract Bindings

```bash
# Using CLI
dart run ink_cli:generate -s path/to/contract.json -o lib/contracts/my_contract.dart

# Or if globally activated
ink_cli generate -s path/to/contract.json -o lib/contracts/my_contract.dart
```

### 2. Deploy a Contract

```dart
import 'package:polkadart/polkadart.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:ink_cli/ink_cli.dart';
import 'my_contract.dart';  // Generated code

void main() async {
  // Connect to node
  final provider = WsProvider(Uri.parse('ws://127.0.0.1:9944'));
  await provider.connect();

  // Load keypair
  final keyring = Keyring();
  final keyPair = await keyring.fromMnemonic('your mnemonic...');

  // Read contract WASM
  final wasmCode = File('contract.wasm').readAsBytesSync();

  // Deploy using generated code
  final deployer = await ContractDeployer.from(provider: provider);
  final result = await MyContract.new_contract(
    deployer: deployer,
    keypair: keyPair,
    code: wasmCode,
    // constructor args...
  );

  print('Contract deployed at: ${result.contractAddress}');

  await provider.disconnect();
}
```

### 3. Call Contract Methods

```dart
// Create contract instance
final contract = MyContract(
  provider: provider,
  contractAddress: contractAddress,
);

// Read-only call (no transaction)
final value = await contract.get_value();
print('Current value: $value');

// State-changing call (submits transaction)
final mutator = await ContractMutator.fromProvider(provider: provider);
await contract.set_value(
  keyPair: keyPair,
  mutator: mutator,
  newValue: 42,
);
```

## Features

- **Code Generation**: Generate type-safe Dart bindings from ink! contract metadata
- **Contract Deployment**: Deploy contracts with automatic gas estimation
- **Method Calls**: Execute both read-only queries and state-changing mutations
- **V14/V15 Support**: Works with both metadata versions
- **Type Safety**: Generated code includes proper Dart types for all contract types
- **Sealed Classes**: Enum types generate Dart 3+ sealed class hierarchies

## CLI Usage

```bash
# Generate bindings
ink_cli generate -s <source_metadata_file> -o <output_file>

# Options:
#   -s, --source_metadata_file  Path to ink! contract metadata JSON
#   -o, --output_file           Output path for generated Dart file
```

## Generated Code Structure

The generated code includes:

```dart
// Type aliases
typedef Balance = BigInt;
typedef AccountId = List<int>;

// Enum types (sealed classes)
sealed class MyEnum {}
class MyEnum$Variant1 extends MyEnum { ... }
class MyEnum$Variant2 extends MyEnum { ... }

// Contract class
class MyContract {
  // Constructor deployment methods
  static Future<InstantiateRequest> new_contract({
    required ContractDeployer deployer,
    required KeyPair keypair,
    required Uint8List code,
    // constructor args...
  });

  // Read-only methods
  Future<int> get_value();

  // State-changing methods
  Future<void> set_value({
    required KeyPair keyPair,
    required ContractMutator mutator,
    required int newValue,
  });

  // Event decoding
  static dynamic decodeEvent(String hex, [List<String>? topics]);
}
```

---

## Breaking Changes from Previous Version

This version includes significant architectural improvements to align with the updated `polkadart` package. If you're upgrading from a previous version, please read this section carefully.

### Removed: `ContractMeta` Class

The `ContractMeta` class for fetching blockchain metadata has been removed. Metadata is now fetched automatically using polkadart's `ChainDataFetcher`.

```dart
// OLD API (removed)
import 'package:ink_cli/ink_cli.dart';

final contractMeta = await ContractMeta.fromProvider(provider: provider);
final blockNumber = contractMeta.blockNumber;
final blockHash = contractMeta.blockHash;
final genesisHash = contractMeta.genesisHash;
final specVersion = contractMeta.specVersion;
final runtimeMetadata = contractMeta.runtimeMetadata;

// NEW API - metadata is fetched automatically
// ContractDeployer and ContractMutator handle metadata internally
final deployer = await ContractDeployer.from(provider: provider);
// or
final mutator = await ContractMutator.fromProvider(provider: provider);

// If you need chain data manually, use ChainDataFetcher from polkadart:
import 'package:polkadart/polkadart.dart';

final chainData = await ChainDataFetcher(provider).fetchStandardData();
```

### Removed: `ContractSigningPayload` Class

The `ContractSigningPayload` class for creating signing payloads has been removed. The new implementation uses polkadart's `ExtrinsicBuilder` which handles signing internally.

```dart
// OLD API (removed)
import 'package:ink_cli/ink_cli.dart';

final signingPayload = ContractSigningPayload(
  method: methodCall,
  blockNumber: meta.blockNumber,
  specVersion: meta.specVersion,
  transactionVersion: meta.transactionVersion,
  genesisHash: meta.genesisHash,
  blockHash: meta.blockHash,
  eraPeriod: 64,
  nonce: nonce,
  tip: 0,
);
final encodedPayload = signingPayload.encode(meta.runtimeMetadata);
final signature = keyPair.sign(encodedPayload);

// NEW API - signing is handled automatically by ExtrinsicBuilder
// ContractBuilder.signAndBuildExtrinsic() handles everything internally
final extrinsic = await ContractBuilder.signAndBuildExtrinsic(
  provider: provider,
  signer: keyPair,
  methodCall: methodCall,
  chainInfo: chainInfo,  // Optional
  tip: 0,
  eraPeriod: 64,
);
```

### Removed: `ContractExtrinsicPayload` Class

The `ContractExtrinsicPayload` class for encoding extrinsics has been removed. Extrinsic encoding is now handled by polkadart's `ExtrinsicBuilder`.

```dart
// OLD API (removed)
import 'package:ink_cli/ink_cli.dart';

final extrinsicPayload = ContractExtrinsicPayload.fromSigningPayload(
  signingPayload,
  keyPair.publicKey.bytes,
  signature,
);
final encodedExtrinsic = extrinsicPayload.encode(
  meta.runtimeMetadata,
  signatureType,
);

// NEW API - encoding handled by ExtrinsicBuilder
// ContractBuilder.signAndBuildExtrinsic() returns encoded extrinsic directly
final encodedExtrinsic = await ContractBuilder.signAndBuildExtrinsic(
  provider: provider,
  signer: keyPair,
  methodCall: methodCall,
);
```

### Removed: `definitions/contracts.dart` (Codec Definitions)

The manual codec definitions for contract runtime API responses have been removed and replaced with `ContractsApiResponseCodec`.

```dart
// OLD API (removed)
// Manual codec structures were defined in definitions/contracts.dart:
// - ContractInstantiateResult
// - ContractExecResult
// - Weight, WeightV1, WeightV2
// - StorageDeposit
// - InstantiateReturnValue
// etc.

// NEW API - use ContractsApiResponseCodec
import 'package:ink_cli/ink_cli.dart';

final codec = ContractsApiResponseCodec(chainInfo);

// Decode deployment result
final instantiateResult = codec.decodeInstantiateResult(responseBytes);

// Decode call result
final callResult = codec.decodeCallResult(responseBytes);
```

### New: `ContractsApiResponseCodec` for Runtime API Decoding

A new codec class properly handles both V14 and V15 metadata for decoding Runtime API responses.

```dart
import 'package:ink_cli/ink_cli.dart';

final codec = ContractsApiResponseCodec(chainInfo);

// For V15 metadata: Uses RuntimeApi metadata for proper type resolution
// For V14 metadata: Falls back to hardcoded known type structures

// Decode instantiate dry-run result
final instantiateResult = codec.decodeInstantiateResult(responseBytes);
final gasRequired = instantiateResult['gas_required'];
final contractAddress = instantiateResult['result']['Ok']['account_id'];

// Decode call dry-run result
final callResult = codec.decodeCallResult(responseBytes);
final gasRequired = callResult['gas_required'];
final returnData = callResult['result']['Ok']['data'];
```

### New: `CodecInterface` Hierarchy for Code Generation

A new type system abstraction provides cleaner code generation.

```dart
// NEW - CodecInterface classes provide type information
import 'package:ink_cli/ink_cli.dart';

// Base interface
abstract class CodecInterface {
  List<String>? get path;
  List<String>? get docs;
}

// Specific implementations:
// - PrimitiveCodecInterface (bool, u8, u32, BigInt, etc.)
// - CompositeCodecInterface (structs)
// - VariantCodecInterface (enums)
// - SequenceCodecInterface (Vec<T>)
// - ArrayCodecInterface ([T; N])
// - TupleCodecInterface ((T1, T2, ...))
// - CompactCodecInterface (Compact<T>)
// - BitSequenceCodecInterface
// - OptionCodecInterface (Option<T>)
```

### Changed: `ContractBuilder` Now Uses `ExtrinsicBuilder`

`ContractBuilder` has been refactored to use polkadart's `ExtrinsicBuilder` internally.

```dart
// OLD API - manual extrinsic construction
final extrinsic = await ContractBuilder.signAndBuildExtrinsic(
  provider: provider,
  signer: keyPair,
  method: methodCall,
  contractMeta: contractMeta,  // Required ContractMeta
  tip: 0,
  eraPeriod: 64,
);

// NEW API - uses ExtrinsicBuilder internally
final extrinsic = await ContractBuilder.signAndBuildExtrinsic(
  provider: provider,
  signer: keyPair,
  methodCall: methodCall,
  chainInfo: chainInfo,  // Optional - fetched if not provided
  tip: 0,
  eraPeriod: 0,  // 0 = immortal, >0 = mortal era period
);

// Nonce is now fetched automatically via ChainDataFetcher
```

### Changed: `ContractDeployer` Uses New Codec

`ContractDeployer` now uses `ContractsApiResponseCodec` for decoding runtime API responses.

```dart
// Usage remains similar, but internal implementation changed
final deployer = await ContractDeployer.from(provider: provider);

final result = await deployer.deployContract(
  code: wasmCode,
  selector: constructorSelector,
  keypair: keyPair,
  constructorArgs: args,
  inkAbi: inkAbi,
  // Optional parameters
  salt: salt,
  storageDepositLimit: limit,
  gasLimit: gasLimit,
);

print('Contract deployed at: ${result.contractAddress}');
```

### Changed: `ContractMutator` Uses New Codec

`ContractMutator` now uses `ContractsApiResponseCodec` for decoding runtime API responses.

```dart
// Usage remains similar, but internal implementation changed
final mutator = await ContractMutator.fromProvider(provider: provider);

final result = await mutator.mutate(
  keypair: keyPair,
  input: encodedInput,
  result: dryRunResult,  // From ContractsApi_call
  contractAddress: address,
  inkAbi: inkAbi,
  // Optional parameters
  storageDepositLimit: limit,
  gasLimit: gasLimit,
);
```

### Changed: Minimum Dart SDK Version

```yaml
# OLD
environment:
  sdk: ^3.6.0

# NEW
environment:
  sdk: ^3.8.0
```

## Resources

- [Polkadart Repository](https://github.com/leonardocustodio/polkadart)
- [ink! Documentation](https://use.ink/)
- [Substrate Contracts Pallet](https://docs.polkadot.com)

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](./LICENSE) file for details.
