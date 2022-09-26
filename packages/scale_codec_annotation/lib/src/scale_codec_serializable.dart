class ScaleCodecSerializable {
  /// If `true` (the default), a static `.decode()` method
  /// is created in the generated part file.
  final bool shouldCreateDecodeMethod;

  /// If `true` (the default), a static `.encode()` method is created in
  /// the generated part file.
  final bool shouldCreateEncodeMethod;

  /// Creates a new [ScaleCodecSerializable] instance
  const ScaleCodecSerializable({
    this.shouldCreateDecodeMethod = true,
    this.shouldCreateEncodeMethod = true,
  });

  /// Creates a new [ScaleCodecSerializable] instance.
  ///
  ///  If any map key wasn't found, the default value will be used instead.
  ///
  /// _OBS: Used to load data from [BuilderOptions] on `build.yaml`_.
  factory ScaleCodecSerializable.fromMap(Map<String, dynamic> map) {
    final shouldCreateDecodeMethod =
        map['should_create_decode_method'] as bool?;
    final shouldCreateEncodeMethod =
        map['should_create_encode_method'] as bool?;

    return ScaleCodecSerializable(
      shouldCreateDecodeMethod: shouldCreateDecodeMethod ?? true,
      shouldCreateEncodeMethod: shouldCreateEncodeMethod ?? true,
    );
  }
}
