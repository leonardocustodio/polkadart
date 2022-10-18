# polkadart_scale_codec

### [polkadart_scale_codec](https://www.pub.dev/packages/polkadart_scale_codec) is a flutter and dart library for encoding and decoding types supported by **polkadot**.

# Lets Get Started

### 1. Depend on it
Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  polkadart_scale_codec: 0.0.2
```

### 2. Install it

You can install packages from the command line:

with `pub`:

```css
$  dart pub get
```

with `Flutter`:

```css
$  flutter pub get
```

### 3. Import it

Now in your `Dart` code, you can use: 

```dart
    import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
```

# Usage

### Unsigned Integers ( u8 | u16 | u32 )

```dart
  // Creates the registry for parsing the types
  final registry = TypeRegistry();

  // specifying which type to use.
  final registryIndex = registry.getIndex('u8');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);
  
  final value = 69;
  
  // 0x45
  var encoded = codec.encode(registryIndex, value);
  
  // 69
  var decoded = codec.decode(registryIndex, encoded);
  
  assert(decoded, value);
```

### Unsigned Integers ( u64 | u128 | u256 )

```dart
  // Creates the registry for parsing the types
  final registry = TypeRegistry();

  // specifying which type to use.
  final registryIndex = registry.getIndex('u256');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);
  
  final value = BigInt.parse('115792089237316195423570985008687907853269984665640564039457584007913129639935');
  
  // 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  var encoded = codec.encode(registryIndex, value);
  
  // _BigIntImpl (115792089237316195423570985008687907853269984665640564039457584007913129639935)
  var decoded = codec.decode(registryIndex, encoded);
  
  assert(decoded, value);
```

### Signed Integers ( i8 | i16 | i32 )

```dart
  // Creates the registry for parsing the types
  final registry = TypeRegistry();

  // specifying which type to use.
  final registryIndex = registry.getIndex('i8');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);
  
  final value = -128;
  
  // 0x80
  var encoded = codec.encode(registryIndex, value);
  
  // -128
  var decoded = codec.decode(registryIndex, encoded);
  
  assert(decoded, value);
```

### Signed Integers ( i64 | i128 | i256 )

```dart
  // Creates the registry for parsing the types
  final registry = TypeRegistry();

  // specifying which type to use.
  final registryIndex = registry.getIndex('i64');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);
  
  final value = BigInt.parse('-9223372036854775808');
  
  // 0x0000000000000080
  var encoded = codec.encode(registryIndex, value);
  
  // _BigIntImpl (-9223372036854775808) 
  var decoded = codec.decode(registryIndex, encoded);
  
  assert(decoded, value);
```

### Result<Ok, Err>

```dart
  // Creates the registry for parsing the types
  final registry = TypeRegistry();

  // specifying which type to use.
  final registryIndex = registry.getIndex('Result<u8, bool>');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);
  
  final value = {'Ok': 42};
  
  // 0x002a
  var encoded = codec.encode(registryIndex, value);
  
  // {'Ok': 42}
  var decoded = codec.decode(registryIndex, encoded);
  assert(decoded, value);
  
  
  
  // or
  // 
  // For Err field
  //
  final value = {'Err': false};
  
  // 0x0100
  var encoded = codec.encode(registryIndex, value);
  
  // {'Err': false}
  var decoded = codec.decode(registryIndex, encoded);
  assert(decoded, value);
```

### Compact

```dart
  // Creates the registry for parsing the types
  final registry = TypeRegistry();

  // specifying which type to use.
  final registryIndex = registry.getIndex('Compact<u8>');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);
  
  final value = 69;
  
  // 0x1501
  var encoded = codec.encode(registryIndex, value);
  
  // 69
  var decoded = codec.decode(registryIndex, encoded);
  assert(decoded, value);
```

### Option

```dart
  // Creates the registry for parsing the types
  final registry = TypeRegistry();

  // specifying which type to use.
  final registryIndex = registry.getIndex('Option<bool>');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);
  
  final value = true;
  
  // 0x0101
  var encoded = codec.encode(registryIndex, value);
  
  // true
  var decoded = codec.decode(registryIndex, encoded);
  assert(decoded, value);
  

  // or
  // null
  final value = null;
  
  // 0x00
  var encoded = codec.encode(registryIndex, value);
  
  // null
  var decoded = codec.decode(registryIndex, encoded);
  assert(decoded, value);
```

### Bytes

```dart
  // Creates the registry for parsing the types
  final registry = TypeRegistry();

  // specifying which type to use.
  final registryIndex = registry.getIndex('Bytes');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);
  
  final value = [255, 255];
  
  // 0x08ffff
  var encoded = codec.encode(registryIndex, value);
  
  // true
  var decoded = codec.decode(registryIndex, encoded);
  assert(decoded, value);
```