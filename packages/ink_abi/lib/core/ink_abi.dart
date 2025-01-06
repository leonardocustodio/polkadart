part of ink_abi;

class InkAbi {
  late final Map<int, Codec> _scaleCodec;
  late final List<InkAbiEvent> _events;
  late final int _messages;
  late final int _constructors;
  late final SelectorsMap _messageSelectors;
  late final SelectorsMap _constructorSelectors;
  late final Map<String, dynamic> _project;
  late final InkAbiDescription _inkAbiDescription;

  InkAbi(final Map<String, dynamic> inkAbiJson) {
    _project = SchemaValidator.getInkProject(inkAbiJson);
    _inkAbiDescription = InkAbiDescription(_project);
    _scaleCodec = _inkAbiDescription.codecTypes();
    _events = _inkAbiDescription.events();
    _messages = _inkAbiDescription.messages();
    _constructors = _inkAbiDescription.constructors();
    _messageSelectors = _inkAbiDescription.messageSelectors();
    _constructorSelectors = _inkAbiDescription.constructorSelectors();
  }

  Uint8List encodeMessageInput(
      final String selector, final List<dynamic> args) {
    final message = _getMessage(selector);
    final ByteOutput output = ByteOutput();
    output.write(decodeHex(selector));
    for (int i = 0; i < message['args'].length; i++) {
      final dynamic arg = message['args'][i];
      final Codec<dynamic>? codec = _scaleCodec[arg['type']['type']];
      if (codec == null) {
        throw Exception(
            'Codec not found for type at index: ${arg['type']['type']}');
      }
      codec.encodeTo(args[i], output);
    }
    return output.toBytes();
  }

  dynamic decodeMessageOutput(final String selector, final Uint8List value) {
    final message = _getMessage(selector);
    assert(message['returnType']?['type'] != null);
    final Codec<dynamic>? codec = _scaleCodec[message['returnType']['type']];
    if (codec == null) {
      throw Exception(
          'Codec not found for type at index: ${message['returnType']['type']}');
    }
    final ByteInput input = ByteInput(value);
    return codec.decode(input);
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
    final codec = _scaleCodec[event.type];
    if (codec == null) {
      throw Exception('Codec not found for type at index: ${event.type}');
    }
    return codec.decode(input);
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
        final codec = _scaleCodec[event.type];
        if (codec == null) {
          throw Exception('Codec not found for type at index: ${event.type}');
        }
        final ByteInput input = ByteInput(data);
        return codec.decode(input);
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
      final codec = _scaleCodec[event.type];
      if (codec == null) {
        throw Exception('Codec not found for type at index: ${event.type}');
      }
      final ByteInput input = ByteInput(data);
      return codec.decode(input);
    }

    throw Exception('Unable to determine event');
  }

  dynamic decodeConstructor(final String data) {
    final ByteInput input =
        SelectorByteInput.fromHex(data, _constructorSelectors);
    final constructorCodec = _scaleCodec[_constructors];
    if (constructorCodec == null) {
      throw Exception('Codec not found for type at index: $_constructors');
    }
    return constructorCodec.decode(input);
  }

  dynamic decodeMessage(final String data) {
    final ByteInput input = SelectorByteInput.fromHex(data, _messageSelectors);
    final messageCodec = _scaleCodec[_messages];
    if (messageCodec == null) {
      throw Exception('Codec not found for type at index: $_messages');
    }
    return messageCodec.decode(input);
  }

  dynamic _getMessage(final String selector) {
    final int? index = _messageSelectors[selector];
    if (index == null) {
      throw Exception('Unknown selector: $selector');
    }
    return _project['spec']['messages'][index];
  }
}
