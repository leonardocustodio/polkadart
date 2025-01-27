part of ink_abi;

class InkAbi {
  late final Map<int, Codec> scaleCodec;
  late final List<InkAbiEvent> _events;
  late final int _messages;
  late final int _constructors;
  late final SelectorsMap _messageSelectors;
  late final SelectorsMap _constructorSelectors;
  late final Map<String, dynamic> _project;
  late final InkAbiDescription inkAbiDescription;

  InkAbi(final Map<String, dynamic> inkAbiJson) {
    _project = SchemaValidator.getInkProject(inkAbiJson);
    inkAbiDescription = InkAbiDescription(_project);
    scaleCodec = inkAbiDescription.codecTypes();
    _events = inkAbiDescription.events();
    _messages = inkAbiDescription.messages();
    _constructors = inkAbiDescription.constructors();
    _messageSelectors = inkAbiDescription.messageSelectors();
    _constructorSelectors = inkAbiDescription.constructorSelectors();
  }

  Codec getCodec(final int type) {
    if (scaleCodec[type] == null) {
      throw Exception('Codec not found for type at index: $type');
    }
    return scaleCodec[type]!;
  }

  Uint8List encodeConstructorInput(final String selector, final List<dynamic> args) {
    final constructor = getConstructor(selector);
    final ByteOutput output = ByteOutput();
    output.write(decodeHex(selector));
    for (int i = 0; i < constructor['args'].length; i++) {
      final dynamic arg = constructor['args'][i];
      getCodec(arg['type']['type']).encodeTo(args[i], output);
    }
    return output.toBytes();
  }

  Uint8List encodeMessageInput(
      final String selector, final List<dynamic> args) {
    final message = getMessage(selector);
    final ByteOutput output = ByteOutput();
    output.write(decodeHex(selector));
    for (int i = 0; i < message['args'].length; i++) {
      final dynamic arg = message['args'][i];
      getCodec(arg['type']['type']).encodeTo(args[i], output);
    }
    return output.toBytes();
  }

  dynamic decodeMessageOutput(final String selector, final Uint8List value) {
    final message = getMessage(selector);
    assert(message['returnType']?['type'] != null);
    final ByteInput input = ByteInput(value);
    return getCodec(message['returnType']['type']).decode(input);
  }

  dynamic decodeEventFromHex(final String data, [final List<String>? topics]) {
    return decodeEvent(decodeHex(data), topics);
  }

  dynamic decodeEvent(final dynamic data, [final List<String>? topics]) {
    assert(data is Uint8List || data is List<int> || data is String);
    late final Uint8List data0;
    if (data is String) {
      data0 = decodeHex(data);
    } else if (data is List<int>) {
      data0 = Uint8List.fromList(data);
    } else {
      data0 = data;
    }
    if (_project['version'] == 5) {
      if (topics?.isEmpty ?? true) {
        throw Exception('Topics are required if ink! contract is version 5');
      }
      return _decodeEventV5(data0, topics!);
    } else {
      return _decodeEventV4(data0);
    }
  }

  dynamic _decodeEventV4(final Uint8List data) {
    final ByteInput input = ByteInput(data);
    final int idx = input.read();
    if (_events.isEmpty) {
      throw Exception('No events found in Ink-ABI');
    }
    if (idx < 0 || idx >= _events.length) {
      throw Exception('Unable to find event with index: $idx');
    }
    final InkAbiEvent event = _events[idx];
    return getCodec(event.type).decode(input);
  }

  dynamic _decodeEventV5(final Uint8List data, final List<String> topics) {
    if (topics.isNotEmpty) {
      final String topic = topics[0];
      InkAbiEvent? event;
      for (final InkAbiEvent e in _events) {
        if (e.signatureTopic == topic) {
          event = e;
          break;
        }
      }
      if (event != null) {
        final ByteInput input = ByteInput(data);
        return getCodec(event.type).decode(input);
      }
    }

    final int amountOfTopics = topics.length;
    final List<InkAbiEvent> potentialEvents =
        _events.where((final InkAbiEvent event) {
      if (event.signatureTopic != null) {
        return false;
      }
      return amountOfTopics == event.amountIndexed;
    }).toList(growable: false);

    if (potentialEvents.length == 1) {
      final InkAbiEvent event = potentialEvents[0];
      final ByteInput input = ByteInput(data);
      return getCodec(event.type).decode(input);
    }

    throw Exception('Unable to determine event');
  }

  dynamic decodeConstructor(final String data) {
    final ByteInput input =
        SelectorByteInput.fromHex(data, _constructorSelectors);
    return getCodec(_constructors).decode(input);
  }

  dynamic decodeMessage(final String data) {
    final ByteInput input = SelectorByteInput.fromHex(data, _messageSelectors);
    return getCodec(_messages).decode(input);
  }

  dynamic getMessage(final String selector) {
    final int? index = _messageSelectors[selector];
    if (index == null) {
      throw Exception('Unknown selector: $selector');
    }
    return _project['spec']['messages'][index];
  }
  dynamic getConstructor(final String selector) {
    final int? index = _constructorSelectors[selector];
    if (index == null) {
      throw Exception('Unknown selector: $selector');
    }
    return _project['spec']['constructors'][index];
  }
}
