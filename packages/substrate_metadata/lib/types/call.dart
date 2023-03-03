part of metadata_types;

class Call with Codec<Map<String, dynamic>> {
  final Registry registry;
  final Map<String, dynamic> metadata;

  const Call({required this.registry, required this.metadata});

  @override
  Map<String, dynamic> decode(Input input) {
    final lookup = input.readBytes(2).toList();
    final String callIndex = encodeHex(lookup);

    assertion(metadata.isNotEmpty, 'Empty metadata found.');
    assertion(metadata['call_index'] != null, 'No call_index found.');

    final call = metadata['call_index'][callIndex];

    final result = <String, dynamic>{
      'module_id': call['module']['name'],
      'call_name': call['call']['name'],
      'params': <Map<String, dynamic>>[],
    };

    final args = call['call']['args'];
    for (final arg in args) {
      final type = arg['type'];
      final name = arg['name'];
      final value = ScaleCodec(registry).decode(type, input);
      (result['params'] as List<Map<String, dynamic>>)
          .add({'name': name, 'type': type, 'value': value});
    }

    return result;
  }

  @override
  void encodeTo(Map<String, dynamic> value, Output output) {
    throw UnimplementedError();
  }
}
