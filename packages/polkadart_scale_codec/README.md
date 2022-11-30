# polkadart_scale_codec

[polkadart_scale_codec](https://www.pub.dev/packages/polkadart_scale_codec) is a flutter and dart library for encoding and decoding types supported by **polkadot**.

# Lets Get Started

### Supported types:

| Types        | Sign                            |
| ------------ | ------------------------------- |
| Unsigned Int | `u8, u16, u32, u64, u128, u256` |
| Signed Int   | `i8, i16, i32, i64, i128, i256` |
| String       | `Text`                          |
| Boolean      | `bool`                          |
| Address      | `Address`                       |
| Bytes        | `Bytes`                         |
| Compact      | `Compact<T>`                    |
| Enum         | `_enum`                         |
| Struct       | `_struct`                       |
| FixedVec     | `[u8, length]`                  |
| BitVec       | `BitVec`                        |
| Option       | `Option<T>`                     |
| Tuple        | `(K, V, T....)`                 |
| Result       | `Result<Ok, Err>`               |

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


  // or
  //
  // For Err field
  //
  final value = {'Err': false};

  // 0x0100
  var encoded = codec.encode(registryIndex, value);

  // {'Err': false}
  var decoded = codec.decode(registryIndex, encoded);
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

  final value = Some(true);

  // 0x0101
  var encoded = codec.encode(registryIndex, value);

  // Some(true)
  var decoded = codec.decode(registryIndex, encoded);

  // or
  // None
  final value = None;

  // 0x00
  var encoded = codec.encode(registryIndex, value);

  // None
  var decoded = codec.decode(registryIndex, encoded);
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

  // [255, 255]
  var decoded = codec.decode(registryIndex, encoded);
```

### BitVec

```dart
  // Creates the registry for parsing the types
  final registry = TypeRegistry();

  // specifying which type to use.
  final registryIndex = registry.getIndex('BitVec');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);

  final value = [255, 255];

  // 0x40ffff
  var encoded = codec.encode(registryIndex, value);

  // [255, 255]
  var decoded = codec.decode(registryIndex, encoded);
```

### Enum

```dart
  // Creates the registry for parsing the types
  final registry = TypeRegistry(
    types: {
      'FavouriteColorEnum': {
        '_enum': ['Red', 'Orange']
      },
      'CustomComplexEnum': {
        '_enum': {
          'Plain': 'Text',
          'ExtraData': {
            'index': 'u8',
            'name': 'Text',
            'customTuple': '(FavouriteColorEnum, bool)'
          }
        }
      },
    },
  );
  // specifying which type to use.
  var typeIndex = registry.getIndex('CustomComplexEnum');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);

  final extraDataComplex = {
    'ExtraData': {
      'index': 1,
      'name': 'polkadart',
      'customTuple': ['Red', true]
    },
  };
  // 0x01
  var encoded = codec.encode(typeIndex, value);

  // 'ExtraData': {
  //   'index': 1,
  //   'name': 'polkadart',
  //   'customTuple': ['Red', true]
  // },
  var decoded = codec.decode(typeIndex, encoded);
```

### Struct

```dart
  // Creates the registry for parsing the types
  final registry = TypeRegistry(
    types: {
      'OrderJuiceEnum': {
        '_enum': ['Orange', 'Apple', 'Kiwi']
      },
      'OuncesEnum': {
        '_struct': {'ounces': 'u8', 'Remarks': 'Option<Text>'}
      },
      'OrderStruct': {
        '_struct': {
          'index': 'u8',
          'note': 'Text',
          'Juice': 'OrderJuiceEnum',
          'Ounces': 'OuncesEnum'
        }
      },
    },
  );

  final typeIndex = registry.getIndex('OrderStruct');

  // fetching the parsed types from `Json` to `Type`
  final types = registry.getTypes();

  // Initializing Scale-Codec object
  final codec = Codec(types);

  final order = {
    'index': 8,
    'note': 'This is a note',
    'Juice': 'Kiwi',
    'Ounces': {
      'ounces': 1,
      'Remarks': Some('This is the first order.'),
    }
  };
  
  final encoded = codec.encode(typeIndex, order);
  
  // {
  //   'index': 8,
  //   'note': 'This is a note',
  //   'Juice': 'Kiwi',
  //   'Ounces': {
  //     'ounces': 1,
  //     'Remarks': Some('This is the first order.'),
  //   }
  // }
  final decoded = codec.decode(typeIndex, encoded);
  
  print(decoded);
```

## Resources

- [substrate.dev](https://substrate.dev/docs/en/knowledgebase/advanced/codec)
- [Parity-scale-codec](https://github.com/paritytech/parity-scale-codec)
- [Polkadot.js](http://polkadot.js.org/)
- [Squid](https://github.com/subsquid/squid)
