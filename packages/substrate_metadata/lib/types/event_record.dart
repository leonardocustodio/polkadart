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
    print(lookup);

    result['lookup'] = encodeHex(lookup.toList());
    print(result['lookup']);

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
      final value = chainInfo.scaleCodec.decode(type, input);
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
    U8Codec.instance.encodeTo(value['phase'], output);

    if (value['phase'] == 0) {
      U32Codec.instance.encodeTo(value['phase']['ApplyExtrinsic'], output);
    }

    output.write(decodeHex(value['lookup']));

    final event = chainInfo.metadata['event_index']?[value['lookup']];

    final args = event['call']['args'];

    for (final type in args) {
      final val =
          value['event'][event['module']['name']][event['call']['name']][type];
      chainInfo.scaleCodec.encodeTo(type, val, output);
    }

    SequenceCodec(StrCodec.instance).encodeTo(value['topic'], output);
  }
}
