// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i2;

import 'executor_param.dart' as _i1;

typedef ExecutorParams = List<_i1.ExecutorParam>;

class ExecutorParamsCodec with _i2.Codec<ExecutorParams> {
  const ExecutorParamsCodec();

  @override
  ExecutorParams decode(_i2.Input input) {
    return const _i2.SequenceCodec<_i1.ExecutorParam>(_i1.ExecutorParam.codec)
        .decode(input);
  }

  @override
  void encodeTo(
    ExecutorParams value,
    _i2.Output output,
  ) {
    const _i2.SequenceCodec<_i1.ExecutorParam>(_i1.ExecutorParam.codec)
        .encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(ExecutorParams value) {
    return const _i2.SequenceCodec<_i1.ExecutorParam>(_i1.ExecutorParam.codec)
        .sizeHint(value);
  }
}
