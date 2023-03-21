part of core;

class ScaleCodec {
  final Registry registry;

  ScaleCodec(this.registry);

  ///
  /// Decode a SCALE encoded value
  dynamic decode(String type, Input input) {
    final codec = registry.getCodec(type);
    if (codec == null) {
      throw Exception('Codec not found for type: $type');
    }
    final value = codec.decode(input);
    return value;
  }

  ///
  /// Encode a value to SCALE
  /// [value] is the value to encode
  /// [type] is the type of the value
  /// [dest] is the destination to write the encoded value to
  void encodeTo(String type, dynamic value, Output dest) {
    final codec = registry.getCodec(type);
    if (codec == null) {
      throw Exception('Codec not found for type: $type');
    }
    codec.encodeTo(value, dest);
  }
}
