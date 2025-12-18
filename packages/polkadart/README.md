# polkadart

A powerful Dart/Flutter SDK for interacting with Polkadot, Kusama, and any Substrate-based blockchain. Query storage, submit extrinsics, make RPC calls, and much more.

---

## Breaking Changes from Previous Version

This is a **major rewrite** of the `polkadart` package with significant architectural improvements. If you're upgrading from a previous version, please read this section carefully.

### Removed: Storage Classes and Hashers

All storage-related classes (`StorageValue`, `StorageMap`, `StorageDoubleMap`, etc.) and hashers (`Hasher`, `StorageHasher`, `Blake2bHasher`, `Blake3Hasher`, `TwoxxHasher`) have been **moved to the `substrate_metadata` package**.

```dart
// OLD API (removed from polkadart)
import 'package:polkadart/substrate/substrate.dart';

final storageMap = StorageMap<Uint8List, AccountInfo>(
  prefix: 'System',
  storage: 'Account',
  hasher: StorageHasher.blake2b128Concat(AccountIdCodec()),
  valueCodec: AccountInfoCodec(),
);

// NEW API - import from substrate_metadata
import 'package:substrate_metadata/substrate_metadata.dart';

final storageMap = StorageMap<Uint8List, AccountInfo>(
  prefix: 'System',
  storage: 'Account',
  hasher: StorageHasher.blake2b128Concat(AccountIdCodec()),
  valueCodec: AccountInfoCodec(),
);
```

**Removed from polkadart:**
- `Hasher` abstract class and implementations (`blake2b64/128/256`, `blake364/128/256`, `twoxx64/128/256`)
- `StorageHasher<K>` class
- `StorageValue<V>`, `StorageMap<K,V>`, `StorageDoubleMap<K1,K2,V>`
- `StorageTripleMap`, `StorageQuadrupleMap`, `StorageQuintupleMap`, `StorageSextupleMap`
- `StorageNMap<V>`
- `Era` class (mortal/immortal era encoding)
- All files in `substrate/hash/` folder

### Removed: `RuntimeMetadata` Class

The `RuntimeMetadata` class (which wrapped `ChainInfo`) has been removed. Use `ChainInfo` directly from `substrate_metadata`.

```dart
// OLD API (removed)
final stateApi = StateApi(provider);
final runtimeMetadata = await stateApi.getMetadata();
final chainInfo = runtimeMetadata.chainInfo;

// NEW API
final stateApi = StateApi(provider);
final chainInfo = await stateApi.getMetadata();  // Returns ChainInfo directly
// Or use typed metadata:
final prefixed = await stateApi.getTypedMetadata();  // Returns RuntimeMetadataPrefixed
final chainInfo = prefixed.buildChainInfo();
```

### Removed: `Transfers` Class

The `Transfers` class with `transferKeepAlive` has been removed. Use the new `Balances` module instead.

```dart
// OLD API (removed)
import 'package:polkadart/primitives/transfers.dart';

final callData = Transfers.transferKeepAlive.encode(
  chainInfo,
  destinationBytes,
  amount,
);

// NEW API - Fluent Balances module
import 'package:polkadart/polkadart.dart';

final callData = Balances.transferKeepAlive
  .to(destination: recipientAddress, amount: amount)
  .encode(chainInfo);

// Or with accountId bytes:
final callData = Balances.transferKeepAlive
  .toAccountId(destination: destinationBytes, amount: amount)
  .encode(chainInfo);
```

### Removed: Old Extrinsic System (`Extrinsic`, `SigningPayload`, `ExtrinsicPayload`)

The entire old extrinsic construction system has been replaced with the new `ExtrinsicBuilder` API.

```dart
// OLD API (removed)
import 'package:polkadart/extrinsic/extrinsic.dart';

final signingPayload = SigningPayload(
  method: callData,
  specVersion: runtimeVersion.specVersion,
  transactionVersion: runtimeVersion.transactionVersion,
  genesisHash: genesisHash,
  blockHash: blockHash,
  blockNumber: blockNumber,
  eraPeriod: 64,
  nonce: nonce,
  tip: 0,
);

final encodedPayload = signingPayload.encode(chainInfo);
final signature = keyPair.sign(encodedPayload);

final extrinsicPayload = ExtrinsicPayload.fromPayload(
  signingPayload,
  keyPair.publicKey.bytes,
  signature,
);
final encodedExtrinsic = extrinsicPayload.encode(chainInfo, signatureType);

// NEW API - Fluent ExtrinsicBuilder
import 'package:polkadart/polkadart.dart';

// Option 1: Quick send (one-liner)
final hash = await ExtrinsicBuilder.quickSend(
  provider: provider,
  chainInfo: chainInfo,
  callData: callData,
  signerAddress: keyPair.address,
  signingCallback: keyPair.sign,
);

// Option 2: From ChainData (recommended)
final chainData = await ChainDataFetcher(provider).fetchStandardData(
  accountAddress: keyPair.address,
);
final result = await ExtrinsicBuilder.fromChainData(
  chainInfo: chainInfo,
  callData: callData,
  chainData: chainData,
)
  .tip(BigInt.from(1000))
  .era(period: 64)
  .signBuildAndSubmit(
    provider: provider,
    signerAddress: keyPair.address,
    signingCallback: keyPair.sign,
  );

// Option 3: Full manual control
final builder = ExtrinsicBuilder(
  chainInfo: chainInfo,
  callData: callData,
  genesisHash: genesisHash,
  blockHash: blockHash,
  blockNumber: blockNumber,
  specVersion: specVersion,
  transactionVersion: transactionVersion,
  nonce: nonce,
);
final encoded = await builder.signAndBuild(
  provider: provider,
  signerAddress: keyPair.address,
  signingCallback: keyPair.sign,
);
await encoded.submit(provider);
```

### Removed: Manual Signed Extensions (`SubstrateSignedExtensions`, `AssetHubSignedExtensions`)

The manual signed extensions classes have been replaced with the automated `ExtensionBuilder` system.

```dart
// OLD API (removed)
import 'package:polkadart/extrinsic/signed_extensions/substrate.dart';

final extensions = SubstrateSignedExtensions();
final (encoded, isUsed) = extensions.signedExtension('CheckNonce', {'nonce': nonce});

// NEW API - Automatic handling via ExtensionBuilder
// Extensions are automatically managed by ExtrinsicBuilder
final builder = ExtrinsicBuilder.fromChainData(...)
  .nonce(nonce)           // Optional: auto-fetched if not provided
  .tip(tip)               // Optional: defaults to 0
  .era(period: 64)        // Optional: defaults to mortal with 64 blocks
  .immortal()             // Or make immortal
  .metadataHash(enabled: true)  // Optional: metadata hash support
  .assetId(assetId);      // Optional: for asset-based fees
```

### Changed: Multisig API (Static Methods to Instance Methods)

The multisig system has been completely redesigned from static methods to an instance-based class.

```dart
// OLD API (changed)
import 'package:polkadart/multisig/multisig.dart';

// Creating multisig
final response = await Multisig.createAndFundMultisig(
  depositorKeyPair: keyPair,
  threshold: 2,
  recipientAddress: recipient,
  amount: amount,
  provider: provider,
  otherSignatoriesAddressList: [address2, address3],
);

// Approving
await Multisig.approveAsMulti(
  multisigResponse: response,
  provider: provider,
  signer: signer,
);

// OLD: MultisigMeta for metadata
final meta = await MultisigMeta.fromProvider(provider);

// OLD: Signatory class
final signatory = Signatory.fromAddress(address);

// NEW API - Instance-based Multisig class
import 'package:polkadart/polkadart.dart';

// Create MultisigAccount first
final multisigAccount = MultisigAccount(
  addresses: [alice.address, bob.address, charlie.address],
  threshold: 2,
);

// Create Multisig instance
final multisig = Multisig(
  provider: provider,
  chainInfo: chainInfo,
  multisigAccount: multisigAccount,
);

// Fund the multisig
await multisig.createAndFundMultisig(
  fundingAmount: amount,
  depositorAddress: alice.address,
  signingCallback: alice.sign,
);

// Initiate a transfer
final response = await multisig.initiateTransfer(
  senderAddress: alice.address,
  signingCallback: alice.sign,
  recipientAddress: recipient,
  transferAmount: amount,
);

// Approve (non-final approval)
await multisig.approveAsMulti(
  approverAddress: bob.address,
  signingCallback: bob.sign,
  callData: response.callData,
);

// Final approval and execution
await multisig.asMulti(
  callData: response.callData,
  approverAddress: charlie.address,
  signingCallback: charlie.sign,
);

// Check status
final status = await response.getStatus(provider, signerAddress: bob.address);
print('Approvals: ${status.approvals.length}/${status.threshold}');
print('Can approve: ${status.canApprove}');
```

**Removed Multisig Classes:**
- `MultisigMeta` - No longer needed, data fetched automatically
- `Signatory` - Replaced by `MultisigAccount`
- `multisig/exceptions.dart` - `FinalApprovalException`, `OwnerCallException`
- `multisig/extensions.dart` - Utility extensions
- `multisig/utilities.dart` - Utility functions

**New Multisig Classes:**
- `MultisigAccount` - Represents multisig configuration
- `MultisigStorageStatus` - Rich status information
- `Uint8ListConverter` - JSON serialization support

### Changed: Provider Location

Provider classes have moved from the root to the `apis/` folder.

```dart
// OLD import (still works via re-export, but file moved)
import 'package:polkadart/provider.dart';

// NEW import (direct)
import 'package:polkadart/apis/provider.dart';

// Recommended import (uses main library)
import 'package:polkadart/polkadart.dart';
```

### New: `ChainDataFetcher` for Batch Data Fetching

A new class for efficiently fetching all required chain data in parallel.

```dart
import 'package:polkadart/polkadart.dart';

final fetcher = ChainDataFetcher(provider);

// Fetch all standard data needed for extrinsics
final chainData = await fetcher.fetchStandardData(
  accountAddress: signerAddress,  // Optional: include nonce
);

print('Genesis: ${chainData.genesisHash}');
print('Block: ${chainData.blockNumber} (${chainData.blockHash})');
print('Spec: ${chainData.specVersion}');
print('Nonce: ${chainData.nonce}');
```

### New: `Balances` Module with Fluent Call Builders

A new type-safe, fluent API for balance operations.

```dart
import 'package:polkadart/polkadart.dart';

// Transfer (transfer_allow_death)
final call = Balances.transfer.to(
  destination: recipientAddress,
  amount: BigInt.from(1000000000000),
);
final encoded = call.encode(chainInfo);

// Transfer keep alive
final call = Balances.transferKeepAlive.toAccountId(
  destination: recipientPubkey,
  amount: amount,
);

// Transfer all
final call = Balances.transferAll.to(
  destination: recipientAddress,
  keepAlive: true,
);

// Force transfer (sudo)
final call = Balances.forceTransfer.to(
  source: fromAddress,
  destination: toAddress,
  amount: amount,
);

// Force set balance (sudo)
final call = Balances.forceSetBalance.to(
  who: targetAddress,
  newFree: newBalance,
);
```

### New: `BlockHeader` and `ChainData` Models

New data models for chain state.

```dart
import 'package:polkadart/polkadart.dart';

// BlockHeader - Simple block reference
final header = BlockHeader(
  hash: blockHash,
  number: blockNumber,
);

// ChainData - Complete chain state for extrinsic building
final chainData = ChainData(
  genesisHash: genesis,
  blockHash: currentHash,
  blockNumber: currentNumber,
  specVersion: specVersion,
  transactionVersion: txVersion,
  nonce: accountNonce,  // Optional
);
```

### Changed: Dependencies

| Removed | Kept | Added |
|---------|------|-------|
| `pointycastle` | `convert` | `equatable` |
| `hashlib_codecs` | `http` | `json_serializable` |
| | `web_socket_client` | `json_annotation` |
| | `polkadart_scale_codec` | |
| | `substrate_metadata` | |
| | `ss58` | |

**Note:** `polkadart_keyring` moved from dependencies to dev_dependencies.

### Changed: Minimum Dart SDK Version

```yaml
# OLD
environment:
  sdk: ^3.6.0

# NEW
environment:
  sdk: ^3.8.0
```

### Changed: Scale Codec Export

The scale codec is now re-exported with a filter.

```dart
// OLD - full export
export 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

// NEW - excludes ListExtension to avoid conflicts
export 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    hide ListExtension;
```

### Migration Summary

| Old API | New API |
|---------|---------|
| `SigningPayload` + `ExtrinsicPayload` | `ExtrinsicBuilder` |
| `SubstrateSignedExtensions` | Automatic via `ExtensionBuilder` |
| `Multisig.createAndFundMultisig(...)` | `multisig.createAndFundMultisig(...)` |
| `MultisigMeta.fromProvider()` | Not needed - automatic |
| `Signatory.fromAddress()` | `MultisigAccount(addresses: [...])` |
| `Transfers.transferKeepAlive.encode()` | `Balances.transferKeepAlive.to(...).encode()` |
| `RuntimeMetadata.fromHex()` | `ChainInfo` from `substrate_metadata` |
| `StorageMap`, `StorageValue`, etc. | Import from `substrate_metadata` |
| `Hasher.blake2b128.hash()` | Import from `substrate_metadata` |
| Manual nonce/era/tip handling | Auto-managed by `ExtrinsicBuilder` |

---

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  polkadart: ^0.7.3
```

Then run:

```bash
dart pub get
```

## Quick Start

```dart
import 'package:polkadart/polkadart.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';

void main() async {
  // Connect to a node
  final provider = WsProvider(Uri.parse('wss://rpc.polkadot.io'));
  await provider.connect();

  // Get chain info (metadata)
  final stateApi = StateApi(provider);
  final chainInfo = await stateApi.getMetadata();

  // Create a keypair
  final keyring = Keyring();
  final keyPair = await keyring.fromMnemonic('your twelve word mnemonic...');

  // Build and submit a transfer
  final callData = Balances.transferKeepAlive
    .to(destination: recipientAddress, amount: BigInt.from(1000000000000))
    .encode(chainInfo);

  final txHash = await ExtrinsicBuilder.quickSend(
    provider: provider,
    chainInfo: chainInfo,
    callData: callData,
    signerAddress: keyPair.address,
    signingCallback: keyPair.sign,
  );

  print('Transaction submitted: $txHash');

  await provider.disconnect();
}
```

## Features

- **Fluent Extrinsic Builder** - Type-safe, chainable API for building transactions
- **Automatic Signed Extensions** - No manual extension handling required
- **Parallel Data Fetching** - Efficient chain data retrieval via `ChainDataFetcher`
- **Balances Module** - Pre-built calls for common balance operations
- **Multisig Support** - Complete multisig transaction management
- **RPC APIs** - Full coverage of author, chain, state, and system APIs
- **Provider Abstraction** - HTTP and WebSocket support with subscriptions

## RPC APIs

### StateApi

```dart
final stateApi = StateApi(provider);

// Get metadata
final chainInfo = await stateApi.getMetadata();

// Get storage
final value = await stateApi.getStorage(storageKey);

// Subscribe to storage changes
await stateApi.subscribeStorage(keys, (changes) {
  print('Storage changed: $changes');
});
```

### ChainApi

```dart
final chainApi = ChainApi(provider);

// Get block hash
final hash = await chainApi.getBlockHash(blockNumber: 1000);

// Get header
final header = await chainApi.getChainHeader();
```

### SystemApi

```dart
final systemApi = SystemApi(provider);

// Node info
final name = await systemApi.name();
final version = await systemApi.version();
final health = await systemApi.health();

// Account nonce
final nonce = await systemApi.accountNextIndex(address);
```

### AuthorApi

```dart
final authorApi = AuthorApi(provider);

// Submit extrinsic
final hash = await authorApi.submitExtrinsic(encodedExtrinsic);

// Submit and watch
await authorApi.submitAndWatchExtrinsic(encodedExtrinsic, (status) {
  if (status.isFinalized) {
    print('Finalized in block: ${status.blockHash}');
  }
});
```

## Extrinsic Building

### Quick Send (Simplest)

```dart
final txHash = await ExtrinsicBuilder.quickSend(
  provider: provider,
  chainInfo: chainInfo,
  callData: callData,
  signerAddress: keyPair.address,
  signingCallback: keyPair.sign,
);
```

### From ChainData (Recommended)

```dart
// Fetch all required data in parallel
final chainData = await ChainDataFetcher(provider).fetchStandardData(
  accountAddress: keyPair.address,
);

// Build with full control
final result = await ExtrinsicBuilder.fromChainData(
  chainInfo: chainInfo,
  callData: callData,
  chainData: chainData,
)
  .tip(BigInt.from(1000))           // Optional tip
  .era(period: 64)                   // Mortal era (64 blocks)
  .signBuildAndSubmitWatch(
    provider: provider,
    signerAddress: keyPair.address,
    signingCallback: keyPair.sign,
    onStatusChange: (status) {
      print('Status: ${status.type}');
    },
  );
```

### Get Signing Payload Only

```dart
final builder = ExtrinsicBuilder.fromChainData(...);
final payload = builder.getSigningPayload();
// Sign externally
final signature = externalSigner.sign(payload);
```

## Multisig Operations

```dart
// Create multisig account
final multisigAccount = MultisigAccount(
  addresses: [alice.address, bob.address, charlie.address],
  threshold: 2,
);

// Create multisig handler
final multisig = Multisig(
  provider: provider,
  chainInfo: chainInfo,
  multisigAccount: multisigAccount,
);

// Initiate a transfer from the multisig
final response = await multisig.initiateTransfer(
  senderAddress: alice.address,
  signingCallback: alice.sign,
  recipientAddress: recipient,
  transferAmount: BigInt.from(1000000000000),
);

// Second signatory approves
await multisig.approveAsMulti(
  approverAddress: bob.address,
  signingCallback: bob.sign,
  callData: response.callData,
);

// Check status
final status = await response.getStatus(provider);
print('${status.approvals.length}/${status.threshold} approvals');
```

## Resources

- [Polkadart Repository](https://github.com/leonardocustodio/polkadart)
- [Polkadot Documentation](https://docs.polkadot.com/)

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](./LICENSE) file for details.

