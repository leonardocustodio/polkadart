// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:polkadart/scale_codec.dart' as _i2;

import 'polkadot_runtime_parachains/assigner_on_demand/types/enqueued_order.dart'
    as _i1;

typedef BinaryHeap = List<_i1.EnqueuedOrder>;

class BinaryHeapCodec with _i2.Codec<BinaryHeap> {
  const BinaryHeapCodec();

  @override
  BinaryHeap decode(_i2.Input input) {
    return const _i2.SequenceCodec<_i1.EnqueuedOrder>(_i1.EnqueuedOrder.codec)
        .decode(input);
  }

  @override
  void encodeTo(
    BinaryHeap value,
    _i2.Output output,
  ) {
    const _i2.SequenceCodec<_i1.EnqueuedOrder>(_i1.EnqueuedOrder.codec)
        .encodeTo(
      value,
      output,
    );
  }

  @override
  int sizeHint(BinaryHeap value) {
    return const _i2.SequenceCodec<_i1.EnqueuedOrder>(_i1.EnqueuedOrder.codec)
        .sizeHint(value);
  }
}
