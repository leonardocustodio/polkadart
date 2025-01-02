part of ink_abi;

class InkAbiDescription {
  final Map<String, dynamic> _project;

  InkAbiDescription(this._project) {
    events();
    event();
    constructors();
    messages();
  }

  SelectorsMap? _messageSelectorsValue;
  SelectorsMap messageSelectors() {
    _messageSelectorsValue ??= _selectors('messages');
    return _messageSelectorsValue!;
  }

  SelectorsMap? _constructorSelectorsValue;
  SelectorsMap constructorSelectors() {
    _constructorSelectorsValue ??= _selectors('constructors');
    return _constructorSelectorsValue!;
  }

  SelectorsMap _selectors(final String selectorType) {
    final SelectorsMap map = <String, int>{};
    final List<dynamic> messages = _project['spec'][selectorType];
    for (int index = 0; index < messages.length; index++) {
      map[messages[index]['selector']] = index;
    }
    return map;
  }

  int? _messagesValue;
  int messages() {
    _messagesValue ??= _createMessagesType(_project['spec']['messages']);
    return _messagesValue!;
  }

  int? _constructorsValue;
  int constructors() {
    _constructorsValue ??=
        _createMessagesType(_project['spec']['constructors']);
    return _constructorsValue!;
  }

  int _createMessagesType(final List list) {
    final VariantCodecInterface object = VariantCodecInterface(
      id: -1,
      variants: _createVariants(list),
    );
    final int actualId = _add(object);
    object.id = actualId;
    return actualId;
  }

  List<InkAbiEvent>? _abiEventsValue;
  List<InkAbiEvent> events() {
    if (_abiEventsValue != null) {
      return _abiEventsValue!;
    }
    _abiEventsValue = <InkAbiEvent>[];
    for (final eventValue in _project['spec']['events']) {
      int amountIndexed = 0;
      for (final arg in eventValue['args']) {
        amountIndexed += arg['indexed'] ? 1 : 0;
      }
      _abiEventsValue!.add(InkAbiEvent(
        name: _normalizeLabel(eventValue['label']),
        type: _createComposite(eventValue),
        amountIndexed: amountIndexed,
        signatureTopic: eventValue['signature_topic'],
      ));
    }
    return _abiEventsValue!;
  }

  int? _eventIndexValue;
  int event() {
    if (_eventIndexValue != null) {
      return _eventIndexValue!;
    }
    final object = VariantCodecInterface(
      id: -1,
      variants: _createVariants(_project['spec']['events']),
      path: ['Event'],
    );
    _eventIndexValue = _add(object);
    object.id = _eventIndexValue!;
    return _eventIndexValue!;
  }

  List<Variants> _createVariants(final List list) {
    final List<Variants> variants = <Variants>[];
    for (int index = 0; index < list.length; index++) {
      final variantMap = list[index];
      variants.add(
        Variants(
          name: _normalizeLabel(variantMap['label']),
          index: index,
          fields: _createFields(variantMap['args']),
          docs: variantMap['docs']?.cast<String>(),
        ),
      );
    }
    return variants;
  }

  int _createComposite(final Map<String, dynamic> map) {
    final CodecInterface composite = CompositeCodecInterface(
      id: -1,
      fields: _createFields(map['args']),
      path: map['path'],
      docs: map['docs']?.cast<String>(),
    );
    final actualId = _add(composite);
    composite.id = actualId;
    return actualId;
  }

  List<Field> _createFields(final List<dynamic> args) {
    return args.map((arg) {
      return Field(
        name: _normalizeLabel(arg['label']),
        type: arg['type']['type'],
        docs: arg['docs']?.cast<String>(),
      );
    }).toList();
  }

  String _normalizeLabel(final String label) {
    return label.replaceAll('::', '_');
  }

  int _add(CodecInterface type) {
    _types().add(type);
    return _types().length - 1;
  }

  List<CodecInterface>? _typesValue;
  List<CodecInterface> _types() {
    if (_typesValue != null) {
      return _typesValue!;
    }
    _typesValue = <CodecInterface>[];
    for (int index = 0; index < _project['types']!.length; index++) {
      final codecInterface = CodecInterface.fromJson(_project['types']![index]);
      _typesValue!.add(codecInterface);
    }
    return _typesValue!;
  }

  List<CodecInterface>? _typesListValue;
  List<CodecInterface> types() {
    if (_typesListValue != null) {
      return _typesListValue!;
    }
    _typesListValue = normalizeMetadataTypes(_types());
    return _typesListValue!;
  }

  Map<int, Codec>? _codecTypesValue;
  Map<int, Codec> codecTypes() {
    if (_codecTypesValue != null) {
      return _codecTypesValue!;
    }
    final List<dynamic> typesList = <dynamic>[];
    final List<CodecInterface> typesInterfaces = types();
    for (final CodecInterface type in typesInterfaces) {
      typesList.add(type.toJson());
    }
    final MetadataV14Expander expander = MetadataV14Expander(typesList);
    final Registry registry = Registry();
    final Map<int, Codec> siTypesCodec = <int, Codec>{};
    registry.registerCustomCodec(expander.customCodecRegister);

    for (int index = 0; index < typesInterfaces.length; index++) {
      String? typeName = expander.registeredSiType[index];
      if (typeName == null) {
        throw Exception('Types not found for index: $index');
      }

      Codec<dynamic>? codec = registry.getCodec(typeName);
      if (codec != null) {
        siTypesCodec[index] = codec;
        continue;
      }
      typeName = expander.customCodecRegister[typeName];
      if (typeName == null) {
        throw Exception('Types not found for index: $index');
      }
      codec = registry.getCodec(typeName);
      if (codec != null) {
        siTypesCodec[index] = codec;
        continue;
      }
    }
    _codecTypesValue = siTypesCodec;
    return siTypesCodec;
  }
}
