part of ink_abi;

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
  late final dynamic _version;
  late final int constructorsIndex;
  late final int messagesIndex;

  /// Selector map for messages (selector -> index)
  /// Used by SelectorByteInput for decoding full message input data
  late final SelectorsMap messageSelectors = _buildMessageSelectors();

  /// Selector map for constructors (selector -> index)
  /// Used by SelectorByteInput for decoding full constructor input data
  late final SelectorsMap constructorSelectors = _buildConstructorSelectors();

  /// Create InkAbi from ink! metadata JSON
  ///
  /// The metadata is validated and the internal registry is initialized.
  /// Throws [InkAbiException] if metadata is invalid.
  InkAbi(final Map<String, dynamic> inkAbiJson) {
    _project = SchemaValidator.getInkProject(inkAbiJson);

    // Determine version from the input or project
    _version =
        _project['version'] ??
        (inkAbiJson.containsKey('V3') ? 3 : (inkAbiJson.containsKey('V4') ? 4 : null));

    _registry = InkMetadataRegistry(_project, _getVersion(_version));
    constructorsIndex = _registry.constructorIndex;
    messagesIndex = _registry.messageIndex;
  }

  int? get version => _getVersion(_version);

  int? _getVersion(final dynamic ver) {
    if (ver == null) {
      return null;
    }
    if (ver is String) {
      return int.tryParse(ver);
    }
    if (ver is! int) {
      throw Exception('Expected int/String version-type but got `${ver.runtimeType}`.');
    }
    return ver;
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

    final codec = _registry.codecFor(constructor.codecTypeId!);
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
  dynamic decodeEvent(final String hex, [final List<String>? topics]) {
    final data = decodeHex(hex);
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
          throw DecodingException(
            'Failed to decode event "${event.label}": $e',
            signatureTopic: topic,
          );
        }
      }
    }

    // Fallback: find by topic count
    final matchingEvents = _registry.events
        .where(
          (final event) => event.signatureTopic == null && event.amountIndexed == topics.length,
        )
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
  Codec getCodec(final int type) => _registry.codecFor(type);

  /// Returns a list of all messages
  List<MessageSpec> get messages => List.unmodifiable(_registry.messages);

  /// Returns a list of all constructors
  List<ConstructorSpec> get constructors => List.unmodifiable(_registry.constructors);

  /// Get registry (for advanced usage)
  ///
  /// Provides direct access to the underlying [InkMetadataRegistry]
  /// for advanced type resolution and metadata access.
  InkMetadataRegistry get registry => _registry;

  // ======================================================================
  // INPUT DECODING (SELECTOR + ARGUMENTS)
  // ======================================================================

  /// Build selector map for messages
  ///
  /// Maps each message selector to its index in the messages list.
  /// Used by [SelectorByteInput] for decoding full message input.
  SelectorsMap _buildMessageSelectors() {
    final SelectorsMap map = <String, int>{};
    for (int i = 0; i < _registry.messages.length; i++) {
      map[_registry.messages[i].selector] = i;
    }
    return map;
  }

  /// Build selector map for constructors
  ///
  /// Maps each constructor selector to its index in the constructors list.
  /// Used by [SelectorByteInput] for decoding full constructor input.
  SelectorsMap _buildConstructorSelectors() {
    final SelectorsMap map = <String, int>{};
    for (int i = 0; i < _registry.constructors.length; i++) {
      map[_registry.constructors[i].selector] = i;
    }
    return map;
  }

  /// Decode constructor input data
  ///
  /// Takes full constructor input [data] (selector + SCALE-encoded arguments)
  /// and decodes it into a list of argument values.
  ///
  /// The [data] must be a hex string starting with "0x" containing:
  /// - 4 bytes: constructor selector
  /// - Remaining bytes: SCALE-encoded arguments
  ///
  /// Throws [DecodingException] if:
  /// - The selector is unknown
  /// - The data is too short (< 4 bytes)
  /// - Any argument fails to decode
  ///
  /// Example:
  /// ```dart
  /// // Decode constructor input: selector + arguments
  /// final args = inkAbi.decodeConstructor('0x9bae9d5e00c817a804');
  /// // Returns: [1000] (if constructor takes a single u128 argument)
  /// ```
  dynamic decodeConstructor(final String data) {
    try {
      final input = SelectorByteInput.fromHex(data, constructorSelectors);
      final codec = _registry.codecFor(constructorsIndex);
      return codec.decode(input);
    } on DecodingException {
      rethrow;
    } catch (e) {
      throw DecodingException('Failed to decode constructor input: $e', context: {'data': data});
    }
  }

  /// Decode message input data
  ///
  /// Takes full message input [data] (selector + SCALE-encoded arguments)
  /// and decodes it into a list of argument values.
  ///
  /// The [data] must be a hex string starting with "0x" containing:
  /// - 4 bytes: message selector
  /// - Remaining bytes: SCALE-encoded arguments
  ///
  /// Throws [DecodingException] if:
  /// - The selector is unknown
  /// - The data is too short (< 4 bytes)
  /// - Any argument fails to decode
  ///
  /// Example:
  /// ```dart
  /// // Decode message input: selector + arguments
  /// final args = inkAbi.decodeMessage('0x633aa55164000000');
  /// // Returns: [100] (if message takes a single u32 argument)
  /// ```
  dynamic decodeMessage(final String data) {
    try {
      final input = SelectorByteInput.fromHex(data, messageSelectors);
      final codec = _registry.codecFor(messagesIndex);
      return codec.decode(input);
    } on DecodingException {
      rethrow;
    } catch (e) {
      throw DecodingException('Failed to decode message input: $e', context: {'data': data});
    }
  }
}
