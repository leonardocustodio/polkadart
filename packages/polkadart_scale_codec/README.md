# polkadart_scale_codec

[polkadart_scale_codec](https://www.pub.dev/packages/polkadart_scale_codec) is a flutter and dart library for encoding and decoding types supported by **polkadot**.

# Lets Get Started

### Supported types:

| Types        | Sign                            |
| ------------ | ------------------------------- |
| Unsigned Int | `u8, u16, u32, u64, u128, u256` |
| Signed Int   | `i8, i16, i32, i64, i128, i256` |
| String       | `Str`                           |
| Boolean      | `bool`                          |
| Compact      | `Compact<T>`                    |
| Enum         | `_enum`                         |
| Composite    | `{}`                            |
| FixedVec     | `[u8, length]`                  |
| BitVec       | `BitVec`                        |
| Option       | `Option<T>`                     |
| Tuple        | `(K, V, T....)`                 |
| Result       | `Result<Ok, Err>`               |

# Usage

### Unsigned Integers ( u8 | u16 | u32 )

```dart
//
// Encode
var output = HexOutput();

final value = 69;

U8Codec.codec.encodeTo(value, output);

// 0x45
var encodedHex = output.toString();

//
// Decode
var input = Input.fromHex(encodedHex);

// 69
var decoded = U8Codec.codec.decode(input);
```

### Unsigned Integers ( u64 | u128 | u256 )

```dart
//
// Encode
var output = HexOutput();

final value = BigInt.parse('115792089237316195423570985008687907853269984665640564039457584007913129639935');

U256Codec.codec.encodeTo(value, output);

// 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
var encodedHex = output.toString();

//
// Decode
var input = Input.fromHex(encodedHex);

// BigInt.parse('115792089237316195423570985008687907853269984665640564039457584007913129639935');
var decoded = U256Codec.codec.decode(input);
```

### Signed Integers ( i8 | i16 | i32 )

```dart
//
// Encode
var output = HexOutput();

final value = -128;

I8Codec.codec.encodeTo(value, output);

// 0x80
var encodedHex = output.toString();

//
// Decode
var input = Input.fromHex(encodedHex);

// -128
var decoded = I8Codec.codec.decode(input);
```

### Signed Integers ( i64 | i128 | i256 )

```dart
//
// Encode
var output = HexOutput();

final value = BigInt.parse('-9223372036854775808');

I64Codec.codec.encodeTo(value, output);

// 0x0000000000000080
var encodedHex = output.toString();

//
// Decode
var input = Input.fromHex(encodedHex);

// BigInt.parse('-9223372036854775808')
var decoded = I64Codec.codec.decode(input);
```

### Compact

```dart
//
// Encode
var output = HexOutput();

final value = 69;

CompactCodec.codec.encodeTo(value, output);

// 0x1501
var encodedHex = output.toString();

//
// Decode
var input = Input.fromHex(encodedHex);

// 69
var decoded = CompactCodec.codec.decode(input);
```

### Option

```dart
  final value = Option.some(true);

  final output = HexOutput();
  
  OptionCodec(BoolCodec.codec).encodeTo(value, output);

  // 0x0101
  var encodedHex = output.toString();

  final input = Input.fromHex(encodedHex);

  // Option.some(true)
  var decoded = OptionCodec(BoolCodec.codec).decode(input);

  // or
  // None
  final value = Option.none();


  final output = HexOutput();
  
  OptionCodec(BoolCodec.codec).encodeTo(value, output);

  // 0x00
  var encodedHex = output.toString();

  final input = Input.fromHex(encodedHex);

  // Option.none()
  var decoded = OptionCodec(BoolCodec.codec).decode(input);
```

### BitVec

```dart
  // Initializing Codec object
  final codec = BitSequenceCodec(BitStore.U8, BitOrder.LSB);

  final value = '11111';

  final bitArray = BitArray.parseBinary(value);

  final output = HexOutput();

  codec.encodeTo(value, output);

  // 0x1f
  final encodedHex = output.toString();

  final input = Input.fromHex(encodedHex);

  // BitArray.parseBinary('11111')
  var decoded = codec.decode(input);
```

### Enum

```dart
  // ignore: unnecessary_cast
  final extraDataCodec = CompositeCodec({
    'index': U8Codec.codec,
    'name': StrCodec.codec,
    'customTuple': TupleCodec([
      SimpleEnumCodec.fromList(['Red', 'Orange']),
      BoolCodec.codec,
    ]),
  }) as Codec;

  final codec = ComplexEnumCodec.sparse(
    {
      0: MapEntry('Plain', StrCodec.codec),
      1: MapEntry('ExtraData', extraDataCodec),
    },
  );

  final value = MapEntry('ExtraData', );
  final output = HexOutput();

  codec.encodeTo(value, output);

  // 0x010124706f6c6b61646172740001
  final encodedHex = output.toString();

  final input = Input.fromHex(encodedHex);

  // MapEntry('ExtraData', {
  //       'index': 1,
  //       'name': 'polkadart',
  //       'customTuple': ['Red', true],
  //     })
  var decoded = codec.decode(input);
```

### Composite

```dart
  // Composite Codec
  final codec = CompositeCodec({
    'index': U8Codec.codec,
    'name': StrCodec.codec,
    'customTuple': TupleCodec([
      SimpleEnumCodec.fromList(['Red', 'Orange']),
      BoolCodec.codec,
    ]),
  }) as Codec;

  final value = {
        'index': 1,
        'name': 'polkadart',
        'customTuple': ['Red', true],
      };

  final output = HexOutput();

  codec.encodeTo(value, output);

  // 0x0124706f6c6b61646172740001
  final encodedHex = output.toString();

  final input = Input.fromHex(encodedHex);

  // {
  //  'index': 1,
  //  'name': 'polkadart',
  //  'customTuple': ['Red', true],
  // }
  var decoded = codec.decode(input);
```

### Result<Ok, Err>

```dart
  // Creates the registry for parsing the types
  final registry = Registry();

  // register the customCodec of your choice
  registry.registerCustomCodec(<String, dynamic>{'A':'Result<u8, bool>'});
  
  // Initialize the scale codec
  final codec = ScaleCodec(registry);

  final output = HexOutput();
  
  codec.encodeTo('A', MapEntry('Ok', 42), output);
  
  // 0x002a
  final encodedHex = output.toString();
  
  final input = Input.fromHex(encodedHex);

  // MapEntry('Ok', 42)
  var decoded = codec.decode('A', input);


  // or
  //
  // For Err field
  //
  final value = MapEntry('Err', false);

  codec.encodeTo('A', value, output);
  // 0x0100
  final encodedHex = output.toString();

  // MapEntry('Err', false)
  var decoded = codec.decode('A', input);
```

## Resources

- [substrate.dev](https://substrate.dev/docs/en/knowledgebase/advanced/codec)
- [Parity-scale-codec](https://github.com/paritytech/parity-scale-codec)
- [Polkadot.js](http://polkadot.js.org/)
- [Squid](https://github.com/subsquid/squid)
