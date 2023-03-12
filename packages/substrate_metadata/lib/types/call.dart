part of metadata_types;

class Call with Codec<Map<String, dynamic>> {
  final Registry registry;
  final Map<String, dynamic> metadata;

  const Call({required this.registry, required this.metadata});

  @override
  Map<String, dynamic> decode(Input input) {
    assertion(metadata.isNotEmpty, 'Empty metadata found.');
    assertion(metadata['call_index'] != null, 'No call_index found.');

    final lookup = input.readBytes(2).toList();
    final String callIndex = encodeHex(lookup);

    final result = <String, dynamic>{};

    result['lookup'] = callIndex;

    final call = metadata['call_index']?[result['lookup']];

    assertion(call != null, 'No call found for lookup: $callIndex');

    final args = call['call']['args'];

    final params = <dynamic>[];

    for (final arg in args) {
      late String type;
      late String paramName;
      if (arg is String) {
        type = arg;
        paramName = type;
      } else if (arg is Map<String, dynamic>) {
        type = arg['type'];
        paramName = arg['name'];
      } else {
        throw Exception('Unknown type of arg: $arg');
      }

      final codec = registry.getCodec(type);
      final value = codec!.decode(input);
      params.add({paramName: value});
    }

    result['call'] = {
      call['module']['name']: {
        call['call']['name']: {
          for (final param in params) param.keys.first: param.values.first,
        }
      },
    };

    return result;
  }

  @override
  void encodeTo(Map<String, dynamic> value, Output output) {
    assertion(metadata.isNotEmpty, 'Empty metadata found.');
    assertion(metadata['call_index'] != null, 'No call_index found.');

    final callIndex = value['lookup'] as String?;

    assertion(callIndex != null, 'No lookup found.');

    output.write(decodeHex(callIndex!).toList());

    final call = metadata['call_index']?[callIndex];

    assertion(call != null, 'No call found for lookup: $callIndex.');

    final moduleName = call['module']['name'];
    final callName = call['call']['name'];

    final args = call['call']['args'];

    final params = value['call'][moduleName][callName];

    for (final arg in args) {
      late String type;
      late String paramName;
      if (arg is String) {
        type = arg;
        paramName = type;
      } else if (arg is Map<String, dynamic>) {
        type = arg['type'];
        paramName = arg['name'];
      } else {
        throw Exception('Unknown type of arg: $arg');
      }

      final codec = registry.getCodec(type);
      final value = params[paramName];
      codec!.encodeTo(value, output);
    }
  }
}
