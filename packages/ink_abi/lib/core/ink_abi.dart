import 'dart:typed_data';
import 'package:ink_abi/ink_abi_base.dart' show SchemaValidator;
import 'package:ink_abi/models/arg_spec.dart' show ArgSpec;
import 'package:ink_abi/models/constructor_spec.dart' show ConstructorSpec;
import 'package:ink_abi/models/message_spec.dart' show MessageSpec;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import '../registry/ink_metadata_registry.dart';
import '../exceptions/ink_abi_exception.dart';
import '../exceptions/encoding_exception.dart';
import '../exceptions/decoding_exception.dart';

/// Main interface for working with ink! contract metadata.
///
/// Provides encoding/decoding for messages, constructors, and events.
/// Buildt on top of [InkMetadataRegistry] for efficient type resolution.
///
/// Example:
/// ```dart
/// final inkAbi = InkAbi(metadataJson);
///
/// // Encode message input
/// final encoded = inkAbi.encodeMessageInput('0x633aa551', [arg1, arg2]);
///
/// // Decode message output
/// final result = inkAbi.decodeMessageOutput('0x633aa551', outputBytes);
///
/// // Decode event
/// final event = inkAbi.decodeEvent(eventData, topics);
/// ```
class InkAbi {
  late final InkMetadataRegistry _registry;
  late final Map<String, dynamic> _project;
  late final int? version;

  /// Create InkAbi from ink! metadata JSON
  ///
  /// The metadata is validated and the internal registry is initialized.
  /// Throws [InkAbiException] if metadata is invalid.
  InkAbi(final Map<String, dynamic> inkAbiJson) {
    _project = SchemaValidator.getInkProject(inkAbiJson);
    version = _project['version'] as int?;
    _registry = InkMetadataRegistry(inkAbiJson);
  }

  // ======================================================================
  // MESSAGE ENCODING/DECODING
  // ======================================================================

  MessageSpec getMessageSpec(final String selector) {
    final message = _registry.messageBySelector(selector);
    if (message == null) {
      throw InkAbiException('Message not found: $selector');
    }
    return message;
  }

  /// Encode message input with positional arguments
  ///
  /// Takes a message [selector] and list of [args] and encodes them
  /// into SCALE-encoded bytes suitable for contract calls.
  ///
  /// Throws [InkAbiException] if the selector is not found.
  /// Throws [EncodingException] if any argument fails to encode.
  ///
  /// Example:
  /// ```dart
  /// final encoded = inkAbi.encodeMessageInput('0x633aa551', [100, true]);
  /// ```
  Uint8List encodeMessageInput(final String selector, final List<dynamic> args) {
    final MessageSpec message = getMessageSpec(selector);

    final ByteOutput output = ByteOutput();
    output.write(decodeHex(selector));

    for (int i = 0; i < message.args.length; i++) {
      final ArgSpec argSpec = message.args[i];
      final codec = _registry.codecFor(argSpec.codecTypeId);

      try {
        codec.encodeTo(args[i], output);
      } catch (e) {
        throw EncodingException(
          'Failed to encode argument "${argSpec.label}" at position $i: $e',
          argumentName: argSpec.label,
          expectedType: argSpec.type.displayNameString,
        );
      }
    }

    return output.toBytes();
  }

  /// Decode message output
  ///
  /// Takes a message [selector] and the raw output [value] bytes,
  /// and decodes them using the message's return type.
  ///
  /// Throws [InkAbiException] if the selector is not found.
  /// Throws [DecodingException] if decoding fails.
  ///
  /// Example:
  /// ```dart
  /// final result = inkAbi.decodeMessageOutput('0x633aa551', outputBytes);
  /// ```
  dynamic decodeMessageOutput(final String selector, final Uint8List value) {
    final MessageSpec message = getMessageSpec(selector);

    final codec = _registry.codecFor(message.codecTypeId);
    final ByteInput input = ByteInput(value);

    try {
      return codec.decode(input);
    } catch (e) {
      throw DecodingException(
        'Failed to decode message output for "${message.label}": $e',
        selector: selector,
      );
    }
  }

  // ======================================================================
  // CONSTRUCTOR ENCODING/DECODING
  // ======================================================================

  ConstructorSpec getConstructorSpec(final String selector) {
    final constructor = _registry.constructorBySelector(selector);
    if (constructor == null) {
      throw InkAbiException('Constructor not found: $selector');
    }
    return constructor;
  }

  /// Encode constructor input with positional arguments
  ///
  /// Takes a constructor [selector] and list of [args] and encodes them
  /// into SCALE-encoded bytes suitable for contract instantiation.
  ///
  /// Throws [InkAbiException] if the selector is not found.
  /// Throws [EncodingException] if any argument fails to encode.
  ///
  /// Example:
  /// ```dart
  /// final encoded = inkAbi.encodeConstructorInput('0x9bae9d5e', [initialValue]);
  /// ```
  Uint8List encodeConstructorInput(final String selector, final List<dynamic> args) {
    final ConstructorSpec constructor = getConstructorSpec(selector);

    final ByteOutput output = ByteOutput();
    output.write(decodeHex(selector));

    for (int i = 0; i < constructor.args.length; i++) {
      final argSpec = constructor.args[i];
      final codec = _registry.codecFor(argSpec.codecTypeId);

      try {
        codec.encodeTo(args[i], output);
      } catch (e) {
        throw EncodingException(
          'Failed to encode constructor argument "${argSpec.label}" at position $i: $e',
          argumentName: argSpec.label,
          expectedType: argSpec.type.displayNameString,
        );
      }
    }

    return output.toBytes();
  }

  /// Decode constructor output
  ///
  /// Takes a constructor [selector] and the raw output [value] bytes,
  /// and decodes them using the constructor's return type.
  ///
  /// Throws [InkAbiException] if the selector is not found.
  /// Throws [DecodingException] if decoding fails.
  ///
  /// Example:
  /// ```dart
  /// final result = inkAbi.decodeConstructorOutput('0x9bae9d5e', outputBytes);
  /// ```
  dynamic decodeConstructorOutput(final String selector, final Uint8List value) {
    final ConstructorSpec constructor = getConstructorSpec(selector);

    final codec = _registry.codecFor(constructor.codecTypeId);
    final ByteInput input = ByteInput(value);

    try {
      return codec.decode(input);
    } catch (e) {
      throw DecodingException(
        'Failed to decode constructor output for "${constructor.label}": $e',
        selector: selector,
      );
    }
  }

  // ======================================================================
  // EVENT DECODING
  // ======================================================================

  /// Decode event based on contract version
  ///
  /// Automatically handles both v4 (index-based) and v5 (topic-based) events.
  /// For v5 contracts, [topics] must be provided.
  ///
  /// Throws [InkEventException] if topics are missing for v5 or event cannot be determined.
  /// Throws [DecodingException] if the event data is invalid.
  ///
  /// Example:
  /// ```dart
  /// // v4 event (no topics needed)
  /// final event = inkAbi.decodeEvent(eventBytes);
  ///
  /// // v5 event (topics required)
  /// final event = inkAbi.decodeEvent(eventBytes, ['0x...']);
  /// ```
  dynamic decodeEvent(final Uint8List data, [final List<String>? topics]) {
    if (version == 5) {
      if (topics == null || topics.isEmpty) {
        throw InkEventException.topicsRequired();
      }
      return _decodeEventV5(data, topics);
    } else {
      return _decodeEventV4(data);
    }
  }

  /// Decode v4 event (index-based)
  dynamic _decodeEventV4(final Uint8List data) {
    final ByteInput input = ByteInput(data);
    final int idx = input.read();

    final event = _registry.eventByIndex(idx);
    if (event == null) {
      throw DecodingException.eventIndexOutOfBounds(idx, _registry.events.length - 1);
    }

    try {
      final codec = _registry.eventCodec(idx);
      return codec.decode(input);
    } catch (e) {
      throw DecodingException('Failed to decode event "${event.label}": $e', eventIndex: idx);
    }
  }

  /// Decode v5 event (topic-based)
  dynamic _decodeEventV5(final Uint8List data, final List<String> topics) {
    if (topics.isNotEmpty) {
      final topic = topics[0];
      final event = _registry.eventBySignatureTopic(topic);

      if (event != null) {
        final codec = _registry.codecFor(event.typeId);
        final input = ByteInput(data);

        try {
          return codec.decode(input);
        } catch (e) {
          throw DecodingException('Failed to decode event "${event.label}": $e',
              signatureTopic: topic);
        }
      }
    }

    // Fallback: find by topic count
    final matchingEvents = _registry.events
        .where(
            (final event) => event.signatureTopic == null && event.amountIndexed == topics.length)
        .toList(growable: false);

    if (matchingEvents.length == 1) {
      final event = matchingEvents.first;
      final codec = _registry.codecFor(event.typeId);
      final input = ByteInput(data);

      try {
        return codec.decode(input);
      } catch (e) {
        throw DecodingException('Failed to decode event "${event.label}": $e');
      }
    }

    throw InkEventException.cannotDetermineEvent(matchingEvents.length);
  }

  /// Get codec for type ID
  ///
  /// Returns the SCALE codec for the given type ID.
  /// This delegates to the internal [InkMetadataRegistry].
  ///
  /// Example:
  /// ```dart
  /// final codec = inkAbi.getCodec(5);
  /// final encoded = codec.encode(value);
  /// ```
  Codec getCodec(int type) => _registry.codecFor(type);

  /// Returns a list of all messages
  List<MessageSpec> get messages => List.unmodifiable(_registry.messages);

  /// Returns a list of all constructors
  List<ConstructorSpec> get constructors => List.unmodifiable(_registry.constructors);

  /// Get registry (for advanced usage)
  ///
  /// Provides direct access to the underlying [InkMetadataRegistry]
  /// for advanced type resolution and metadata access.
  InkMetadataRegistry get registry => _registry;
}
