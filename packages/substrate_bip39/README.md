<!--
---
title: Substrate BIP39
category: 6554f399f9c12600114b8cb8
---
-->

# substrate_bip39

This is a package for deriving secret keys from BIP39 phrases using [substrate-bip39](https://github.com/paritytech/substrate-bip39) standard.

## Usage

Simple BIP39 mneumonic
```dart
import 'package:convert/convert.dart' show hex;
import 'package:substrate_bip39/substrate_bip39.dart';

final phrase = 'ozone drill grab fiber curtain grace pudding thank cruise elder eight picnic';

final seed = await SubstrateBip39.ed25519.seedFromUri(phrase);
assert(hex.encode(seed) == 'ae2383139b3aa529c5997ed82f62def14243fbf92bc9ef7badf72e0ff289ea82');
```

Substrate Junctions and Password
```dart
final phrase = 'vessel ladder alter error federal sibling chat ability sun glass valve picture//0///password';

// Ed25519
final seed = await SubstrateBip39.ed25519.seedFromUri(phrase);
assert(hex.encode(seed) == 'd77ca3404e232ff317509d5da871495f9f5bade1821a84216d7070fc92c9bedb');

// Ecdsa
final seed = await SubstrateBip39.ecdsa.seedFromUri(phrase);
assert(hex.encode(seed) == 'cfacf223c22a3ce5758b07be3c16fffd47acfec5a0bb5e0d71f3c21f87e22333');
```

Substrate Development Accounts
```dart
final phrase = '//Alice';
final seed = await SubstrateBip39.ed25519.seedFromUri(phrase);
assert(hex.encode(seed) == 'abf8e5bdbe30c65656c0a3cbd181ff8a56294a69dfedd27982aace4a76909115');
```

512bit seed from entropy
```dart
final entropy = hex.decode('59d1d7b63fbc9a343360a7dabc035f66d7504c549696d2b0b1ae56862911a821');
final seed = await SubstrateBip39.seedFromEntropy(entropy);
assert(hex.encode(seed) == '38b35a8cfbad9e9ca3ed4260be142b8237494aea83dee55d24f6228d4014b5736f40f51ebb8ddab08c31da0da394a0e0f68cb0e06402497e31908e942bf79d78');
```

256bit seed from entropy
```dart
final entropy = hex.decode('59d1d7b63fbc9a343360a7dabc035f66d7504c549696d2b0b1ae56862911a821');
final seed = await SubstrateBip39.miniSecretFromEntropy(entropy);
assert(hex.encode(seed) == '38b35a8cfbad9e9ca3ed4260be142b8237494aea83dee55d24f6228d4014b573');
```
