part of derived_codecs;

/// Codec for extrinsic signature information
class ExtrinsicSignatureCodec with Codec<ExtrinsicSignature> {
  final MetadataTypeRegistry registry;
  late final Codec _addressCodec;
  late final Codec _signatureCodec;
  late final SignedExtensionsCodec _extensionsCodec;

  ExtrinsicSignatureCodec(this.registry) {
    _addressCodec = registry.codecFor(registry.extrinsic.addressType);
    _signatureCodec = registry.codecFor(registry.extrinsic.signatureType);
    _extensionsCodec = SignedExtensionsCodec(registry);
  }

  @override
  ExtrinsicSignature decode(Input input) {
    final address = _addressCodec.decode(input);
    final signature = _signatureCodec.decode(input);
    final extra = _extensionsCodec.decode(input);

    return ExtrinsicSignature(
      address: address,
      signature: signature,
      extra: extra,
    );
  }

  @override
  void encodeTo(ExtrinsicSignature value, Output output) {
    _addressCodec.encodeTo(value.address, output);
    _signatureCodec.encodeTo(value.signature, output);
    _extensionsCodec.encodeTo(value.extra, output);
  }

  @override
  int sizeHint(ExtrinsicSignature value) {
    return _addressCodec.sizeHint(value.address) +
        _signatureCodec.sizeHint(value.signature) +
        _extensionsCodec.sizeHint(value.extra);
  }
}
