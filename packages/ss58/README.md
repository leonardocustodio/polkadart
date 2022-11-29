## SS58

Provides encoding and decoding methods for parsing [substrate](https://docs.substrate.io/fundamentals/accounts-addresses-keys/)
addresses.

SS58 account examples can be finded in [ss58-Registry](https://github.com/paritytech/ss58-registry).

# Lets Get Started

### 1. Depend on it

Add `ss58` with command:

```css
dart pub add ss58
```

### 2. Install it

You can install packages from the command line:

with `pub`:

```css
dart pub get
```

with `Flutter`:

```css
flutter pub get
```

### 3. Import it

Now in your `Dart` code, you can use:

```dart
import 'package:ss58/ss58.dart';
```

### Registry Info by Network

```dart
// get registry info of given `network`

final kusamaRegistry = Codec.registry.getByNetwork('kusama');

print('kusama registry: $kusamaRegistry');
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
