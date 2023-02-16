part of primitives;

///
/// BTreeMap to encode/decode map of values
class BTreeMapCodec<K, V> with Codec<Map<K, V>> {
  final Codec<K> keyCodec;
  final Codec<V> valueCodec;

  const BTreeMapCodec({required this.keyCodec, required this.valueCodec});

  @override
  Map<K, V> decode(Input input) {
    final result = <K, V>{};

    final length = CompactCodec.instance.decode(input);

    for (var i = 0; i < length; i++) {
      final key = keyCodec.decode(input);
      final value = valueCodec.decode(input);
      result[key] = value;
    }
    return result;
  }

  @override
  void encodeTo(Map<K, V> value, Output output) {
    CompactCodec.instance.encodeTo(value.length, output);

    value.forEach((key, value) {
      keyCodec.encodeTo(key, output);
      valueCodec.encodeTo(value, output);
    });
  }
}
