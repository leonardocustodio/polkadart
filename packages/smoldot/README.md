# smoldot

A Dart wrapper for smoldot-light, providing a lightweight Polkadot/Substrate client implementation.

## Features

- **Lightweight**: No need for a full node, runs entirely in-process via FFI
- **Multi-chain**: Support for multiple chains simultaneously (relay chains + parachains)
- **Async/Await**: Idiomatic Dart async APIs for all operations
- **JSON-RPC**: Full JSON-RPC support with concurrent requests
- **Subscriptions**: Stream-based subscriptions to blockchain events
- **Chain Information**: Query chain status, peers, block numbers, and more
- **Type-safe**: Comprehensive type definitions and error handling
- **Cross-platform**: Works on Android, iOS, macOS, Linux, and Windows
- **Thread-safe**: Concurrent requests handled safely with Rust Tokio runtime

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  smoldot: ^0.1.0
```

## Prerequisites

This package requires the native smoldot-light library to be available. The Rust FFI bridge must be built and installed before using this package.

## Usage

### Basic Example

```dart
import 'package:smoldot/smoldot.dart';

void main() async {
  // Create and initialize the client
  final client = SmoldotClient(
    config: SmoldotConfig(
      maxLogLevel: 3,
      maxChains: 8,
    ),
  );

  await client.initialize();

  // Add a chain
  final chain = await client.addChain(
    AddChainConfig(
      chainSpec: polkadotChainSpec,
    ),
  );

  // Make JSON-RPC calls
  final response = await chain.request('system_chain', []);
  print('Connected to: ${response.result}');

  // Get chain information
  final info = await chain.getInfo();
  print('Chain: ${info.name}');
  print('Status: ${info.status}');
  print('Peers: ${info.peerCount}');
  print('Block: #${info.bestBlockNumber}');

  // Subscribe to new blocks
  final subscription = chain.subscribe('chain_subscribeNewHeads', []);
  await for (final block in subscription.take(5)) {
    final header = block.result as Map<String, dynamic>;
    print('New block: ${header['number']}');
  }

  // Clean up
  await client.dispose();
}
```

### Multi-Chain Support

```dart
// Add Polkadot relay chain
final polkadot = await client.addChain(
  AddChainConfig(chainSpec: polkadotSpec),
);

// Add Statemint parachain
final statemint = await client.addChain(
  AddChainConfig(
    chainSpec: statemintSpec,
    potentialRelayChains: [polkadot.chainId],
  ),
);

// Interact with both chains
final polkadotName = await polkadot.request('system_chain', []);
final statemintName = await statemint.request('system_chain', []);
```

### Chain Information

```dart
// Get comprehensive chain info
final info = await chain.getInfo();
print('Name: ${info.name}');
print('Status: ${info.status}');
print('Peers: ${info.peerCount}');
print('Block: #${info.bestBlockNumber}');
print('Hash: ${info.bestBlockHash}');

// Get specific information
final blockNumber = await chain.getBestBlockNumber();
final blockHash = await chain.getBestBlockHash();
final peerCount = await chain.getPeerCount();
final status = await chain.getStatus();

// Get info for all chains
final allChains = await client.getAllChainInfo();
for (final chainInfo in allChains) {
  print('${chainInfo.name}: ${chainInfo.status}');
}
```

### Concurrent Requests

```dart
// Make multiple concurrent JSON-RPC requests
final futures = [
  chain.request('system_chain', []),
  chain.request('system_version', []),
  chain.request('system_name', []),
  chain.request('system_properties', []),
];

final responses = await Future.wait(futures);
print('Chain: ${responses[0].result}');
print('Version: ${responses[1].result}');
```

### Error Handling

```dart
try {
  final response = await chain.request('system_chain', []);
  print(response.result);
} on JsonRpcException catch (e) {
  print('RPC error: ${e.error?.message}');
} on ChainException catch (e) {
  print('Chain ${e.chainId} error: ${e.message}');
} on SmoldotException catch (e) {
  print('Smoldot error: ${e.message}');
}
```

## API Reference

### SmoldotClient

The main client class for managing smoldot-light.

- `initialize()`: Initialize the client
- `addChain(config)`: Add a new chain
- `removeChain(chainId)`: Remove a chain
- `getAllChainInfo()`: Get info for all chains
- `getChain(chainId)`: Get a specific chain by ID
- `hasChain(chainId)`: Check if a chain exists
- `chains`: Get list of all active chains
- `chainCount`: Get the number of active chains
- `dispose()`: Clean up resources

### Chain

Represents a blockchain chain.

- `request(method, params)`: Send JSON-RPC request (concurrent-safe)
- `subscribe(method, params)`: Subscribe to notifications (returns Stream)
- `unsubscribe(subscriptionId)`: Unsubscribe from notifications
- `getInfo()`: Get comprehensive chain information
- `getBestBlockNumber()`: Get the current best block number
- `getBestBlockHash()`: Get the current best block hash
- `getPeerCount()`: Get the number of connected peers
- `getStatus()`: Get the chain status (syncing/synced)
- `waitUntilSynced()`: Wait for sync completion
- `dispose()`: Clean up chain resources

### Configuration

#### SmoldotConfig

```dart
SmoldotConfig(
  maxLogLevel: 3,        // 0=off, 1=error, 2=warn, 3=info, 4=debug, 5=trace
  maxChains: 8,          // Maximum number of chains
  cpuRateLimit: 1.0,     // CPU rate limit (0.0 to 1.0)
  wasmCpuMetering: false,// Enable WASM CPU metering
)
```

#### AddChainConfig

```dart
AddChainConfig(
  chainSpec: '...',                    // Chain specification JSON
  databaseContent: '...',              // Optional: Restore from database
  potentialRelayChains: ['...'],      // Optional: Relay chain IDs
  disableJsonRpc: false,               // Optional: Disable JSON-RPC
)
```

## Platform Support

| Platform | Support | Library Format |
|----------|---------|----------------|
| Android  | ✅      | .so            |
| iOS      | ✅      | .dylib         |
| macOS    | ✅      | .dylib         |
| Linux    | ✅      | .so            |
| Windows  | ✅      | .dll           |

## Building the Native Library

The native smoldot-light library must be built from Rust:

```bash
# Clone smoldot
git clone https://github.com/smol-dot/smoldot.git
cd smoldot

# Build the FFI library (example, adjust as needed)
cargo build --release --package smoldot-light-ffi

# Copy to package directory
cp target/release/libsmoldot_light.* /path/to/smoldot_light/native/
```

## Development Status

✅ **This package is fully functional with comprehensive FFI bridge implementation.**

**Implemented Features:**
- ✅ Client initialization and disposal
- ✅ Chain creation with real chain specs
- ✅ Multi-chain support (relay chains + parachains)
- ✅ Cross-thread FFI callbacks (Rust Tokio → Dart)
- ✅ JSON-RPC requests with concurrent request support
- ✅ Subscriptions to chain events (stream-based)
- ✅ Chain information queries
- ✅ Enhanced chain management

**Known Limitations:**
- ⚠️ Database persistence: Not exposed by smoldot-light API
- ⚠️ Logging: Handled by platform (Android logcat, iOS oslog)
