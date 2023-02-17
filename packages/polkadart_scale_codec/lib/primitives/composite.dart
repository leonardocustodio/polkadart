part of primitives;

///
/// Composite to encode/decode map of values
class CompositeCodec with Codec<LinkedHashMap<String, dynamic>> {
  final LinkedHashMap<String, Codec<dynamic>> mappedCodec;

  ///
  /// constructor
  const CompositeCodec(this.mappedCodec);

  ///
  /// Decodes the value from the Codec's input
  @override
  LinkedHashMap<String, dynamic> decode(Input input) {
    final LinkedHashMap result = LinkedHashMap<String, dynamic>();

    for (final entry in mappedCodec.entries) {
      if (entry.key.toLowerCase() == 'hasher') {
        print('here');
      }
      result[entry.key] = entry.value.decode(input);
    }
    return result as LinkedHashMap<String, dynamic>;
  }

  ///
  /// Encodes Composite of values.
  @override
  void encodeTo(LinkedHashMap<String, dynamic> value, Output output) {
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
