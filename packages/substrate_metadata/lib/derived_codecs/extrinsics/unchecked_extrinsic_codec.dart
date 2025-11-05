part of derived_codecs;

/// Codec for a single UncheckedExtrinsic
///
/// Handles the core extrinsic encoding/decoding logic for both signed and unsigned
/// extrinsics. This includes version byte, optional signature, and call data.
class UncheckedExtrinsicCodec with Codec<UncheckedExtrinsic> {
  final MetadataTypeRegistry registry;
  late final RuntimeCallCodec _callCodec;
  late final ExtrinsicSignatureCodec _signatureCodec;

  UncheckedExtrinsicCodec(this.registry) {
    _callCodec = RuntimeCallCodec(registry);
    _signatureCodec = ExtrinsicSignatureCodec(registry);
  }

  @override
  UncheckedExtrinsic decode(Input input) {
    // Read version byte and extract the actual version and signed flag
    final versionByte = input.read();
    final isSigned = (versionByte & 0x80) != 0;
    final version = versionByte & 0x7F;

    // Verify version matches metadata
    if (version != registry.extrinsic.version) {
      throw MetadataException(
        'Extrinsic version mismatch: expected ${registry.extrinsic.version}, got $version',
      );
    }

    ExtrinsicSignature? signature;
    if (isSigned) {
      signature = _signatureCodec.decode(input);
    }

    final call = _callCodec.decode(input);

    return UncheckedExtrinsic(
      version: version,
      signature: signature,
      call: call,
    );
  }

  @override
  void encodeTo(UncheckedExtrinsic value, Output output) {
    final int extrinsicVersion = value.version;
    // Only set the signed bit (0x80) if there's a signature
    final int versionByte = value.signature != null
        ? (extrinsicVersion | 0x80)
        : extrinsicVersion;

    output.pushByte(versionByte);

    // Encode signature if present
    if (value.signature != null) {
      _signatureCodec.encodeTo(value.signature!, output);
    }

    // Encode call
    _callCodec.encodeTo(value.call, output);
  }

  @override
  int sizeHint(UncheckedExtrinsic value) {
    int size = 1; // Version byte

    if (value.signature != null) {
      size += _signatureCodec.sizeHint(value.signature!);
    }

    size += _callCodec.sizeHint(value.call);
    return size;
  }

  @override
  bool isSizeZero() {
    // This class directly encodes a version byte
    return false;
  }
}
