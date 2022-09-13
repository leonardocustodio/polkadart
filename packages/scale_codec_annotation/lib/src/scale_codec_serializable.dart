class ScaleCodecSerializable {
  /// If `true` (the default), a static `_$decode` method
  /// is created in the generated part file.
  final bool? createDecodeMethod;

  /// If `true` (the default), a static `_$decode` method
  /// is created in the generated part file.
  final bool? createEncodeMethod;

  const ScaleCodecSerializable(
      {this.createDecodeMethod, this.createEncodeMethod});
}
