class ScaleCodecSerializable {
  /// If `true` (the default), a static `.decode()` method
  /// is created in the generated part file.
  final bool? shouldCreateDecodeMethod;

  /// If `true` (the default), a static `.encode()` method is created in
  /// the generated part file.
  final bool? shouldCreateEncodeMethod;

  /// Creates a new [ScaleCodecSerializable] instance
  const ScaleCodecSerializable({
    this.shouldCreateDecodeMethod,
    this.shouldCreateEncodeMethod,
  });

  /// Creates a new [ScaleCodecSerializable] instance.
  ///
  /// Used to load data from [BuilderOptions] on `build.yaml`.
  factory ScaleCodecSerializable.fromMap(Map<String, dynamic> map) {
    return ScaleCodecSerializable(
      shouldCreateDecodeMethod: map['should_create_decode_method'] as bool?,
      shouldCreateEncodeMethod: map['should_create_encode_method'] as bool?,
    );
  }
}
