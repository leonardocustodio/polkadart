part of ink_abi;

class SelectorByteInput extends ByteInput {
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

class InkAbiDescription {
  final Map<String, dynamic> _project;
  final Registry registry = Registry();
  late final MetadataV14Expander _expander;
  final Map<int, Codec> _siTypesCodec = <int, Codec>{};

  InkAbiDescription(this._project) {
    _preParseTypes();
    // Making first call to initialize and cache all the values
    abiEvents();
    constructors();
    messages();
  }

  Codec<dynamic>? getCodec(int type) {
    return _siTypesCodec[type];
  }

  void _preParseTypes() {
    {
      final List<dynamic> types = _project['types'];
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
            //path.insert(0, namespace);
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
      _project['types'] = types;
    }

    _expander = MetadataV14Expander(_project['types']);
    registry.registerCustomCodec(_expander.customCodecRegister);

    for (int index = 0; index < _project['types'].length; index++) {
      String? typeName = _expander.registeredSiType[index];
      if (typeName == null) {
        throw Exception('Types not found for index: $index');
      }

      Codec<dynamic>? codec = registry.getCodec(typeName);
      if (codec != null) {
        _siTypesCodec[index] = codec;
        continue;
      }
      typeName = _expander.customCodecRegister[typeName];
      if (typeName == null) {
        throw Exception('Types not found for index: $index');
      }
      codec = registry.getCodec(typeName);
      if (codec != null) {
        _siTypesCodec[index] = codec;
        continue;
      }
    }
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

  List<InkAbiEvent>? _abiEventsValue;
  List<InkAbiEvent> abiEvents() {
    if (_abiEventsValue == null) {
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
    }
    return _abiEventsValue!;
  }

  ComplexEnumCodec<dynamic>? _messagesValue;
  ComplexEnumCodec<dynamic> messages() {
    _messagesValue ??= _createMessagesType(_project['spec']['messages'])
        as ComplexEnumCodec<dynamic>;
    return _messagesValue!;
  }

  ComplexEnumCodec<dynamic>? _constructorsValue;
  ComplexEnumCodec<dynamic> constructors() {
    _constructorsValue ??= _createMessagesType(_project['spec']['constructors'])
        as ComplexEnumCodec<dynamic>;
    return _constructorsValue!;
  }

  /* ComplexEnumCodec<dynamic>? _eventValue;
  ComplexEnumCodec<dynamic> event() {
    _eventValue ??= _createMessagesType(_project['spec']['constructors'])
        as ComplexEnumCodec<dynamic>;
    return _eventValue!;
  } */

  Codec<dynamic> _createMessagesType(List<dynamic> list) {
    final Map<int, MapEntry<String, Codec<dynamic>>> variants =
        <int, MapEntry<String, Codec<dynamic>>>{};

    for (int index = 0; index < list.length; index++) {
      final Map<String, dynamic> variant = list[index];
      late final Codec<dynamic> codec;
      if (variant['args'].isEmpty) {
        // TODO: Check if much simpler approach can be followed here or not?
        codec = NullCodec.codec;
      } else {
        codec = _createComposite(variant);
      }
      variants[index] = MapEntry(_normalizeLabel(variant['label']), codec);
    }
    return ComplexEnumCodec.sparse(variants);
  }

  Codec<dynamic> _createComposite(Map<String, dynamic> map) {
    final codecMap = <String, Codec<dynamic>>{};
    for (final Map<String, dynamic> arg in map['args']!) {
      codecMap[_normalizeLabel(arg['label'])] =
          _siTypesCodec[arg['type']!['type']!]!;
    }
    return CompositeCodec(codecMap);
  }

  String _normalizeLabel(String label) {
    return label.replaceAll('::', '_');
  }
}
