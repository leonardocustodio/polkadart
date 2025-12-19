# SS58

A Dart library for encoding and decoding [SS58 addresses](https://docs.polkadot.com/polkadot-protocol/parachain-basics/accounts/#address-formats) used in [Substrate](https://docs.polkadot.com/develop/parachains/intro-polkadot-sdk/#substrate)-based blockchains like Polkadot, Kusama, and 80+ other networks.

## Features

- Decode SS58 addresses to extract prefix and public key
- Encode public keys to SS58 address format
- Safe parsing with `tryDecode()` (returns null instead of throwing)
- Convert addresses between different networks
- Built-in registry with 80+ supported networks
- Full exception handling for invalid inputs
- Uses Blake2b hashing (RFC 7693 compliant)

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  ss58: any
```

Then run:

```bash
dart pub get
```

## Quick Start

```dart
import 'package:ss58/ss58.dart';

void main() {
  // Decode an address
  final address = Address.decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
  print('Prefix: ${address.prefix}');  // 42 (Substrate)
  print('Public Key: ${address.pubkey}');

  // Encode to a different network
  final polkadotAddress = address.withPrefix(0).encode();
  print('Polkadot: $polkadotAddress');
}
```

## Usage

### Decoding Addresses

#### Standard Decoding (throws on invalid input)

```dart
import 'package:ss58/ss58.dart';

// Decode any SS58 address
final address = Address.decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');

print('Network Prefix: ${address.prefix}');  // 42
print('Public Key Length: ${address.pubkey.length}');  // 32 bytes
```

#### Safe Decoding (returns null on invalid input)

```dart
// Safe parsing - no exceptions thrown
final address = Address.tryDecode('invalid-address');

if (address != null) {
  print('Valid address with prefix: ${address.prefix}');
} else {
  print('Invalid address');
}
```

### Encoding Addresses

#### From an Address Object

```dart
final address = Address.decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');

// Encode with original prefix
final encoded = address.encode();

// Encode with a different prefix
final polkadotEncoded = address.encode(prefix: 0);
```

#### From Raw Bytes

```dart
import 'dart:typed_data';
import 'package:ss58/ss58.dart';

final pubkey = Uint8List.fromList([/* 32 bytes */]);
final address = Address(prefix: 0, pubkey: pubkey);
final encoded = address.encode();
```

### Cross-Network Address Conversion

Convert the same public key between different networks:

```dart
// Start with a Substrate address (prefix 42)
final substrate = Address.decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');

// Convert to Polkadot (prefix 0)
final polkadot = substrate.withPrefix(0);
print('Polkadot: ${polkadot.encode()}');

// Convert to Kusama (prefix 2)
final kusama = substrate.withPrefix(2);
print('Kusama: ${kusama.encode()}');

// The public key remains the same across all networks
assert(substrate.pubkey == polkadot.pubkey);
```

### Using the Codec Class

For network-specific encoding/decoding:

```dart
// Create a codec for a specific network
final polkadotCodec = Codec.fromNetwork('polkadot');
final kusamaCodec = Codec.fromNetwork('kusama');

// Or by prefix
final substrateCodec = Codec(42);

// Decode (validates the address matches the expected network)
final bytes = substrateCodec.decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');

// Encode
final address = substrateCodec.encode(bytes);
```

### Registry Lookups

Look up network information:

```dart
// Get network by prefix
final polkadot = Codec.registry.getByPrefix(0);
print('Network: ${polkadot.network}');  // "polkadot"

// Get network by name
final kusama = Codec.registry.getByNetwork('kusama');
print('Prefix: ${kusama.prefix}');  // 2

// List all registered networks
for (final item in Codec.registry.items) {
  print('${item.network}: prefix ${item.prefix}');
}
```

## Common Networks

| Network | Prefix | Example Address |
|---------|--------|-----------------|
| Polkadot | 0 | `15oF4uVJwmo4TdGW7VfQxNLavjCXviqxT9S1MgbjMNHr6Sp5` |
| Kusama | 2 | `EXtQYFeY2ivDsfazZvGC9aG87DxnhWH2f9kjUUq2pXTZKF5` |
| Substrate | 42 | `5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY` |
| Crust | 66 | `cTMxUeDi2HdYVpedqu5AFMtyDcn4djbBfCKiPDds6k1fuFYXL` |
| Acala | 10 | `23M5ttkmR6KcoTAAE6gcmibnKFtVaTP5yxnY8HF1BmrJ2A1i` |
| Astar | 5 | `ajYMsCKsEAhEvHpeA4XqsfiA9v1CdzZPrCfS6pEfeGHW9j8` |

See the full list in the [SS58 Registry](https://github.com/paritytech/ss58-registry).

## Error Handling

The library provides specific exceptions for different error cases:

```dart
import 'package:ss58/ss58.dart';

try {
  final address = Address.decode('invalid');
} on BadAddressLengthException catch (e) {
  print('Address too short or invalid length');
} on InvalidPrefixException catch (e) {
  print('Invalid network prefix: ${e.prefix}');
} on InvalidCheckSumException catch (e) {
  print('Checksum verification failed');
}

// For Codec with network validation
try {
  Codec(2).decode('5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
} on InvalidAddressPrefixException catch (e) {
  print('Expected prefix ${e.prefix}, got ${e.address.prefix}');
}

// For registry lookups
try {
  Codec.registry.getByNetwork('nonexistent');
} on NoEntryForNetworkException catch (e) {
  print('Unknown network: ${e.network}');
}
```

### Exception Types

| Exception | When Thrown |
|-----------|-------------|
| `BadAddressLengthException` | Address is too short or has invalid pubkey length |
| `InvalidPrefixException` | Prefix is negative, > 16383, or cannot be parsed |
| `InvalidCheckSumException` | Blake2b checksum verification failed |
| `InvalidAddressPrefixException` | Address prefix doesn't match Codec's expected prefix |
| `NoEntryForNetworkException` | Network name not found in registry |
| `NoEntryForPrefixException` | Prefix not found in registry |
| `DuplicatePrefixException` | Duplicate prefix when building registry |
| `DuplicateNetworkException` | Duplicate network name when building registry |

## API Reference

### Address Class

| Method | Description |
|--------|-------------|
| `Address.decode(String)` | Decode SS58 address string (throws on error) |
| `Address.tryDecode(String)` | Decode SS58 address string (returns null on error) |
| `encode({int? prefix})` | Encode to SS58 string, optionally with different prefix |
| `withPrefix(int)` | Create new Address with same pubkey but different prefix |
| `prefix` | Network prefix (0-16383) |
| `pubkey` | Raw public key bytes |

### Codec Class

| Method | Description |
|--------|-------------|
| `Codec(int prefix)` | Create codec for specific prefix |
| `Codec.fromNetwork(String)` | Create codec for named network |
| `encode(List<int>)` | Encode bytes to SS58 string |
| `decode(String)` | Decode SS58 string to bytes (validates prefix) |
| `Codec.registry` | Access the global network registry |

### Registry Class

| Method | Description |
|--------|-------------|
| `getByPrefix(int)` | Get RegistryItem by prefix |
| `getByNetwork(String)` | Get RegistryItem by network name |
| `items` | List of all registered networks |

## Supported Public Key Lengths

| Length | Hash Length | Use Case |
|--------|-------------|----------|
| 1 byte | 1 byte | Minimal identifiers |
| 2 bytes | 1 byte | Short identifiers |
| 4 bytes | 1 byte | Account indices |
| 8 bytes | 1 byte | Extended indices |
| 32 bytes | 2 bytes | Standard Ed25519/Sr25519 keys |
| 33 bytes | 2 bytes | Compressed ECDSA keys |

## Resources

- [SS58 Address Format Specification](https://docs.substrate.io/reference/address-formats/)
- [SS58 Registry (GitHub)](https://github.com/paritytech/ss58-registry)
- [Substrate Documentation](https://docs.polkadot.com/develop/parachains/intro-polkadot-sdk/#substrate)
- [Polkadot Wiki](https://wiki.polkadot.network/)

## License

This project is licensed under the Apache 2.0 License - see the [LICENSE](LICENSE) file for details.
