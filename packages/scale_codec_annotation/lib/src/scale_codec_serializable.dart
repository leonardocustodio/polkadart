class ScaleCodecSerializable {
  /// If `true` (the default), a static `.decode()` method
  /// is created in the generated part file.
  final bool shouldCreateDecodeMethod;

  /// If `true` (the default), a static `.encode()` method
  /// is created in the generated part file.
  final bool shouldCreateEncodeMethod;

  /// Creates a new [ScaleCodecSerializable] instance
  const ScaleCodecSerializable({
    this.shouldCreateDecodeMethod = true,
    this.shouldCreateEncodeMethod = true,
  });

  /// Creates a new [ScaleCodecSerializable] instance.
  ///
  /// Used with `BuilderOptions.config` when the builder configuration
  /// on `build.yaml` is used to provide custom configurations instead
  /// of setting arguments on the associated annotation class.
  factory ScaleCodecSerializable.fromMap(Map<String, dynamic> map) {
    return ScaleCodecSerializable(
      shouldCreateDecodeMethod: map['should_create_decode_method'] ?? true,
      shouldCreateEncodeMethod: map['should_create_encode_method'] ?? true,
    );
  }
}
