/// ink! ABI library for Polkadart
///
/// This library provides comprehensive support for working with ink! smart contract
/// metadata including encoding/decoding messages, constructors, and events.
///
/// ## Usage
///
/// ```dart
/// import 'package:ink_abi/ink_abi.dart';
///
/// // Parse metadata
/// final metadata = jsonDecode(metadataJson);
/// final registry = InkMetadataRegistry(metadata);
///
/// // Get message specification
/// final message = registry.messageBySelector('0x633aa551');
/// print('Message: ${message?.label}');
///
/// // Get codec for encoding/decoding
/// final codec = registry.codecFor(message.returnType.typeId);
/// final decoded = codec.decode(input);
/// ```
library ink_abi;

// Core registry
export 'registry/ink_metadata_registry.dart';

// Models/Specs
export 'models/arg_spec.dart';
export 'models/constructor_spec.dart';
export 'models/event_spec.dart';
export 'models/message_spec.dart';
export 'models/type_spec.dart';

// Exceptions
export 'exceptions/ink_abi_exception.dart';
export 'exceptions/type_resolution_exception.dart';
export 'exceptions/encoding_exception.dart';
export 'exceptions/decoding_exception.dart';
