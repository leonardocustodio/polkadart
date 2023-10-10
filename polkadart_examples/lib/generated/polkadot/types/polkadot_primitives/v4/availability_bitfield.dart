// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;

typedef AvailabilityBitfield = _i1.BitArray;

class AvailabilityBitfieldCodec with _i1.Codec<AvailabilityBitfield> {
  const AvailabilityBitfieldCodec();

  @override
  AvailabilityBitfield decode(_i1.Input input) {
    return const _i1.BitSequenceCodec(
      _i1.BitStore.U8,
      _i1.BitOrder.LSB,
    ).decode(input);
  }

  @override
  void encodeTo(
    AvailabilityBitfield value,
    _i1.Output output,
  ) {
    const _i1.BitSequenceCodec(
      _i1.BitStore.U8,
      _i1.BitOrder.LSB,
    ).encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(AvailabilityBitfield value) {
    return const _i1.BitSequenceCodec(
      _i1.BitStore.U8,
      _i1.BitOrder.LSB,
    ).sizeHint(value);
  }
}
