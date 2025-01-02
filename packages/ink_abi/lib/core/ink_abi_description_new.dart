/* part of ink_abi;

class NewInkAbiDescription {
  final Map<String, dynamic> _project;
  final Registry registry = Registry();
  late final MetadataV14Expander _expander;
  final Map<int, Codec> _siTypesCodec = <int, Codec>{};

  NewInkAbiDescription(this._project) {
    final eves = events();
    final eve = event();
    final cons = constructors();
    final msgs = messages();
    messageSelectors();
    constructorSelectors();
    _preParseTypes();
    print('done');
  }

/*   Codec<dynamic>? getCodec(int type) {
    return _siTypesCodec[type];
  }
 */

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

  SelectorsMap _selectors(String selectorType) {
    final SelectorsMap map = <String, int>{};
    {
      final List<dynamic> messages = _project['spec'][selectorType];
      for (int i = 0; i < messages.length; i++) {
        map[messages[i]['selector']] = i;
      }
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

  int _createMessagesType(List list) {
    final VariantCodecInterface object = VariantCodecInterface(
      id: -1,
      variants: _createVariants(list),
      /* params: [], */
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
      /* params: [], */
    );
    _eventIndexValue = _add(object);
    object.id = _eventIndexValue!;

    return _eventIndexValue!;
  }

  List<Variants> _createVariants(List list) {
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

  int _createComposite(Map<String, dynamic> map) {
    final CodecInterface composite = CompositeCodecInterface(
      id: -1,
      fields: _createFields(map['args']),
      path: map['path'],
      docs: map['docs']?.cast<String>(),
      /* params: map['params']?.map((e) => Params.fromJson(e)).toList(), */
    );

    final actualId = _add(composite);
    composite.id = actualId;

    return actualId;
  }

  List<Field> _createFields(List<dynamic> args) {
    return args.map((arg) {
      return Field(
        name: _normalizeLabel(arg['label']),
        type: arg['type']['type'],
        docs: arg['docs']?.cast<String>(),
      );
    }).toList();
  }

  String _normalizeLabel(String label) {
    return label.replaceAll('::', '_');
  }

  int _add(CodecInterface type) {
    _types().add(type);
    return _types().length - 1;
  }

  List<CodecInterface>? _typesValue;
  List<CodecInterface> _types([List<dynamic>? types1]) {
    if (types1 == null && _typesValue != null) {
      return _typesValue!;
    }
    types1 ??= _project['types'];
    _typesValue = <CodecInterface>[];
    for (int index = 0; index < types1!.length; index++) {
      final codecInterface = toType(types1[index]);
      _typesValue!.add(codecInterface);
    }
    return _typesValue!;
  }

  CodecInterface toType(Map<String, dynamic> map) {
    return CodecInterface.fromJson(map);
  }

  void _preParseTypes() {
    /*final List<dynamic> types = List.from(_project['types']);
    for (int i = 0; i < types.length; i++) {
      final String label = types[i]['type']['def'].keys.first;
      types[i]['type']['def'] = <String, dynamic>{
        label.capitalize(): types[i]['type']['def'][label]
      };
    }
    for (int i = 0; i < types.length; i++) {
      if (types[i]['type'].containsKey('path') &&
          types[i]['type']['path'] is List) {
        if (!['Option', 'Result'].contains(types[i]['type']['path'][0])) {
          final List<dynamic> path = types[i]['type']['path'];
          // TODO: Check if namespace is important or not.
          // path.insert(0, namespace);
          types[i]['type']['path'] = path;
        }
      } else {
        types[i]['type']['path'] = <String>[];
      }
      if (types[i]['type']['def'].containsKey('Variant')) {
        if (types[i]['type']['def']['Variant'].containsKey('variants')) {
          final List<dynamic> variants =
              types[i]['type']['def']['Variant']['variants'];
          for (int j = 0; j < variants.length; j++) {
            variants[j]['fields'] = <dynamic>[];
          }
          types[i]['type']['def']['Variant']['variants'] = variants;
        }
      }
    }
    final MetadataV14Expander _expander1 = MetadataV14Expander(types); */

    final List<dynamic> typesList = <dynamic>[];
    final List<CodecInterface> t = normalizeMetadataTypes(_types());
    for (final CodecInterface type in t) {
      typesList.add(type.toJson());
    }
    final MetadataV14Expander _expander2 = MetadataV14Expander(typesList);

    registry.registerCustomCodec(_expander2.customCodecRegister);
    return;
    for (int index = 0; index < _project['types'].length; index++) {
      String? typeName = _expander.registeredSiType[index];
      if (typeName == null) {
        throw Exception('Types not found for index: $index');
      }

      Codec<dynamic>? codec = registry.getCodec(typeName);
      if (codec != null) {
        final typeRightNow = _project['types'][index];
        _siTypesCodec[index] = codec;
        continue;
      }
      typeName = _expander.customCodecRegister[typeName];
      if (typeName == null) {
        throw Exception('Types not found for index: $index');
      }
      codec = registry.getCodec(typeName);
      if (codec != null) {
        final typeRightNow = _project['types'][index];
        _siTypesCodec[index] = codec;
        continue;
      }
    }
    print('done');
  }
}

/* class SelectorByteInput extends ByteInput {
  int? index;
  SelectorByteInput._(Uint8List buffer) : super(buffer);

  static SelectorByteInput fromHex(String hex, SelectorsMap selectors) {
    final Uint8List buffer = decodeHex(hex);
    final String key = encodeHex(buffer.sublist(0, 4));
    final int? index = selectors['0x$key'];
    if (index == null) {
      throw Exception('Unknown selector: $key');
    }
    final SelectorByteInput selectorByteInput =
        SelectorByteInput._(buffer.sublist(4));
    selectorByteInput.index = index;
    return selectorByteInput;
  }

  @override
  int read() {
    if (index == null) {
      return super.read();
    } else {
      final int idx = index!;
      index = null;
      return idx;
    }
  }
}
 */
 */
