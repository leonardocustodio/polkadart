## SS58 Codec

Provides encoder and decoder used by [SS58](https://github.com/rankanizer/polkadart/tree/main/packages/ss58) to parse [substrate](https://docs.substrate.io/fundamentals/accounts-addresses-keys/) addresses.

## Usage

# Lets Get Started

### 1. Depend on it

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  ss58_codec: any
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
import 'dart:typed_data';
import 'package:ss58_codec/ss58_codec.dart';
```

### Decoding
```dart
  // Decoding a Polkadot Address Object
  
  Address address = SS58Codec.decode('1zugcag7cJVBtVRnFxv5Qftn7xKAnR6YJ9x4x3XLgGgmNnS');
 
  print('Address: $address');
```

### Encoding

```dart
  // Encoding previous Address object
  
  String encodedAddress = SS58Codec.encode(address);
  
  print('Encoded address: $encodedAddress');
```

### Encoding with custom prefix

```dart
  // Encoding with a custom prefix
  
  Address customAddress = Address(prefix: 0, bytes: Uint8List.fromList([1, 2, 3, 4]));
  
  String encodedCustomAddress = SS58Codec.encode(customAddress);
  
  print('Custom address encoded: $encodedCustomAddress');
```
