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

    if (chainInfo.version == 14) {
      print(lookup);
      print(result['lookup']);
    }

    if (chainInfo.metadata['event_index']?[result['lookup']] == null) {
      throw Exception('Metadata lookup is empty');
    }

    final event = chainInfo.metadata['event_index']?[result['lookup']];
    final moduleName = event['module']['name'];
    final eventName = event['call']['name'];

    final args = event['call']['args'];
    final params = <dynamic>[];
    for (final arg in args) {
      late String type;
      if (arg is String) {
        // In case of legacy metadata
        type = arg;
      } else if (arg is Map<String, dynamic>) {
        // In case of v14 metadata
        type = arg['type'];
      } else {
        throw Exception('Unknown type of arg: $arg');
      }
      final value = chainInfo.scaleCodec.decode(type, input);
      params.add(value);
    }
    result['event'] = {
      moduleName: {
        eventName: params is List<Map<String, dynamic>> ? params : params,
      },
    };

    result['topic'] = SequenceCodec(StrCodec.instance).decode(input);

    return result;
  }

  @override
  void encodeTo(Map<String, dynamic> value, Output output) {
    if (value['phase'] is int) {
      U8Codec.instance.encodeTo(value['phase'], output);
    } else {
      U8Codec.instance.encodeTo(0, output);
      U32Codec.instance.encodeTo(value['phase']['ApplyExtrinsic'], output);
    }

    final lookup = (value['lookup'] as String).padLeft(4, '0');

    output.write(decodeHex(lookup));

    final event = chainInfo.metadata['event_index']?[lookup];
    final moduleName = event['module']['name'];
    final eventName = event['call']['name'];
    final List<dynamic> params = value['event'][moduleName][eventName];

    final args = event['call']['args'];

    for (var index = 0; index < args.length; index++) {
      final arg = args[index];
      late String type;
      if (arg is String) {
        // In case of legacy metadata
        type = arg;
      } else if (arg is Map<String, dynamic>) {
        // In case of v14 metadata
        type = arg['type'];
      } else {
        throw Exception('Unknown type of arg: $arg');
      }
      chainInfo.scaleCodec.encodeTo(type, params[index], output);
    }

    SequenceCodec(StrCodec.instance)
        .encodeTo(value['topic'] ?? <String>[], output);
  }
}
