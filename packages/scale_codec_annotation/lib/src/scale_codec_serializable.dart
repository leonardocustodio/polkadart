class ScaleCodecSerializable {
  /// If `true` (the default), a static `.decode()` method
  /// is created in the generated part file.
  final bool shouldCreateDecodeMethod;

  /// If `true` (the default), a static `.encode()` method
  /// is created in the generated part file.
  final bool shouldCreateEncodeMethod;

  const ScaleCodecSerializable({
    this.shouldCreateDecodeMethod = true,
    this.shouldCreateEncodeMethod = true,
  });
}
