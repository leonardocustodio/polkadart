part of metadata_types;

class EventRecord with Codec<Map<String, dynamic>> {
  final Registry registry;
  final Map<String, dynamic> metadata;

  const EventRecord({required this.registry, required this.metadata});

  @override
  Map<String, dynamic> decode(Input input) {
    if (metadata.isEmpty) {
      throw Exception('Metadata is empty');
    }

    final result = <String, dynamic>{};

    result['phase'] = U8Codec.instance.decode(input);

    if (result['phase'] == 0) {
      result['phase'] = {'ApplyExtrinsic': U32Codec.instance.decode(input)};
    }

    result['lookup'] = encodeHex(input.readBytes(2));

    if (metadata['event_index']?[result['lookup']] == null) {
      throw Exception('Metadata lookup is empty');
    }

    final event = metadata['event_index']?[result['lookup']];
    final moduleName = event['module']['name'];
    final eventName = event['call']['name'];
    final params = <String, dynamic>{};

    final args = event['call']['args'];
    for (final type in args) {
      final value = ScaleCodec(registry).decode(type, input);
      params[type] = value;
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

    final event = metadata['event_index']?[value['lookup']];

    final args = event['call']['args'];

    for (final type in args) {
      final val =
          value['event'][event['module']['name']][event['call']['name']][type];
      ScaleCodec(registry).encodeTo(type, val, output);
    }

    SequenceCodec(StrCodec.instance).encodeTo(value['topic'], output);
  }
}
