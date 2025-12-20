# ink_abi

A Dart package for encoding and decoding ink! smart contract ABI (Application Binary Interface). This package supports ink! metadata versions 3, 4, and 5.

## Features

- Decode constructor calls from encoded data
- Decode message (function) calls from encoded data
- Decode events emitted by ink! contracts
- Encode constructor and message calls
- Full support for ink! metadata v3, v4, and v5
- Type-safe codec resolution via `substrate_metadata` integration
- Comprehensive exception handling with typed exceptions

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  ink_abi: ^0.3.1
```

## Usage

```dart
import 'dart:convert';
import 'dart:io';
import 'package:ink_abi/ink_abi.dart';

void main() {
  // Load contract metadata JSON
  final json = jsonDecode(File('contract.json').readAsStringSync());

  // Create InkAbi instance
  final inkAbi = InkAbi(json);

  // Decode a constructor call
  final constructorResult = inkAbi.decodeConstructor('0x9bae9d5e...');
  print('Constructor: ${constructorResult.name}');
  print('Args: ${constructorResult.value}');

  // Decode a message call
  final messageResult = inkAbi.decodeMessage('0x84a15da1...');
  print('Message: ${messageResult.name}');
  print('Args: ${messageResult.value}');

  // Decode an event (v3/v4)
  final eventData = inkAbi.decodeEvent('0x00...');
  print('Event data: $eventData');

  // Decode an event with topics (v5)
  final topics = ['0x1a35e726...', '0xda002226...'];
  final v5EventData = inkAbi.decodeEvent('0x...', topics);
  print('V5 Event data: $v5EventData');

  // Encode a message call
  final encoded = inkAbi.encodeMessageCall('transfer', [recipient, amount]);

  // Encode a constructor call
  final encodedConstructor = inkAbi.encodeConstructorCall('new', [initialSupply]);
}
```

## API Reference

### InkAbi Class

The main class for interacting with ink! contract ABIs.

#### Constructor

```dart
InkAbi(Map<String, dynamic> inkMetadataJson)
```

#### Methods

| Method | Description |
|--------|-------------|
| `decodeConstructor(String data)` | Decode constructor call data, returns `DecodeResult` |
| `decodeMessage(String data)` | Decode message call data, returns `DecodeResult` |
| `decodeEvent(String data, [List<String>? topics])` | Decode event data (topics required for v5 signature-based events) |
| `encodeMessageCall(String name, List args)` | Encode a message call by name |
| `encodeConstructorCall(String name, List args)` | Encode a constructor call by name |

### Specification Classes

| Class | Description |
|-------|-------------|
| `MessageSpec` | Message/function specification with `selector`, `args`, `returnType`, `mutates`, `payable` |
| `ConstructorSpec` | Constructor specification with `selector`, `args`, `returnType`, `payable` |
| `EventSpec` | Event specification with `typeId`, `amountIndexed`, `signatureTopic` |
| `ArgSpec` | Argument specification with `label` and `type` |
| `TypeSpec` | Type specification with `typeId` and `displayName` |
| `TypeInfo` | Type information helper with path, typeDef, and type checking methods |
| `EventData` | Decoded event data wrapper with `name`, `data`, `spec`, and optional `topics`/`index` |

### Exception Classes

| Exception | Description |
|-----------|-------------|
| `InkAbiException` | Base exception for ink_abi errors |
| `DecodingException` | Thrown when decoding fails (invalid data, unknown selector) |
| `EncodingException` | Thrown when encoding fails (selector not found, invalid args) |
| `TypeResolutionException` | Thrown when type resolution fails (type not found) |

---

## Breaking Changes (v0.3.x)

This version introduces a complete architectural overhaul using a registry-based approach. Review these breaking changes carefully before upgrading.

### 1. Import Path Changed

```dart
// Before
import 'package:ink_abi/ink_abi_base.dart';

// After
import 'package:ink_abi/ink_abi.dart';
```

### 2. Removed Classes

The following classes have been **completely removed**:

| Removed Class | Reason |
|---------------|--------|
| `InkAbiDescription` | Functionality merged into `InkAbi` |
| `TypesNormalizer` | Replaced by `InkMetadataRegistry` |
| `InkAbiEvent` | Replaced by `EventSpec` and `EventData` |

#### Removed Interface Classes (entire `interfaces/` folder)

All custom codec interface classes have been removed in favor of `substrate_metadata` integration:

- `AbstractInterface`
- `ArrayCodecInterface`
- `BitSequenceInterface`
- `CompactCodecInterface`
- `CompositeCodecInterface`
- `OptionCodecInterface`
- `PrimitiveCodecInterface`
- `SequenceCodecInterface`
- `TupleCodecInterface`
- `VariantCodecInterface`
- `Params`

#### Removed Enums

- `TypeKindEnum`
- `PrimitiveEnum`

#### Removed Utilities

- `StringExtension` (from `utils/string_extension.dart`)
- Utility functions (from `utils/utils.dart`)

### 3. Event Decoding API Change

Event decoding now supports v5 signature topics:

```dart
// v3/v4 events (index-based) - unchanged
final decoded = inkAbi.decodeEvent(data);

// v5 events (signature topic-based) - NEW
final topics = ['0x1a35e726...', '0xda002226...'];
final decoded = inkAbi.decodeEvent(data, topics);
```

### 4. Typed Exceptions

Replace generic exception handling with typed exceptions:

```dart
// Before
try {
  inkAbi.decodeMessage(data);
} catch (e) {
  // Generic Exception
}

// After
try {
  inkAbi.decodeMessage(data);
} on DecodingException catch (e) {
  print('Decoding failed: ${e.message}');
} on EncodingException catch (e) {
  print('Encoding failed: ${e.message}');
} on TypeResolutionException catch (e) {
  print('Type not found: ${e.message}');
} on InkAbiException catch (e) {
  print('General error: ${e.message}');
}
```

### 5. Registry-Based Architecture

The internal architecture now uses `substrate_metadata`'s `MetadataTypeRegistry` for type resolution:

```dart
// Access the internal registry if needed
final registry = inkAbi.registry;

// Get codec for a specific type ID
final codec = registry.codecFor(typeId);

// Access message specifications
final messages = registry.messages;

// Access constructor specifications
final constructors = registry.constructors;

// Access event specifications
final events = registry.events;

// Lookup by selector
final message = registry.messageBySelector('0x633aa551');
final constructor = registry.constructorBySelector('0x9bae9d5e');
```

### 6. New Dependencies

The following dependencies have been added:

- `equatable` - Value equality for model classes
- `json_annotation` - JSON serialization support
- `substrate_metadata` - Type registry and codec resolution

### 7. SDK Version

Minimum Dart SDK version is now `^3.8.0`.

---

## Supported ink! Versions

| Metadata Version | Event Handling | Status |
|-----------------|----------------|--------|
| v3 | Index-based | Supported |
| v4 | Index-based | Supported |
| v5 | Signature topic-based | Supported |

