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
    _codecs[codecName] = codec;
  }

  ///
  /// Get a codec from the registry
  Codec? getCodec(String codecName) {
    return _codecs[codecName];
  }

  ///
  /// Adds map of codecs to the registry
  void addCodecs(Map<String, Codec> codecs) {
    _codecs.addAll(codecs);
  }
}
