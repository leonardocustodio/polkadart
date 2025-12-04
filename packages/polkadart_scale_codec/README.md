# polkadart_scale_codec

A Dart library for encoding and decoding data using the [SCALE (Simple Concatenated Aggregate Little-Endian)](https://docs.substrate.io/reference/scale-codec/) codec used in Polkadot and Substrate-based blockchains.

## Features

- Full support for all SCALE primitive types
- Composite types (structs, tuples, enums)
- Collection types (arrays, sequences, maps, sets)
- Optional and Result types
- Compact integer encoding
- Bit sequences with custom bit ordering
- Zero-copy encoding/decoding where possible

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  polkadart_scale_codec: ^latest_version
```

## Quick Start

```dart
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';

void main() {
  // Create an output buffer
  final output = HexOutput();

  // Encode a value
  U8Codec.codec.encodeTo(42, output);
  print(output.toString()); // 0x2a

  // Decode it back
  final input = Input.fromHex('0x2a');
  final decoded = U8Codec.codec.decode(input);
  print(decoded); // 42
}
```

## Core Concepts

### Input and Output

All encoding and decoding operations use `Input` and `Output` interfaces:

- **`Input`** - For reading encoded data
  - `Input.fromHex(String)` - Create from hex string
  - `Input.fromBytes(List<int>)` - Create from bytes

- **`Output`** - For writing encoded data
  - `HexOutput()` - Outputs hex string
  - `ByteOutput()` - Outputs raw bytes

### Codecs

Every type has a corresponding `Codec` that provides:
- `encodeTo(value, output)` - Encode a value
- `decode(input)` - Decode a value
- `encode(value)` - Encode to bytes (convenience method)
- `sizeHint(value)` - Get encoded size in bytes

## Supported Types

### Integer Types

#### Unsigned Integers

| Type | Size | Dart Type | Example |
|------|------|-----------|---------|
| `u8` | 1 byte | `int` | 0 to 255 |
| `u16` | 2 bytes | `int` | 0 to 65,535 |
| `u32` | 4 bytes | `int` | 0 to 4,294,967,295 |
| `u64` | 8 bytes | `BigInt` | 0 to 2^64-1 |
| `u128` | 16 bytes | `BigInt` | 0 to 2^128-1 |
| `u256` | 32 bytes | `BigInt` | 0 to 2^256-1 |

```dart
// Small integers (u8, u16, u32)
final output = HexOutput();
U8Codec.codec.encodeTo(69, output);
print(output); // 0x45

// Large integers (u64, u128, u256)
final bigInt = BigInt.parse('115792089237316195423570985008687907853269984665640564039457584007913129639935');
final output2 = HexOutput();
U256Codec.codec.encodeTo(bigInt, output2);
print(output2); // 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
```

#### Signed Integers

| Type | Size | Dart Type | Range |
|------|------|-----------|-------|
| `i8` | 1 byte | `int` | -128 to 127 |
| `i16` | 2 bytes | `int` | -32,768 to 32,767 |
| `i32` | 4 bytes | `int` | -2^31 to 2^31-1 |
| `i64` | 8 bytes | `BigInt` | -2^63 to 2^63-1 |
| `i128` | 16 bytes | `BigInt` | -2^127 to 2^127-1 |
| `i256` | 32 bytes | `BigInt` | -2^255 to 2^255-1 |

```dart
final output = HexOutput();
I8Codec.codec.encodeTo(-128, output);
print(output); // 0x80

final input = Input.fromHex('0x80');
final decoded = I8Codec.codec.decode(input);
print(decoded); // -128
```

### Compact Encoding

Compact encoding is a variable-length encoding for integers that uses fewer bytes for smaller values.

```dart
// CompactCodec for regular integers
final output = HexOutput();
CompactCodec.codec.encodeTo(69, output);
print(output); // 0x1501

// CompactBigIntCodec for BigInt values
final bigValue = BigInt.parse('18446744073709551615');
final output2 = HexOutput();
CompactBigIntCodec.codec.encodeTo(bigValue, output2);
print(output2); // 0x13ffffffffffffffff
```

Compact encoding rules:
- 0-63: Single byte mode (value << 2)
- 64-16383: Two-byte mode
- 16384-1073741823: Four-byte mode
- Larger: Multi-byte mode with length prefix

### Basic Types

#### String

```dart
final output = HexOutput();
StrCodec.codec.encodeTo('hello', output);
print(output); // 0x1468656c6c6f (length prefix + UTF-8 bytes)

final input = Input.fromHex('0x1468656c6c6f');
final decoded = StrCodec.codec.decode(input);
print(decoded); // hello
```

#### Boolean

```dart
final output = HexOutput();
BoolCodec.codec.encodeTo(true, output);
print(output); // 0x01

final output2 = HexOutput();
BoolCodec.codec.encodeTo(false, output2);
print(output2); // 0x00
```

### Option Type

Represents an optional value (Some or None).

```dart
// Using nullable syntax
final codec = OptionCodec(BoolCodec.codec);

final output = HexOutput();
codec.encodeTo(true, output);
print(output); // 0x0101 (Some(true))

final output2 = HexOutput();
codec.encodeTo(null, output2);
print(output2); // 0x00 (None)

// Using Option class
final value = Option.some(true);
final output3 = HexOutput();
NestedOptionCodec(BoolCodec.codec).encodeTo(value, output3);
print(output3); // 0x0101
```

### Result Type

Represents a value that can be either Ok or Err.

```dart
final codec = ResultCodec(U8Codec.codec, BoolCodec.codec);

// Ok variant
final okValue = Result<int, bool>.ok(42);
final output = HexOutput();
codec.encodeTo(okValue, output);
print(output); // 0x002a

final input = Input.fromHex('0x002a');
final decoded = codec.decode(input);
print(decoded.isOk); // true
print(decoded.okValue); // 42

// Err variant
final errValue = Result<int, bool>.err(false);
final output2 = HexOutput();
codec.encodeTo(errValue, output2);
print(output2); // 0x0100
```

### Collections

#### Array (Fixed Length)

Arrays have a fixed size known at compile time.

```dart
// Array of 4 u8 values
final codec = ArrayCodec(U8Codec.codec, 4);

final output = HexOutput();
codec.encodeTo([1, 2, 3, 4], output);
print(output); // 0x01020304

final input = Input.fromHex('0x01020304');
final decoded = codec.decode(input);
print(decoded); // [1, 2, 3, 4]
```

#### Sequence (Variable Length)

Sequences have a variable length with a compact-encoded length prefix.

```dart
final codec = SequenceCodec(U8Codec.codec);

final output = HexOutput();
codec.encodeTo([1, 2, 3, 4], output);
print(output); // 0x1001020304 (length prefix + data)

final input = Input.fromHex('0x1001020304');
final decoded = codec.decode(input);
print(decoded); // [1, 2, 3, 4]
```

#### BTreeMap

Maps with compact-encoded length prefix.

```dart
final codec = BTreeMapCodec(
  keyCodec: U32Codec.codec,
  valueCodec: BoolCodec.codec,
);

final output = HexOutput();
codec.encodeTo({632: false}, output);
print(output); // 0x047802000000

final input = Input.fromHex('0x047802000000');
final decoded = codec.decode(input);
print(decoded); // {632: false}
```

#### Set

Bit-flag based sets for enum-like values.

```dart
final codec = SetCodec(8, ['Read', 'Write', 'Execute']);

final output = HexOutput();
codec.encodeTo(['Read', 'Execute'], output);
print(output); // 0x05 (binary: 00000101)

final input = Input.fromHex('0x05');
final decoded = codec.decode(input);
print(decoded); // ['Read', 'Execute']
```

### Composite Types

#### Tuple

Fixed-size collection of values of different types.

```dart
final codec = TupleCodec([
  CompactCodec.codec,
  BoolCodec.codec,
  StrCodec.codec,
]);

final output = HexOutput();
codec.encodeTo([3, true, 'hi'], output);
print(output); // 0x0c01086869

final input = Input.fromHex('0x0c01086869');
final decoded = codec.decode(input);
print(decoded); // [3, true, 'hi']
```

#### Composite (Struct)

Named fields with different types.

```dart
final codec = CompositeCodec({
  'index': U8Codec.codec,
  'name': StrCodec.codec,
  'active': BoolCodec.codec,
});

final output = HexOutput();
codec.encodeTo({
  'index': 1,
  'name': 'polkadart',
  'active': true,
}, output);

final input = Input.fromHex(output.toString());
final decoded = codec.decode(input);
print(decoded); // {index: 1, name: polkadart, active: true}
```

### Enums

#### Simple Enum

Enum with unit variants (no data).

```dart
final codec = SimpleEnumCodec.fromList(['Red', 'Green', 'Blue']);

final output = HexOutput();
codec.encodeTo('Green', output);
print(output); // 0x01

final input = Input.fromHex('0x01');
final decoded = codec.decode(input);
print(decoded); // Green
```

#### Complex Enum

Enum with variants that carry data.

```dart
final codec = ComplexEnumCodec.sparse({
  0: const MapEntry<String, Codec>('Plain', StrCodec.codec),
  1: MapEntry<String, Codec>('Fancy', CompositeCodec({
    'index': U8Codec.codec,
    'name': StrCodec.codec,
  })),
});

final output = HexOutput();
codec.encodeTo(MapEntry('Fancy', {
  'index': 1,
  'name': 'polkadart',
}), output);

final input = Input.fromHex(output.toString());
final decoded = codec.decode(input);
print(decoded.key); // Fancy
print(decoded.value); // {index: 1, name: polkadart}
```

### Bit Sequences

Compact representation of bit arrays with configurable bit ordering.

```dart
final codec = BitSequenceCodec(BitStore.U8, BitOrder.LSB);

final bitArray = BitArray.parseBinary('11111');
final output = HexOutput();
codec.encodeTo(bitArray, output);
print(output); // 0x141f (length + packed bits)

final input = Input.fromHex('0x141f');
final decoded = codec.decode(input);
print(decoded.toBinaryString()); // 11111
```

## Advanced Features

### Length-Prefixed Codec

Wraps any codec with a compact length prefix.

```dart
final codec = LengthPrefixedCodec(StrCodec.codec);

final output = HexOutput();
codec.encodeTo('hello', output);
// Outputs: compact(length) + compact(str_length) + bytes
```

### Proxy Codec

Used for recursive type definitions.

```dart
final proxyCodec = ProxyCodec();
// Define recursive structure
proxyCodec.codec = ComplexEnumCodec.sparse({
  0: MapEntry('Leaf', U8Codec.codec),
  1: MapEntry('Branch', proxyCodec), // Self-reference
});
```

### Scale Raw Bytes

For including pre-encoded SCALE data without re-encoding.

```dart
final preEncoded = U8Codec.codec.encode(42);
final rawBytes = ScaleRawBytes(preEncoded);

// Use in a larger structure without decode/re-encode
final codec = CompositeCodec({
  'data': ScaleRawBytes.codec,
});
```

### Null Codec

Empty codec that encodes/decodes nothing (zero bytes).

```dart
final codec = NullCodec.codec;

final output = HexOutput();
codec.encodeTo(null, output);
print(output); // 0x (empty)
```

## Working with Bytes

### Encoding to Different Formats

```dart
final value = 42;

// Hex string
final hexOutput = HexOutput();
U8Codec.codec.encodeTo(value, hexOutput);
print(hexOutput.toString()); // 0x2a

// Raw bytes
final byteOutput = ByteOutput();
U8Codec.codec.encodeTo(value, byteOutput);
final bytes = byteOutput.toBytes();
print(bytes); // Uint8List [42]

// Using encode() helper
final encoded = U8Codec.codec.encode(value);
print(encoded); // Uint8List [42]
```

### Decoding from Different Sources

```dart
// From hex string
final input1 = Input.fromHex('0x2a');
final decoded1 = U8Codec.codec.decode(input1);

// From bytes
final input2 = Input.fromBytes([42]);
final decoded2 = U8Codec.codec.decode(input2);

// From Uint8List
final uint8list = Uint8List.fromList([42]);
final input3 = Input.fromBytes(uint8list);
final decoded3 = U8Codec.codec.decode(input3);
```

## Size Hints

Get the encoded size of a value without actually encoding it:

```dart
final value = 'hello';
final size = StrCodec.codec.sizeHint(value);
print(size); // Number of bytes when encoded

// Useful for pre-allocating buffers
final buffer = ByteOutput(size);
StrCodec.codec.encodeTo(value, buffer);
```

## Common Patterns

### Encoding Multiple Values

```dart
final output = HexOutput();

U8Codec.codec.encodeTo(1, output);
BoolCodec.codec.encodeTo(true, output);
StrCodec.codec.encodeTo('test', output);

print(output); // All values concatenated
```

### Decoding Multiple Values

```dart
final input = Input.fromHex('0x0101107465737402');

final value1 = U8Codec.codec.decode(input);
final value2 = BoolCodec.codec.decode(input);
final value3 = StrCodec.codec.decode(input);
final value4 = U8Codec.codec.decode(input);

print([value1, value2, value3, value4]); // [1, true, test, 2]
```

### Checking Remaining Data

```dart
final input = Input.fromHex('0x2a');

print(input.hasBytes()); // true
final value = U8Codec.codec.decode(input);
print(input.hasBytes()); // false

// Assert all data consumed
input.assertEndOfDataReached(); // Throws if data remaining
```

## Type Reference

### Integer Sequence/Array Codecs

For convenience, specialized codecs exist for integer sequences:

```dart
// Sequences (with length prefix)
U8SequenceCodec.codec
U16SequenceCodec.codec
U32SequenceCodec.codec
U64SequenceCodec.codec
I8SequenceCodec.codec
I16SequenceCodec.codec
I32SequenceCodec.codec
I64SequenceCodec.codec

// Arrays (fixed length)
U8ArrayCodec(length)
U16ArrayCodec(length)
U32ArrayCodec(length)
U64ArrayCodec(length)
I8ArrayCodec(length)
I16ArrayCodec(length)
I32ArrayCodec(length)
I64ArrayCodec(length)
```

## Resources

- [Polkadot Documentation](https://docs.polkadot.com/polkadot-protocol/basics/data-encoding/)
- [Parity SCALE Codec (Rust)](https://github.com/paritytech/parity-scale-codec)
- [Polkadot.js](https://polkadot.js.org/)
- [Squid](https://github.com/subsquid/squid)

## License

See the LICENSE file for details.
