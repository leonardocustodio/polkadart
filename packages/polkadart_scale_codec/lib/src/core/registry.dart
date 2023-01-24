part of core;

class Registry {
  final Map<String, Codec> _codecs = <String, Codec>{};

  ///
  /// Get the registry length
  int get length => _codecs.length;

  ///
  /// Get the registry keys
  Iterable<String> get keys => _codecs.keys;

  ///
  /// Add a codec to the registry
  void addCodec(String codecName, Codec codec) {
    _codecs[codecName.toLowerCase()] = codec;
  }

  ///
  /// Get a codec from the registry
  Codec? getCodec(String codecName) {
    final codec = _codecs[codecName.toLowerCase()];
    return codec?.copyWith(codec);
  }
}
