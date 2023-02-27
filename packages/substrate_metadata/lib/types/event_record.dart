part of metadata_types;

class EventRecord with Codec<Map<String, dynamic>> {
  final ChainInfo chainInfo;

  const EventRecord({required this.chainInfo});

  @override
  Map<String, dynamic> decode(Input input) {
    if (chainInfo.metadata.isEmpty) {
      throw Exception('Metadata is empty');
    }

    final result = <String, dynamic>{};

    result['phase'] = U8Codec.instance.decode(input);

    if (result['phase'] == 0) {
      result['phase'] = {'ApplyExtrinsic': U32Codec.instance.decode(input)};
    }

    final lookup = input.readBytes(2);

    result['lookup'] = encodeHex(lookup.toList());

    if (chainInfo.metadata['event_index']?[result['lookup']] == null) {
      throw Exception('Metadata lookup is empty');
    }

    final event = chainInfo.metadata['event_index']?[result['lookup']];
    final moduleName = event['module']['name'];
    final eventName = event['call']['name'];
    final params = <String, dynamic>{};

    final args = event['call']['args'];
    for (final arg in args) {
      final name = arg['name'];
      final type = arg['type'];
      final typeCodec = chainInfo.scaleCodec.registry.getCodec(type);
      if (typeCodec == null) {
        throw Exception('Codec not found for type: $type');
      }
      final value = typeCodec.decode(input);
      params[name] = value;
    }
    result['event'] = {
      moduleName: {
        eventName: params,
      },
    };

    result['topic'] = SequenceCodec(StrCodec.instance).decode(input);

    return result;
  }

  @override
  void encodeTo(Map<String, dynamic> value, Output output) {
    if (value['phase'] is int){
      U8Codec.instance.encodeTo(value['phase'], output);
    }else {
      U8Codec.instance.encodeTo(0, output);
      U32Codec.instance.encodeTo(value['phase']['ApplyExtrinsic'], output);
    }

    final lookup = (value['lookup'] as String).padLeft(4, '0');

    output.write(decodeHex(lookup));

    final event = chainInfo.metadata['event_index']?[lookup];
    final moduleName = event['module']['name'];
    final eventName = event['call']['name'];
    final params = value['event'][moduleName][eventName];

    final args = event['call']['args'];

    for (final arg in args) {
      final name = arg['name'];
      final type = arg['type'];
      chainInfo.scaleCodec.encodeTo(type, params[name], output);
    }

    SequenceCodec(StrCodec.instance)
        .encodeTo(value['topic'] ?? <String>[], output);
  }
}
