part of primitives;

///
/// BTreeMap to encode/decode map of values
class BTreeMap with Codec<Map<dynamic, dynamic>> {
  final Codec keyCodec;
  final Codec valueCodec;

  const BTreeMap({required this.keyCodec, required this.valueCodec});

  @override
  Map<dynamic, dynamic> decode(Input input) {
    final result = <dynamic, dynamic>{};

    final length = CompactCodec.instance.decode(input);

    for (var i = 0; i < length; i++) {
      final key = keyCodec.decode(input);
      final value = valueCodec.decode(input);
      result[key] = value;
    }
    return result;
  }

  @override
  void encodeTo(Map<dynamic, dynamic> value, Output output) {
    CompactCodec.instance.encodeTo(value.length, output);

    value.forEach((key, value) {
      keyCodec.encodeTo(key, output);
      valueCodec.encodeTo(value, output);
    });
  }
}
