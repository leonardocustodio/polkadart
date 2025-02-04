// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i1;

typedef QueueIndex = int;

class QueueIndexCodec with _i1.Codec<QueueIndex> {
  const QueueIndexCodec();

  @override
  QueueIndex decode(_i1.Input input) {
    return _i1.U32Codec.codec.decode(input);
  }

  @override
  void encodeTo(
    QueueIndex value,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(QueueIndex value) {
    return _i1.U32Codec.codec.sizeHint(value);
  }
}
