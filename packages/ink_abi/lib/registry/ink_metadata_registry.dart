part of ink_abi;

/// Type registry for ink! contract metadata
///
/// Provides centralized type resolution and codec management specifically
/// for ink! smart contracts. Builds on top of [MetadataTypeRegistry] to
/// add ink!-specific features like selector-based lookups and event handling.
///
/// Example:
/// ```dart
/// final registry = InkMetadataRegistry(inkMetadataJson);
///
/// // Get message by selector
/// final message = registry.messageBySelector('0x633aa551');
///
/// // Get codec for message return type
/// final codec = registry.codecFor(message.returnType.typeId);
///
/// // Encode message arguments
/// final output = ByteOutput();
/// for (int i = 0; i < message.args.length; i++) {
///   final argCodec = registry.codecFor(message.args[i].type.typeId);
///   argCodec.encodeTo(args[i], output);
/// }
/// ```
class InkMetadataRegistry {
  /// Raw ink! metadata JSON
  final Map<String, dynamic> _inkMetadata;

  /// Ink! metadata version (3, 4, or 5)
  final int? version;

  /// Internal MetadataTypeRegistry for codec resolution
  late final MetadataTypeRegistry _typeRegistry;

  /// Portable type registry built from ink! types
  late final PortableRegistry _portableRegistry;

  // Selector maps for O(1) lookups
  late final Map<String, MessageSpec> _messagesBySelector;
  late final Map<String, ConstructorSpec> _constructorsBySelector;

  // Specs lists
  late final List<MessageSpec> _messages;
  late final List<ConstructorSpec> _constructors;
  late final List<EventSpec> _events;
  late final int constructorIndex;
  late final int messageIndex;

  /// Create registry from ink! metadata JSON
  ///
  /// The metadata must include 'version', 'types', and 'spec' fields.
  /// Throws [InkAbiException] if metadata is invalid.
  InkMetadataRegistry(this._inkMetadata) : version = _inkMetadata['version'] as int? {
    _validateMetadata();
    _initializeTypeRegistry();
    _initializeSpecs();
  }

  /// Validate that the metadata has all required fields
  void _validateMetadata() {
    if (_inkMetadata['version'] == null) {
      throw InkAbiException('Missing version in ink! metadata');
    }
    if (_inkMetadata['types'] == null) {
      throw InkAbiException('Missing types in ink! metadata');
    }
    if (_inkMetadata['spec'] == null) {
      throw InkAbiException('Missing spec in ink! metadata');
    }

    final ver = version;
    if (ver != 3 && ver != 4 && ver != 5) {
      throw InkAbiException('Unsupported ink! metadata version: $ver');
    }
  }

  /// Initialize the type registry from ink! types
  ///
  /// Converts ink! types to substrate-compatible PortableTypes and
  /// creates a synthetic metadata structure for MetadataTypeRegistry.
  void _initializeTypeRegistry() {
    final types = _inkMetadata['types'] as List;

    // Convert ink! types to PortableType format
    _portableRegistry = PortableRegistry(_convertInkTypesToPortable(types));

    // Create synthetic metadata for MetadataTypeRegistry
    final syntheticMetadata = _createSyntheticMetadata();
    _typeRegistry = MetadataTypeRegistry(syntheticMetadata);
  }

  /// Convert ink! type format to substrate PortableType format
  List<PortableType> _convertInkTypesToPortable(final List types) {
    return types.map((final type) {
      return PortableType(
        id: type['id'] as int,
        type: _convertTypeInfo(type['type'] as Map<String, dynamic>),
      );
    }).toList();
  }

  /// Convert ink! type info to substrate PortableTypeDef
  PortableTypeDef _convertTypeInfo(final Map<String, dynamic> typeInfo) {
    return PortableTypeDef(
      path: (typeInfo['path'] as List?)?.cast<String>() ?? <String>[],
      params: _convertParams(typeInfo['params']),
      typeDef: _convertTypeDef(typeInfo['def'] as Map<String, dynamic>),
      docs: (typeInfo['docs'] as List?)?.cast<String>() ?? <String>[],
    );
  }

  /// Convert ink! type parameters to substrate TypeParameter format
  List<TypeParameter> _convertParams(final dynamic params) {
    if (params == null || params is! List) {
      return <TypeParameter>[];
    }
    return params.map((final p) {
      return TypeParameter(
        name: p['name'] as String,
        type: p['type'] as int?,
      );
    }).toList();
  }

  /// Convert ink! type def to substrate TypeDef
  TypeDef _convertTypeDef(final Map<String, dynamic> def) {
    // The def is a map with a single entry indicating the type
    final entry = def.entries.first;
    final key = entry.key.toLowerCase();
    final value = entry.value;

    return switch (key) {
      'primitive' => _convertPrimitiveTypeDef(value as String),
      'composite' => _convertCompositeTypeDef(value as Map<String, dynamic>),
      'variant' => _convertVariantTypeDef(value as Map<String, dynamic>),
      'sequence' => TypeDefSequence(type: value['type'] as int),
      'array' => TypeDefArray(
          type: value['type'] as int,
          length: value['len'] as int,
        ),
      'tuple' => TypeDefTuple(
          fields: (value as List?)?.cast<int>() ?? [],
        ),
      'compact' => TypeDefCompact(type: value['type'] as int),
      'bitsequence' => TypeDefBitSequence(
          bitStoreType: value['bit_store_type'] as int,
          bitOrderType: value['bit_order_type'] as int,
        ),
      _ => throw InkAbiException('Unknown type def: $key'),
    };
  }

  /// Map ink! primitive names to substrate Primitive enum
  TypeDefPrimitive _convertPrimitiveTypeDef(final String primitive) {
    final prim = Primitive.fromString(primitive);
    return TypeDefPrimitive(prim);
  }

  /// Convert ink! composite to substrate TypeDefComposite
  TypeDefComposite _convertCompositeTypeDef(final Map<String, dynamic> composite) {
    List<Field> fields = <Field>[];
    if (composite['fields'] != null && composite['fields'] is List?) {
      fields = _extractFields(composite['fields']);
    }

    return TypeDefComposite(fields: fields);
  }

  /// Convert ink! variant to substrate TypeDefVariant
  TypeDefVariant _convertVariantTypeDef(final Map<String, dynamic> variant) {
    final variantsList = variant['variants'] as List?;
    if (variantsList == null) {
      return TypeDefVariant(variants: <VariantDef>[]);
    }

    final variants = variantsList.map((final v) {
      List<Field> fields = <Field>[];
      if (v['fields'] != null && v['fields'] is List?) {
        fields = _extractFields(v['fields']);
      }
      return VariantDef(
        name: v['name'] as String,
        fields: fields,
        index: v['index'] as int,
        docs: (v['docs'] as List?)?.cast<String>() ?? <String>[],
      );
    }).toList();

    return TypeDefVariant(variants: variants);
  }

  List<Field> _extractFields(final List? fields) {
    return fields?.map((final field) {
          return Field(
            name: field['name'] as String?,
            type: field['type'] as int,
            typeName: field['typeName'] as String?,
            docs: (field['docs'] as List?)?.cast<String>() ?? <String>[],
          );
        }).toList() ??
        <Field>[];
  }

  /// Create minimal synthetic metadata for MetadataTypeRegistry
  ///
  /// We only need the types, not pallets/extrinsics/etc.
  RuntimeMetadataPrefixed _createSyntheticMetadata() {
    final metadata = RuntimeMetadataV14(
      types: _portableRegistry.types,
      pallets: <PalletMetadataV14>[], // It is currenty not needed for ink!
      extrinsic: _createSyntheticExtrinsic(),
      type: 14,
    );

    return RuntimeMetadataPrefixed(
      // magicNumber: 0x6174656d, // 'meta' identifier (correct byte order)
      magicNumber: 0x6174656d, // 'meta' identifier
      metadata: metadata,
    );
  }

  /// Create minimal extrinsic metadata (required by RuntimeMetadataV14)
  ExtrinsicMetadataV14 _createSyntheticExtrinsic() {
    return ExtrinsicMetadataV14(
      type: 14,
      version: 4,
      addressType: 0,
      callType: 0,
      signatureType: 0,
      extraType: 0,
      signedExtensions: <SignedExtensionMetadata>[],
    );
  }

  /// Initialize message, constructor, and event specifications
  void _initializeSpecs() {
    final spec = _inkMetadata['spec'] as Map<String, dynamic>;

    // Initialize messages
    {
      final messagesJson = spec['messages'] as List;
      _messages = <MessageSpec>[];
      _messagesBySelector = <String, MessageSpec>{};
      for (final m in messagesJson) {
        final messageSpec = MessageSpec.fromJson(m as Map<String, dynamic>);
        _messages.add(messageSpec);
        _messagesBySelector[messageSpec.selector] = messageSpec;
      }
      messageIndex = _createMessageVariantType(_messages);
    }

    // Initialize constructors
    {
      final constructorsJson = spec['constructors'] as List;
      _constructors = <ConstructorSpec>[];
      _constructorsBySelector = <String, ConstructorSpec>{};
      for (final c in constructorsJson) {
        final constructorSpec = ConstructorSpec.fromJson(c as Map<String, dynamic>);
        _constructors.add(constructorSpec);
        _constructorsBySelector[constructorSpec.selector] = constructorSpec;
      }
      constructorIndex = _createConstructorVariantType(_constructors);
    }

    // Initialize events
    {
      _events = <EventSpec>[];
      final eventsJson = spec['events'] as List?;
      if (eventsJson != null) {
        for (final event in eventsJson) {
          final eventMap = event as Map<String, dynamic>;
          // Create composite type for event fields
          final eventTypeId = _createEventCompositeType(eventMap);
          _events.add(EventSpec.fromJson(eventMap, eventTypeId));
        }
      }
    }
  }

  /// Create a composite type for an event's fields
  ///
  /// Events need a composite type created from their args.
  /// This type is added to the portable registry and its ID returned.
  int _createEventCompositeType(final Map<String, dynamic> event) {
    final args = event['args'] as List;
    final fields = args.map((final arg) {
      final argMap = arg as Map<String, dynamic>;
      final type = argMap['type'] as Map<String, dynamic>;
      return Field(
        name: argMap['label'] as String,
        type: type['type'] as int,
        typeName: null,
        docs: [],
      );
    }).toList();

    // Get the next available type ID
    final nextTypeId = _portableRegistry.types.length;

    // Create composite type for the event
    final compositeType = PortableType(
      id: nextTypeId,
      type: PortableTypeDef(
        path: [event['label'] as String],
        params: [],
        typeDef: TypeDefComposite(fields: fields),
        docs: [],
      ),
    );

    // Add to registry
    _portableRegistry.types.add(compositeType);
    return nextTypeId;
  }

  List<Field> _extractFieldFromArgSpec(final List<ArgSpec> args) {
    return args.map((final arg) {
      return Field(
        name: arg.label,
        type: arg.type.typeId,
        docs: arg.docs?.cast<String>() ?? <String>[],
      );
    }).toList();
  }

  int _createMessageVariantType(final List<MessageSpec> messages) {
    final variants = <VariantDef>[];
    for (int index = 0; index < messages.length; index++) {
      final message = messages[index];
      final variant = VariantDef(
        name: message.label,
        fields: _extractFieldFromArgSpec(message.args),
        index: index,
        docs: message.docs?.cast<String>() ?? <String>[],
      );
      variants.add(variant);
    }

    // Get the next available type ID
    final nextTypeId = _portableRegistry.types.length;

    final portableType = PortableType(
      id: nextTypeId,
      type: PortableTypeDef(
        typeDef: TypeDefVariant(variants: variants),
        path: [],
        params: [],
      ),
    );
    // Add to registry
    _portableRegistry.types.add(portableType);
    return nextTypeId;
  }

  int _createConstructorVariantType(final List<ConstructorSpec> constructors) {
    final variants = <VariantDef>[];
    for (int index = 0; index < constructors.length; index++) {
      final constructor = constructors[index];
      final variant = VariantDef(
        name: constructor.label,
        fields: _extractFieldFromArgSpec(constructor.args),
        index: index,
        docs: constructor.docs?.cast<String>() ?? <String>[],
      );
      variants.add(variant);
    }

    // Get the next available type ID
    final nextTypeId = _portableRegistry.types.length;

    final portableType = PortableType(
      id: nextTypeId,
      type: PortableTypeDef(
        typeDef: TypeDefVariant(variants: variants),
        path: [],
        params: [],
      ),
    );

    // Add to registry
    _portableRegistry.types.add(portableType);
    return nextTypeId;
  }

  // ========================================================================
  // Codec Access
  // ========================================================================

  /// Get codec for a type ID using MetadataTypeRegistry
  ///
  /// This delegates to the underlying [MetadataTypeRegistry] which provides
  /// intelligent caching and handles all substrate types including
  /// Option, Result, composites, variants, etc.
  Codec codecFor(final int typeId) {
    return _typeRegistry.codecFor(typeId);
  }

  /// Get codec for a message's return type
  ///
  /// Throws [EncodingException] if the selector is not found.
  Codec messageReturnCodec(final String selector) {
    final message = messageBySelector(selector);
    if (message == null) {
      throw EncodingException.selectorNotFound(selector, 'messages');
    }
    return codecFor(message.returnType.typeId);
  }

  /// Get codec for a constructor's return type
  ///
  /// Throws [EncodingException] if the selector is not found.
  Codec constructorReturnCodec(final String selector) {
    final constructor = constructorBySelector(selector);
    if (constructor == null || constructor.codecTypeId == null) {
      throw EncodingException.selectorNotFound(selector, 'constructors');
    }
    return codecFor(constructor.returnType!.typeId);
  }

  /// Get codec for an event by index
  ///
  /// Throws [DecodingException] if the index is out of bounds.
  Codec eventCodec(final int index) {
    if (index < 0 || index >= _events.length) {
      throw DecodingException.eventIndexOutOfBounds(index, _events.length - 1);
    }
    return codecFor(_events[index].typeId);
  }

  // ========================================================================
  // Spec Access
  // ========================================================================

  /// Get message specification by selector
  ///
  /// Returns null if no message with the given selector exists.
  MessageSpec? messageBySelector(final String selector) {
    return _messagesBySelector[selector];
  }

  /// Get constructor specification by selector
  ///
  /// Returns null if no constructor with the given selector exists.
  ConstructorSpec? constructorBySelector(final String selector) {
    return _constructorsBySelector[selector];
  }

  /// Get event specification by index
  ///
  /// Returns null if the index is out of bounds.
  EventSpec? eventByIndex(final int index) {
    if (index < 0 || index >= _events.length) {
      return null;
    }
    return _events[index];
  }

  /// Get event by signature topic (v5 only)
  ///
  /// Returns null if no event matches the signature topic.
  EventSpec? eventBySignatureTopic(final String topic) {
    for (final event in _events) {
      if (event.signatureTopic == topic) {
        return event;
      }
    }
    return null;
  }

  /// Get all messages
  List<MessageSpec> get messages => List.unmodifiable(_messages);

  /// Get all constructors
  List<ConstructorSpec> get constructors => List.unmodifiable(_constructors);

  /// Get all events
  List<EventSpec> get events => List.unmodifiable(_events);

  // ========================================================================
  // Type Access
  // ========================================================================

  /// Get type by ID from the portable registry
  ///
  /// Throws [TypeResolutionException] if the type is not found.
  PortableType typeById(final int id) {
    try {
      return _typeRegistry.typeById(id);
    } on MetadataException {
      throw TypeResolutionException.typeNotFound(id);
    }
  }

  /// Get type by path from the portable registry
  ///
  /// Returns null if no type with the given path exists.
  PortableType? typeByPath(final String path) {
    return _typeRegistry.typeByPath(path);
  }

  // ========================================================================
  // Utility Methods
  // ========================================================================

  /// Clear all caches in the type registry
  ///
  /// Useful for memory management in long-running applications.
  void clearCache() {
    _typeRegistry.clearCache();
  }

  /// Get cache statistics from the underlying type registry
  CacheStats get cacheStats => _typeRegistry.cacheStats;

  @override
  String toString() => 'InkMetadataRegistry(version: $version, '
      'messages: ${_messages.length}, '
      'constructors: ${_constructors.length}, '
      'events: ${_events.length}'
      ')';
}
