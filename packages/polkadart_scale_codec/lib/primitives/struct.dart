part of primitives;

///
/// Struct to encode/decode map of values
class Struct with Codec<LinkedHashMap<String, dynamic>> {
  final LinkedHashMap<String, Codec<dynamic>> mappedCodec;

  ///
  /// constructor
  const Struct(this.mappedCodec);

  ///
  /// Decodes the value from the Codec's input
  @override
  LinkedHashMap<String, dynamic> decode(Input input) {
    final LinkedHashMap result = LinkedHashMap<String, dynamic>();

    for (final entry in mappedCodec.entries) {
      result[entry.key] = entry.value.decode(input);
    }
    return result as LinkedHashMap<String, dynamic>;
  }

  ///
  /// Encodes Struct of values.
  @override
  void encodeTo(LinkedHashMap<String, dynamic> value, Output output) {
    if (mappedCodec.isEmpty) {
      return;
    }

    for (final entry in mappedCodec.entries) {
      if (mappedCodec.containsKey(entry.key) == false) {
        throw StructException(
            'Codec not found for key: ${entry.key}, in mappedCodec: $mappedCodec');
      }

      final codec = entry.value;
      codec.encodeTo(value[entry.key], output);
    }
  }
}
