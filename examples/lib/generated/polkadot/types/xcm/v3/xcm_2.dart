// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i2;

import 'instruction_2.dart' as _i1;

typedef Xcm = List<_i1.Instruction>;

class XcmCodec with _i2.Codec<Xcm> {
  const XcmCodec();

  @override
  Xcm decode(_i2.Input input) {
    return const _i2.SequenceCodec<_i1.Instruction>(_i1.Instruction.codec)
        .decode(input);
  }

  @override
  void encodeTo(
    Xcm value,
    _i2.Output output,
  ) {
    const _i2.SequenceCodec<_i1.Instruction>(_i1.Instruction.codec).encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(Xcm value) {
    return const _i2.SequenceCodec<_i1.Instruction>(_i1.Instruction.codec)
        .sizeHint(value);
  }
}
