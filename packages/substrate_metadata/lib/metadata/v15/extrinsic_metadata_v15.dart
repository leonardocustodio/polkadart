part of metadata;

/// Metadata of the extrinsic used by the runtime (Version 15)
///
/// V15 improves on V14 by directly encoding the individual component type IDs
/// instead of requiring extraction from a single generic type.
///
class ExtrinsicMetadataV15 extends ExtrinsicMetadata {
  const ExtrinsicMetadataV15({
    required super.version,
    required super.addressType,
    required super.callType,
    required super.signatureType,
    required super.extraType,
    required super.signedExtensions,
  });

  /// Codec instance for ExtrinsicMetadataV15
  static const $ExtrinsicMetadataV15 codec = $ExtrinsicMetadataV15._();
}

/// Codec for ExtrinsicMetadataV15
class $ExtrinsicMetadataV15 with Codec<ExtrinsicMetadataV15> {
  const $ExtrinsicMetadataV15._();

  @override
  ExtrinsicMetadataV15 decode(Input input, {List<PortableType> types = const <PortableType>[]}) {
    final version = U8Codec.codec.decode(input);
    final addressType = CompactCodec.codec.decode(input);
    final callType = CompactCodec.codec.decode(input);
    final signatureType = CompactCodec.codec.decode(input);
    final extraType = CompactCodec.codec.decode(input);
    final signedExtensions = SequenceCodec(SignedExtensionMetadata.codec).decode(input);

    return ExtrinsicMetadataV15(
      version: version,
      addressType: addressType,
      callType: callType,
      signatureType: signatureType,
      extraType: extraType,
      signedExtensions: signedExtensions,
    );
  }

  @override
  void encodeTo(ExtrinsicMetadataV15 value, Output output) {
    U8Codec.codec.encodeTo(value.version, output);
    CompactCodec.codec.encodeTo(value.addressType, output);
    CompactCodec.codec.encodeTo(value.callType, output);
    CompactCodec.codec.encodeTo(value.signatureType, output);
    CompactCodec.codec.encodeTo(value.extraType, output);
    SequenceCodec(SignedExtensionMetadata.codec).encodeTo(value.signedExtensions, output);
  }

  @override
  int sizeHint(ExtrinsicMetadataV15 value) {
    var size = 0;
    size += U8Codec.codec.sizeHint(value.version);
    size += CompactCodec.codec.sizeHint(value.addressType);
    size += CompactCodec.codec.sizeHint(value.callType);
    size += CompactCodec.codec.sizeHint(value.signatureType);
    size += CompactCodec.codec.sizeHint(value.extraType);
    size += SequenceCodec(SignedExtensionMetadata.codec).sizeHint(value.signedExtensions);
    return size;
  }

  @override
  bool isSizeZero() {
    return U8Codec.codec.isSizeZero() &&
        CompactCodec.codec.isSizeZero() &&
        SequenceCodec(SignedExtensionMetadata.codec).isSizeZero();
  }
}
