---
title: SS58
category: 6554f399f9c12600114b8cb8
---

## SS58

Provides encoding and decoding methods for parsing [substrate](https://docs.substrate.io/fundamentals/accounts-addresses-keys/)
addresses.

SS58 account examples can be finded in [ss58-Registry](https://github.com/paritytech/ss58-registry).

# Lets Get Started

### Decoding a Polkadot Address Object

```dart
final address = Address.decode('1zugcag7cJVBtVRnFxv5Qftn7xKAnR6YJ9x4x3XLgGgmNnS');
```

### Registry Info by Prefix

```dart
// get registry info of given `prefix`

final polkadotRegistry = Codec.registry.getByPrefix(0);

print('polkadot registry: $polkadotRegistry');
```

### Decoding Substrate Address

```dart
// decoding substrate address

final String originalEncodedAddress = '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY';

final List<int> decodedBytes = Codec.fromNetwork('substrate').decode(originalEncodedAddress);

print('Substrate address bytes: $decodedBytes');
```

### Encoding bytes to produce address

```dart
// Encoding the decodedBytes to produce back encodedAddress.

final int substrateAddressPrefix = 42;

final encodedAddress = Codec(substrateAddressPrefix).encode(decodedBytes);

print(encodedAddress);
```
