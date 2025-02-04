// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i2;

import '../primitive_types/h256.dart' as _i1;

typedef CandidateHash = _i1.H256;

class CandidateHashCodec with _i2.Codec<CandidateHash> {
  const CandidateHashCodec();

  @override
  CandidateHash decode(_i2.Input input) {
    return const _i2.U8ArrayCodec(32).decode(input);
  }

  @override
  void encodeTo(
    CandidateHash value,
    _i2.Output output,
  ) {
    const _i2.U8ArrayCodec(32).encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(CandidateHash value) {
    return const _i1.H256Codec().sizeHint(value);
  }
}
