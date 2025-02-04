// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../../polkadot_parachain_primitives/primitives/id.dart' as _i2;
import 'queue_index.dart' as _i3;

class EnqueuedOrder {
  const EnqueuedOrder({
    required this.paraId,
    required this.idx,
  });

  factory EnqueuedOrder.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// ParaId
  final _i2.Id paraId;

  /// QueueIndex
  final _i3.QueueIndex idx;

  static const $EnqueuedOrderCodec codec = $EnqueuedOrderCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, int> toJson() => {
        'paraId': paraId,
        'idx': idx,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is EnqueuedOrder && other.paraId == paraId && other.idx == idx;

  @override
  int get hashCode => Object.hash(
        paraId,
        idx,
      );
}

class $EnqueuedOrderCodec with _i1.Codec<EnqueuedOrder> {
  const $EnqueuedOrderCodec();

  @override
  void encodeTo(
    EnqueuedOrder obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.paraId,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.idx,
      output,
    );
  }

  @override
  EnqueuedOrder decode(_i1.Input input) {
    return EnqueuedOrder(
      paraId: _i1.U32Codec.codec.decode(input),
      idx: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(EnqueuedOrder obj) {
    int size = 0;
    size = size + const _i2.IdCodec().sizeHint(obj.paraId);
    size = size + const _i3.QueueIndexCodec().sizeHint(obj.idx);
    return size;
  }
}
