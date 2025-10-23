part of metadata;

/// Runtime API metadata for V16
///
/// V16 adds deprecation information to runtime APIs
class RuntimeApiMetadataV16 extends RuntimeApiMetadataV15 {
  /// Deprecation information
  final DeprecationInfo? deprecationInfo;

  const RuntimeApiMetadataV16({
    required super.name,
    required super.methods,
    required super.docs,
    this.deprecationInfo,
  });

  static const $RuntimeApiMetadataV16 codec = $RuntimeApiMetadataV16._();

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        if (deprecationInfo != null) 'deprecationInfo': deprecationInfo!.toJson(),
      };
}

class $RuntimeApiMetadataV16 with Codec<RuntimeApiMetadataV16> {
  const $RuntimeApiMetadataV16._();

  @override
  RuntimeApiMetadataV16 decode(Input input) {
    final base = RuntimeApiMetadataV15.codec.decode(input);
    final hasDeprecation = BoolCodec.codec.decode(input);
    final deprecationInfo = hasDeprecation ? DeprecationInfo.codec.decode(input) : null;

    return RuntimeApiMetadataV16(
      name: base.name,
      methods: base.methods,
      docs: base.docs,
      deprecationInfo: deprecationInfo,
    );
  }

  @override
  void encodeTo(RuntimeApiMetadataV16 value, Output output) {
    RuntimeApiMetadataV15.codec.encodeTo(value, output);
    BoolCodec.codec.encodeTo(value.deprecationInfo != null, output);
    if (value.deprecationInfo != null) {
      DeprecationInfo.codec.encodeTo(value.deprecationInfo!, output);
    }
  }

  @override
  int sizeHint(RuntimeApiMetadataV16 value) {
    var size = 0;
    size += RuntimeApiMetadataV15.codec.sizeHint(value);
    size += BoolCodec.codec.sizeHint(value.deprecationInfo != null);
    if (value.deprecationInfo != null) {
      size += DeprecationInfo.codec.sizeHint(value.deprecationInfo!);
    }
    return size;
  }
}
