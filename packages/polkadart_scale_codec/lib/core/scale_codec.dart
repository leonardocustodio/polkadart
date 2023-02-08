part of core;

class ScaleCodec {
  final Registry registry;

  ScaleCodec(this.registry);

  ///
  /// Decode a SCALE encoded value
  dynamic decode(Input input, String type) {
    final codec = registry.getCodec(type);
    if (codec == null) {
      throw Exception('Codec not found for type: $type');
    }
    return codec.decode(input);
  }

  ///
  /// Encode a value to SCALE
  /// [value] is the value to encode
  /// [type] is the type of the value
  /// [dest] is the destination to write the encoded value to
  void encodeTo(dynamic value, String type, Output dest) {
    final codec = registry.getCodec(type);
    if (codec == null) {
      throw Exception('Codec not found for type: $type');
    }
    codec.encodeTo(value, dest);
  }
}
