part of derived_codecs;

/// Codec for encoding and decoding Phase information
///
/// Phase indicates when during block execution an event was emitted:
/// - ApplyExtrinsic: During extrinsic application (with extrinsic index)
/// - Finalization: During block finalization
/// - Initialization: During block initialization
class PhaseCodec with Codec<Phase> {
  const PhaseCodec();

  /// Decode phase information from input
  @override
  Phase decode(Input input) {
    final index = input.read();

    switch (index) {
      case 0: // ApplyExtrinsic
        final extrinsicIndex = U32Codec.codec.decode(input);
        return Phase.applyExtrinsic(extrinsicIndex);

      case 1: // Finalization
        return Phase.finalization();

      case 2: // Initialization
        return Phase.initialization();

      default:
        throw MetadataException('Unknown phase index: $index');
    }
  }

  /// Encode phase information to output
  @override
  void encodeTo(Phase value, Output output) {
    switch (value.type) {
      case PhaseType.applyExtrinsic:
        // Write variant index
        output.pushByte(0);
        // Write extrinsic index
        if (value.extrinsicIndex == null) {
          throw MetadataException('ApplyExtrinsic phase must have extrinsicIndex');
        }
        U32Codec.codec.encodeTo(value.extrinsicIndex!, output);
        break;

      case PhaseType.finalization:
        // Write variant index
        output.pushByte(1);
        break;

      case PhaseType.initialization:
        // Write variant index
        output.pushByte(2);
        break;
    }
  }

  /// Calculate size hint for phase
  @override
  int sizeHint(Phase value) {
    int size = 1;
    if (value.type == PhaseType.applyExtrinsic) {
      size += U32Codec.codec.sizeHint(value.extrinsicIndex ?? 0);
    }
    return size;
  }

  @override
  bool isSizeZero() {
    // This class directly encodes variant index byte
    return false;
  }
}
