// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i2;

import 'validator_index.dart' as _i1;

typedef IndexedVec = List<List<_i1.ValidatorIndex>>;

class IndexedVecCodec with _i2.Codec<IndexedVec> {
  const IndexedVecCodec();

  @override
  IndexedVec decode(_i2.Input input) {
    return const _i2.SequenceCodec<List<_i1.ValidatorIndex>>(
            _i2.SequenceCodec<_i1.ValidatorIndex>(_i1.ValidatorIndexCodec()))
        .decode(input);
  }

  @override
  void encodeTo(
    IndexedVec value,
    _i2.Output output,
  ) {
    const _i2.SequenceCodec<List<_i1.ValidatorIndex>>(
            _i2.SequenceCodec<_i1.ValidatorIndex>(_i1.ValidatorIndexCodec()))
        .encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(IndexedVec value) {
    return const _i2.SequenceCodec<List<_i1.ValidatorIndex>>(
            _i2.SequenceCodec<_i1.ValidatorIndex>(_i1.ValidatorIndexCodec()))
        .sizeHint(value);
  }
}
