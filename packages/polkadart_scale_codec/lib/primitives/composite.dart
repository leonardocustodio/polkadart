part of primitives;

///
/// Composite to encode/decode map of values
class CompositeCodec with Codec<Map<String, dynamic>> {
  final Map<String, Codec<dynamic>> mappedCodec;

  ///
  /// constructor
  const CompositeCodec(this.mappedCodec);

  ///
  /// Decodes the value from the Codec's input
  @override
  Map<String, dynamic> decode(Input input) {
    final result = <String, dynamic>{};

    for (final entry in mappedCodec.entries) {
      result[entry.key] = entry.value.decode(input);
    }
    return result;
  }

  ///
  /// Encodes Composite of values.
  @override
  void encodeTo(Map<String, dynamic> value, Output output) {
    if (mappedCodec.isEmpty) {
      return;
    }

    for (final entry in mappedCodec.entries) {
      if (mappedCodec.containsKey(entry.key) == false) {
        throw CompositeException(
            'Codec not found for key: ${entry.key}, in mappedCodec: $mappedCodec');
      }

      final codec = entry.value;
      codec.encodeTo(value[entry.key], output);
    }
  }
}
