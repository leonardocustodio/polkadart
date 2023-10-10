// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i2;

import 'validator_app/public.dart' as _i1;

typedef IndexedVec = List<_i1.Public>;

class IndexedVecCodec with _i2.Codec<IndexedVec> {
  const IndexedVecCodec();

  @override
  IndexedVec decode(_i2.Input input) {
    return const _i2.SequenceCodec<_i1.Public>(_i1.PublicCodec()).decode(input);
  }

  @override
  void encodeTo(
    IndexedVec value,
    _i2.Output output,
  ) {
    const _i2.SequenceCodec<_i1.Public>(_i1.PublicCodec()).encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(IndexedVec value) {
    return const _i2.SequenceCodec<_i1.Public>(_i1.PublicCodec())
        .sizeHint(value);
  }
}
