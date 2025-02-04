// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i2;

import '../../tuples.dart' as _i1;

typedef Payload = List<_i1.Tuple2<List<int>, List<int>>>;

class PayloadCodec with _i2.Codec<Payload> {
  const PayloadCodec();

  @override
  Payload decode(_i2.Input input) {
    return const _i2.SequenceCodec<_i1.Tuple2<List<int>, List<int>>>(
        _i1.Tuple2Codec<List<int>, List<int>>(
      _i2.U8ArrayCodec(2),
      _i2.U8SequenceCodec.codec,
    )).decode(input);
  }

  @override
  void encodeTo(
    Payload value,
    _i2.Output output,
  ) {
    const _i2.SequenceCodec<_i1.Tuple2<List<int>, List<int>>>(
        _i1.Tuple2Codec<List<int>, List<int>>(
      _i2.U8ArrayCodec(2),
      _i2.U8SequenceCodec.codec,
    )).encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(Payload value) {
    return const _i2.SequenceCodec<_i1.Tuple2<List<int>, List<int>>>(
        _i1.Tuple2Codec<List<int>, List<int>>(
      _i2.U8ArrayCodec(2),
      _i2.U8SequenceCodec.codec,
    )).sizeHint(value);
  }
}
