# substrate_metadata

A powerful Dart/Flutter library for encoding and decoding Substrate blockchain metadata, extrinsics, events, and constants.

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  substrate_metadata: any
```

Then run:

```bash
dart pub get
```

## Quick Start

```dart
import 'package:substrate_metadata/substrate_metadata.dart';

// 1. Decode metadata from hex bytes
final metadataBytes = decodeHex('0x6d657461...'); // Your chain's metadata
final prefixed = RuntimeMetadataPrefixed.fromBytes(metadataBytes);

// 2. Create ChainInfo - your one-stop shop for chain operations
final chainInfo = prefixed.buildChainInfo();

// 3. Decode events from storage
final eventsHex = '0x08000000...'; // Events from System.Events storage
final events = chainInfo.eventsCodec.decode(Input.fromHex(eventsHex));

for (final record in events) {
  print('${record.event.palletName}.${record.event.eventName}');
  print('Data: ${record.event.data}');
}

// 4. Access runtime constants
final existentialDeposit = chainInfo.constantsCodec.getConstant(
  'Balances',
  'ExistentialDeposit'
);
print('Existential Deposit: $existentialDeposit');
```

## Common Use Cases

### Decoding Events

```dart
final eventsCodec = EventsRecordCodec(registry);

// Decode events from System.Events storage
final events = eventsCodec.decode(Input.fromHex(eventsHex));

for (final record in events) {
  // Phase: when the event occurred
  switch (record.phase.type) {
    case PhaseType.applyExtrinsic:
      print('During extrinsic ${record.phase.extrinsicIndex}');
    case PhaseType.finalization:
      print('During finalization');
    case PhaseType.initialization:
      print('During initialization');
  }

  // Event details
  final event = record.event;
  print('Pallet: ${event.palletName} (index: ${event.palletIndex})');
  print('Event: ${event.eventName} (index: ${event.eventIndex})');
  print('Data: ${event.data}');

  // Topics for filtering
  print('Topics: ${record.topics}');
}

// Encode events back to bytes
final output = HexOutput();
eventsCodec.encodeTo(events, output);
final encodedHex = output.toString();

// Query event metadata
final transferInfo = eventsCodec.getEventInfo('Balances', 'Transfer');
print('Fields: ${transferInfo?.fields.map((f) => f.name)}');
```

### Decoding Extrinsics

```dart
final extrinsicsCodec = ExtrinsicsCodec(registry);

// Decode extrinsics from a block
final extrinsics = extrinsicsCodec.decode(Input.fromHex(blockExtrinsicsHex));

for (final ext in extrinsics) {
  print('Version: ${ext.version}');
  print('Signed: ${ext.isSigned}');

  // The call being made
  final call = ext.call;
  print('Call: ${call.palletName}.${call.callName}');
  print('Args: ${call.args}');

  // Signature (if signed)
  if (ext.signature != null) {
    final sig = ext.signature!;
    print('Signer: ${sig.address}');
    print('Nonce: ${sig.extra['CheckNonce']}');
    print('Tip: ${sig.extra['ChargeTransactionPayment']}');
  }
}

// Encode a runtime call
final callCodec = RuntimeCallCodec(registry);
final encodedCall = callCodec.encode(RuntimeCall(
  palletName: 'Balances',
  palletIndex: 5,
  callName: 'transfer_allow_death',
  callIndex: 0,
  args: {
    'dest': {'Id': recipientBytes},
    'value': BigInt.from(1000000000000),
  },
));
```

### Working with Constants

```dart
// Standard codec - loads all constants eagerly
final constantsCodec = ConstantsCodec(registry);

// Get a single constant
final blockHashCount = constantsCodec.getConstant('System', 'BlockHashCount');

// Get all constants for a pallet
final balancesConstants = constantsCodec.getPalletConstants('Balances');
print('ExistentialDeposit: ${balancesConstants['ExistentialDeposit']}');

// Get all constants across runtime
final allConstants = constantsCodec.getAllConstants();

// Get constant metadata
final info = constantsCodec.getConstantInfo('Balances', 'ExistentialDeposit');
print('Type: ${info?.typeString}');
print('Docs: ${info?.documentation}');

// Lazy codec - loads constants on demand (memory efficient)
final lazyCodec = LazyConstantsCodec(registry);

// Preload frequently used constants
lazyCodec.preloadConstants([
  ('Balances', 'ExistentialDeposit'),
  ('TransactionPayment', 'TransactionByteFee'),
]);

// Check loading status
final stats = lazyCodec.getLoadingStats();
print('Loaded: ${stats['loadedConstants']}/${stats['totalConstants']}');
```

### ChainInfo & MetadataTypeRegistry

```dart
// ChainInfo - convenient facade for all chain operations
final chainInfo = ChainInfo.fromMetadata(metadataBytes);

// Or from prefixed metadata
final prefixed = RuntimeMetadataPrefixed.fromBytes(bytes);
final chainInfo = prefixed.buildChainInfo();

// Access components
final registry = chainInfo.registry;           // Type registry
final eventsCodec = chainInfo.eventsCodec;     // Events codec
final extrinsicsCodec = chainInfo.extrinsicsCodec;  // Extrinsics codec
final constantsCodec = chainInfo.constantsCodec;    // Constants codec
final callsCodec = chainInfo.callsCodec;       // Runtime calls codec

// MetadataTypeRegistry - the heart of the type system
final registry = MetadataTypeRegistry(prefixedMetadata);

// Get codec for any type ID
final codec = registry.codecFor(typeId);
final decoded = codec.decode(input);

// Look up types
final type = registry.typeById(42);
final typeByPath = registry.typeByPath('sp_runtime::DispatchError');

// Access pallet metadata
final balances = registry.palletByName('Balances');
final system = registry.palletByIndex(0);

// Get storage metadata
final accountStorage = registry.getStorageMetadata('System', 'Account');

// V15: Access runtime APIs
final apiCodec = registry.getRuntimeApiOutputCodec('Core', 'version');
```

## Features

- **Metadata V14 & V15 Support** - Full support for modern Substrate metadata formats
- **Complete Type System** - Portable type registry with all Substrate type definitions
- **Event Decoding/Encoding** - Decode and encode runtime events with full type safety
- **Extrinsic Handling** - Parse and construct signed/unsigned extrinsics
- **Constants Access** - Easy access to runtime constants with lazy loading support
- **Storage Hashers** - Blake2b, Blake3, and XXHash implementations for storage key generation
- **Cross-Platform** - Works on Flutter, Dart VM, and Web (WASM compatible)
- **Zero Configuration** - Automatically adapts to any Substrate-based chain via metadata

## Storage Hashers

Generate storage keys for querying chain state:

```dart
// Available hashers
final blake2b128 = Hasher.blake2b128;  // Cryptographic, 16 bytes
final blake2b256 = Hasher.blake2b256;  // Cryptographic, 32 bytes
final twox128 = Hasher.twoxx128;       // Fast (non-crypto), 16 bytes
final twox64 = Hasher.twoxx64;         // Fast (non-crypto), 8 bytes

// Hash a string
final hash = Hasher.twoxx128.hashString('System');

// Storage value (no key)
final storageValue = StorageValue(
  prefix: 'System',
  storage: 'Number',
  valueCodec: U32Codec.codec,
);
final key = storageValue.hashedKey();  // 32 bytes

// Storage map (single key)
final storageMap = StorageMap(
  prefix: 'System',
  storage: 'Account',
  hasher: StorageHasher.blake2b128Concat(accountIdCodec),
  valueCodec: accountInfoCodec,
);
final accountKey = storageMap.hashedKeyFor(accountId);

// Storage double map (two keys)
final doubleMap = StorageDoubleMap(
  prefix: 'Staking',
  storage: 'ErasStakers',
  hasher1: StorageHasher.twoxx64Concat(U32Codec.codec),
  hasher2: StorageHasher.twoxx64Concat(accountIdCodec),
  valueCodec: exposureCodec,
);
final stakersKey = doubleMap.hashedKeyFor(eraIndex, validatorId);

// N-map for variable number of keys
final nMap = StorageNMap(
  prefix: 'Assets',
  storage: 'Account',
  hashers: [
    StorageHasher.blake2b128Concat(U32Codec.codec),
    StorageHasher.blake2b128Concat(accountIdCodec),
  ],
  valueCodec: assetAccountCodec,
);
final assetKey = nMap.hashedKeyFor([assetId, accountId]);
```

### Hasher Selection Guide

| Hasher | Security | Speed | Use Case |
|--------|----------|-------|----------|
| `blake2b128Concat` | Secure | Moderate | User-controlled keys (recommended) |
| `blake2b256` | Secure | Moderate | High-security hashing |
| `twox64Concat` | Not secure | Fast | Trusted keys only |
| `twox128` | Not secure | Fast | Internal/system keys |
| `identity` | N/A | Fastest | When key is already unique |

**Note**: "Concat" variants append the original key, enabling storage enumeration.

## Data Models

### RuntimeEvent

```dart
class RuntimeEvent {
  final String palletName;    // e.g., "Balances"
  final int palletIndex;      // e.g., 5
  final String eventName;     // e.g., "Transfer"
  final int eventIndex;       // e.g., 2
  final Map<String, dynamic> data;  // Event fields

  String get identifier => '$palletName.$eventName';
}
```

### UncheckedExtrinsic

```dart
class UncheckedExtrinsic {
  final int version;                    // Extrinsic version (usually 4)
  final ExtrinsicSignature? signature;  // null for unsigned
  final RuntimeCall call;               // The actual call

  bool get isSigned => signature != null;
}
```

### RuntimeCall

```dart
class RuntimeCall {
  final String palletName;
  final int palletIndex;
  final String callName;
  final int callIndex;
  final Map<String, dynamic> args;
}
```

### EventRecord

```dart
class EventRecord {
  final Phase phase;           // When during block execution
  final RuntimeEvent event;    // The actual event
  final List<String> topics;   // For indexed filtering
}
```

### Phase

```dart
enum PhaseType { applyExtrinsic, finalization, initialization }

class Phase {
  final PhaseType type;
  final int? extrinsicIndex;  // Only for applyExtrinsic
}
```

## Core Concepts

### The Metadata-Driven Approach

Unlike traditional SDKs that require compile-time type definitions, `substrate_metadata` dynamically builds codecs from runtime metadata. This means:

1. **Any Chain Support** - Works with Polkadot, Kusama, or any custom Substrate chain
2. **Version Agnostic** - Automatically handles runtime upgrades
3. **No Code Generation** - No build steps or generated files needed

### Key Components

| Component | Purpose |
|-----------|---------|
| `RuntimeMetadataPrefixed` | Decoded metadata with version detection |
| `MetadataTypeRegistry` | Core type resolution and codec generation |
| `ChainInfo` | High-level facade for common operations |
| `EventsRecordCodec` | Decode/encode event records |
| `ExtrinsicsCodec` | Decode/encode block extrinsics |
| `ConstantsCodec` | Access runtime constants |

## Metadata Versions

### V14 (Current Standard)

- Portable type registry
- Pallet metadata (calls, events, errors, constants, storage)
- Extrinsic metadata with signed extensions

### V15 (Latest)

Everything in V14, plus:

- **Runtime APIs**: Metadata for runtime API methods
- **Outer Enums**: Direct access to RuntimeCall, RuntimeEvent, RuntimeError types
- **Custom Metadata**: Chain-specific metadata extensions
- **Pallet Documentation**: Documentation strings for pallets

```dart
// V15-specific: Access runtime APIs
if (registry.outerEnums != null) {
  final apiCodec = registry.getRuntimeApiOutputCodec('TransactionPaymentApi', 'query_info');
  // Use codec for runtime API calls
}
```

## Resources

- [Polkadart Repository](https://github.com/leonardocustodio/polkadart)
- [Polkadot Documentation](https://docs.polkadot.com/)
- [SCALE Codec Specification](https://docs.polkadot.com/polkadot-protocol/basics/data-encoding/)
- [Substrate Metadata](https://docs.substrate.io/build/application-dev/#metadata-system)
- [Polkadot.js](https://polkadot.js.org/)

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](./LICENSE) file for details.
