part of ink_abi;

class InkAbi {
  late final List<InkAbiEvent> _events;
  late final Codec<dynamic> _messages;
  late final Codec<dynamic> _constructors;
  late final SelectorsMap _messageSelectors;
  late final SelectorsMap _constructorSelectors;
  late final Map<String, dynamic> _project;
  late final InkAbiDescription _inkAbiDescription;

  InkAbi(Map<String, dynamic> inkAbiJson) {
    _project = SchemaValidator.getInkProject(inkAbiJson);
    _inkAbiDescription = InkAbiDescription(_project);
    _events = _inkAbiDescription.abiEvents();
    _messages = _inkAbiDescription.messages();
    _constructors = _inkAbiDescription.constructors();
    _messageSelectors = _inkAbiDescription.messageSelectors();
    _constructorSelectors = _inkAbiDescription.constructorSelectors();
  }

  Uint8List encodeMessageInput(String selector, List<dynamic> args) {
    final message = _getMessage(selector);
    final ByteOutput output = ByteOutput();
    output.write(decodeHex(selector));
    for (int i = 0; i < message['args'].length; i++) {
      final dynamic arg = message['args'][i];
      final Codec<dynamic>? codec =
          _inkAbiDescription.getCodec(arg['type']['type']);
      if (codec == null) {
        throw Exception(
            'Codec not found for type at index: ${arg['type']['type']}');
      }
      codec.encodeTo(args[i], output);
    }
    return output.toBytes();
  }

  dynamic decodeMessageOutput(String selector, Uint8List value) {
    final message = _getMessage(selector);
    assert(message['returnType']?['type'] != null);
    final Codec<dynamic>? codec =
        _inkAbiDescription.getCodec(message['returnType']['type']);
    if (codec == null) {
      throw Exception(
          'Codec not found for type at index: ${message['returnType']['type']}');
    }
    final ByteInput input = ByteInput(value);
    return codec.decode(input);
  }

  dynamic decodeEventFromHex(String data, [List<String>? topics]) {
    return decodeEvent(decodeHex(data), topics);
  }

  dynamic decodeEvent(Uint8List data, [List<String>? topics]) {
    if (_project['version'] == 5) {
      if (topics?.isEmpty ?? true) {
        throw Exception('Topics are required if ink! contract is version 5');
      }
      return _decodeEventV5(data, topics!);
    } else {
      return _decodeEventV4(data);
    }
  }

  dynamic _decodeEventV4(Uint8List data) {
    final ByteInput input = ByteInput(data);
    final int idx = input.read();
    if (_events.isEmpty) {
      throw Exception('No events found in Ink-ABI');
    }
    if (idx < 0 || idx >= _events.length) {
      throw Exception('Unable to find event with index: $idx');
    }
    final InkAbiEvent event = _events[idx];
    return event.type.decode(input);
  }

  dynamic _decodeEventV5(Uint8List data, List<String> topics) {
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
        return event.type.decode(input);
      }
    }

    final int amountOfTopics = topics.length;
    final List<InkAbiEvent> potentialEvents =
        _events.where((InkAbiEvent event) {
      if (event.signatureTopic != null) {
        return false;
      }
      return amountOfTopics == event.amountIndexed;
    }).toList(growable: false);

    if (potentialEvents.length == 1) {
      final InkAbiEvent event = potentialEvents[0];
      final ByteInput input = ByteInput(data);
      return event.type.decode(input);
    }

    throw Exception('Unable to determine event');
  }

  dynamic decodeConstructor(String data) {
    final ByteInput input =
        SelectorByteInput.fromHex(data, _constructorSelectors);
    return _constructors.decode(input);
  }

  dynamic decodeMessage(String data) {
    final ByteInput input = SelectorByteInput.fromHex(data, _messageSelectors);
    return _messages.decode(input);
  }

  dynamic _getMessage(String selector) {
    final int? index = _messageSelectors[selector];
    if (index == null) {
      throw Exception('Unknown selector: $selector');
    }
    return _project['spec']['messages'][index];
  }
}
