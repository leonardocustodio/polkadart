part of codec_types;

///
/// Struct to encode/decode map of values
class Struct extends Codec<Map<String, dynamic>> {
  ///
  /// constructor
  Struct._() : super(registry: Registry());

  ///
  /// [static] returns a new instance of Struct
  @override
  Struct freshInstance() => Struct._();

  ///
  /// Decodes the value from the Codec's input
  @override
  Map<String, dynamic> decode(Input input) {
    final result = <String, dynamic>{};

    for (final entry in typeStruct.entries) {
      result[entry.key] = entry.value.decode(input);
    }
    return result;
  }

  ///
  /// Encodes Struct of values.
  @override
  void encode(Encoder encoder, Map<String, dynamic> map) {
    if (typeStruct.isEmpty) {
      return;
    }

    for (final entry in typeStruct.entries) {
      if (!map.containsKey(entry.key)) {
        throw InvalidStructException(entry.key);
      }

      final codec = entry.value;
      codec.encode(encoder, map[entry.key]);
    }
  }
}
